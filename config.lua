Config = {}

Config.useESX = false -- if you want to use esx notify | default: false

Config.Position = {x = -234.2982, y = -920.7202, z = 32.3122}

Config.Locale = 'de'

Config.Blip = {
    BlipLabel = "Test",
    BlipNumber = 407, 
    Colour = 27,
}

Config.Jobs = {
    {
        Label = "Trucker Job",
        Description = "Trucker",
        Value = "trucker",
        grade = 0
    },
    {
        Label = "Trucker Job2",
        Description = "3233",
        Value = "trucker2",
        grade = 0
    },
}

Translation = {
    ['de'] = {
        ['showhelp'] = 'Drücke ~INPUT_CONTEXT~ um das ~y~AMS~w~ zu öffnen!',
        ['unemployed'] = 'Du bist jetzt ~r~Arbeitlos!',
    },
    ['en'] = {
        ['showhelp'] = 'Presss ~INPUT_CONTEXT~ to open the ~y~LSJC Menu~w~ !',
        ['unemployed'] = 'Your are now ~r~Unemployed~s~!',
    },
}