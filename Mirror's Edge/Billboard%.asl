state ("MirrorsEdge", "Unknown") {}

state ("MirrorsEdge", "Steam") 
{
    // Player's position
    float playerPosX: 0x01C553D0, 0xCC, 0x1CC, 0x2F8, 0xE8;
    float playerPosZ: 0x01C553D0, 0xCC, 0x1CC, 0x2F8, 0xF0;

    // Object's position that the player is standing on
    float basePosX: 0x01C553D0, 0xCC, 0x1CC, 0x2F8, 0x74, 0xE8;
    float basePosY: 0x01C553D0, 0xCC, 0x1CC, 0x2F8, 0x74, 0xEC;
    float basePosZ: 0x01C553D0, 0xCC, 0x1CC, 0x2F8, 0x74, 0xF0;
}

state ("MirrorsEdge", "Origin")  
{
    float playerPosX: 0x01C6E50C, 0xCC, 0x1CC, 0x2F8, 0xE8;
    float playerPosZ: 0x01C6E50C, 0xCC, 0x1CC, 0x2F8, 0xF0;
    float basePosX: 0x01C6E50C, 0xCC, 0x1CC, 0x2F8, 0x74, 0xE8;
    float basePosY: 0x01C6E50C, 0xCC, 0x1CC, 0x2F8, 0x74, 0xEC;
    float basePosZ: 0x01C6E50C, 0xCC, 0x1CC, 0x2F8, 0x74, 0xF0;
}

state ("MirrorsEdge", "Reloaded") 
{
    float playerPosX: 0x01C6E50C, 0xCC, 0x1CC, 0x2F8, 0xE8;
    float playerPosZ: 0x01C6E50C, 0xCC, 0x1CC, 0x2F8, 0xF0;
    float basePosX: 0x01C6E50C, 0xCC, 0x1CC, 0x2F8, 0x74, 0xE8;
    float basePosY: 0x01C6E50C, 0xCC, 0x1CC, 0x2F8, 0x74, 0xEC;
    float basePosZ: 0x01C6E50C, 0xCC, 0x1CC, 0x2F8, 0x74, 0xF0;
}

state ("MirrorsEdge", "Origin (Asia)") 
{
    float playerPosX: 0x01B8BE54, 0xCC, 0x1CC, 0x2F8, 0xE8;
    float playerPosZ: 0x01B8BE54, 0xCC, 0x1CC, 0x2F8, 0xF0;
    float basePosX: 0x01B8BE54, 0xCC, 0x1CC, 0x2F8, 0x74, 0xE8;
    float basePosY: 0x01B8BE54, 0xCC, 0x1CC, 0x2F8, 0x74, 0xEC;
    float basePosZ: 0x01B8BE54, 0xCC, 0x1CC, 0x2F8, 0x74, 0xF0;
}

state ("MirrorsEdge", "Origin (DLC)") 
{
    float playerPosX: 0x01C7561C, 0xE4, 0x1CC, 0x2F8, 0xE8;
    float playerPosZ: 0x01C7561C, 0xE4, 0x1CC, 0x2F8, 0xF0;
    float basePosX: 0x01C7561C, 0xE4, 0x1CC, 0x2F8, 0x74, 0xE8;
    float basePosY: 0x01C7561C, 0xE4, 0x1CC, 0x2F8, 0x74, 0xEC;
    float basePosZ: 0x01C7561C, 0xE4, 0x1CC, 0x2F8, 0x74, 0xF0;
}

init 
{
    switch (modules.First().ModuleMemorySize) 
    {
        case 32976896: 
        case 32632832: 
            version = "Steam"; 
            break;
    
        case 42889216: 
            version = "Origin"; 
            break;
    
        case 60298504: 
        case 42876928: 
            version = "Reloaded"; 
            break;
    
        case 42717184:
            version = "Origin (Asia)";
            break;

        case 43794432:
            version = "Origin (DLC)";
            break;

        default: 
            MessageBox.Show("Memory Size: " + modules.First().ModuleMemorySize.ToString(), "Unknown Version Detected!");
            version = "Unknown"; 
            break;
    }

    vars.BillboardsVisited = new List<Vector3f>();
    vars.BillboardLocations = new List<Vector3f>
    {
        // Training
        { new Vector3f(-3908f, -1280f, 3043f) }, 

        // 0C
        { new Vector3f(-14232f, -4075f, 6505f) }, 
        { new Vector3f(-17924f, 4430f, 6005f) },

        // 3A
        { new Vector3f(-4424f, 12976f, 4256f) },
        { new Vector3f(1864f, 11312f, 2720f) },

        // 3C
        { new Vector3f(12384f, -11200f, 2710f) },
        { new Vector3f(29232f, -14432f, 3872f) },

        // 3D
        { new Vector3f(37272f, -11648f, 6018f) },
        { new Vector3f(42016f, -11208f, 5756.000977f) },
        { new Vector3f(40808f, -4836f, 5371.618164f) },

        // 4A
        { new Vector3f(-4128.001953f, -13167.99805f, 5920f) },

        // 6A
        { new Vector3f(15136f, -5816f, 2816f) },

        // 8A
        { new Vector3f(-32092f, 16291f, 4932f) },
        { new Vector3f(-20732f, 3284f, 4960f) },
        { new Vector3f(-21340f, 6852f, 6112f) },

        // 8B
        { new Vector3f(-7660f, 2560f, 6018f) },
        { new Vector3f(-8222f, 1488f, 6018f) },
        { new Vector3f(-4494f, 2212f, 2809.007324f) },
    };
}

startup
{
    settings.Add("Billboards", true, "Split After Billboard");
    settings.SetToolTip("Billboards", "Choose when you want it to split. For example, if you do all chapter 8 in a row, then you want to enable 6.\nAfter you've have done chapter 8, you'll probably do chapter 6. Since that has 1 billboard, enable 7 and so on...");

    for (int i = 1; i < 19; i++)
    {
        settings.Add("billboard_" + i, i == 18 ? true : false, "" + i, "Billboards");
        settings.SetToolTip("billboard_" + i, "Split after you have been on " + i + " billboard" + (i == 1 ? "" : "s"));
    }
}

start 
{
    return current.playerPosX == 0f && old.playerPosX == -79.89810944f;
}

split 
{
    // Checks if player is within the Z distance range of the base object
    if (current.playerPosZ - current.basePosZ <= 720f || current.playerPosZ - current.basePosZ >= 1300f) 
    {
        return false;
    }

    for (int i = 0; i < vars.BillboardLocations.Count; i++)
    {
        if (vars.BillboardLocations[i].X == current.basePosX && vars.BillboardLocations[i].Y == current.basePosY && vars.BillboardLocations[i].Z == current.basePosZ) 
        {
            for (int j = 0; j < vars.BillboardsVisited.Count; j++)
            {
                if (vars.BillboardLocations[i].X == vars.BillboardsVisited[j].X && vars.BillboardLocations[i].Y == vars.BillboardsVisited[j].Y && vars.BillboardLocations[i].Z == vars.BillboardsVisited[j].Z) 
                {
                    // Already been on the billboard
                    return false;
                }
            }

            // Runner hasn't been on the current billboard, add it to the visited list
            vars.BillboardsVisited.Add(vars.BillboardLocations[i]);

            // Only split if runners has choosen for it to split after for example 3, 5, 8, 12, and etc 
            return settings["billboard_" + vars.BillboardsVisited.Count];
        }
    }
}

onReset
{
    vars.BillboardsVisited.Clear();
}

exit
{
    timer.IsGameTimePaused = true;
}
