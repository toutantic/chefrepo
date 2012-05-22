java_ark "oraclejdk7" do
    url 'http://dl.dropbox.com/u/24652695/jdk-7u4-linux-x64.tar.gz'
    app_home '/usr/local/java/default'
    bin_cmds ["java", "javac"]
    action :install
end
