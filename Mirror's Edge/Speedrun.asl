state ("MirrorsEdge", "Unknown") {}

state ("MirrorsEdge", "Steam") 
{
    string16 mapName: 0x01C553D0, 0xCC, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x368, 0x100, 0x48, 0x0;
    int checkpointWeight: 0x01C553D0, 0xCC, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x368, 0x100, 0x54;
    byte isSpeedrunOver: 0x01C553D0, 0xCC, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x3C8;
    float speedrunTime: 0x01C553D0, 0xCC, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x368, 0x114;
    float worldTime: 0x01C553D0, 0xCC, 0x1CC, 0x9C, 0xC34;
}

state ("MirrorsEdge", "Origin") 
{
    string16 mapName: 0x01C6E50C, 0xCC, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x3C8, 0x100, 0x48, 0x0;
    int checkpointWeight: 0x01C6E50C, 0xCC, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x3C8, 0x100, 0x54;
    bool isSpeedrunOver: 0x01C6E50C, 0xCC, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x3C8;
    float speedrunTime: 0x01C6E50C, 0xCC, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x368, 0x114;
    float worldTime: 0x01C6E50C, 0xCC, 0x1CC, 0x9C, 0xC34;
}

state ("MirrorsEdge", "Reloaded") 
{
    string16 mapName: 0x01C6E50C, 0xCC, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x3C8, 0x100, 0x48, 0x0;
    int checkpointWeight: 0x01C6E50C, 0xCC, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x3C8, 0x100, 0x54;
    bool isSpeedrunOver: 0x01C6E50C, 0xCC, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x3C8;
    float speedrunTime: 0x01C6E50C, 0xCC, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x368, 0x114;
    float worldTime: 0x01C6E50C, 0xCC, 0x1CC, 0x9C, 0xC34;
}

state ("MirrorsEdge", "Origin (Asia)") 
{
    string16 mapName: 0x01B8BE54, 0xCC, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x3C8, 0x100, 0x48, 0x0;
    int checkpointWeight: 0x01B8BE54, 0xCC, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x3C8, 0x100, 0x54;
    bool isSpeedrunOver: 0x01B8BE54, 0xCC, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x3C8;
    float speedrunTime: 0x01B8BE54, 0xCC, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x368, 0x114;
    float worldTime: 0x01B8BE54, 0xCC, 0x1CC, 0x9C, 0xC34;
}

state ("MirrorsEdge", "Origin (DLC)") 
{
    string16 mapName: 0x01C7561C, 0xE4, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x3C8, 0x100, 0x48, 0x0;
    int checkpointWeight: 0x01C7561C, 0xE4, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x3C8, 0x100, 0x54;
    bool isSpeedrunOver: 0x01C7561C, 0xE4, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x3C8;
    float speedrunTime: 0x01C7561C, 0xE4, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x368, 0x114;
    float worldTime: 0x01C7561C, 0xE4, 0x1CC, 0x9C, 0xC34;
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

    // MapName, CheckpointWeight
    vars.checkpoints = new Tuple<string,int>[]
    {
        // Comment out checkpoints you don't want it to split at or add your own

        // Chapter 0 (The Edge/Prologue)
        Tuple.Create("Edge_p", 5), // 0B
        Tuple.Create("Edge_p", 30), // 0C
        Tuple.Create("Edge_p", 40), // 0D

        // Chapter 1 (Flight)
        Tuple.Create("Escape_p", 15), // 1B
        Tuple.Create("Escape_p", 30), // 1C
        Tuple.Create("Escape_p", 50), // 1D
        Tuple.Create("Escape_p", 60), // 1E

        // Chapter 2 (Jacknife)
        Tuple.Create("Stormdrain_p", 30), // 2B
        Tuple.Create("Stormdrain_p", 50), // 2C
        Tuple.Create("Stormdrain_p", 95), // 2D
        Tuple.Create("Stormdrain_p", 120), // 2E
        Tuple.Create("Stormdrain_p", 135), // 2F
        Tuple.Create("Stormdrain_p", 140), // 2G

        // Chapter 3 (Heat)
        Tuple.Create("Cranes_p", 40), // 3B
        Tuple.Create("Cranes_p", 80), // 3C
        Tuple.Create("Cranes_p", 120), // 3D

        // Chapter 4 (Ropeburn)
        Tuple.Create("Subway_p", 30), // 4B
        Tuple.Create("Subway_p", 50), // 4C
        Tuple.Create("Subway_p", 60), // 4D
        Tuple.Create("Subway_p", 80), // 4E
        Tuple.Create("Subway_p", 100), // 4F

        // Chapter 5 (New Eden)
        Tuple.Create("Mall_p", 50), // 5B
        Tuple.Create("Mall_p", 90), // 5C
        Tuple.Create("Mall_p", 130), // 5D

        // Chapter 6 (Pirandello Kruger)
        Tuple.Create("Factory_p", 30), // 6B
        Tuple.Create("Factory_p", 60), // 6C
        Tuple.Create("Factory_p", 80), // 6D
        Tuple.Create("Factory_p", 90), // 6E

        // Chapter 7 (The Boat)
        Tuple.Create("Boat_p", 15), // 7B
        Tuple.Create("Boat_p", 30), // 7C
        Tuple.Create("Boat_p", 45), // 7D
        Tuple.Create("Boat_p", 60), // 7E
        Tuple.Create("Boat_p", 70), // 7F

        // Chapter 8 (Kate)
        Tuple.Create("Convoy_p", 25), // 8B
        Tuple.Create("Convoy_p", 50), // 8C
        Tuple.Create("Convoy_p", 85), // 8D
        Tuple.Create("Convoy_p", 95), // 8E

        // Chapter 9 (The Shard)
        Tuple.Create("Scraper_p", 7), // 9B
        Tuple.Create("Scraper_p", 12), // 9C
        Tuple.Create("Scraper_p", 20), // 9D
        Tuple.Create("Scraper_p", 35), // 9E
        Tuple.Create("Scraper_p", 45), // 9F
        Tuple.Create("Scraper_p", 60), // 9G
    };

    vars.lastCheckpointWeight = 0;
}

reset
{
    if (current.worldTime == 0f)
    {
        vars.lastCheckpointWeight = 0;
        timer.SetGameTime(TimeSpan.FromSeconds(0f));

        return true;
    }
}

start
{
    if (old.speedrunTime == 0f && current.speedrunTime > 0f)
    {
        vars.lastCheckpointWeight = 0;
        timer.SetGameTime(TimeSpan.FromSeconds(0f));

        return true;
    }
}

split
{
    if (current.isSpeedrunOver == 1 && old.isSpeedrunOver == 0)
    {
        return true;
    }

    if (current.checkpointWeight > old.checkpointWeight && current.checkpointWeight != 0 && old.checkpointWeight != 0)
    {
        // print("[ASL] current.checkpointWeight: " + current.checkpointWeight + " old.checkpointWeight: " + old.checkpointWeight);

        foreach (var checkpoint in vars.checkpoints) 
        {
            if (checkpoint.Item1 == current.mapName && checkpoint.Item2 == current.checkpointWeight && vars.lastCheckpointWeight != current.checkpointWeight)
            {
                vars.lastCheckpointWeight = current.checkpointWeight;
                return true;
            }
        }
    }
}

update
{
    if (current.speedrunTime > 0f)
    {
        timer.IsGameTimePaused = false;
        timer.SetGameTime(TimeSpan.FromSeconds(current.speedrunTime));
    }
    else
    {
        timer.IsGameTimePaused = true;
    }
}
