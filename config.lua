Config = {}

Config.Peds = {
   {
    name = "change me",  -- The display name of the selling ped
    model = "a_m_y_business_01",  -- Ped model to use (refer to your model list)
    coords = vector4(-199.28, -650.47, 48.24, 332.93),  -- In-game coordinates and heading
    items = {
        { 
            name = "change_me", 
            price = math.random(5000, 10000)  -- Price will be randomized between 5000 and 10000 
        },
        { 
            name = "change_me", 
            price = 3500  -- Fixed price example 
        },
        { 
            name = "change_me", 
            price = 3500  -- Additional fixed price example 
        },
    },
}
