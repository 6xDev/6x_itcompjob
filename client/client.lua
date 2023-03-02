local QBCore = exports['qb-core']:GetCoreObject()

canStart = true
ongoing = false
fixed = false
local alreadyEnteredZone = false

Citizen.CreateThread(function()
    ItCompJob = AddBlipForCoord(Config.BlipLocation)
    SetBlipSprite (ItCompJob, 606)
    SetBlipDisplay(ItCompJob, 4)
    SetBlipScale  (ItCompJob, 0.8)
    SetBlipAsShortRange(ItCompJob, true)
    SetBlipColour(ItCompJob, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.BlipName2)
    EndTextCommandSetBlipName(ItCompJob)
end)

Citizen.CreateThread(function()
    ItCompJob = AddBlipForCoord(Config.BlipLocation3)
    SetBlipSprite (ItCompJob, 606)
    SetBlipDisplay(ItCompJob, 4)
    SetBlipScale  (ItCompJob, 0.8)
    SetBlipAsShortRange(ItCompJob, true)
    SetBlipColour(ItCompJob, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.BlipName3)
    EndTextCommandSetBlipName(ItCompJob)
end)

Citizen.CreateThread(function()
    hashKey = RequestModel(GetHashKey(Config.ShopPed))


    while not HasModelLoaded(GetHashKey(Config.ShopPed)) do
        Wait(1)
    end

    local npc = CreatePed(4, Config.ShopHash, Config.ShopLocation, false, true)

    SetEntityHeading(npc, Config.ShopHeading)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
end)

Citizen.CreateThread(function()
    hashKey = RequestModel(GetHashKey(Config.TaskPed))


    while not HasModelLoaded(GetHashKey(Config.TaskPed)) do
        Wait(1)
    end

    local npc = CreatePed(4, Config.TaskPedHash, Config.TaskPedLocation, false, true)
    
    SetEntityHeading(npc, Config.TaskPedHeading)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
end)

Citizen.CreateThread(function()
    exports['qb-target']:AddTargetModel(Config.ShopPed, {
    	options = {
    		{
    			event = '6x_itcompjob:openshop',
    			icon = 'far fa-clipboard',
    			label = Lang:t('label.shop'),
                job = Config.job
    		}
    	},
    	distance = 2.5,
    })
end)

Citizen.CreateThread(function()
    exports['qb-target']:AddTargetModel(Config.TaskPed, {
    	options = {
    		{
    			event = '6x_itcompjob:takejob',
    			icon = 'far fa-clipboard',
    			label = Lang:t('label.reqjob'),
                job = Config.job
    		},
            {
                event = '6x_itcompjob:finishjob',
                icon = 'far fa-clipboard',
                label = Lang:t('label.finishjob'),
                job = Config.job
            },
            {
                event = 'nh-context:startdelivery',
                icon = 'far fa-clipboard',
                label = Lang:t('label.startdelivery'),
                job = Config.job
            }
    	},
    	distance = 2.5,
    })
end)

RegisterNetEvent('6x_itcompjob:takejob')
AddEventHandler('6x_itcompjob:takejob', function()
    checkedmon = false
    checkedgpu = false
    checkedcpu = false
    checkedssd = false

    if canStart then
        canStart = false
        ongoing = true
        SetTimeout(2000, function()
            TriggerEvent('6x_itcompjob:getrandomhouseloc')
        end)
    else
        QBCore.Functions.Notify(Lang:t('notify.jobinprogress'), 'error')
    end
end)

local s = math.random(1,4)

RegisterNetEvent('6x_itcompjob:finishjob')
AddEventHandler('6x_itcompjob:finishjob', function()
    if ongoing == true then
        if fixed == true then
            TriggerEvent('nh-context:withdraw')
        else
            QBCore.Functions.Notify(Lang:t('notify.notfinish'), 'error')
        end
    else
        QBCore.Functions.Notify(Lang:t('notify.needtostartjob'), 'error')
    end
end)

