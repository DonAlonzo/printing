use <3dparty/springs.scad>; 
// spring with default values 

   translate([0,200*0,0])
   color("yellow")
   spring();

// rect spring
   translate([0,200*1,0])
   color("blue")
   spring(R1=100, w = 20,  h=10); 

// quadratic spring reversed
   color("red")
   translate([0,200*2,0])
   spring(w=10, H=100, reverse=true); 

// negative height, partial windings allowed, ring at start added 
   color("green")
   translate([0,200*3,0])
   spring(windings = 2.5, H=-50, center = false, start=true);   

// conical spring
   color("grey")
   translate([0,200*4,0])
   spring(windings = 5.5, R = 30, R1=100, ends=true); 


// flat spring
   color("aqua")
   translate([0,200*5,0])
   spring(H=0, R=100, R1 = 10); 

// flat rect spring
   color("fuchsia")
   translate([0,200*6,0])
   spring(H=0, R=70, R1=10, w=2, h=10); 

// flat quadratic spring ccw
   color("olive")
   translate([0,200*7,0])
   spring(H=0, R=100, R1=10, w=8); 

// flat quadratic spring cw
   color("silver")
   translate([0,200*8,0])
   spring(H=0, R=10, R1=100, w=8); 

// device to roll your own springs
   color("teal")
   translate([0,200*9,0])
   springmaker(r=3, R=20, R1=40, h=50, ends =true);
 
   
   
// ** error ** this radius causes self intersection
/* spring(r=15);  */