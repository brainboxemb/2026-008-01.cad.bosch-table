/*
Bosch GTS 10 XC table stand v1.1
Configuration

v1.1 starts the custom design around the aluminium mobile base.

Project coordinate convention:
  [0,0,0] = front-left point on the floor
  X = left -> right
  Y = front -> rear
  Z = up
*/

$fn = 72;

/* [View] */
show_profile_slots = true;
show_floor = false;
show_saw_reference = false;

/* [Aluminium base frame] */
frame_length = 1060;       // overall X [mm]
frame_width  = 670;        // overall Y [mm]
profile_size = 60;         // 60 x 60 mm profile
profile_slot_width = 10;   // visual slot width [mm]
profile_slot_depth = 8;    // visual slot depth [mm]

/* [Base wheels] */
// Dimensions retained from the aluminium-base reference model.
wheel_diameter = 150;
wheel_width = 40;
caster_overall_height = 190;
caster_plate_x = 110;
caster_plate_y = 80;
caster_plate_thickness = 6;
caster_trail = 28;
axle_diameter = 14;

/* [Bosch reference] */
saw_x = 0;               // left-align saw with the table origin
saw_y = (frame_width - 678) / 2; // approximately centred in depth
saw_z = caster_overall_height + profile_size;
saw_color = [0.12, 0.22, 0.30, 0.85];

/* [Appearance] */
aluminium_color = [0.72, 0.74, 0.76];
slot_color = [0.30, 0.31, 0.32];
wheel_color = [0.08, 0.08, 0.08];
metal_color = [0.40, 0.42, 0.44];
hub_color = [0.68, 0.68, 0.68];

EPS = 0.2;

/* [Derived] */
frame_z = caster_overall_height;
long_rail_length = frame_length - 2 * profile_size;