RegisterNetEvent("6x_itcompjob:getrandomhouseloc")
AddEventHandler("6x_itcompjob:getrandomhouseloc", function()
    local missionTarget = Config.Locations[math.random(#Config.Locations)]
    TriggerEvent("6x_itcompjob:createblipandroute", missionTarget)
    TriggerEvent("6x_itcompjob:createentry", missionTarget)
end)

RegisterNetEvent("6x_itcompjob:createblipandroute")
AddEventHandler("6x_itcompjob:createblipandroute", function(missionTarget)
    QBCore.Functions.Notify(Lang:t("notify.recivedlocation"), "success")
    targetBlip = AddBlipForCoord(missionTarget.location.x, missionTarget.location.y, missionTarget.location.z)
    SetBlipSprite(targetBlip, 374)
    SetBlipColour(targetBlip, 1)
    SetBlipAlpha(targetBlip, 90)
    SetBlipScale(targetBlip, 0.5)
    SetBlipRoute(targetBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.BlipName)
    EndTextCommandSetBlipName(targetBlip)
end)

RegisterNetEvent("6x_itcompjob:goinside")
AddEventHandler("6x_itcompjob:goinside", function(missionTarget)
    local missionTarget = Config.Locations[#Config.Locations]
    if ongoing == true then
        SetEntityCoords(PlayerPedId(), missionTarget.inside.x, missionTarget.inside.y, missionTarget.inside.z)
        TriggerEvent("6x_itcompjob:createpc", missionTarget)
    else
        QBCore.Functions.Notify(Lang:t('notify.needtostartjob'), 'error')
    end
end)

RegisterNetEvent("6x_itcompjob:gooutside")
AddEventHandler("6x_itcompjob:gooutside", function(missionTarget)
    local missionTarget = Config.Locations[#Config.Locations]
    if ongoing == true then
        SetEntityCoords(PlayerPedId(), missionTarget.location.x, missionTarget.location.y, missionTarget.location.z)
    else
        QBCore.Functions.Notify(Lang:t('notify.needtostartjob'), 'error')
    end
end)

Citizen.CreateThread(function()
    local missionTarget = Config.Locations[#Config.Locations]

    for i,v in ipairs(missionTarget.comp) do

        exports['qb-target']:AddCircleZone('CheckPC', vector3(v.x, v.y, v.z), 0.5,{
            name = 'CheckPC',
            debugPoly = false, 
            useZ=true
        }, {
            options = {{
                label = Lang:t("label.checkpc"),
                icon = 'fa-solid fa-hand-holding',
                action = function()
                    openfixmenu() 
                end}},
                job = Config.job,
            distance = 2.0
        })
    end
end)

Citizen.CreateThread(function()
    local missionTarget = Config.Locations[#Config.Locations]

    exports['qb-target']:AddCircleZone('Entry', vector3(missionTarget.location.x, missionTarget.location.y, missionTarget.location.z), 0.8,{
        name = 'Entry',
        debugPoly = false, 
        useZ=true
    }, {
        options = {
            {
                label = Lang:t("label.entry"),
                icon = 'fa-solid fa-hand-holding',
                event = '6x_itcompjob:goinside',
                job = Config.job
            },
        },
        distance = 2.0
    })
end)

Citizen.CreateThread(function()
    local missionTarget = Config.Locations[#Config.Locations]
    
    exports['qb-target']:AddCircleZone('Exit', vector3(missionTarget.inside.x, missionTarget.inside.y, missionTarget.inside.z), 0.8,{
        name = 'Exit',
        debugPoly = false, 
        useZ=true
    }, {
        options = {
            {
                label = Lang:t("label.exit"),
                icon = 'fa-solid fa-hand-holding', 
                event = '6x_itcompjob:gooutside',
                job = Config.job
            },
        },
        distance = 2.0
    })
end)

RegisterNetEvent('nh-context:startdelivery', function(data)
    exports['qb-menu']:openMenu({
        {
            header = Lang:t("label.startdelivery"),
            isMenuHeader = true
        },
        {
           
            header = Lang:t("qbmenu.needtodeliver"),
            isMenuHeader = true
        },
        {
           
            header = Lang:t(Config.DeliveryItem),
            isMenuHeader = true
        },
        {
           
            header = Lang:t("qbmenu.tolocation"),
            isMenuHeader = true
        },
        {
           
            header = Lang:t("qbmenu.confirm"),
            params = {
                event = "6x_itcompjob:client:startdelivery"
            }
        },
        {
            header = Lang:t("qbmenu.closeheader"),
            isMenuHeader = true
        }
    })
end)

RegisterNetEvent('nh-context:FixMenu', function(data)
    exports['qb-menu']:openMenu({
        {
            header = Lang:t("qbmenu.avboptions"),
            isMenuHeader = true
        },
        {
           
            header = Lang:t("qbmenu.checkmonitor"),
            txt = Lang:t('qbmenu.checktxt'),
            params = {
                event = "6x_itcompjob:checkmonitor"
            }
        },
        {
           
            header = Lang:t("qbmenu.checkgpu"),
            txt = Lang:t('qbmenu.checktxt'),
            params = {
                event = "6x_itcompjob:checkgpu"
            }
        },
        {
           
            header = Lang:t("qbmenu.checkcpu"),
            txt = Lang:t('qbmenu.checktxt'),
            params = {
                event = "6x_itcompjob:checkcpu"
            }
        },
        {
           
            header = Lang:t("qbmenu.checkssd"),
            txt = Lang:t('qbmenu.checktxt'),
            params = {
                event = "6x_itcompjob:checkssd"
            }
        },
        {
            header = Lang:t("qbmenu.closeheader"),
            isMenuHeader = true
        }
    })
end)

RegisterNetEvent('6x_itcompjob:checkmonitor')
AddEventHandler('6x_itcompjob:checkmonitor', function()
    if checkedmon == false then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
            if HasItem then
                QBCore.Functions.Progressbar("pickup", Lang:t("progress.checkingpart"), 10000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },{
                    animDict = "mini@repair",
                    anim = "fixing_a_ped",
                    flags = 8,
                    }
                )
                Citizen.Wait(10000)
                if s == 1 then
                    TriggerEvent('nh-context:ImBroken')
                else
                    QBCore.Functions.Notify(Lang:t('notify.imnotbroken'))
                    checkedmon = true
                end
            else
                QBCore.Functions.Notify(Lang:t('notify.donthaveitem'), 'error')
            end
        end, '6x_toolbox')
    else
        QBCore.Functions.Notify(Lang:t('notify.alreadychecked'), 'error')
    end
end)

RegisterNetEvent('6x_itcompjob:checkgpu')
AddEventHandler('6x_itcompjob:checkgpu', function()
    if checkedgpu == false then
        if checkedmon == true then
            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
                if HasItem then
                    QBCore.Functions.Progressbar("pickup", Lang:t("progress.checkingpart"), 10000, true, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    },{
                        animDict = "mini@repair",
                        anim = "fixing_a_ped",
                        flags = 8,
                        }
                    )
                    Citizen.Wait(10000)
                    if s == 2 then
                        TriggerEvent('nh-context:ImBroken')
                    else
                        QBCore.Functions.Notify(Lang:t('notify.imnotbroken'))
                        checkedgpu = true
                    end
                else
                    QBCore.Functions.Notify(Lang:t('notify.donthaveitem'), 'error')
                end
            end, '6x_toolbox')
        else
            QBCore.Functions.Notify(Lang:t('notify.needtocheckmon'), 'error')
        end
    else
        QBCore.Functions.Notify(Lang:t('notify.alreadychecked'), 'error')
    end
end)

RegisterNetEvent('6x_itcompjob:checkcpu')
AddEventHandler('6x_itcompjob:checkcpu', function()
    if checkedcpu == false then
        if checkedgpu == true then
            if checkedmon == true then
                QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
                    if HasItem then
                        QBCore.Functions.Progressbar("pickup", Lang:t("progress.checkingpart"), 10000, false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },{
                            animDict = "mini@repair",
                            anim = "fixing_a_ped",
                            flags = 8,
                            }
                        )
                        Citizen.Wait(10000)
                        if s == 3 then
                            TriggerEvent('nh-context:ImBroken')
                        else
                            QBCore.Functions.Notify(Lang:t('notify.imnotbroken'))
                            checkedcpu = true
                        end
                    else
                        QBCore.Functions.Notify(Lang:t('notify.donthaveitem'), 'error')
                    end
                end, '6x_toolbox')
            else
                QBCore.Functions.Notify(Lang:t('notify.needtocheckmon'), 'error')
            end
        else
            QBCore.Functions.Notify(Lang:t('notify.needtocheckgpu'), 'error')
        end
    else
        QBCore.Functions.Notify(Lang:t('notify.alreadychecked'), 'error')
    end
end)

RegisterNetEvent('6x_itcompjob:checkssd')
AddEventHandler('6x_itcompjob:checkssd', function()
    if checkedssd == false then
        if checkedcpu == true then
            if checkedgpu == true then
                if checkedmon == true then
                    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
                        if HasItem then
                            QBCore.Functions.Progressbar("pickup", Lang:t("progress.checkingpart"), 10000, false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            },{
                                animDict = "mini@repair",
                                anim = "fixing_a_ped",
                                flags = 8,
                                }
                            )
                            Citizen.Wait(10000)
                            if s == 4 then
                                TriggerEvent('nh-context:ImBroken')
                            else
                                QBCore.Functions.Notify(Lang:t('notify.imnotbroken'))
                                checkedssd = true
                            end
                        else
                            QBCore.Functions.Notify(Lang:t('notify.donthaveitem'), 'error')
                        end
                    end, '6x_toolbox')
                else
                    QBCore.Functions.Notify(Lang:t('notify.needtocheckmon'), 'error')
                end
            else
                QBCore.Functions.Notify(Lang:t('notify.needtocheckgpu'), 'error')
            end
        else
            QBCore.Functions.Notify(Lang:t('notify.needtocheckcpu'), 'error')
        end
    else
        QBCore.Functions.Notify(Lang:t('notify.alreadychecked'), 'error')
    end
