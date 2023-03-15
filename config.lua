Config = {}

Config.ShopPed = 'a_m_m_eastsa_02'
Config.ShopHash = 'a_m_m_eastsa_02'
Config.ShopLocation = vector3(89.71, -1101.65, 28.28)
Config.ShopHeading = 62.94

Config.TaskPed = 'a_m_y_stbla_02'
Config.TaskPedHash = 'a_m_y_stbla_02'
Config.TaskPedLocation = vector3(-826.89, -690.01, 27.06)
Config.TaskPedHeading = 88.75

Config.BlipName = 'IT Comp. Call' -- For calls
Config.BlipName2 = 'IT Company'
Config.BlipLocation = vector3(-827.46, -689.94, 28.06)
Config.BlipName3 = 'IT Shop'
Config.BlipLocation3 = vector3(88.99, -1101.38, 29.28)

Config.CarSpawnCoord = vector4(-834.41, -685.18, 27.28, 0.29)
Config.DeliveryVeh = "burrito3"
Config.Fuel = "LegacyFuel"
Config.VehPlate = "Delivery"
local items = {itemmonitor, "6x_keyboard", "6x_mouse", "6x_compcase", "6x_powersupplie", "6x_cpu", "6x_cpucooler", "6x_motherboard", "6x_memory", "6x_graphiccard", "6x_ssd", "6x_cables"}
Config.DeliveryItem = items[math.random(1, #items)]

Config.Payout = math.random(2000, 4000)
Config.Job = 'itcomp'
Config.Phone = 'qb-phone' -- qb-phone, gks-phone, qs-phone
Config.tarortxt = 'drawtxt' -- qb-target or drawtxt

Delivery.Coords = {
    [1] = {['x'] = 224.15, ['y'] = 513.55, ['z'] = 140.92,['h'] = 245.45, ['info'] = 'Vinewood 1'},
    [2] = {['x'] = 43.02, ['y'] = 468.85, ['z'] = 148.1,['h'] = 230.45, ['info'] = 'Vinewood 2'}, 
    [3] = {['x'] = 119.33, ['y'] = 564.1, ['z'] = 183.96,['h'] = 230.45, ['info'] = 'Vinewood 3'},
    [4] = {['x'] = -60.82, ['y'] = 360.56, ['z'] = 113.06,['h'] = 230.45, ['info'] = 'Vinewood 4'},
    [5] = {['x'] = -622.87, ['y'] = 488.81, ['z'] = 108.88,['h'] = 230.45, ['info'] = 'Vinewood 5'}, 
    [6] = {['x'] = -1040.67, ['y'] = 508.11, ['z'] = 84.38,['h'] = 123.45, ['info'] = 'Vinewood 6'}, 
    [7] = {['x'] = -1308.13, ['y'] = 448.9, ['z'] = 100.97,['h'] = 194.45, ['info'] = 'Vinewood 7'}, 
    [8] = {['x'] = -1733.21, ['y'] = 378.99, ['z'] = 89.73,['h'] = 194.45, ['info'] = 'Vinewood 8'},
    [9] = {['x'] = -2009.15, ['y'] = 367.42, ['z'] = 94.81,['h'] = 232.45, ['info'] = 'Vinewood 9'},
    [10] = {['x'] = -1996.29, ['y'] = 591.25, ['z'] = 118.1,['h'] = 232.45, ['info'] = 'Vinewood 10'},
}

Config.Locations = {
    {
        location = vector3(232.22, 672.12, 189.98),
        inside = vector3(-174.27, 497.83, 137.65),
        outside = vector3(231.55, 673.05, 189.94),
        comp = {
            vector3(-169.25, 492.70, 130.04),
        }
    },
}

Config.PcParts = {
label = 'PC Parts',
    slots = 1,
    items = {
        [1] = {
            name = '6x_monitor',
            price = 0,
            amount = 500,
            info = {},
            type = 'item',
            slot = 1,
        },
        [2] = {
            name = '6x_keyboard',
            price = 0,
            amount = 500,
            info = {},
            type = 'item',
            slot = 2,
        },
        [3] = {
            name = '6x_mouse',
            price = 0,
            amount = 500,
            info = {},
            type = 'item',
            slot = 3,
        },
        [4] = {
            name = '6x_compcase',
            price = 0,
            amount = 500,
            info = {},
            type = 'item',
            slot = 4,
        },
        [5] = {
            name = '6x_powersupplie',
            price = 0,
            amount = 500,
            info = {},
            type = 'item',
            slot = 5,
        },
        [6] = {
            name = '6x_cables',
            price = 0,
            amount = 500,
            info = {},
            type = 'item',
            slot = 6,
        },
        [7] = {
            name = '6x_toolbox',
            price = 0,
            amount = 500,
            info = {},
            type = 'item',
            slot = 7,
        },
        [8] = {
            name = '6x_cpu',
            price = 0,
            amount = 500,
            info = {},
            type = 'item',
            slot = 8,
        },
        [9] = {
            name = '6x_cpucooler',
            price = 0,
            amount = 500,
            info = {},
            type = 'item',
            slot = 9,
        },
        [10] = {
            name = '6x_motherboard',
            price = 0,
            amount = 500,
            info = {},
            type = 'item',
            slot = 10,
        },
        [11] = {
            name = '6x_memory',
            price = 0,
            amount = 500,
            info = {},
            type = 'item',
            slot = 11,
        },
        [12] = {
            name = '6x_graphiccard',
            price = 0,
            amount = 500,
            info = {},
            type = 'item',
            slot = 12,
        },
        [13] = {
            name = '6x_ssd',
            price = 0,
            amount = 500,
            info = {},
            type = 'item',
            slot = 13,
        },

    }
}
