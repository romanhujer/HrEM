/*  Bolts and Nuts v1.9.6 OpenSCAD Library
    Copyright (C) 2015 Cristiano Gariboldo - Pixel3Design.it

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
-------------------------------------------------------------------------

    The "nuts_and_bolts.scad" script includes the "threads.scad" library
    coded by Dan Kirshner v2.5 - dan_kirshner@yahoo.com to make it easier for
    those peoples that don't know how to include a new library into
    OpenSCAD and to make it work in the future into the MakerBot
    Customizer.

-------------------------------------------------------------------------
*/

use <threads.scad>;

function hex_dia (dia) = dia * ( 2 / sqrt (3) ); // return real size for hexagon side to side
function imp (imp_m) = imp_m * 25.4; // return converted imperial -> metric values

module cut_bit (height, radius) { // hegagonal nuts insertion cutout
    $fn = 64;
    union () {
        translate ([0, 0, height / 2]) cylinder (h = height / 2, r1 = hex_dia (radius + (radius * (3 / 10))), r2 = hex_dia (radius - (radius * (2 / 13)))); // top half cone
        translate ([0, 0, 0]) cylinder (h = height / 2, r2 = hex_dia (radius + (radius * (3 / 10))), r1 = hex_dia (radius - (radius * (2 / 13)))); // bottom half cone
    }
}

// EXAMPLES :

render = 0; // Set render at 1 to preview types, set to 0 otherwise.
    


if ( render == 1 ) {
//  conical_allen_bolt (height, width, head_size, head_height, tolerance, quality, thread, bool_round, allen_o, thread_len, pitch);
    translate ([63, 0, 0]) conical_allen_bolt (20, 3, 6, 4, 0.2, 32, "metric", 1, 2.5, 10, 0.4);
    translate ([63, -10, 0]) conical_allen_bolt (4/5, 1/8, 1/4, 1/8, 1/128, 32, "imperial", 0, 3/32, 1/3, 45);
    translate ([63, -20, 0]) conical_allen_bolt (20, 3, 6, 4, 0.2, 32);
    
//  allen_bolt (length, thread_d, head_h, head_d, a_depth, tolerance, quality, bool_round, allen_o, thread, pitch);
    translate ([0, 0, 0]) allen_bolt (10, 3, 3.5, 5.5, 3, 0.2, 32, 1, 2.5, "metric", 0.425);
    translate ([0, -10, 0]) allen_bolt (10, 3, 3.5, 5.5, 3, 0.2, 32, 1, 2.5);
    translate ([0, -20, 0]) allen_bolt (10, 3, 3.5, 5.5, 3, 0.2, 32);

//  hex_bolt (length, thread_d, head_h, head_d, tolerance, quality, thread, pitch);
    translate ([10, 0, 0]) hex_bolt (3/8, 2/8, 1/8, 3/8, 1/128, 32, 1, "imperial", 28);
    translate ([10, -10, 0]) hex_bolt (3/8, 2/8, 1/8, 3/8, 1/128, 32, 1, "imperial");
    translate ([10, -20, 0]) hex_bolt (3/8, 2/8, 1/8, 3/8, 1/128, 32, 0, "imperial", 28);

//  grub_bolt (length, thread_d, a_depth, tolerance, quality, allen_o, thread, pitch);
    translate ([20, 0, 0]) grub_bolt (4, 3, 3, 0.2, 32, 1.5, "metric", 0.425);
    translate ([20, -10, 0]) grub_bolt (4, 3, 3, 0.2, 32, 1.5);
    translate ([20, -20, 0]) grub_bolt (4, 3, 3, 0.2, 32);

//  cone_head_bolt (length, thread_d, head_h, head_d, a_depth, tolerance, quality, allen_o, thread, pitch);
    translate ([30, 0, 0]) cone_head_bolt (10, 3, 1.5, 5.5, 2, 0.2, 32, 2, "metric", 0.425);
    translate ([30, -10, 0]) cone_head_bolt (10, 3, 1.5, 5.5, 2, 0.2, 32, 2);
    translate ([30, -20, 0]) cone_head_bolt (10, 3, 1.5, 5.5, 2, 0.2, 32);

//  hex_nut (height, thread_d, size, tolerance, quality, thread, pitch);
    translate ([40, 0, 0]) hex_nut (1/8, 1/4, 3/8, 1/128, 32, 1, "imperial", 28);
    translate ([40, -10, 0]) hex_nut (1/8, 1/4, 3/8, 1/128, 32, 1, "imperial");
    translate ([40, -20, 0]) hex_nut (1/8, 1/4, 3/8, 1/128, 32, 0, "imperial");

//  washer (outer, inner, width, tolerance, quality, thread);
    translate ([53, 0, 0]) washer (3/8, 3/16, 1/16, 1/128, 32, "imperial");
}

