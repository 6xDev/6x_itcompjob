local Translations = {
    label = {
        ["shop"] = "Shop",
        ["reqjob"] = "Request Job",
        ["finishjob"] = "Finish job",
        ["entry"] = "Entry",
        ["exit"] = "Exit",
        ["checkpc"] = "Check PC"
    },

    notify = {
        ["jobinprogress"] = "Your job is still in progress.",
        ["recivedlocation"] = "You recived an caller location.",
        ["alreadychecked"] = "You already checked this part.",
        ["imnotbroken"] = "This part is not broken.",
        ["donthaveitem"] = "You don't have item.",
        ["alreadyfixed"] = "You already fixed this PC",
        ["notfinish"] = "You're not done yet!",
        ["needtostartjob"] = "You need to start job first!",
        ["needtocheckmon"] = "You first need to check Monitor!",
        ["needtocheckgpu"] = "You first need to check Graphic Card!",
        ["needtocheckcpu"] = "You first need to check Processor!",
        ["success"] = "Success"
    },

    mail = {
        ["sender"] = "Mr. Smith",
        --
        ["subject"] = "IT C.E.O",
        ["message"] = "Good Work! Get back to company to collect money."
    },

    qbmenu = {
        ["avboptions"] = "Available Options",
        ["checkmonitor"] = "Check Monitor",
        ["checkgpu"] = "Check GPU",
        ["checkcpu"] = "Check CPU",
        ["checkssd"] = "Check SSD",
        ["checktxt"] = "Toolbox",
        ["imbroken"] = "I think there's something wrong here, so I'd better replace it.",
        ["replaceit"] = "Replace this part",
        ["wdmoney"] = "Withdraw money",
        ["cash"] = "Cash",
        ["bank"] = "Bank",
        ["closeheader"] = "Close (ESC)"

    },

    progress = {
        ["checkingpart"] = "Checking..",
        ["replacingpart"] = "Replacing part.."
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})