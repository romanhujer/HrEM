/* 
    Domyos weight holder
        

   Copyright (c) 2020 Roman Hujer   http://hujer.net

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,ss
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.

  Description: 
  
     Domyos weight holder for EQ5 or others telescope mounts 
  

*/

use <threads.scad>
use <nuts_and_bolts.scad>

//Set Rod diametr 20.5 mm  EQ5 (default), 18.5 mm  EQ6 (NEQ6)or GS280 or 12.5 mm for  Seben EQ3 or  BRESSER EQ3 (Lidl Sope)
Rod_dia = 6.3;

//Weigh Therd diameter  (disk hole) default is 29 mm for  Domyos weight disk
Weigh_Thred_dia = 29; 

//Weigh Therd long {default is 60 mm)
Weigh_Thred_long = 70;

//Weigh Therd pitch {default is 3 mm)
Weigh_Thred_pitch = 3;


// Render model select (for export to .stl  select only one model)  1 = enable  0 = disable render
Holder = 0;
Nuts  = 1;

module inbusM5()
{
    translate ([0,0,5]) cylinder (h = 5, r=4.3, $fn=100);
    cylinder(h = 6, r=2.65, $fn=100);
    
}


if( Nuts == 1) {
     
    translate ([0, 0,50]) hex_nut (10, Weigh_Thred_dia + 0.35, 50,1, 1,1, "metric", Weigh_Thred_pitch);
}    


if ( Holder == 1) {
   difference() {
    union(){
     cylinder(h=2, r1=52, r2=53, $fn=360) ;  
     translate ([0,0,2])cylinder (h = 6, r=53,$fn=360) ; 
     translate ([0,0,8]) cylinder(h=2, r1=53, r2=51.5, $fn=360) ;  
     translate ([0,0,9]) metric_thread (diameter=Weigh_Thred_dia, pitch=Weigh_Thred_pitch, length=Weigh_Thred_long, internal=false );
    }
   {
     cylinder (h = Weigh_Thred_long+30, r=Rod_dia/2, $fn=100 );
     for (i=[0:1:6]) rotate([0,0,i*60])translate ([0,45,0]) inbusM5();  
     cylinder (h = 5, r=9.9/sqrt(3),$fn=6) ; 
   }   
}

}
