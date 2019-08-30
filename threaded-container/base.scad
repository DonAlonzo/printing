difference() {
    scale([1, 1, 0.5])
    translate([-105, -65, 0])
    import("base.stl");
    
    translate([0, 0, 23])
    cube([100, 100, 10], center = true);
}