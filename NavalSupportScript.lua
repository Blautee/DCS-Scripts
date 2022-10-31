--[[
Naval Support Script!

example use:

NavalSupport('Group-1', 'zone-hit-here-', 1, 20, 3)
-- > Group-1 will Fire at Point of Zones called 'zone-hit-here-1' to 'zone-hit-here-20' with 3 Attacks per Zone!

NavalSupport('Ship-Group-1', 'target-zone-', 5, 10, 5)
-- > Ship-Group-1 will Fire at Point of Zones called 'target-zone-5' to 'target-zone-10' with 5 Attacks per Zone!

]]
--						String	  String	 int	  int 	  	  int
function NavalSupport(groupName, zoneName, zoneMin, zoneMax, attacksPerZone)

	local navalGroup = Group.getByName(groupName)
	trigger.action.outTextForCoalition(coalition.side.BLUE, 'Group acquired', 5)
	
	if navalGroup == nil then
		local msg = ("Naval Support " .. groupName .. " KIA!")
		trigger.action.outTextForCoalition(coalition.side.BLUE, msg, 10)
		trigger.action.outSoundForCoalition(coalition.side.BLUE, "radiobeep.ogg")
		
		return
	else
		local i = zoneMin
		local j = zoneMax + 1
		while (i < j)
		do
			local zone = (zoneName .. i)
			local target = {}
			target.x = trigger.misc.getZone(zone).point.x
			target.y = trigger.misc.getZone(zone).point.z
			target.radius = trigger.misc.getZone(zone).radius
			target.expendQty = attacksPerZone
			target.expendQtyEnabled = true
			local fire = {id = 'FireAtPoint', params = target}
			navalGroup:getController():pushTask(fire)
			i = i + 1
		end
	end
end