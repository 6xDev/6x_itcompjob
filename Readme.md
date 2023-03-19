# 6x_itcompjob
- [CUSTOM] Detailed 6x IT Comp. Job [QBCORE]
- New QBCore

## Video Showcase
- https://youtu.be/qXGp5HJ99Vw
## Discord
- https://discord.gg/nyRp7Vtvra

## Features
- Low Resmon
- Ped on location
- Phone Mail Support
- You can add multiple locations
- LockPick system with minigame
- Searching House and find rare items
- You can add more items
- Dispatch Support when you fail

## Dependencies
- [qb-core](https://github.com/qbcore-framework/qb-core)
- [qb-target](https://github.com/qbcore-framework/qb-target)

### Script
- Download the script and put it in the `[qb]` directory.
- Add the following code to your server.cfg/resouces.cfg
```
ensure 6x_itcompjob
```

## Insert into @qb-core --> shared --> items.lua
```
	-- 6x_itcompjob
	['6x_monitor'] 				= {['name'] = '6x_monitor', 			['label'] = 'Monitor',	            			['weight'] = 100,     ['type'] = 'item',      ['image'] = '6x_monitor.png',         	['unique'] = false,     ['useable'] = true,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = ''},
	['6x_keyboard'] 			= {['name'] = '6x_keyboard', 			['label'] = 'Keyboard',	            			['weight'] = 100,     ['type'] = 'item',      ['image'] = '6x_keyboard.png',         	['unique'] = false,     ['useable'] = true,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = ''},
	['6x_mouse'] 				= {['name'] = '6x_mouse', 				['label'] = 'Mouse',                			['weight'] = 100,     ['type'] = 'item',      ['image'] = '6x_mouse.png',         	['unique'] = false,     ['useable'] = true,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = ''},
	['6x_compcase'] 			= {['name'] = '6x_compcase', 			['label'] = 'Computer Case',           			['weight'] = 100,     ['type'] = 'item',      ['image'] = '6x_compcase.png',         	['unique'] = false,     ['useable'] = true,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = ''},
	['6x_powersupplie'] 		= {['name'] = '6x_powersupplie', 		['label'] = 'Power Supplie',           			['weight'] = 100,     ['type'] = 'item',      ['image'] = '6x_powersupplie.png',         	['unique'] = false,     ['useable'] = true,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = ''},
	['6x_toolbox'] 				= {['name'] = '6x_toolbox', 			['label'] = 'Toolbox',	            			['weight'] = 100,     ['type'] = 'item',      ['image'] = '6x_toolbox.png',         	['unique'] = false,     ['useable'] = true,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = ''},
	['6x_cpu'] 					= {['name'] = '6x_cpu', 				['label'] = 'CPU',		            			['weight'] = 100,     ['type'] = 'item',      ['image'] = '6x_cpu.png',         	['unique'] = false,     ['useable'] = true,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = ''},
	['6x_cpucooler'] 			= {['name'] = '6x_cpucooler', 			['label'] = 'CPU Cooler',            			['weight'] = 100,     ['type'] = 'item',      ['image'] = '6x_cpucooler.png',         	['unique'] = false,     ['useable'] = true,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = ''},
	['6x_motherboard'] 			= {['name'] = '6x_motherboard', 		['label'] = 'Motherboard',            			['weight'] = 100,     ['type'] = 'item',      ['image'] = '6x_motherboard.png',         	['unique'] = false,     ['useable'] = true,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = ''},
	['6x_memory'] 				= {['name'] = '6x_memory', 				['label'] = '8GB Ram Memory',            		['weight'] = 100,     ['type'] = 'item',      ['image'] = '6x_memory.png',         	['unique'] = false,     ['useable'] = true,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = ''},
	['6x_graphiccard'] 			= {['name'] = '6x_graphiccard', 		['label'] = 'Graphic Card',            			['weight'] = 100,     ['type'] = 'item',      ['image'] = '6x_graphiccard.png',         	['unique'] = false,     ['useable'] = true,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = ''},
	['6x_ssd'] 					= {['name'] = '6x_ssd', 				['label'] = '1TB SSD',            				['weight'] = 100,     ['type'] = 'item',      ['image'] = '6x_ssd.png',         	['unique'] = false,     ['useable'] = true,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = ''},
	['6x_cables'] 				= {['name'] = '6x_cables', 			    ['label'] = 'Cables',            				['weight'] = 100,     ['type'] = 'item',      ['image'] = '6x_cables.png',         	['unique'] = false,     ['useable'] = true,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = ''},
```

## Insert into @qb-core/shared/jobs.lua 
```
QBShared.Jobs = {
    ["itcomp"] = {
		label = "IT Comp",
		defaultDuty = false,
		grades = {
            ['1'] = {
                name = "Employee",
                payment = 0
            },
        },
	},
}		
```

## Insert into @qb-inventory --> html --> images
From 6x_itcompjob\images
