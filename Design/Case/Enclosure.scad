w = 47.5;
h = 25;
d = 28.5;
t=1.5;

usbw = 8;
usbh = 3.5;
usbl = 1;

mdw = 25.7;

ss = 4;
ps = 4;

module box() {
	difference() {
		cube([w+2*t, d+2*t, h+2*t], center=true);
		cube([w, d, h], center=true);
	}
}

module topSlice() {
	translate([0,0,h-3]) cube([w+(2*t+1)*0+1.5, d+(2*t+2)*0+1.5, h], center=true);
	translate([0,0,h+t-2.4]) cube([w+(2*t+1)+1.5, d+(2*t+2)+1.5, h], center=true);
}
module bottomSlice() { translate([0,0,-h/2]) cube([w+2*t+1, d+2*t+2, h], center=true); }

lhm = 1.5;
tolerance=0.14;
module lid_new() {
	difference() {
		translate([0,0,lhm/2]) cube([w+1.5-tolerance*2.5, d+1.5-tolerance, lhm], center=true);
		translate([w/2+1-tolerance/2,0,lhm/2]) cube([2, 8, lhm+2*tolerance], center=true);
		translate([-3, -2, 0]) slit();
		translate([-3, 0, 0]) slit();
		translate([-3, 2, 0]) slit();
	}
}

module ports() {
	module usb() {
		// cube([usbw, usbh, t+2], center = true);
		d1 = 11;
		d2 = 9;
		difference() {
			cube([usbw, t+2, usbh], center = true);
			translate([(usbw/2+usbw/d1), 0, (usbh/2+usbw/d1)]) rotate([0, 45, 0]) cube([3, t+2, usbh], center = true);
			translate([-(usbw/2+usbw/d1), 0, (usbh/2+usbw/d1)]) rotate([0, -45, 0]) cube([3, t+2, usbh], center = true);
			translate([(usbw/2+usbw/d2), 0, -(usbh/2+usbw/d2)]) rotate([0, -45, 0]) cube([3, t+2, usbh], center = true);
			translate([-(usbw/2+usbw/d2), 0, -(usbh/2+usbw/d2)]) rotate([0, 45, 0]) cube([3, t+2, usbh], center = true);
		}
	}
	translate([w/2-1, d/5, -1.5]) rotate([0, 90, 0]) cylinder(r=6.2/2, h=t+2, $fn=32);
	translate([w/2-1, -d/5, -1.5]) rotate([0, 90, 0]) cylinder(r=6.2/2, h=t+2, $fn=32);
	translate([-(w/2-mdw/2), d/2+t/2, -(h/2-(usbh/2)-usbl)]) usb();
}

module divider() {
	translate([mdw-(w/2-t/2), 0, -(h/2-(h/6))]) cube([t, d, h/3], center=true);
}

module pegs() {
		translate([(w/2-ps/2), (d/2-ps/2), -h/10]) cube([ps, ps, h-h/10], center=true);
		translate([(w/2-ps/2), -(d/2-ps/2), -h/10]) cube([ps, ps, h-h/10], center=true);

		translate([mdw-(w/2-t/2)+t/2+ps/2, (d/2-ps/2), -h/10]) cube([ps, ps, h-h/10], center=true);
		translate([mdw-(w/2-t/2)+t/2+ps/2, -(d/2-ps/2), -h/10]) cube([ps, ps, h-h/10], center=true);
}

module indicators() {
	translate([w/2+t/2, 0, 8]) slit();
	translate([w/2+t/2, -2, 8]) slit();
	translate([w/2+t/2, 2, 8]) slit();
}

module symbols() {
	translate([w/2+t, -(d/2-(d/15)), -1.5]) one();
	translate([w/2+t, (d/2-(d/15)), -1.5]) zero();
}

module zero() {
	rotate([0, 90, 0]) linear_extrude(height=1, center=true) circle(r=ss/2, $fn=32);
}

module one() {
	cube([1, 1, ss], center=true);
}

module slit() {
	cube([2*t, 1, ss], center=true);
}

module top() {
	difference() {
		box();
		bottomSlice();
		indicators();
	}
}

module bottom() {
	union() {
		difference() {
			box();
			topSlice();
			ports();
			symbols();
		}
		//pegs();
		divider();
	}
}

module enclosure() {
	translate([0,0,(h/2+t)]) bottom();
//	translate([0,0, h+lhm+3]) lid_new();
	translate([0,-35,0]) lid_new();
}

enclosure();

