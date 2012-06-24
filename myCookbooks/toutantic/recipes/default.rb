["rar","unrar","curl"].each do |packageName|
	package packageName do
	  action :install
	end
end
