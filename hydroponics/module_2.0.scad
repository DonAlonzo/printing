Z_FIGHTING_MARGIN = 0.1;

h_module = 30;
r_module = 22;
t_module = 1;

r_pipe = 3;
t_pipe = 0.5;

r_insert = 10;
h_insert = 22;
t_insert = 0.5;
a_insert = 30;

fn = 512;
indent = 2;

body(
    r_module,
    h_module,
    t_module,
    
    r_pipe,
    t_pipe,
    
    r_insert,
    h_insert,
    t_insert,
    a_insert,
    
    indent,
    fn
);

module body(
    r_module,
    h_module,
    t_module,
    
    r_pipe,
    t_pipe,
    
    r_insert,
    h_insert,
    t_insert,
    a_insert,
    
    indent,
    fn
) {
    difference() {
        // Module body
        holynder(
            r_module,
            h_module,
            t_module,
            fn,
            center = true
        );
        
        // Inserts
        for (i = [1 : 3]) {
            rotate([0, 0, (i + 0.5) * 360 / 3])
            translate([r_module, 0, 0])
            rotate([0, 45, 0])
            cylinder(
                r = r_insert - t_insert,
                h = h_insert,
                center = true,
                $fn = fn
            );
        }
    }
    
    difference() {
        // Inserts
        for (i = [1 : 3]) {
            rotate([0, 0, (i + 0.5) * 360 / 3])
            translate([r_module, 0, 0])
            rotate([0, 45, 0])
            holynder(
                r_insert,
                h_insert,
                t_insert,
                fn,
                center = true
            );
        }
        
        // Module body
        cylinder(
            r = r_module - t_module,
            h = h_module,
            center = true,
            $fn = fn
        );
    }
    
    // Inner pipes
    for (i = [1 : 3]) {
        rotate([0, 0, i * 360 / 3])
        translate([r_module - t_module - r_pipe, 0, indent])
        inner_pipe(r_pipe, r_module, h_module, t_pipe, fn);
    }
    
}

module inner_pipe(
    r_inner,
    r_module,
    h_module,
    t_pipe,
    fn
) {
    holynder(
        r_inner,
        h_module,
        t_pipe,
        fn,
        center = true
    );
    
    difference() {
        distance = r_module - r_inner;
        angle = 2 * asin((r_inner) / distance);
        translate([-distance, 0, 0])
        rotate([0, 0, -angle / 2])
        rotate_extrude(
            angle = angle,
            $fn = fn
        )
        translate([distance - t_pipe / 2, -h_module / 2])
        square([r_inner + t_pipe / 2, h_module]);
        
        cylinder(
            r = r_inner,
            h = h_module + Z_FIGHTING_MARGIN,
            center = true,
            $fn = fn
        );
    }
}

module holynder(r, h, t, $fn, center = false) {
    rotate_extrude()
    if (center) translate([0, -h / 2])
    translate([r - t, 0])
    square([t, h]);
}