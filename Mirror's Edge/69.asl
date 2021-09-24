// Autosplitter for the game Mirror's Edge for the category "69 Stars"
// Made by: Toyro98

// Created: 28th Oct 2020
// Updated: 24th Sep 2021

state ("MirrorsEdge", "Steam") 
{
    int total_checkpoints : 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D0;
    int checkpoint : 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D4;
    int id : 0x01C55EA8, 0x170, 0x74, 0xC, 0xFC;
    float x : 0x01C553D0, 0xCC, 0x1CC, 0xD0, 0x10, 0xE8;
}

state ("MirrorsEdge", "Origin") 
{
    int total_checkpoints : 0x01C14D64, 0x54, 0x1E0, 0x318, 0x3D0;
    int checkpoint : 0x01C14D64, 0x54, 0x1E0, 0x318, 0x3D4;
    int id : 0x01C6EFE0, 0x1A0, 0x74, 0xC, 0xFC;
    float x : 0x01B7C39C, 0xCC, 0x70, 0x2F8, 0xE8; 
}

state ("MirrorsEdge", "GoG") 
{
    int total_checkpoints : 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D0;
    int checkpoint : 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D4;
    int id : 0x01C55EA8, 0x170, 0x74, 0xC, 0xFC;
    float x : 0x01C553D0, 0xCC, 0x1CC, 0xD0, 0x10, 0xE8;
}

state ("MirrorsEdge", "Reloaded") 
{
    int total_checkpoints : 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x3D0;
    int checkpoint : 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x3D4;
    int id : 0x01C60078, 0x2E0, 0x1CC, 0x418;
    float x : 0x01B7C39C, 0xCC, 0x70, 0x1C0, 0xE8;
}

init 
{
    switch (modules.First().ModuleMemorySize.ToString()) 
    {
        case "32976896": 
            version = "Steam"; 
            break;

        case "42889216": 
            version = "Origin"; 
            break;

        case "32632832": 
            version = "GoG"; 
            break;

        case "60298504": 
            version = "Reloaded"; 
            break;

        default: 
            version = "Unknown Version :( [" + modules.First().ModuleMemorySize.ToString() + "]"; 
            break;
    }
}

start 
{
    if (current.checkpoint == 0 && current.id == 0 && current.x != -79.89811f)
    {
        if (old.x == -79.89811f)
        {
            return true;
        }
    }
}

split 
{
    if (current.checkpoint > old.checkpoint) 
    {
        if (current.checkpoint == current.total_checkpoints) 
        {
            return true;
        }
    } 
}

exit
{
    timer.IsGameTimePaused = true;
}