/*

    variables marked by an * can be declared or not. Just remember that if you want to not set (eg. "allen_o") a variable, next vars MUST NOT BE DECLARED!!! Look at examples.

    conical_allen_bolt (height, width, head_size, head_height, tolerance, quality, thread, finish, allen_o, thread_len, pitch);
        height      =   total bar length
        width       =   bar diameter width
        head_size   =   diameter width of head cone base
        head_height =   height of cone head
        tolerance   =   tolerance of entire measures (always positive, addition and subtraction  already calculated within the script
        quality     =   overall quality of the returned function (ref. $fn)


    allen_bolt (length, thread_d, head_h, head_d, a_depth, tolerance, quality, allen_o, thread, pitch);
        length      =   threaded bar length
        thread_d    =   threaded bar diameter width
        head_h      =   cylindrical bolt head height
        head_d      =   cylindrical bolt head diameter
        a_depth     =   hexagonal Allen keyhole depth height
        tolerance   =   tolerance of entire measures (always positive, addition and subtraction  already calculated within the script
        quality     =   overall quality of the returned function (ref. $fn)
        *bool_round =   boolean that set roundness of the head
        *allen_o    =   allen hexagonal keyhole dimension
        *thread     =   string variable declaring measure type -> "metric" or "imperial"
        *pitch      =   stands for thread pitch

    hex_bolt (length, thread_d, head_h, head_d, tolerance, quality, bool_cut, thread, pitch);
        length      =   threaded bar length
        thread_d    =   threaded bar diameter width
        head_h      =   hexagonal bolt head height
        head_d      =   hexagonal bolt head size
        tolerance   =   tolerance of entire measures (always positive, addition and subtraction already
                        calculated within the script
        quality     =   overall quality of the returned function (ref. $fn)
        bool_cut    =   do (1) or not (0) the nut cut
        *thread     =   string variable declaring measure type -> "metric" or "imperial"
        *pitch      =   stands for thread pitch
        
    grub_bolt (length, thread_d, a_depth, tolerance, quality, allen_o, thread, pitch);
        length      =   threaded bar length
        thread_d    =   threaded bar diameter width
        a_depth     =   hexagonal Allen keyhole depth height
        tolerance   =   tolerance of entire measures (always positive, addition and subtraction already
                        calculated within the script
        quality     =   overall quality of the returned function (ref. $fn)
        *allen_o    =   allen hexagonal keyhole dimension
        *thread     =   string variable declaring measure type -> "metric" or "imperial"
        *pitch      =   stands for thread pitch
        
    cone_head_bolt (length, thread_d, head_h, head_d, a_depth, tolerance, quality, allen_o, thread, pitch);
        length      =   threaded bar length
        thread_d    =   threaded bar diameter width
        head_h      =   cylindrical bolt head height
        head_d      =   cylindrical bolt head diameter
        a_depth     =   hexagonal Allen keyhole depth height
        tolerance   =   tolerance of entire measures (always positive, addition and subtraction already
                        calculated within the script
        quality     =   overall quality of the returned function (ref. $fn)
        *allen_o    =   allen hexagonal keyhole dimension
        *thread     =   string variable declaring measure type -> "metric" or "imperial"
        *pitch      =   stands for thread pitch

    hex_nut (height, thread_d, size, tolerance, quality, bool_cut, thread, pitch);
        height      =   height of the nut
        thread_d    =   threaded hole diameter width
        size        =   hexagonal nut size
        tolerance   =   tolerance of entire measures (always positive, addition and subtraction already
                        calculated within the script
        quality     =   overall quality of the returned function (ref. $fn)
        bool_cut    =   do (1) or not (0) the nut cut
        *thread     =   string variable declaring measure type -> "metric" or "imperial"
        *pitch      =   stands for thread pitch

    washer (outer, inner, width, tolerance, quality, thread);
        outer       =   outer washer diameter
        inner       =   inner washer diameter
        tolerance   =   tolerance of entire measures (always positive, addition and subtraction already
                        calculated within the script
        quality     =   overall quality of the returned function (ref. $fn)
        *thread     =   string variable declaring measure type -> "metric" or "imperial"
        
*/

