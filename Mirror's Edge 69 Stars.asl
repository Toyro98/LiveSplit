state("MirrorsEdge") {
    // int playground1;
    // int playground2;
    // int playground3;
    // int edge;
    // int arland;
    int flight : 0x01C499C0, 0xC4, 0x78, 0x2C, 0x3D4;
    // int chase;
    // int stormdrains1;
    // int stormdrains2;
    // int stormdrains3;
    // int heat;
    // int burfield;
    // int cranes1;
    // int cranes2;
    // int neweden;
    // int factory;
    // int office;
    // int convoy1;
    // int convoy2;
    // int atrium1;
    // int atrium2;
    // int shard1;
    // int shard2;
}

// This below is just for testing if it worked
start {
    if (current.flight == 0) {
        return true;
    }
}

split {
    if (current.flight > old.flight) {
        return true;
    }
}
