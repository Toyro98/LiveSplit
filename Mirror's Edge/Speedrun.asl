state ("MirrorsEdge", "Unknown") {}

state ("MirrorsEdge", "Steam") 
{
    byte isSpeedrunOver: 0x01C553D0, 0xCC, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x3C8;
    float speedrunTime: 0x01C553D0, 0xCC, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x368, 0x114;
    float worldTime: 0x01C553D0, 0xCC, 0x1CC, 0x9C, 0xC34;
}

state ("MirrorsEdge", "Origin") 
{
    byte isSpeedrunOver: 0x01C6E50C, 0xCC, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x3C8;
    float speedrunTime: 0x01C6E50C, 0xCC, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x368, 0x114;
    float worldTime: 0x01C6E50C, 0xCC, 0x1CC, 0x9C, 0xC34;
}

state ("MirrorsEdge", "Reloaded") 
{
    byte isSpeedrunOver: 0x01C6E50C, 0xCC, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x3C8;
    float speedrunTime: 0x01C6E50C, 0xCC, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x368, 0x114;
    float worldTime: 0x01C6E50C, 0xCC, 0x1CC, 0x9C, 0xC34;
}

state ("MirrorsEdge", "Origin (Asia)") 
{
    byte isSpeedrunOver: 0x01B8BE54, 0xCC, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x3C8;
    float speedrunTime: 0x01B8BE54, 0xCC, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x368, 0x114;
    float worldTime: 0x01B8BE54, 0xCC, 0x1CC, 0x9C, 0xC34;
}

state ("MirrorsEdge", "Origin (DLC)") 
{
    byte isSpeedrunOver: 0x01C7561C, 0xE4, 0x1CC, 0x2F8, 0x9C, 0xCC4, 0x3C8;
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
}

reset
{
    if (current.worldTime == 0.0f)
    {
        timer.SetGameTime(TimeSpan.FromSeconds(0.0f));
        return true;
    }
}

start
{
    if (old.speedrunTime == 0.0f && current.speedrunTime > 0.0f)
    {
        timer.SetGameTime(TimeSpan.FromSeconds(0.0f));
        return true;
    }
}

split
{
    return current.isSpeedrunOver == 1 && old.isSpeedrunOver == 0;
}

update
{
    if (current.speedrunTime > 0.0f && old.isSpeedrunOver == 0)
    {
        timer.SetGameTime(TimeSpan.FromSeconds(current.speedrunTime));
    }
}