module conical_allen_bolt (height = 30, width = 6, head_size = 14, head_height = 8, tolerance = 0.2, quality = 32, thread, bool_round, allen_o, thread_len, pitch) {
    union () {
        $fn = quality;
        if ( thread ) {
            if ( thread == "metric" ) {
                translate ([0,0,thread_len]) cylinder (h=height-thread_len, r=(width/2)-tolerance, $fn=32);
                if ( thread_len ) {
                    metric_thread (width-tolerance, pitch, thread_len);
                }
                else {
                    cylinder (r = width / 2, h = thread_len );
                }
                translate ([0,0,height-0.001]) head_conical_allen (head_size-tolerance, head_height, quality, bool_round, allen_o + tolerance);
            }
            else {
                thread_len_i = imp (thread_len);
                height = imp (height);
                width_i = imp (width);
                tolerance_i = imp (tolerance);
                allen_o = imp (allen_o);
                head_size = imp (head_size);
                head_height = imp (head_height);
                translate ([0,0,thread_len_i]) cylinder (h=height-thread_len_i, r=(width_i/2)-tolerance_i, $fn=32);
                english_thread (width-tolerance, pitch, thread_len);
                translate ([0,0,height-0.001]) head_conical_allen (head_size-tolerance_i, head_height, quality, bool_round, allen_o+tolerance_i);
            }
        }
        else {
            //translate ([0,0,thread_len]) cylinder (h=height-thread_len, r=(width/2)-tolerance, $fn=32);
            cylinder (h = height, r = (width-tolerance) / 2, $fn = quality / 2);
            //metric_thread (width-tolerance, pitch, thread_len);
            translate ([0,0,height-0.001]) head_conical_allen (head_size-tolerance, head_height, quality, bool_round, allen_o + tolerance);
        }
    }
}

module hex_nut (height, thread_d, size, tolerance, quality, bool_cut, thread, pitch) {
    difference () {
        $fn = 6; // make it "hex"
        if ( thread ) { // is set?
            if ( thread == "metric" ) { // is metric?
                if ( bool_cut ) {
                    intersection() { // making "the Nut"
                        cylinder (r = hex_dia (size - tolerance) / 2, h = height); // hex nut
                        cut_bit (height, size / 2); // cutout
                    }
                }
                else {
                    cylinder (r = hex_dia (size - tolerance) / 2, h = height); // hex nut
                }
            } 
            if ( thread == "imperial" ) { // is imperial?
                size = imp (size); // imperial -> metric
                height = imp (height); // imperial -> metric
                tolerance = imp (tolerance); // imperial -> metric
                if ( bool_cut ) {
                    intersection() { // making "the Nut"
                        cylinder (r = hex_dia (size - tolerance) / 2, h = height); // hex nut
                        cut_bit (height, size / 2); // cutout
                    }
                }
                else {
                    cylinder (r = hex_dia (size - tolerance) / 2, h = height); // hex nut
                }
            }
        }
        // cut part
        if ( thread ) { // is set?
            if ( thread == "metric" ) { // is metric?
                $fn = quality; // set the quality
                translate ([0, 0, -1]) {
                    if ( pitch ) {
                        metric_thread (thread_d + tolerance, pitch, height + 2); // thread it!
                    }
                    else {
                        $fn = quality / 2;
                        cylinder (r = (thread_d + tolerance) / 2, height + 2); // a dummy cylindric bar
                    }
                }
            } 
            if ( thread == "imperial" ) { // is imperial?
                $fn = quality ; // set the quality
                translate ([0, 0, -1]) {
                    if ( pitch ) {
                        english_thread (thread_d + tolerance, pitch, height + (1/10)); // thread it!
                    }
                    else {
                        $fn = quality / 2; // half declared quality
                        thread_d = imp (thread_d);
                        tolerance = imp (tolerance);
                        height = imp (height);
                        cylinder (r = (thread_d + tolerance) / 2, height + 2); // a dummy cylindric bar
                    }
                }
            }
        } else {
            $fn = quality / 2; // half declared quality
            translate ([0, 0, -1]) cylinder (r = (thread_d + tolerance) / 2, height + 2); // a dummy cylindric bar
        }
    }
}

