ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)
        local level = exports["kaves_levelsistemi"]:level()
        local exp = exports["kaves_levelsistemi"]:exp()
        local player = PlayerPedId()
        local health = GetEntityHealth(player) -- male 200 - female 175
        local armor = GetPedArmour(player)
        local stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId()) -- 100
        local oxygen = GetPlayerUnderwaterTimeRemaining(PlayerId()) -- 40
       -- print(health, armor, stamina, oxygen, level, exp)
       local death = IsEntityDead(PlayerPedId())

       if death then
            StartScreenEffect('Dont_tazeme_bro',0,false)
        end

       SendNUIMessage({
           action = "data_emitted",
           health = health,
           armor = armor,
           isDeath = death
       })
    end
end)


Citizen.CreateThread(function()
    while true do
            TriggerEvent('esx_status:getStatus', 'hunger', function(hunger)
                TriggerEvent('esx_status:getStatus', 'thirst', function(thirst)
                    TriggerEvent('esx_status:getStatus','stress',function(stress)
                        local myhunger = hunger.getPercent()
                        local mythirst = thirst.getPercent()
                        local mystress = stress.getPercent()
                    end)
                end)
            end)
        Citizen.Wait(5000)
    end
end)

AddEventHandler('playerSpawned', function()
    TriggerEvent('skinchanger:getSkin', function(skin)
        print(skin.sex)
        if skin.sex == 0 then
          SendNUIMessage({
              action = "gender_emit",
              gender = "female"
          })
        else
            SendNUIMessage({
                action = "gender_emit",
                gender = "male"
            })
        end
    end)
end)