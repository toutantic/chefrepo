# Add an entry to the cron
# http://wiki.opscode.com/display/chef/Resources#Resources-Cron
cron "DoStuffAt5am" do
  hour "5"
  minute "0"
  command "/bin/true"
end

# Create de directory
# http://wiki.opscode.com/display/chef/Resources#Resources-Directory
directory "/tmp/something" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

# Download a file by http if is not already downloaded
# http://wiki.opscode.com/display/chef/Resources#Resources-RemoteFile
remote_file "/tmp/tomcat.tgz" do
  source "http://apache.crihan.fr/dist/tomcat/tomcat-7/v7.0.27/bin/apache-tomcat-7.0.27.tar.gz"
  checksum "38168d97dcd828698bb161fa7c051d8c229c7e9d609ee5e1132011f9fb68ec8e"
  not_if "test -f /tmp/tomcat.tgz"
end

# Execute a shell command <= Most usefull ressource ;)
# http://wiki.opscode.com/display/chef/Resources#Resources-Execute
execute "create a symlink" do
  command "ln -s /usr/local/apache-tomcat-7.0.27 $TARGET"
  creates "/usr/local/tomcat"
  action :run
  environment ({'TARGET' => '/usr/local/tomcat'})
end