module grub_bolt (length, thread_d, a_depth, tolerance, quality, allen_o, thread, pitch) {
    difference () {
        union () {
            if ( thread ) {
                if ( thread == "metric" ) {
                    $fn = quality;
                    metric_thread (thread_d - tolerance, pitch, length);
                }
                if ( thread == "imperial" ) {
                    $fn = quality;
                    english_thread (thread_d - tolerance, pitch, length);
                }
            } else {
                $fn = quality / 2;
                cylinder (r = (thread_d - tolerance) / 2, h = length);
            }
        }
        if ( allen_o ) {
            $fn = 6;
            if ( thread ) {
                if ( thread == "metric" ) {
                    translate ([0, 0, length - a_depth + 0.5]) cylinder (h = a_depth, r = hex_dia (allen_o + tolerance) / 2);
                }
                if ( thread == "imperial" ) {
                    length = imp (length);
                    a_depth = imp (a_depth);
                    allen_o = imp (allen_o);
                    tolerance = imp (tolerance);
                    translate ([0, 0, length - a_depth + 0.5]) cylinder (h = a_depth, r = hex_dia (allen_o + tolerance) / 2);
                }
            } else {
                
                    translate ([0, 0, length - a_depth + 0.5]) cylinder (h = a_depth, r = hex_dia (allen_o + tolerance) / 2);
            }
        }
    }
}

module hex_bolt (length, thread_d, head_h, head_d, tolerance, quality, bool_cut, thread, pitch) {
    union () {
        if ( thread ) {
            if ( thread == "metric" ) {
                $fn = quality;
                if ( pitch ) {
                    metric_thread (thread_d - tolerance, pitch, length);
                } else {
                    $fn = quality / 2;
                    cylinder (r = (thread_d - tolerance) / 2, h = length);
                }
            }
            if ( thread == "imperial" ) {
                $fn = quality;
                if ( pitch ) {
                    english_thread (thread_d - tolerance, pitch, length);
                } else {
                    $fn = quality / 2;
                    thread_d = imp(thread_d);
                    tolerance = imp(tolerance);
                    length = imp(length);
                    cylinder (r = (thread_d - tolerance) / 2, h = length);
                }
            }
        } else {
            $fn = quality / 2;
            cylinder (r = (thread_d - tolerance) / 2, h = length);
        }
        $fn = 6;
        if ( thread ) {
            if ( thread == "imperial" ) {
                length = imp (length);
                head_d = imp (head_d);
                head_h = imp (head_h);
                tolerance = imp (tolerance);
                translate ([0, 0, length]) {
                    if ( bool_cut == 1 ) {
                        intersection() {
                            cylinder (r = hex_dia (head_d - tolerance) / 2, h = head_h);
                            cut_bit (head_h, head_d/2);
                        }
                    } else {
                        cylinder (r = hex_dia (head_d - tolerance) / 2, h = head_h);
                    }
                }
            }
            if ( thread == "metric" ) {
                translate ([0, 0, length]) {
                    if ( bool_cut == 1 ) {
                        intersection() {
                            cylinder (r = hex_dia (head_d - tolerance) / 2, h = head_h);
                            cut_bit (head_h, head_d/2);
                        }
                    } else {
                        cylinder (r = hex_dia (head_d - tolerance) / 2, h = head_h);
                    }
                }
            }
        } else {
            translate ([0, 0, length]) {
                intersection() {
                    cylinder (r = hex_dia (head_d - tolerance) / 2, h = head_h);
                    cut_bit (head_h, head_d/2);
                }
            }
        } 
    }   
}

