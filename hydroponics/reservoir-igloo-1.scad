cog_h = 3;
h_male = 5;
h_tube = 5;
r_tube = 7;
w_wall_tube = 0.75;
w_wall = 0.75;
w_floor = 0.5;
depth = 3;
fn = 181;

r = 80;
h_female = 4;

h = 3;
r_male = 22;
r_female = 25;
gap = 0.15;
cog_h1 = 0.99;
cog_h2 = 1.89;
cog_l = 1.5;
cog_n = 3;
angular_length_slit = 64;
angular_length_cog = 12;
angular_gap = 4;

r_extension_inner =  2 * r_male - r_female + 1;

z_cutoff_male = sqrt(r*r - r_male*r_male);
z_cutoff_female = sqrt(r*r - r_female*r_female);

h_extension = 1.5;

module female() {
    difference() {
        cylinder(h, r1 = r_female, r2 = r_female, $fn = fn);
        
        union() {
            // Male connector hole
            cylinder(h, r1 = r_male + gap, r2 = r_male + gap, $fn = fn);
            
            // Slits
            rotate([0, 0, -(angular_length_cog + angular_gap) / 2])
            for (i = [0 : cog_n]) {
                rotate([ 0, 0, 360 * i / cog_n ]) {
                    rotate_extrude( angle = angular_length_cog + angular_gap, $fn = fn )
                    translate([ r_male + gap, 0, 0 ])
                    polygon([
                        [ cog_l, 0 ],
                        [ 0, 0 ],
                        [ 0, 4 ],
                        [ cog_l, 4 ]
                    ]);
                    
                    rotate([0, 0, angular_length_cog + angular_gap])
                    rotate_extrude( angle = angular_length_slit, $fn = fn )
                    translate([ r_male + gap, 0, 0 ])
                    polygon([
                        [ cog_l, 0 ],
                        [ 0, 0 ],
                        [ 0,  cog_h2 + gap ],
                        [ cog_l, cog_h1 + gap ]
                    ]);
                }
            }
        }
    }
}



union() {
    // Female
    translate([0, 0, z_cutoff_female + h_extension])
    female();

    // Female extension
    difference() {
        translate([0, 0, z_cutoff_female]) {
            difference() {
                cylinder(h_extension, r1 = r_female, r2 = r_female, $fn = fn);
                
                cylinder(h_extension, r1 = r_extension_inner, r2 = r_extension_inner, $fn = fn);
            }
        }
        difference() {
            sphere(r, $fn = fn);
            translate([0, 0, r])
            cube(size = [r, r, (r - z_cutoff_male) * 2], center = true);
        }
    }

    // Tube
    h_tube_offset = 1;
    r_tube_outer = 3.5 + w_wall;
    r_tube_inner = r_tube_outer - w_wall_tube;
    difference() {
        translate([r + 8, 0, r_tube_inner + w_floor + w_wall_tube / 2 + h_tube_offset])
        rotate([0, -90, 0])
        cylinder(h = 25, r1 = r_tube_outer, r2 = r_tube_outer, $fn = fn);
        
        // Inner tube
        translate([r + 15, 0, w_floor + r_tube_inner + w_wall_tube / 2 + h_tube_offset])
        rotate([0, -90, 0])
        cylinder(h = 30, r1 = r_tube_inner, r2 = r_tube_inner, $fn = fn);
        
        // Igloo
        sphere(r, $fn = fn);
    }

    difference() {
        sphere(r, $fn = fn);
        
        translate([0, 0, -r])
        cube(size = r * 2, center = true);
        
        // Hollowness
        difference() {
            sphere(r - w_wall, $fn = fn);
            
            translate([0, 0, -r + w_floor])
            cube(size = r * 2, center = true);
        }
        
        translate([0, 0, r])
        cube(size = [r, r, (r - z_cutoff_male) * 2], center = true);
        
        // Top hole
        translate([0, 0, z_cutoff_male - r / 2])
        cylinder(h = r, r1 = r_extension_inner, r2 = r_extension_inner, $fn = fn);
        
        // Tube hole
        translate([r, 0, w_floor + r_tube_inner + w_wall_tube / 2 + h_tube_offset])
        rotate([0, -90, 0])
        cylinder(h = 10, r1 = r_tube_inner, r2 = r_tube_inner, $fn = fn);
    }
}
