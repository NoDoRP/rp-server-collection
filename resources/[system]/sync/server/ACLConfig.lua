-- Check the ping of the client attempting to connect. Set to 0 to disable this check
ACL.maxPing = 120

-- Set to false to disable whitelisting
ACL.enableWhitelist = false

-- Set to true to enable the /kick and /playerlist commands
ACL.enablePlayerManagement = false

-- Set to false to disable the check whether identities really belong to connecting player (causes "please try again" message)
ACL.useIdentBugWorkaround = true

ACL.whitelist = {
}

-- Currently mods and admins are indistinguishable
ACL.mods = {
}

ACL.admins = {
	"ip:0.0.0.0",
	"ip:192.168.1.69",
     "ip:199.126.13.45"

}

ACL.banlist = {
}