end)

RegisterNetEvent('nh-context:ImBroken', function(data)
    exports['qb-menu']:openMenu({
        {
            header = Lang:t("qbmenu.imbroken"),
            isMenuHeader = true
        },
        {
            header = Lang:t("qbmenu.replaceit"),
            params = {
                event = "6x_itcompjob:replace"
            }
        },
    })
end)

RegisterNetEvent('nh-context:withdraw', function(data)
    exports['qb-menu']:openMenu({
        {
            header = Lang:t("qbmenu.avboptions"),
            isMenuHeader = true
        },
        {
            header = Lang:t("qbmenu.wdmoney"),
            params = {
                event = "nh-context:cashbank"
            }
        },
    })
end)

RegisterNetEvent('nh-context:cashbank', function(data)
    exports['qb-menu']:openMenu({
        {
            header = Lang:t("qbmenu.avboptions"),
            isMenuHeader = true
        },
        {
            header = Lang:t("qbmenu.cash"),
            params = {
                event = "6x_itcompjob:finishjob2",
                canStart = true
            }
        },
        {
            header = Lang:t("qbmenu.bank"),
            params = {
                event = "6x_itcompjob:finishjob3",
                canStart = true
            }
        },
    })
end)

RegisterNetEvent('6x_itcompjob:finishjob2')
AddEventHandler('6x_itcompjob:finishjob2', function()
    TriggerServerEvent('6x_itcompjob:server:givemoney', Config.Payout)
    canStart = true
    ongoing = false
    fixed = false
end)

