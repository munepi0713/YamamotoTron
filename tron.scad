// To generate STL data, you need to export one part by one,
// by controlling the following parameters.

// part(s) to show.
//   [a, b, c]
//   a = {0, 1} --> Set 1 to show the base board part.
//   b = {0, 1} --> Set 1 to show the front tire part.
//   c = {0, 1} --> Set 1 to show the body part.
parts_to_show = [1, 1, 1];

// scale factor
//   1.0 --> normal size. W161  mm x D101  mm x H85mm
//   0.5 --> small size.  W 80.5mm x D 80.5mm x H42mm
fscale = 1.0;
//fscale = 0.5;

// cylind/curve face dividing precision
// 0.01 --> unbelievably precise, but too slow to use.
// 0.1  --> very precise, and best for STL generation.
// 0.3  --> good precision, and good for STL generation.
// 1    --> good balance to preview.
//prec = 0.01;
//prec = 0.1;
//prec = 0.3;
prec = 1;

module block(a, b, c, x, y, z, cr, cg, cb) {
    color([cr / 255.0, cg / 255.0, cb / 255.0])
    translate([x, y, z])
    cube([2 * a, 2 * b, 2 * c], center=true);
}

module plane(a, b, c, x, y, z, cr, cg, cb) {
    color([cr / 255.0, cg / 255.0, cb / 255.0])
    translate([x - 500, y - 200, z - 500])
    rotate(a=[-10, 0, 0])
    cube([1000, 100, 1000], center=false);
}

module cylind(a, b, c, x, y, z, cr, cg, cb) {
    if (a == 0) {
        color([cr / 255.0, cg / 255.0, cb / 255.0])
        translate([x - 500, y, z])
        rotate(a=[0,90,0])
        cylinder(h=1000, r1=b, r2=c, $fa=1, $fs=prec);
    }
}

module curve(a, b, c, x, y, z, cr, cg, cb) {
    m = [ [a, 0, 0, x],
          [0, b, 0, y],
          [0, 0, c, z],
          [0, 0, 0, 1] ];
    multmatrix(m) {
        color([cr / 255.0, cg / 255.0, cb / 255.0])
        sphere(1, $fa=1, $fs=prec * 0.1);
    }
}

module checker_block(a, b, c, x, y, z) {
    colors = [
        [1.0, 1.0, 1.0],
        [1.0, 0.3, 0.7],
    ];
    for (aa=[-a:10:a-10]) {
        for (bb=[-b:10:b-10]) {
            for (cc=[-c:10:c-10]) {
                if ((abs(aa+bb+cc-a-b-c) % 20) == 10) {
                    color(colors[0])
                    translate([x + aa, y + bb, z + cc])
                    cube([11, 10, 11]);
                } else {
//                    color(colors[1])
//                    translate([x + aa, y + bb, z + cc])
//                    cube([10, 10, 10]);
                }
            }
        }
    }
}


// 0, 1, 1,0, 20,20,65, 0,20,45, 1,1.0, 250, 128,210,0
module p0() {
    block(20,20,65, 0,20,45, 128,210,0);
}

// 0, 3, 1,0, 25,40,70, 0,0,40, 1,1.0, 250, 128,210,0
module p1() {
    curve(25,40,70, 0,0,40, 128,210,0);
}

// 0, 3, 1,0, 0,30,30, 0,-5,0, -1,1.0, 250, 128,211,0
module p2() {
    cylind(0,30,30, 0,-5,0, 128,211,0);
    // a=0
}

// 0, 1, 1,0, 20,10,30, 0,-10,80, 1,1.0, 250, 128,211,0
module p3() {
    block(20,10,30, 0,-10,80, 128,211,0);
}

// 0, 2, 1,0, 0,-1.5,-1, 0,0,50, 1,1.0, 250, 128,211,0
module p4() {
    plane(0,-1.5,-1, 0,0,50, 128,211,0);
}

// 0, 1, 1,0, 22,28,28, 0,-5,0, 1,1.0,250, 0,211,211
module p5() {
    block(22,28,28, 0,-5,0, 0,211,211);
}

// 0, 3, 1,0, 40,28,28, 0,-5,0, 1,1.0,250, 0,211,211
module p6() {
    curve(40,28,28, 0,-5,0, 0,211,211);
}

// 0, 3, 1,0, 0,15,15, 0,-5,0, 1,1.0,250, 0,211,211
module p7() {
    cylind(0,15,15, 0,-5,0, 0,211,211);
}