module cone_head_bolt (length, thread_d, head_h, head_d, a_depth, tolerance, quality, allen_o, thread, pitch) {
    difference () {
        union () {
            if ( thread ) {
                if ( thread == "metric" ) {
                    $fn = quality;
                    metric_thread (thread_d - tolerance, pitch, length);
                }
                if ( thread == "imperial" ) {
                    $fn = quality;
                    english_thread (thread_d - tolerance, pitch, length);
                }
            } else {
                $fn = quality / 2;
                cylinder (r = (thread_d - tolerance) / 2, h = length);
            }
            if ( thread ) {
                if ( thread == "imperial" ) {
                    $fn = quality;
                    thread_d = imp (thread_d);
                    head_d = imp (head_d);
                    head_h = imp (head_h);
                    tolerance = imp (tolerance);
                    minkowski () {
                        sphere (r = (1 / 8) * ((thread_d - tolerance) / 2));
                        translate ([0, 0, length]) cylinder (r1 = (thread_d / 2) - ((1 / 8) * ((thread_d - tolerance) / 2)), r2 = ((head_d - tolerance) / 2) - ((1 / 8) * ((head_d - tolerance) / 2)), h = head_h + tolerance);
                    }
                }
                if ( thread == "metric" ) {
                    $fn = quality;
                    minkowski () {
                        sphere (r = (1 / 8) * ((thread_d - tolerance) / 2));
                        translate ([0, 0, length]) cylinder (r1 = (thread_d / 2) - ((1 / 8) * ((thread_d - tolerance) / 2)), r2 = ((head_d - tolerance) / 2) - ((1 / 8) * ((head_d - tolerance) / 2)), h = head_h + tolerance);
                    }
                }
            } else {
                minkowski () {
                    $fn = quality / 2;
                    sphere (r = (1 / 8) * ((thread_d - tolerance) / 2));
                    translate ([0, 0, length]) cylinder (r1 = (thread_d / 2) - ((1 / 8) * ((thread_d - tolerance) / 2)), r2 = ((head_d - tolerance) / 2) - ((1 / 8) * ((head_d - tolerance) / 2)), h = head_h + tolerance);
                    }
            }
        }
        if ( allen_o ) {
            $fn = 6;
            if ( thread ) {
                if ( thread == "imperial" ) {
                    length = imp (length);
                    head_h = imp (head_h);
                    a_depth = imp (a_depth);
                    allen_o = imp (allen_o);
                    tolerance = imp (tolerance);
                    translate ([0, 0, (length + head_h) - (a_depth - 0.5)]) cylinder (h = a_depth, r = hex_dia (allen_o + tolerance) / 2);
                }
                if ( thread == "metric" ) {
                    translate ([0, 0, (length + head_h) - (a_depth - 0.5)]) cylinder (h = a_depth, r = hex_dia (allen_o + tolerance) / 2);
                }
            } else {
                translate ([0, 0, (length + head_h) - (a_depth - 0.5)]) cylinder (h = a_depth, r = hex_dia (allen_o + tolerance) / 2);
            }
        }
    }
}

module allen_bolt (length, thread_d, head_h, head_d, a_depth, tolerance, quality, bool_round, allen_o, thread, pitch) {
    difference () {
        union () {
            if ( thread ) {
                if ( thread == "metric" ) {
                    $fn = quality;
                    metric_thread (thread_d - tolerance, pitch, length);
                }
                if ( thread == "imperial" ) {
                    $fn = quality;
                    english_thread (thread_d - tolerance, pitch, length);
                }
            } else {
                $fn = quality / 2;
                cylinder (r = (thread_d - tolerance) / 2, h = length);
            }
            if ( thread ) {
                if ( thread == "metric" ) {
                    if ( bool_round ) {
                        $fn = quality;
                        minkowski () {
                            sphere (r = (1 / 8) * ((head_d - tolerance) / 2));
                            translate ([0, 0, length]) cylinder (h = head_h - tolerance, r = ((head_d - tolerance) / 2) - ((1 / 8) * ((head_d - tolerance) / 2)));
                        }
                    } else {
                        $fn = quality / 2;
                        translate ([0, 0, length]) cylinder (h = head_h - tolerance, r = (head_d - tolerance) / 2);
                    }
                }
                if ( thread == "imperial" ) {
                    head_d = imp (head_d);
                    length = imp (length);
                    tolerance = imp (tolerance);
                    if ( bool_round ) {
                        $fn = quality;
                        minkowski () {
                            sphere (r = (1 / 8) * ((head_d - tolerance) / 2));
                            translate ([0, 0, length]) cylinder (h = head_h - tolerance, r = ((head_d - tolerance) / 2) - ((1 / 8) * ((head_d - tolerance) / 2)));
                        }
                    } else {
                        $fn = quality / 2;
                        translate ([0, 0, length]) cylinder (h = head_h - tolerance, r = (head_d - tolerance) / 2);
                    }
                }
            } else {
                if ( bool_round ) {
                    $fn = quality;
                    minkowski () {
                        sphere (r = (1 / 8) * ((head_d - tolerance) / 2));
                        translate ([0, 0, length]) cylinder (h = head_h - tolerance, r = ((head_d - tolerance) / 2) - ((1 / 8) * ((head_d - tolerance) / 2)));
                    }
                } else {
                    $fn = quality / 2;
                    translate ([0, 0, length]) cylinder (h = head_h - tolerance, r = (head_d - tolerance) / 2);
                }
            }
        }
        if ( allen_o ) {
            $fn = 6;
            if ( thread ) {
                if ( thread == "imperial" ) {
                    length = imp (length);
                    head_h = imp (head_h);
                    a_depth = imp (a_depth);
                    allen_o = imp (allen_o);
                    tolerance = imp (tolerance);
                    translate ([0, 0, (length + head_h) - (a_depth - 0.5)]) cylinder (h = a_depth, r = hex_dia (allen_o + tolerance) / 2);
                }
                if ( thread == "metric" ) {
                    translate ([0, 0, (length + head_h) - (a_depth - 0.5)]) cylinder (h = a_depth, r = hex_dia (allen_o + tolerance) / 2);
                }
            } else {
                translate ([0, 0, (length + head_h) - (a_depth - 0.5)]) cylinder (h = a_depth, r = hex_dia (allen_o + tolerance) / 2);
            }
        }
    }
}

