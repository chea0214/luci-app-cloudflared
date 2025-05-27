local m, s, o
local fs = require "nixio.fs"
local conffile = "/etc/cloudflared/config.yml"


m = Map("cloudflared")
s = m:section(TypedSection, "cloudflared")
s.anonymous = true
s.addremove = false

o = s:option(TextValue, "yaml")
o.rows = 30
o.wrap = "off"

o.cfgvalue = function(self, section)
	return fs.readfile(conffile) or ""
end

o.write = function(self, section, value)
	fs.writefile(conffile, value:gsub("\r\n", "\n"))
end

o.remove = function(self, section, value)
	fs.writefile(conffile, "")
end

o.validate=function(self, value)
    fs.writefile(conffile, value:gsub("\r\n", "\n"))
		return value
end

return m
