state ("MirrorsEdge", "Steam") {
    int tt_checkpoint : 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D4;
    int tt_checkpoint_time : 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D8;
    int tt_id : 0x01C47514, 0x28, 0x48, 0x3C, 0xFC;
    float x : 0x01C553D0, 0xCC, 0x1CC, 0xD0, 0x10, 0xE8;
    bool tt_selectionMenu : 0x01C47158, 0x44, 0xC8, 0x56C, 0x158, 0x1C4;
}

state ("MirrorsEdge", "Origin") {
    int tt_checkpoint : 0x01C14D64, 0x54, 0x1E0, 0x318, 0x3D4;
    int tt_checkpoint_time : 0x01C14D64, 0x54, 0x1E0, 0x318, 0x3D8;
    int tt_id : 0x01C6EFE0, 0x1A0, 0x74, 0xC, 0xFC;
    float x : 0x01B7C39C, 0xCC, 0x70, 0x2F8, 0xE8; 
    bool tt_selectionMenu : 0x01C5E4F0, 0x10, 0x28, 0xC8, 0x56C, 0xE0;
}

state ("MirrorsEdge", "GoG") {
    int tt_checkpoint : 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D4;
    int tt_checkpoint_time : 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D8;
    int tt_id : 0x01C47514, 0x28, 0x48, 0x3C, 0xFC;
    float x : 0x01C553D0, 0xCC, 0x1CC, 0xD0, 0x10, 0xE8;
    bool tt_selectionMenu : 0x01C47158, 0x44, 0xC8, 0x56C, 0x158, 0x1C4;
}

init {
    if (modules.First().ModuleMemorySize.ToString() == "32976896") {
        version = "Steam";
    } else if (modules.First().ModuleMemorySize.ToString() == "42889216") {
        version = "Origin";
    } else if (modules.First().ModuleMemorySize.ToString() == "32632832") {
        version = "GoG";
    } else {
        version = "Unknown";
        print(modules.First().ModuleMemorySize.ToString());
    }
}

startup {
    settings.Add("splitFinish", true, "Split at end of a Time Trial");
    settings.SetToolTip("splitFinish", "It will only split when you finish a Time Trial");

    settings.Add("splitBehindorAhead", false, "Split when text shows up");
    settings.SetToolTip("splitBehindorAhead", "Split everytime where it would display if you're ahead or behind current ghost");

    settings.Add("splitEverytime", false, "Split everytime");
    settings.SetToolTip("splitEverytime", "If you touch a checkpoint, it will split. When using this, you'll get better sum of best but you need 214 splits!");

    vars.tt_finalCheckpoint = new List<int> 
    {
		{5},  // Playground One
		{10}, // Playground Two
		{12}, // Playground Three
		{7},  // Edge
		{6},  // Arland
		{8},  // Flight
		{6},  // Chase
		{15}, // Stormdrains One
		{9},  // Stormdrains Two
		{8},  // Stormdrains Three
		{9},  // Heat
		{5},  // Burfield
		{13}, // Cranes One
		{9},  // Cranes Two
		{6},  // New Eden
		{18}, // Factory
		{2},  // Office
		{7},  // Convoy One
		{9},  // Convoy Two
		{17}, // Atrium One
		{13}, // Atrium Two
		{10}, // Shard One
		{10}  // Shard Two
	};
}

start {
    if (old.tt_selectionMenu == true) {
        if (current.tt_checkpoint == 0 && current.tt_id == 0 && current.x != -79.89811f) {
            if (old.x == -79.89811f) {
                return true;
            } else {
                return false;
            }
        }
    }
}

reset {
    if (old.tt_selectionMenu == true) {
        if (current.tt_checkpoint == 0 && current.tt_id == 0 && current.x != -79.89811f) {
            if (old.x == -79.89811f) {
                return true;
            } 
        }
    }
}

split {
    if (settings["splitFinish"]) {
        if (current.tt_checkpoint > old.tt_checkpoint) {
            if (current.tt_checkpoint == vars.tt_finalCheckpoint[current.tt_id]) {
                return true;
            } 
        }
    } else if (settings["splitBehindorAhead"]) {
        if (current.tt_checkpoint_time > old.tt_checkpoint_time) {
            return true;
        }
    } else if (settings["splitEverytime"]) {
        if (current.tt_checkpoint > old.tt_checkpoint) {
            return true;
        }
    }
}
