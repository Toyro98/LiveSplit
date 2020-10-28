state("MirrorsEdge") {
    
    int checkpoint : 0x01C499C0, 0xC4, 0x78, 0x2C, 0x3D4;

    // These doesn't work with current pointer path with offsets
    /*
    playground1
    playground2
    playground3
    heat
    burfield
    factory
    office
    shard1
    shard2
    */
}

// This below is just for testing if it worked
start {
    if (current.checkpoint == 0) {
        return true;
    }
}

split {
    if (current.checkpoint > old.checkpoint) {
        return true;
    }
}