RegisterNetEvent('6x_itcompjob:finishjob3')
AddEventHandler('6x_itcompjob:finishjob3', function()
    TriggerServerEvent('6x_itcompjob:server:givemoney2', Config.Payout)
    canStart = true
    ongoing = false
    fixed = false
end)

RegisterNetEvent('6x_itcompjob:replace')
AddEventHandler('6x_itcompjob:replace', function()
    if s == 1 then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
            if HasItem then
                QBCore.Functions.Progressbar("pickup", Lang:t("progress.replacingpart"), 20000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },{
                    animDict = "mini@repair",
                    anim = "fixing_a_ped",
                    flags = 8,
                    }
                )
                Citizen.Wait(20000)
                TriggerServerEvent('6x_itcompjob:server:takeitem', "6x_monitor", 1)
                TriggerEvent('6x_itcompjob:fixedpc')
                fixed = true
                RemoveBlip(targetBlip)
            else
                QBCore.Functions.Notify(Lang:t('notify.donthaveitem'), 'error')
            end
        end, '6x_monitor')
    elseif s == 2 then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
            if HasItem then
                QBCore.Functions.Progressbar("pickup", Lang:t("progress.replacingpart"), 20000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },{
                    animDict = "mini@repair",
                    anim = "fixing_a_ped",
                    flags = 8,
                    }
                )
                Citizen.Wait(20000)
                TriggerServerEvent('6x_itcompjob:server:takeitem', "6x_graphiccard", 1)
                TriggerEvent('6x_itcompjob:fixedpc')
                fixed = true
                RemoveBlip(targetBlip)
            else
                QBCore.Functions.Notify(Lang:t('notify.donthaveitem'), 'error')
            end
        end, '6x_graphiccard')
    elseif s == 3 then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
            if HasItem then
                QBCore.Functions.Progressbar("pickup", Lang:t("progress.replacingpart"), 20000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },{
                    animDict = "mini@repair",
                    anim = "fixing_a_ped",
                    flags = 8,
                    }
                )
                Citizen.Wait(20000)
                TriggerServerEvent('6x_itcompjob:server:takeitem', "6x_cpu", 1)
                TriggerEvent('6x_itcompjob:fixedpc')
                fixed = true
                RemoveBlip(targetBlip)
            else
                QBCore.Functions.Notify(Lang:t('notify.donthaveitem'), 'error')
            end
        end, '6x_cpu')
    elseif s == 4 then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
            if HasItem then
                QBCore.Functions.Progressbar("pickup", Lang:t("progress.replacingpart"), 20000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },{
                    animDict = "mini@repair",
                    anim = "fixing_a_ped",
                    flags = 8,
                    }
                )
                Citizen.Wait(20000)
                TriggerServerEvent('6x_itcompjob:server:takeitem', "6x_ssd", 1)
                TriggerEvent('6x_itcompjob:fixedpc')
                fixed = true
                RemoveBlip(targetBlip)
            else
                QBCore.Functions.Notify(Lang:t('notify.donthaveitem'), 'error')
            end
        end, '6x_ssd')
    end
