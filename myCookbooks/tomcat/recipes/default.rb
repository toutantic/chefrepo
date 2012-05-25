include_recipe "java"

catalinaHome = node.tomcat.catalinaHome
installDir = catalinaHome[0,catalinaHome.rindex('/')]

catalinaBase = node['tomcat']['catalinaBase']
configFile = catalinaBase[0,catalinaBase.rindex('/')]+"/tomcat.conf"

user = node.tomcat.user
uid = node.tomcat.uid
group = node.tomcat.group
gid = node.tomcat.gid

archiveFile= installDir+"/apache-tomcat.tar.gz"
directoryName= "apache-tomcat-" + node.tomcat.version
absoluteDestinationPath= installDir + "/" + directoryName


#Création de l'utilisateur tomcat
group "#{group}" do
  gid #{gid}
  not_if "grep #{group} /etc/group"
end

user "#{user}" do
  uid #{uid}
  gid "#{user}"
  home "/home/#{user}"
  shell "/bin/bash"
  not_if "grep #{user} /etc/passwd"
end


#Download et installation de tomcat
remote_file "#{archiveFile}" do
  source node.tomcat.tc7_download_url
  checksum node.tomcat.tc7_checksum
  not_if "test -d #{absoluteDestinationPath} && test -d #{node.tomcat.catalinaHome}"
end


bash "untarTomcat" do
  cwd "#{installDir}"
  code <<-EOH
	tar -xzf #{archiveFile}
	rm #{archiveFile}
	chown -R #{user}:#{group} #{directoryName}
	rm #{node.tomcat.catalinaHome}
	ln -s #{directoryName} tomcat
  EOH
  not_if "test -d #{absoluteDestinationPath} && test -d #{node.tomcat.catalinaHome}"
end

#installation de CATALINA_BASE
["#{catalinaBase}","#{catalinaBase}/conf","#{catalinaBase}/conf/Catalina","#{catalinaBase}/conf/Catalina/localhost","#{catalinaBase}/logs", "#{catalinaBase}/temp", "#{catalinaBase}/work", "#{catalinaBase}/webapp"].each do |dir|
  directory dir do
    owner "#{user}"
    group "#{group}"
    mode "0755"
    recursive true
    action :create
  end
end

template "#{configFile}" do
	source "tomcat_conf.erb"
	owner "#{user}"
	group "#{group}"
	mode "0755"
	variables({
		:catalinaBase => "#{catalinaBase}",
		:user => "#{user}"
	})
end

bash "copyTomcatConf" do
  code <<-EOH
	cp -R #{absoluteDestinationPath}/conf #{catalinaBase}
	chmod a+x #{absoluteDestinationPath}/conf
	chmod -R a+w #{absoluteDestinationPath}/conf
  EOH
end

#tomcat user
cookbook_file "#{catalinaBase}/conf/tomcat-users.xml" do
  source "tomcat-users.xml"
  mode "0655"
  owner "#{user}"
  group "#{group}"	 
end

# Ajout de la webapp manager
cookbook_file "#{catalinaBase}/conf/Catalina/localhost/manager.xml" do
  source "manager.xml"
  mode "0655"
  owner "#{user}"
  group "#{group}"	 
end

#Script de démarrage
template "/etc/init.d/tomcat" do
	source "tomcat_debian.erb"
	mode "0755"
	variables(
	    :configFile => configFile
	)
end

service "tomcat" do
  case node[:platform]
  when "linuxmint"
      provider Chef::Provider::Service::Init::Debian
  end
  supports :restart => true, :start => true, :stop => true, :reload => true
  action [ :enable]
end
