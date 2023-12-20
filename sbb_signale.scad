// OpenSCAD konstruiert Kreise und Kugeln aus Liniensegmenten. Über $fn wird konfiguriert aus wie vielen Segmenten.
$fn=60;

// 3.5mm TRRS Stecker
use <stecker.scad>

// Modellmasstab
scale=1/87;

// Koordination der Flammen in original mm relativ zum Mittelpunkt des Schirms
flammen=[
 [-250, 275],   // links oben
 [0, 275],      // mitte oben
 [250, 275],    // rechts oben
 [0, 25],       // mitte mitte
 [250, 25],     // mitte rechts
 [-250, -275],  // links unten
 [0, -275],     // links mitte
 //[250, -275]    // recht unten
];
flammen_durchmesser = 215;  // in original mm
schuten_dicke = 0.33;  // in modell mm

rotate([90, 0, 0]) {
  translate([0, 1000 * scale / 2, 0.25]) {
    schild();
    schuten();
  }
  
  translate([0,-4475/2*scale + 1000 * scale,-4/2])
  mast();
  
  color("Gray")
  translate([0.2,-4475*scale + 1000 * scale ,-0.75])
  rotate([0,90,0])
  stecker();
}

module schild() {
    difference() {
      intersection() {
          cube([1000 * scale, 1000 * scale, 0.5], true);
          rotate([0,0,45]) {
              cube([1230 * scale, 1230 * scale, 0.5], true);
          }
      }
      
      // Löcher für Flammen
      for (i = [ 0 : len(flammen) - 1 ]) {
        translate([flammen[i][0] * scale,flammen[i][1] * scale, 0])
        cylinder(h=2,d=flammen_durchmesser * scale, center=true);
      }
  }
  
  translate([0,0,-0.6 - 0.28]) {
   color("Green")

  cube([9,9,0.6], center=true);
  for (i = [ 0 : len(flammen) - 1 ]) {
      translate([flammen[i][0] * scale, flammen[i][1] * scale, 0.6/2+0.28/2]) {
            color("White")

      cube([2.2,2,0.28], center=true);
       translate([0,0,0.84/2])
            color("Silver")

                cube([1.45,2,0.56], center=true);

      }
     }
  }
}

module mast() {
    color("Lime")
      cube([100*scale,4475 * scale,200*scale], center=true);
    
       color("Lime")
    translate([0,-18.2,2.75])
    difference() {
        
      cube([100*scale, 1300*scale, 350*scale], center=true);
        
      translate([0,-5,4])
      rotate([20,0,0])
      cube([120*scale, 1000*scale, 600*scale], center=true);
    }
}

module schuten() {
  for (i = [ 0 : len(flammen) - 1 ]) {

  translate([flammen[i][0] * scale,flammen[i][1] * scale,0])
  intersection() {
    // hohler cylinder
    difference() {

      color("YellowGreen")
      cylinder(h=230 * scale, d=flammen_durchmesser * scale + schuten_dicke);
     
      translate([0,0,-0.5])
      cylinder(h=230 * scale +1,d=flammen_durchmesser * scale);
    }
     
    color("YellowGreen")
    intersection() {
        translate([0,140 * scale,60 * scale])
        rotate([50,0,0])
        cube([400 * scale, 500 * scale, 300 * scale], center=true);
        translate([0 * scale,100 * scale,0 * scale])
        cube([400 * scale, 300 * scale, 500 * scale], center=true);

        }
   }
  }
}
