state("MirrorsEdge") {
    
    /* Possible pointer path with offsets
    0x01BFBB70, 0x4, 0x1F4, 0x318, 0x3D4;
    0x01BFBB70, 0x1F4, 0x318, 0x3D4;
        
    0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D4;
    0x01BFBCA4, 0x54, 0x1E0, 0x318, 0x3D4;
    */

    int checkpoint : 0x01BFBB70, 0x4, 0x1F4, 0x318, 0x3D4;
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
