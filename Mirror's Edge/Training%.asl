/* 
* Autosplitter for the game Mirror's Edge for the category extension "Training%"
* Made by: Toyro98
*/

state ("MirrorsEdge", "Unknown") {}

state ("MirrorsEdge", "Steam") 
{
    byte tutorialCompleted: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3F8;
    byte movementChallenge: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3C8;
}

state ("MirrorsEdge", "Origin") 
{
    byte tutorialCompleted: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x3F8;
    byte movementChallenge: 0x01C14D64, 0x54, 0x1E0, 0x318, 0x3C8;
}

state ("MirrorsEdge", "GoG") 
{
    byte tutorialCompleted: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3F8;
    byte movementChallenge: 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3C8;
}

state ("MirrorsEdge", "Reloaded") 
{
    byte tutorialCompleted: 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x3F8;
    byte movementChallenge: 0x01C14D5C, 0x54, 0x1E0, 0x318, 0x3C8;
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
            MessageBox.Show("It appears you're running an unknown version of the game :(\nIf you're not running on Steam, Origin, GoG, or Reloaded. Please contact Toyro98#0001 on Discord for help!\n\nMemory Size: " + modules.First().ModuleMemorySize.ToString(), "Unknown Version Detected!");
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

    settings.SetToolTip("splitType", "Setting the Split Type to false will make it only split when you finish the training");
    settings.SetToolTip("noTab", "9 splits required");
    settings.SetToolTip("withTab", "2 splits required");
}

update
{
    // Debug stuff. You need DebugView to see it
    // Useful if you want to create your own rules where to split
    if (current.movementChallenge != old.movementChallenge) 
    {
        print("current.movementChallenge = " + current.movementChallenge + "\n" + "old.movementChallenge = " + old.movementChallenge + "\n");
    }

    if (current.tutorialCompleted != old.tutorialCompleted) 
    {
        print("current.tutorialCompleted = " + current.tutorialCompleted + "\n" + "old.tutorialCompleted = " + old.tutorialCompleted + "\n"); 
    }
}

onStart
{ 
    vars.splitIndex = 0;
}

split 
{
    // Don't ask me why it has to be "151"
    // It's 0 until the exact frame the save icon appears
    if (current.tutorialCompleted == 151) 
    {
        return true;
    } 

    // Don't check other if statements if both are at 0
    if (current.movementChallenge == 0 && old.movementChallenge == 0) 
    {
        return false;
    }

    if (settings["noTab"] == true) 
    {
        // The Basics -> Follow the leader
        if (vars.splitIndex == 0 && (old.movementChallenge == 0 || old.movementChallenge == 5) && current.movementChallenge == 6) 
        {
            vars.splitIndex++;
            return true;
        }

        // Follow the leader -> Balance Walk
        if (vars.splitIndex == 1 && (old.movementChallenge == 0 || old.movementChallenge == 9) && current.movementChallenge == 10)
        {
            vars.splitIndex++;
            return true;
        }

        // Balance Walk -> Climbing
        if (vars.splitIndex == 2 && (old.movementChallenge == 0 || old.movementChallenge == 10) && current.movementChallenge == 11)
        {
            vars.splitIndex++;
            return true;
        }

        // Climbing -> The L-jump
        if (vars.splitIndex == 3 && (old.movementChallenge == 0 || old.movementChallenge == 15) && current.movementChallenge == 17)
        {
            vars.splitIndex++;
            return true;
        }

        // The L-jump -> Zip line
        if (vars.splitIndex == 4 && (old.movementChallenge == 0 || old.movementChallenge == 34) && current.movementChallenge == 18)
        {
            vars.splitIndex++;
            return true;
        }

        // Zip line -> Advanced jumping
        if (vars.splitIndex == 5 && (old.movementChallenge == 0 || old.movementChallenge == 19) && current.movementChallenge == 37)
        {
            vars.splitIndex++;
            return true;
        }

        // Advanced jumping -> Basic combat
        if (vars.splitIndex == 6 && (old.movementChallenge == 0 || old.movementChallenge == 21) && current.movementChallenge == 24)
        {
            vars.splitIndex++;
            return true;
        }

        // Basic combat -> Advanced combat
        if (vars.splitIndex == 7 && (old.movementChallenge == 0 || old.movementChallenge == 27) && current.movementChallenge == 30)
        {
            return true;
        }

        return false;
    }

    if (settings["withTab"] == true) 
    {
        // The Basics -> Advanced combat
        if (old.movementChallenge != 30 && current.movementChallenge == 30) 
        {
            return true;
        }

        return false;
    }
}