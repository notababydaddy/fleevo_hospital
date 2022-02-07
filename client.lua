ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData() == nil do
		Citizen.Wait(10)
	end
end)

function DoAction(action)

    if action == "CheckIn" then
		SetEntityCoords(GetPlayerPed(-1), 351.37716674805, -583.1494140625, 44.206405639648 + 0.3)
        TriggerEvent('esx_ambulancejob:revive', GetPlayerPed(-1))
        SetEntityHealth(GetPlayerPed(-1), 200)
        Citizen.Wait(1000)
        TreatmentInProgress()
        Citizen.Wait(500)
        Citizen.CreateThread(function()
            local timeStarted = GetGameTimer()
            local CheckIn = true
			local playerPed = GetPlayerPed(-1)
            local time = 120000
			while CheckIn do

				if currentView ~= 4 then
				    DisableActions(GetPlayerPed(-1))

				Citizen.Wait(5)

        exports['fleevo_hospital']:taskBar(50000,"Being Treated")
					Citizen.Wait(50)

                    ClearPedTasksImmediately(GetPlayerPed(-1))
                    CheckIn = false
					DoScreenFadeIn(30)
					exports['mythic_notify']:DoHudText('error', 'You begin to feel medicated')
                    --exports['notify']:Alert("HUD", "You begin to feel medicated!", 2500, 'error')
					SetEntityCoords(GetPlayerPed(-1), 316.55, -584.42, 43.32)
					SetEntityHeading(GetPlayerPed(-1), 351.02)
					RequestAnimSet("move_m@drunk@slightlydrunk")
					while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
					 Citizen.Wait(0)
					end
					SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)
                    StartScreenEffect('drugsmichaelaliensfightout', 0, true)
					Citizen.Wait(5000)
					StartScreenEffect('drugsmichaelaliensfightout', 0, true)
                    Citizen.Wait(90000)
                    StopAllScreenEffects(GetPlayerPed(-1))
					ResetPedMovementClipset(playerPed, 0)

			end
		  end
		end)
    end
end

function startAnim(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(GetPlayerPed(-1), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
	end)
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

function TreatmentInProgress()

    SetEntityCoords(GetPlayerPed(-1), 317.88, -585.21, 44.22 + 0.3)
    RequestAnimDict('anim@gangops@morgue@table@')
    while not HasAnimDictLoaded('anim@gangops@morgue@table@') do
        Citizen.Wait(0)
    end
    TaskPlayAnim(GetPlayerPed(-1), 'anim@gangops@morgue@table@' , 'ko_front' ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(GetPlayerPed(-1), 335.05)
    InAction = true


    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
        end
    end)
end

function Nurse()
    wanted_model="a_m_m_prolhost_01"
    modelHash = GetHashKey(wanted_model)
    RequestModel(modelHash)

    while not HasModelLoaded(modelHash) do
        Wait(1)
    end
    local NurseNPC = CreatePed(5, modelHash, 316.82, -579.40, 43.30, 178.70, false, false)
    SetEntityAsMissionEntity(NurseNPC)
	SetEntityInvincible(NurseNPC, true)
    Wait(1500)

    SetPedDesiredHeading(NurseNPC, 178.70)
    Wait(100)

    TaskGoStraightToCoord(NurseNPC, 316.67, -585.20, 43.28, 1.0, 5000, 251.89, 2.0)
    Wait(5000)

    TaskStartScenarioInPlace(NurseNPC, "PROP_HUMAN_BUM_BIN", 0, false)
    Wait(85000)
    TaskGoStraightToCoord(NurseNPC, 342.41, -581.68, 42.41, 1.0, 5000, 70.50, 2.0)
    Wait(5000)
    DeleteEntity(NurseNPC)
end

RegisterNetEvent('fleevo_hospital:Last')
AddEventHandler('fleevo_hospital:Last', function()
    DoAction("CheckIn")
    Nurse()
end)

function DisableActions()
    DisableAllControlActions(0)
	EnableControlAction(0, 1, true)
	EnableControlAction(0, 2, true)
	EnableControlAction(0, 245, true)
end