// rear tire (red part)
// 0, 3, 1,0, 15,25,25, 0,-5,70, 1,1.0,250, 211,0,0
module p8() {
    curve(15,25,25, 0,-5,70, 211,0,0);
}

// 0, 1, 1,0, 5,11,45, 0,35,40, 1,1.0,250, 211,128,0
module p9() {
    block(5,11,45, 0,40,40, 211,128,0);
}

// 0, 3, 1,0, 30,45,75, 0,0,40, 1,1.0,250, 211,128,0
module p10() {
    curve(30,45,75, 0,0,40, 211,128,0);
}

// 0, 1, 1,0, 25,41,70, 0,5,40, 1,1.0,250, 0,0,0
module p11() {
    block(25,41,70, 0,5,40, 0,0,0);
}

// base board
// 1, 1, 1,0, 50,5,200, 0,-35,150, 1,1.0,250, 200,200,200
module p12() {
    difference() {
        union() {
            checker_block(50,5,80, 0,-35,40);
            block(49.5,4.5,79.5, 0.5,-35.5,40.5, 255, 48, 208);
        }
        block(18,3.1,16, 26,-37,-17.5, 48, 48, 208);
        block(18,3.1,16, 26,-37,21, 48, 48, 208);
        block(18,3.1,16, 26,-37,59.5, 48, 48, 208);
        block(18,3.1,16, 26,-37,98, 48, 48, 208);
        block(18,3.1,16, -26,-37,-17, 48, 48, 208);
        block(18,3.1,16, -26,-37,21, 48, 48, 208);
        block(18,3.1,16, -26,-37,59.5, 48, 48, 208);
        block(18,3.1,16, -26,-37,98, 48, 48, 208);
    }
}

// 0, 3, 1,0, 25,10,10, 0,-5,0, 1,1.0,250, 211,128,128
module p13() {
    curve(25,10,10, 0,-5,0, 211,128,128);
}

// 0, 3, 2,0, 25,20,20, 0,0,70, 1,0.3,0, 0,0,255
module p14() {
    curve(25,20,20, 0,0,70, 0,0,255);
}

// shaft of front tire
module p15() {
    color([0.2, 0.2, 0.2])
    translate([0, -5, 0])
    rotate(a=[-45,0,0])
    cylinder(h=25, r=3, $fn=50);
}

// joint pole on front tire.
module p16() {
    block(4,6.5,8, 0,-33,0, 0,0,0);
}

// joint pole on rear tire.
module p17() {
    block(4,6.5,8, 0,-33,70, 0,0,0);
}

// joint hole for front tire
module p16inv() {
    block(4.1,6.5,8.1, 0,-33,0, 128,128,255);
    block(3.8,7,7.8, 0,-34,0, 128,128,255);
}

// joint hole for rear tire.
module p17inv() {
    block(4.1,6.5,8.1, 0,-33,70, 128,128,255);
    block(3.8,7,7.8, 0,-34,70, 128,128,255);
}

module base_board() {
    difference() {
        // 12,-1
        p12();

        union() {
            p16inv();
            p17inv();
            intersection() {
                p5();
                p6();
            }
        }
    }
}

module body() {
    // upper body (green part)
    // 0,1,2,-1
    difference(){
        intersection() {
            p0();
            p1();
        }
        p2();
    }
    
    // lower body (green part)
    // 3,1,4,-1
    difference() {
        intersection() {
            p3();
            p1();
        }
        p4();
    }

    // top design on body (orange part)
    // 9,10,-1
    intersection() {
        p9();
        p10();
    }
    
    // rear tire (red part)
    // 8,-1
    p8();

    // axis of rear tire (blue part)
    // 14,-1
    p14();

    // joint part under rear tire (black part)
    p17();
}

module front_tire() {
    // front tier (cyan part)
    // 5,6,7,-1
    difference() {
        intersection() {
            p5();
            p6();
        }
        p7();
    }

    // axis of front tier (pink part)
    // 13,-1
    p13();

    // shaft of front tire (gray part)
    p15();

    // joint part under front tier (black part)
    p16();
}

// main
scale([fscale, fscale, fscale])
rotate(a=[90,0,0]) {
    if (parts_to_show[0]) {
        base_board();
    }
    if (parts_to_show[1]) {
        front_tire();
    }
    if (parts_to_show[2]) {
        body();
    }
}