end)

RegisterNetEvent('6x_itcompjob:fixedpc')
AddEventHandler('6x_itcompjob:fixedpc', function()
    if Config.Phone == 'qb-phone' then
        if Config.Phone == "qb-phone" then
            TriggerServerEvent('qb-phone:server:sendNewMail', {
                sender =  Lang:t("mail.sender"),
                subject = Lang:t("mail.subject"),
                message = Lang:t("mail.message"),
                button = {
                }
            })
        elseif Config.Phone == "gks-phone" then
            TriggerServerEvent('gksphone:NewMail', {
                sender =  Lang:t("mail.sender"),
                subject = Lang:t("mail.subject"),
                message = Lang:t("mail.message")
            })
        elseif Config.Phone == "qs-phone" then
            TriggerServerEvent('qs-smartphone:server:sendNewMail', {
                sender =  Lang:t("mail.sender"),
                subject = Lang:t("mail.subject"),
                message = Lang:t("mail.message"),
                button = {
                }
            })
        elseif Config.Phone == "none" then
            TriggerEvent('nh-context:mailwithoutphone')
        end
    end
end)

RegisterNetEvent('nh-context:mailwithoutphone', function(data)
    exports['qb-menu']:openMenu({
        {

            header = Lang:t("mail.sender"),
            isMenuHeader = true,
        },
        {

            header = Lang:t("mail.subject"),
            isMenuHeader = true,
        },
        {
            header = Lang:t("qbmenu.message"),
            isMenuHeader = true
        },
    })
end)

function openfixmenu()
    if fixed == true then
        QBCore.Functions.Notify(Lang:t('notify.alreadyfixed'), 'error')
    else
        TriggerEvent('nh-context:FixMenu')
    end
end

RegisterNetEvent('6x_itcompjob:openshop')
AddEventHandler('6x_itcompjob:openshop', function()
    TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'components', Config.PcParts)
end)
