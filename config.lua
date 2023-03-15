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
