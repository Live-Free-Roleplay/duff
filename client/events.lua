--[[local function GetAllEvents()
    local events = {}
    for k, v in pairs(_G) do
        if type(v) == 'table' and v.name ~= nil then
            events[#events + 1] = v.name
        end
    end
    return events
end]]

--[[---@param group number | 0 = SCRIPT_EVENT_QUEUE_AI (CEventGroupScriptAI), 1 = SCRIPT_EVENT_QUEUE_NETWORK (CEventGroupScriptNetwork)
local function GetAllEvents(group)
    local events = {}
    for i = 1, GetNumberOfEvents(group) do
        local name = GetEventAtIndex(group, i)
        events[#events + 1] = name
    end
    return events
end]]

-- exports('GetAllEvents', function(group) return GetAllEvents(group) end)

--------------------------------- Damage Events --------------------------------- [Credits goes to: evTestingPizza | https://github.com/DevTestingPizza/DamageEvents]

---@param vehicle number | Vehicle Entity Handle
---@param attacker number | Attacker Entity Handle
---@param weapon number | Weapon Hash
---@param isMelee boolean | Is Melee Damage
---@param flags number | Damage Flags
local function VehicleDestroyed(vehicle, attacker, weapon, isMelee, flags)
	if IsEntityAVehicle(vehicle) then
		if IsEntityAVehicle(attacker) then
			-- Vehicle Killed by Vehicle Event
			-- print('Vehicle killed with a vehicle!')
			TriggerEvent('duf:vehicleKilledByVehicle', vehicle, attacker, weapon, isMelee, flags)
		elseif IsEntityAPed(attacker) then
			if IsPedAPlayer(attacker) then
				-- Player Killed Vehicle Event
				-- print('Player killed a vehicle!')
				TriggerEvent('duf:playerKilledVehicle', vehicle, attacker, weapon, isMelee, flags)
			else
				-- Ped Killed Vehicle Event
				-- print('Ped killed a vehicle!')
				TriggerEvent('duf:pedKilledVehicle', vehicle, attacker, weapon, isMelee, flags)
			end
		else
			-- Vehicle Killed Event
			-- print('Vehicle killed!')
			TriggerEvent('duf:vehicleDestroyed', vehicle, attacker, weapon, isMelee, flags)
		end
	end
end

---@param ped number | Ped Entity Handle
---@param vehicle number | Vehicle Entity Handle
---@param weapon number | Weapon Hash
---@param isMelee boolean | Is Melee Damage
---@param flags number | Damage Flags
local function PedKilledByVehicle(ped, vehicle, weapon, isMelee, flags)
	if IsEntityAPed(ped) then
		if IsPedAPlayer(ped) then
			-- Player Killed by Vehicle Event
			-- print('Player killed by a vehicle!')
			TriggerEvent('duf:playerKilledByVehicle', ped, vehicle, weapon, isMelee, flags)
		else
			-- Ped Killed by Vehicle Event
			-- print('Ped killed by a vehicle!')
			TriggerEvent('duf:pedKilledByVehicle', ped, vehicle, weapon, isMelee, flags)
		end
	end
end

---@param ped number | Ped Entity Handle
---@param player number | Player Ped Entity Handle
---@param weapon number | Weapon Hash
---@param isMelee boolean | Is Melee Damage
local function PedKilledByPlayer(ped, player, weapon, isMelee)
	if IsEntityAPed(ped) then
		if IsPedAPlayer(ped) then
			-- Player Killed by Player Event
			-- print('Player killed by a player!')
			TriggerEvent('duf:playerKilledByPlayer', ped, player, weapon, isMelee)
		else
			TriggerEvent('duf:pedKilledByPlayer', ped, player, weapon, isMelee)
		end
	end
end

---@param ped number | Ped Entity Handle
---@param attacker number | Attacker Entity Handle
---@param weapon number | Weapon Hash
---@param isMelee boolean | Is Melee Damage
local function PedKilledByPed(ped, attacker, weapon, isMelee)
	if IsEntityAPed(ped) then
		if IsPedAPlayer(ped) then
			TriggerEvent('duf:playerKilledByPed', ped, attacker, weapon, isMelee)
		else
			-- Ped Killed by Ped Event
			-- print('Ped killed by a ped!')
			TriggerEvent('duf:pedKilledByPed', ped, attacker, weapon, isMelee)
		end
	end
end

---@param ped number | Ped Entity Handle
---@param attacker number | Attacker Entity Handle
---@param weapon number | Weapon Hash
---@param isMelee boolean | Is Melee Damage
---@param flags number | Damage Flags
local function PedKilled(ped, attacker, weapon, isMelee, flags)
	if IsEntityAPed(ped) then
		if IsPedAPlayer(ped) then
			TriggerEvent('duf:playerKilled', ped, attacker, weapon, isMelee, flags)
		else
			-- Ped Killed Event
			-- print('Ped killed!')
			TriggerEvent('duf:pedKilled', ped, attacker, weapon, isMelee, flags)
		end
	end
end

---@param entity number | Entity Handle
---@param attacker number | Attacker Entity Handle
---@param weapon number | Weapon Hash
---@param isMelee boolean | Is Melee Damage
---@param flags number | Damage Flags
local function EntityKilled(entity, attacker, weapon, isMelee, flags)
	-- print('Something killed!')
	TriggerEvent('duf:entityKilled', entity, attacker, weapon, isMelee, flags)
end

---@param vehicle number | Vehicle Entity Handle
---@param attacker number | Attacker Entity Handle
---@param weapon number | Weapon Hash
---@param isMelee boolean | Is Melee Damage
---@param flags number | Damage Flags
local function VehicleDamaged(vehicle, attacker, weapon, isMelee, flags)
	if IsEntityAVehicle(vehicle) then
		if IsEntityAVehicle(attacker) then
			-- Vehicle Damaged by Vehicle Event
			-- print('Vehicle damaged with a vehicle!')
			TriggerEvent('duf:vehicleDamagedByVehicle', vehicle, attacker, weapon, isMelee, flags)
		elseif IsEntityAPed(attacker) then
			if IsPedAPlayer(attacker) then
				-- Player Damaged Vehicle Event
				-- print('Player damaged a vehicle!')
				TriggerEvent('duf:playerDamagedVehicle', vehicle, attacker, weapon, isMelee, flags)
			else
				-- Ped Damaged Vehicle Event
				-- print('Ped damaged a vehicle!')
				TriggerEvent('duf:pedDamagedVehicle', vehicle, attacker, weapon, isMelee, flags)
			end
		else
			-- Vehicle Damaged Event
			-- print('Vehicle damaged!')
			TriggerEvent('duf:vehicleDamaged', vehicle, attacker, weapon, isMelee, flags)
		end
	end
end

---@param ped number | Ped Entity Handle
---@param vehicle number | Vehicle Entity Handle
---@param weapon number | Weapon Hash
---@param isMelee boolean | Is Melee Damage
---@param flags number | Damage Flags
local function PedDamagedByVehicle(ped, vehicle, weapon, isMelee, flags)
	if IsEntityAPed(ped) then
		if IsPedAPlayer(ped) then
			-- Player Damaged by Vehicle Event
			-- print('Player damaged by a vehicle!')
			TriggerEvent('duf:playerDamagedByVehicle', ped, vehicle, weapon, isMelee, flags)
		else
			-- Ped Damaged by Vehicle Event
			-- print('Ped damaged by a vehicle!')
			TriggerEvent('duf:pedDamagedByVehicle', ped, vehicle, weapon, isMelee, flags)
		end
	end
end

---@param ped number | Ped Entity Handle
---@param player number | Player Ped Entity Handle
---@param weapon number | Weapon Hash
---@param isMelee boolean | Is Melee Damage
local function PedDamagedByPlayer(ped, player, weapon, isMelee)
	if IsEntityAPed(ped) then
		if IsPedAPlayer(ped) then
			-- Player Damaged by Player Event
			-- print('Player damaged by a player!')
			TriggerEvent('duf:playerDamagedByPlayer', ped, player, weapon, isMelee)
		else
			TriggerEvent('duf:pedDamagedByPlayer', ped, player, weapon, isMelee)
		end
	end
end

---@param ped number | Ped Entity Handle
---@param attacker number | Attacker Entity Handle
---@param weapon number | Weapon Hash
---@param isMelee boolean | Is Melee Damage
local function PedDamagedByPed(ped, attacker, weapon, isMelee)
	if IsEntityAPed(ped) then
		if IsPedAPlayer(ped) then
			TriggerEvent('duf:playerDamagedByPed', ped, attacker, weapon, isMelee)
		else
			-- Ped Damaged by Ped Event
			-- print('Ped damaged by a ped!')
			TriggerEvent('duf:pedDamagedByPed', ped, attacker, weapon, isMelee)
		end
	end
end

---@param ped number | Ped Entity Handle
---@param attacker number | Attacker Entity Handle
---@param weapon number | Weapon Hash
---@param isMelee boolean | Is Melee Damage
---@param flags number | Damage Flags
local function PedDamaged(ped, attacker, weapon, isMelee, flags)
	if IsEntityAPed(ped) then
		if IsPedAPlayer(ped) then
			TriggerEvent('duf:playerDamaged', ped, attacker, weapon, isMelee, flags)
		else
			-- Ped Damaged Event
			-- print('Ped damaged!')
			TriggerEvent('duf:pedDamaged', ped, attacker, weapon, isMelee, flags)
		end
	end
end

---@param entity number | Entity Handle
---@param attacker number | Attacker Entity Handle
---@param weapon number | Weapon Hash
---@param isMelee boolean | Is Melee Damage
---@param flags number | Damage Flags
local function EntityDamaged(entity, attacker, weapon, isMelee, flags)
	-- Entity Damaged Event
	-- print('Entity damaged!')
	TriggerEvent('duf:entityDamaged', entity, attacker, weapon, isMelee, flags)
end

--------------------------------- Game Events --------------------------------- [Credits goes to: FiveM Docs and FiveM Forums | https://docs.fivem.net/docs/game-references/game-events/]
-- NOTE: This is not a complete list of game events, I'm going through each event and finding their unknown parameters. If you know any of the unknown parameters, please let me know.

AddEventHandler('gameEventTriggered', function(name, args)
	if name == 'CEventNetworkEntityDamage' then
		victim = args[1]
		attacker = args[2]
		isDead = args[6] == 1
		weapon = args[7]
		isMelee = args[12]
		flags = args[13]
		if victim and attacker then
			if isDead then
				if IsEntityAVehicle(victim) then
					VehicleDestroyed(victim, attacker, weapon, isMelee, flags)
				elseif IsEntityAPed(victim) then
					if IsEntityAVehicle(attacker) then
						PedKilledByVehicle(victim, attacker, weapon, isMelee, flags)
					elseif IsEntityAPed(attacker) then
						if IsPedAPlayer(attacker) then
							PedKilledByPlayer(victim, attacker, weapon, isMelee)
						else
							PedKilledByPed(victim, attacker, weapon, isMelee)
						end
					else
						PedKilled(victim, attacker, weapon, isMelee, flags)
					end
				else
					EntityKilled(victim, attacker, weapon, isMelee)
				end
			else
				if IsEntityAVehicle(victim) then
					VehicleDamaged(victim, attacker, weapon, isMelee, flags)
				elseif IsEntityAPed(victim) then
					if IsEntityAVehicle(attacker) then
						PedDamagedByVehicle(victim, attacker, weapon, isMelee, flags)
					elseif IsEntityAPed(attacker) then
						if IsPedAPlayer(attacker) then
							PedDamagedByPlayer(victim, attacker, weapon, isMelee)
						else
							PedDamagedByPed(victim, attacker, weapon, isMelee)
						end
					else
						PedDamaged(victim, attacker, weapon, isMelee, flags)
					end
				else
					EntityDamaged(victim, attacker, weapon, isMelee, flags)
				end
			end
		end
	else
		local _text = "gameEventTriggered \npid: "..PlayerPedId().."\nname: "..name.."\nargs: "..json.encode(args)
		print(_text)
	end
end)

--------------------------------- Shocking Events ---------------------------------

---@param witnesses table | Array of entity handles who witnessed the event
---@param ped number | Entity handle of the ped who triggered the event
---@param x number | X coord of ped
---@param y number | Y coord of ped
---@param z number | Z coord of ped
AddEventHandler('CEventShockingBicycleCrash', function(witnesses, ped, x, y, z)
	-- local _text = "CEventShockingBicycleCrash \nPlyPId: "..PlayerPedId().."\nPed: "..ped.."\nWitnesses: "..json.encode(witnesses).."\nCoords: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of entity handles who witnessed the event
---@param vehicle number | Entity handle of the vehicle who triggered the event
---@param x number | X coord of vehicle
---@param y number | Y coord of vehicle
---@param z number | Z coord of vehicle
AddEventHandler('CEventShockingBicycleOnPavement', function(witnesses, vehicle, x, y, z)
	-- local _text = "CEventShockingBicycleOnPavement \nPlyPId: "..PlayerPedId().."\nVehicle: "..vehicle.."\nWitnesses: "..json.encode(witnesses).."\nCoords: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of entity handles who witnessed the event
---@param vehicle number | Entity handle of the vehicle who triggered the event
---@param x number | X coord of vehicle
---@param y number | Y coord of vehicle
---@param z number | Z coord of vehicle
AddEventHandler('CEventShockingCarAlarm', function(witnesses, vehicle, x, y, z)
	-- local _text = "CEventShockingCarAlarm \nVehicle: "..vehicle.."\nWitnesses: "..json.encode(witnesses).."\nCoords: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of entity handles who witnessed the event
---@param driver number | Entity handle of the ped who triggered the event
---@param x number | X coord of driver
---@param y number | Y coord of driver
---@param z number | Z coord of driver
AddEventHandler('CEventShockingCarCrash', function(witnesses, driver, x, y, z)
	-- local _text = "CEventShockingCarCrash \nPlyPId: "..PlayerPedId().."\nDriver: "..driver.."\nWitnesses: "..json.encode(witnesses).."\nCoords: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of entity handles who witnessed the event
---@param driver number | Entity handle of the driver who triggered the event
---@param x number | X coord of driver
---@param y number | Y coord of driver
---@param z number | Z coord of driver
AddEventHandler('CEventShockingCarOnCar', function(witnesses, driver, x, y, z)
	-- local _text = "CEventShockingCarOnCar \nPlyPId: "..PlayerPedId().."\nDriver: "..driver.."\nWitnesses: "..json.encode(witnesses).."\nargs: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of entity handles who witnessed the event
---@param driver number | Entity handle of the driver who triggered the event
---@param x number | X coord of driver
---@param y number | Y coord of driver
---@param z number | Z coord of driver
AddEventHandler('CEventShockingCarPileUp', function(witnesses, driver, x, y, z)
	-- local _text = "CEventShockingCarPileUp \npid: "..PlayerPedId().."\nDriver: "..driver.."\nWitnesses: "..json.encode(witnesses).."\nCoords: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of entity handles who witnessed the event
---@param ped number | Entity handle of the ped who triggered the event
---@param x number | X coord of ped
---@param y number | Y coord of ped
---@param z number | Z coord of ped
AddEventHandler('CEventShockingDeadBody', function(witnesses, ped, x, y, z)
	-- local _text = "CEventShockingDeadBody \nPlyPId: "..PlayerPedId().."\nPed: "..ped.."\nWitnesses: "..json.encode(witnesses).."\nCoords: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of entity handles who witnessed the event
---@param vehicle number | Entity handle of the vehicle which triggered the event
---@param x number | X coord of vehicle
---@param y number | Y coord of vehicle
---@param z number | Z coord of vehicle
AddEventHandler('CEventShockingDrivingOnPavement', function(witnesses, vehicle, x, y, z)
	-- local _text = "CEventShockingDrivingOnPavement \nVehicle: "..vehicle.."\nWitnesses: "..json.encode(witnesses).."\nCoords: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of entity handles who witnessed the explosion
---@param entity number | Handle of the entity which triggered the explosion
---@param x number | X coordinate of the explosion
---@param y number | Y coordinate of the explosion
---@param z number | Z coordinate of the explosion
AddEventHandler('CEventShockingExplosion', function(witnesses, entity, x, y, z)
	-- local _text = "CEventShockingExplosion \nPlyPId: "..PlayerPedId().."\nSource: "..entity.."\nWitnesses: "..json.encode(witnesses).."\nCoords: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of entity handles who witnessed the fire
---@param entity number | Handle of the entity which thats on fire
---@param x number | X coordinate of the fire
---@param y number | Y coordinate of the fire
---@param z number | Z coordinate of the fire
AddEventHandler('CEventShockingFire', function(witnesses, entity, x, y, z)
	-- local _text = "CEventShockingFire \npid: "..PlayerPedId().."\nSource: "..entity.."\nWitnesses: "..json.encode(witnesses).."\nCoords: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of entity handles who witnessed the event
---@param ped number | Entity handle of the ped who triggered the event
---@param x number | X coord of ped
---@param y number | Y coord of ped
---@param z number | Z coord of ped
AddEventHandler('CEventShockingGunshotFired', function(witnesses, ped, x, y, z)
	-- local _text = "CEventShockingGunshotFired \nPlyPId: "..PlayerPedId().."\nShooter: "..ped.."\nWitnesses: "..json.encode(witnesses).."\nCoords: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of entity handles who witnessed the event
---@param vehicle number | Entity handle of the helicopter
---@param x number | X coordinate of the helicopter
---@param y number | Y coordinate of the helicopter
---@param z number | Z coordinate of the helicopter
AddEventHandler('CEventShockingHelicopterOverhead', function(witnesses, vehicle, x, y, z)
	-- local _text = "CEventShockingHelicopterOverhead \npid: "..PlayerPedId().."\nVehicle: "..vehicle.."\nWitnesses: "..json.encode(witnesses).."\nCoords: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of entity handles who witnessed the event
---@param vehicle number | Entity handle of the vehicle which sounded their horn
---@param x number | X coordinate of the vehicle
---@param y number | Y coordinate of the vehicle
---@param z number | Z coordinate of the vehicle
AddEventHandler('CEventShockingHornSounded', function(witnesses, vehicle, x, y, z)
	-- local _text = "CEventShockingHornSounded \nPlyPId: "..PlayerPedId().."\nVehicle: "..vehicle.."\nWitnesses: "..json.encode(witnesses).."\nCoords: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of entity handles who witnessed the event
---@param attacker number | Entity handle of the ped who injured the other ped
---@param x number | X coordinate of the injured ped
---@param y number | Y coordinate of the injured ped
---@param z number | Z coordinate of the injured ped
AddEventHandler('CEventShockingInjuredPed', function(witnesses, attacker, x, y, z)
	-- local _text = "CEventShockingInjuredPed \nPlyPId: "..PlayerPedId().."\nAttacker: "..attacker.."\nWitnesses: "..json.encode(witnesses).."\nCoords: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of entity handles who witnessed the event
---@param ped number | Entity handle of the ped who triggered the event
---@param x number | X coord of ped
---@param y number | Y coord of ped
---@param z number | Z coord of ped
AddEventHandler('CEventShockingMadDriver', function(witnesses, ped, x, y, z)
	-- local _text = "CEventShockingMadDriver \nPlyPId: "..PlayerPedId().."\nPed: "..ped.."\nWitnesses: "..json.encode(witnesses).."\nCoords: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of entity handles who witnessed the event
---@param ped number | Entity handle of the ped who triggered the event
---@param x number | X coord of ped
---@param y number | Y coord of ped
---@param z number | Z coord of ped
AddEventHandler('CEventShockingMadDriverBicycle', function(witnesses, ped, x, y, z)
	-- local _text = "CEventShockingMadDriverBicycle \nPlyPId: "..PlayerPedId().."\nPed: "..ped.."\nWitnesses: "..json.encode(witnesses).."\nCoords: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of entity handles who witnessed the event
---@param ped number | Entity handle of the ped who triggered the event
---@param x number | X coord of ped
---@param y number | Y coord of ped
---@param z number | Z coord of ped
AddEventHandler('CEventShockingMadDriverExtreme', function(ped, witnesses, x, y, z)
	-- local _text = "CEventShockingMadDriverExtreme \nPlyPId: "..PlayerPedId().."\nPed: "..ped.."\nWitnesses: "..json.encode(witnesses).."\naCoords: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of entity handles who witnessed the event
---@param ped number | Entity handle of the ped that is parachuting
---@param x number | X coordinate of the parachuter
---@param y number | Y coordinate of the parachuter
---@param z number | Z coordinate of the parachuter
AddEventHandler('CEventShockingParachuterOverhead', function(witnesses, ped, x, y, z)
	-- local _text = "CEventShockingParachuterOverhead \npid: "..PlayerPedId().."\nWitnesses: "..json.encode(witnesses).."\nPed: "..ped.."\nCoords: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of peds that witnessed the event
---@param player number | Player ped that knocked into the ped
---@param x number | X coordinate of the event
---@param y number | Y coordinate of the event
---@param z number | Z coordinate of the event
AddEventHandler('CEventShockingPedKnockedIntoByPlayer', function(witnesses, player, x, y, z)
	-- local _text = "CEventShockingPedKnockedIntoByPlayer \npid: "..PlayerPedId().."\nWitnesses: "..json.encode(witnesses).."\nPlayer: "..player.."\nCoords: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of entity handles who witnessed the event
---@param driver number | Entity handle of the ped who injured the other ped
---@param x number | X coordinate of the injured ped
---@param y number | Y coordinate of the injured ped
---@param z number | Z coordinate of the injured ped
AddEventHandler('CEventShockingPedRunOver', function(witnesses, driver, x, y, z)
	-- local _text = "CEventShockingPedRunOver \nPlyPId: "..PlayerPedId().."\nDriver: "..driver.."\nWitnesses: "..json.encode(witnesses).."\nCoords: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of peds that witnessed the event
---@param attacker number | The ped that attacked
---@param x number | The x position of the event
---@param y number | The y position of the event
---@param z number | The z position of the event
AddEventHandler('CEventShockingPedShot', function(witnesses, attacker, x, y, z)
	-- local _text = "CEventShockingPedShot \nPlyPId: "..PlayerPedId().."\nWitnesses: "..json.encode(witnesses).."\nAttacker: "..attacker.."\nCoords: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of entity handles that witnessed the event
---@param ped number | Entity handle of the ped is running
---@param x number | X coordinate of the ped
---@param y number | Y coordinate of the ped
---@param z number | Z coordinate of the ped
AddEventHandler('CEventShockingRunningPed', function(witnesses, ped, x, y, z)
	-- local _text = "CEventShockingRunningPed \nPlyPId: "..PlayerPedId().."\nPed: "..ped.."\nWitnesses: "..json.encode(witnesses).."\nCoords: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of peds that witnessed the event
---@param ped number | Handle of the ped that is running (ie triggered the stampede)
---@param x number | X coord of the event
---@param y number | Y coord of the event
---@param z number | Z coord of the event
AddEventHandler('CEventShockingRunningStampede', function(witnesses, ped, x, y, z)
	-- local _text = "CEventShockingRunningStampede \nPlyPId: "..PlayerPedId().."\nWitnesses: "..json.encode(witnesses).."\nPed: "..ped.."\nCoords: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of entities that witnessed the event
---@param jacker number | The ped that jacked the vehicle
---@param x number | The x coordinate of the vehicle
---@param y number | The y coordinate of the vehicle
---@param z number | The z coordinate of the vehicle
AddEventHandler('CEventShockingSeenCarStolen', function(witnesses, jacker, x, y, z)
	-- local _text = "CEventShockingSeenCarStolen \npid: "..PlayerPedId().."\nWitnesses: "..json.encode(witnesses).."\nJacker: "..jacker.."\nCoords: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of peds that witnessed the event
---@param attacker number | The ped that used the melee weapon
---@param x number | The x coordinate of the event
---@param y number | The y coordinate of the event
---@param z number | The z coordinate of the event
AddEventHandler('CEventShockingSeenMeleeAction', function(witnesses, attacker, x, y, z)
	-- local _text = "CEventShockingSeenMeleeAction \nPlyPId: "..PlayerPedId().."\nAttacker: "..attacker.."\nWitnesses: "..json.encode(witnesses).."\nCoords: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of entity handles who witnessed the event
---@param vehicle number | Entity handle of the vehicle who triggered the event
---@param x number | X coord of vehicle
---@param y number | Y coord of vehicle
---@param z number | Z coord of vehicle
AddEventHandler('CEventShockingSeenNiceCar', function(witnesses, vehicle, x, y, z)
	-- local _text = "CEventShockingSeenNiceCar \nPlyPId: "..PlayerPedId().."\nVehicle: "..vehicle.."\nWitnesses: "..json.encode(witnesses).."\nCoords: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of entity handles who witnessed the event
---@param ped number | Entity handle of the ped who triggered the event
---@param x number | X coord of ped
---@param y number | Y coord of ped
---@param z number | Z coord of ped
AddEventHandler('CEventShockingVisibleWeapon', function(witnesses, ped, x, y, z)
	-- local _text = "CEventShockingVisibleWeapon \nPlyPId: "..PlayerPedId().."\nPed: "..ped.."\nWitnesses: "..json.encode(witnesses).."\nargs: "..json.encode(x, y, z)
	-- print(_text)
end)

---@param witnesses table | Array of entity handles who witnessed the event
---@param ped number | Entity handle of the ped who triggered the event
---@param x number | X coord of ped
---@param y number | Y coord of ped
---@param z number | Z coord of ped
AddEventHandler('CEventShockingWeaponThreat', function(witnesses, ped, x, y, z)
	-- local _text = "CEventShockingWeaponThreat \nPlyPId: "..PlayerPedId().."\nPed: "..ped.."\nWitnesses: "..json.encode(witnesses).."\nargs: "..json.encode(x, y, z)
	-- print(_text)
end)

--------------------------------- Events ---------------------------------

---@param peds table | Array of entity handles who are agitated 
AddEventHandler('CEventAgitated', function(peds)
	-- local _text = "CEventAgitated \nPeds: "..json.encode(peds)
	-- print(_text)
end)

---@param peds table | Array of entity handles who are agitated
---@param entity number | Handle of the entity which triggered the event
AddEventHandler('CEventAgitatedAction', function(peds, entity)
	-- local _text = "CEventAgitatedAction \nPlyPId: "..PlayerPedId().."\nSource: "..entity.."\nPeds: "..json.encode(peds)
	-- print(_text)
end)

---@param entities table | Array of entity handles to send the event to
---@param entity number | Handle of the entity which is sharing the event
AddEventHandler('CEventCommunicateEvent', function(entities, entity)
	-- local _text = "CEventCommunicateEvent \nSource: "..entity.."\nEntities: "..json.encode(entities)
	-- print(_text)
end)

---@param witnesses table | Array of entity handles who witnessed the event
---@param ped number | Entity handle of the ped who fired the gun
AddEventHandler('CEventGunShot', function(witnesses, ped)
	-- local _text = "CEventGunShot \nPlyPId: "..PlayerPedId().."\nShooter: "..ped.."\nWitnesses: "..json.encode(witnesses)
	-- print(_text)
end)

---@param peds table | Array of entity handles who received the command
AddEventHandler('CEventScriptCommand', function(peds)
	-- local _text = "CEventScriptCommand \nPed: "..json.encode(peds)
	-- print(_text)
end)

---@param peds table | Array of entity handles who received the task
AddEventHandler('CEventGivePedTask', function(peds)
	-- local _text = "CEventGivePedTask \nPeds: "..json.encode(peds)
	-- print(_text)
end)

--------------------------------- Unknown Parameters ---------------------------------

AddEventHandler('CEventShocking', function(entities, eventEntity, args)
	local _text = "CEventShocking \nPlyPId: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventShockingCarChase', function(entities, eventEntity, args)
	local _text = "CEventShockingCarChase \nPlyPId: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventShockingDangerousAnimal', function(entities, eventEntity, args)
	local _text = "CEventShockingDangerousAnimal \nPlyPId: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventCallForCover', function(entities, eventEntity, args)
	local _text = "CEventCallForCover \npid: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventCombatTaunt', function(entities, eventEntity, args)
	local _text = "CEventCombatTaunt \npid: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventShockingEngineRevved', function(entities, eventEntity, args)
	local _text = "CEventShockingEngineRevved \nPlyPId: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventShockingGunFight', function(entities, eventEntity, args)
	local _text = "CEventShockingGunFight \nPlyPId: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventShockingInDangerousVehicle', function(entities, eventEntity, args)
	local _text = "CEventShockingInDangerousVehicle \nPlyPId: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventShockingMugging', function(entities, eventEntity, args)
	local _text = "CEventShockingMugging \npid: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventShockingNonViolentWeaponAimedAt', function(entities, eventEntity, args)
	local _text = "CEventShockingNonViolentWeaponAimedAt \nPlyPId: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventShockingPlaneFlyby', function(entities, eventEntity, args)
	local _text = "CEventShockingPlaneFlyby \npid: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventShockingPotentialBlast', function(entities, eventEntity, args)
	local _text = "CEventShockingPotentialBlast \npid: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventShockingPropertyDamage', function(entities, eventEntity, args)
	local _text = "CEventShockingPropertyDamage \nPlyPId: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventShockingSeenConfrontation', function(entities, eventEntity, args)
	local _text = "CEventShockingSeenConfrontation \npid: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventShockingSeenGangFight', function(entities, eventEntity, args)
	local _text = "CEventShockingSeenGangFight \nPlyPId: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventShockingSeenInsult', function(entities, eventEntity, args)
	local _text = "CEventShockingSeenInsult \nPlyPId: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventShockingSiren', function(entities, eventEntity, args)
	local _text = "CEventShockingSiren \nPlyPId: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventShockingStudioBomb', function(entities, eventEntity, args)
	local _text = "CEventShockingStudioBomb \npid: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventShockingVehicleTowed', function(entities, eventEntity, args)
	local _text = "CEventShockingVehicleTowed \nPlyPId: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventShockingWeirdPed', function(entities, eventEntity, args)
	local _text = "CEventShockingWeirdPed \npid: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventShockingWeirdPedApproaching', function(entities, eventEntity, args)
	local _text = "CEventShockingWeirdPedApproaching \nPlyPId: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventShoutBlockingLos', function(entities, eventEntity, args)
	local _text = "CEventShoutBlockingLos \npid: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventShoutTargetPosition', function(entities, eventEntity, args)
	local _text = "CEventShoutTargetPosition \npid: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventDataResponseTaskShockingEventBackAway', function(entities, eventEntity, args)
	local _text = "CEventDataResponseTaskShockingEventBackAway \npid: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventDataResponseTaskShockingEventGoto', function(entities, eventEntity, args)
	local _text = "CEventDataResponseTaskShockingEventGoto \npid: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventDataResponseTaskShockingEventWatch', function(entities, eventEntity, args)
	local _text = "CEventDataResponseTaskShockingEventWatch \npid: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventDataResponseTaskShockingEventThreatResponse', function(entities, eventEntity, args)
	local _text = "CEventDataResponseTaskShockingEventThreatResponse \npid: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventDataResponseTaskShockingEventReact', function(entities, eventEntity, args)
	local _text = "CEventDataResponseTaskShockingEventReact \npid: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventDataResponseTaskShockingEventFlee', function(entities, eventEntity, args)
	local _text = "CEventDataResponseTaskShockingEventFlee \npid: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventDataResponseTaskShockingEventInvestigate', function(entities, eventEntity, args)
	local _text = "CEventDataResponseTaskShockingEventInvestigate \npid: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventShockingSeenDeadBody', function(entities, eventEntity, args)
	local _text = "CEventShockingSeenDeadBody \nPlyPId: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventShockingInDangerousVehicle', function(entities, eventEntity, args)
	local _text = "CEventShockingInDangerousVehicle \nPlyPId: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventReactionEnemyPed', function(entities, eventEntity, args)
	local _text = "CEventReactionEnemyPed \npid: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventScriptWithData', function(entities, eventEntity, args)
	local _text = "CEventScriptWithData \npid: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventNewTask', function(entities, eventEntity, args)
	local _text = "CEventNewTask \npid: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)

AddEventHandler('CEventOpenDoor', function(entities, eventEntity, args)
	local _text = "CEventOpenDoor \npid: "..PlayerPedId().."\neventEnt: "..eventEntity.."\nentities: "..json.encode(entities).."\nargs: "..json.encode(args)
	print(_text)
end)