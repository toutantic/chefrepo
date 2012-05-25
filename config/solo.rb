root = File.expand_path(File.dirname(__FILE__)+ "/../")

file_cache_path root 
cookbook_path 
cookbook_path [root + "/thirdPartiesCookbooks", root + "/myCookbooks"]
