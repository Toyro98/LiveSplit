state ("MirrorsEdge", "Unknown") {}

state ("MirrorsEdge", "Steam") 
{
    byte tutorialCompleted: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3A0;
    byte movementChallenge: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3C8;
}

state ("MirrorsEdge", "Origin") 
{
    byte tutorialCompleted: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x3A0;
    byte movementChallenge: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x3C8;
}

state ("MirrorsEdge", "Reloaded") 
{
    byte tutorialCompleted: 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x3A0;
    byte movementChallenge: 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x3C8;
}

state ("MirrorsEdge", "Origin (Asia)") 
{
    byte tutorialCompleted: 0x01BE6134, 0x54, 0x1E0, 0x318, 0x3A0;
    byte movementChallenge: 0x01BE6134, 0x54, 0x1E0, 0x318, 0x3C8;
}

state ("MirrorsEdge", "Origin (DLC)") 
{
    byte tutorialCompleted: 0x01C1BE24, 0x54, 0x1E0, 0x318, 0x3A0;
    byte movementChallenge: 0x01C1BE24, 0x54, 0x1E0, 0x318, 0x3C8;
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

    vars.splitIndex = 0;
}

startup
{
    settings.Add("splitType", true, "Split Type");
    settings.Add("noTab", true, "No TAB skip", "splitType");
    settings.Add("withTab", false, "with TAB skip", "splitType");

    settings.SetToolTip("splitType", "Setting the Split Type to false will make it only split when you finish the training. 1 split required");
    settings.SetToolTip("noTab", "9 splits required");
    settings.SetToolTip("withTab", "2 splits required");
}

update
{
    // Debug stuff. You need DebugView to see it. Useful if you want to create your own rules where to split

    /*
    if (current.movementChallenge != old.movementChallenge) 
    {
        print("current.movementChallenge = " + current.movementChallenge + "\n" + "old.movementChallenge = " + old.movementChallenge + "\n");
    }

    if (current.tutorialCompleted != old.tutorialCompleted) 
    {
        print("current.tutorialCompleted = " + current.tutorialCompleted + "\n" + "old.tutorialCompleted = " + old.tutorialCompleted + "\n"); 
    }
    */
}

onStart
{ 
    vars.splitIndex = 0;
}

onSplit
{
    vars.splitIndex += 1;
}

split 
{
    // It's -1 until the exact frame the save icon appears
    if (current.tutorialCompleted == 0 && old.tutorialCompleted == 255) 
    {
        return true;
    } 

    if (current.movementChallenge == 0 && old.movementChallenge == 0) 
    {
        return false;
    }

    if (settings["withTab"]) 
    {
        // The Basics -> Advanced combat
        return old.movementChallenge != 30 && current.movementChallenge == 30;
    }

    if (settings["noTab"]) 
    {
        // The Basics -> Follow the leader
        if (vars.splitIndex == 0 && (old.movementChallenge == 0 || old.movementChallenge == 5) && current.movementChallenge == 6) 
        {
            return true;
        }

        // Follow the leader -> Balance Walk
        if (vars.splitIndex == 1 && (old.movementChallenge == 0 || old.movementChallenge == 9) && current.movementChallenge == 10)
        {
            return true;
        }

        // Balance Walk -> Climbing
        if (vars.splitIndex == 2 && (old.movementChallenge == 0 || old.movementChallenge == 10) && current.movementChallenge == 11)
        {
            return true;
        }

        // Climbing -> The L-jump
        if (vars.splitIndex == 3 && (old.movementChallenge == 0 || old.movementChallenge == 15) && current.movementChallenge == 17)
        {
            return true;
        }

        // The L-jump -> Zip line
        if (vars.splitIndex == 4 && (old.movementChallenge == 0 || old.movementChallenge == 34) && current.movementChallenge == 18)
        {
            return true;
        }

        // Zip line -> Advanced jumping
        if (vars.splitIndex == 5 && (old.movementChallenge == 0 || old.movementChallenge == 19) && current.movementChallenge == 37)
        {
            return true;
        }

        // Advanced jumping -> Basic combat
        if (vars.splitIndex == 6 && (old.movementChallenge == 0 || old.movementChallenge == 21) && current.movementChallenge == 24)
        {
            return true;
        }

        // Basic combat -> Advanced combat
        return vars.splitIndex == 7 && (old.movementChallenge == 0 || old.movementChallenge == 27) && current.movementChallenge == 30;
    }
}
