state("MirrorsEdge") {
    int tt_checkpoint : 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D4;
    int tt_checkpoint_time : 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D8;
    int tt_id : 0x01B993B0, 0x328, 0x60, 0x228, 0xFC;
}

startup {
    // Todo: fix name
    settings.Add("a", true, "A");
    settings.SetToolTip("a", "Split only when you finish a time trial");

    settings.Add("b", false, "B");
    settings.SetToolTip("b", "Split everytime where it would display if you're ahead or behind current ghost");

    settings.Add("c", false, "C");
    settings.SetToolTip("c", "Split everytime you touch a checkpoint (You need a lot of splits ~200)");

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
    // Start on Playground One
    if (current.tt_checkpoint == 0 && current.tt_id == 0) {
        return true;
    }
}

split {
    if (current.tt_checkpoint > old.tt_checkpoint) {
        if (current.tt_checkpoint == vars.tt_finalCheckpoint[current.tt_id]) {
            return true;
        } 
    }
}