module washer (outer, inner, width, tolerance, quality, thread) {
    $fn = quality;
    if ( thread ) {
        if ( thread == "metric") {
            difference () {
                cylinder (r = (outer - tolerance) / 2, h = width);
                translate ([0, 0, -1]) cylinder (r = (inner + tolerance) / 2, h = width + 2);
            }
        }
        if ( thread == "imperial" ) {
            outer = imp (outer);
            inner = imp (inner);
            width = imp (width);
            tolerance = imp (tolerance);
            difference () {
                cylinder (r = (outer - tolerance) / 2, h = width);
                translate ([0, 0, -1]) cylinder (r = (inner + tolerance) / 2, h = width + 2);
            }
        } else {
            difference () {
                cylinder (r = (outer - tolerance) / 2, h = width);
                translate ([0, 0, -1]) cylinder (r = (inner + tolerance) / 2, h = width + 2);
            }
        }
    }
}

module head_conical_allen (width = 10, height = 5, quality = 32, bool_round, allen_o) {
    if ( allen_o ) {
        difference () {
            if ( bool_round == 1 ) {
                minkowski () {
                    $fn = quality;
                    sphere ((1/32)*width);
                    cylinder (h=height-(1/32)*width, r1=(width-((1/32)*width))/2, r2=((width*(4/5))-((1/32)*width))/2);
                }
            }
            if ( bool_round == 0 ) {
                $fn = quality / 2;
                cylinder (h=height, r1=width/2, r2=(width*(4/5))/2);
            }
            translate ([0,0,height*(2/7)]) cylinder (h=height*(3/4), r=(allen_o/(2/sqrt(3)))/2, $fn=6);
        }
    }
    else {
        $fn = quality / 2;
        cylinder (h=height, r1=width/2, r2=(width*(4/5))/2);
    }
}

/* From http://www.thingiverse.com/thing:3457
   © 2010 whosawhatsis

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU Lesser General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
   GNU Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public License
   along with this program. If not, see <http://www.gnu.org/licenses/>.
*/


/*
This script generates a teardrop shape at the appropriate angle to prevent overhangs greater than 45 degrees. The angle is in degrees, and is a rotation around the Y axis. You can then rotate around Z to point it in any direction. Rotation around X or Y will cause the angle to be wrong.
*/

module teardrop(radius, length, angle) {
	rotate([0, angle, 0]) union() {
		linear_extrude(height = length, center = true, convexity = radius, twist = 0)
			circle(r = radius, center = true, $fn = 30);
		linear_extrude(height = length, center = true, convexity = radius, twist = 0)
			projection(cut = false) rotate([0, -angle, 0]) translate([0, 0, radius * sin(45) * 1.5]) cylinder(h = radius * sin(45), r1 = radius * sin(45), r2 = 0, center = true, $fn = 30);
	}
}