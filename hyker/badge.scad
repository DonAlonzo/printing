module hyker_logo(scale = 1, thickness = 0.05, $fn = 32) {
  a_outer = scale / 2;
  a_inner = (scale - thickness) / 2;
  b_outer = scale * sqrt(3) / 2;
  b_inner = (scale - thickness) * sqrt(3) / 2;
  
  union() {
    minkowski() {
      difference() {
        polygon([
          [0, -scale],
          [b_outer, -a_outer],
          [b_outer, a_outer],
          [0, scale],
          [-b_outer, a_outer],
          [-b_outer, -a_outer],
        ]);
        polygon([
          [0, -(scale - thickness)],
          [b_inner, -a_inner],
          [b_inner, a_inner],
          [0, scale - thickness],
          [-b_inner, a_inner],
          [-b_inner, -a_inner],
        ]);
      };
      circle(r = thickness, $fn = $fn);
    };
    
    minkowski() {
      difference() {
        polygon([
          [-b_outer / 2, -a_outer / 2],
          [0, -scale / 2],
          [b_outer / 2, -a_outer / 2],
          [b_outer / 2, a_outer / 2],
          [0, scale / 2],
          [-b_outer / 2, a_outer / 2],
          [0, 0],
          [0, 0.01],
          [-b_inner / 2, a_inner / 2],
          [0, (scale - thickness) / 2],
          [b_inner / 2, a_inner / 2],
          [b_inner / 2, -a_inner / 2],
          [0, -(scale - thickness) / 2],
          [-b_inner / 2, -a_inner / 2],
        ]);
      };
      circle(r = thickness, $fn = $fn);
    };
  };
}

#difference() {
  cube([80, 30, 1]);

  translate([15, 16, 0.5])
  linear_extrude(height = 1)
  text(
    "HYKER SECURITY",
    5,
    font = "Nunito Light",
    spacing = 1.1
  );

  translate([18, 5, 0.5])
  linear_extrude(height = 1)
  text(
    "Hampus Björkdahl",
    4,
    font = "Nunito Light"
  );

  translate([9.5, 18.5, 0.5])
  linear_extrude(height = 1)
  hyker_logo(5, 0.125);
}