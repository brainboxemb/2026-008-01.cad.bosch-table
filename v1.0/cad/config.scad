/*
Bosch GTS 10 XC table stand v1.0
Configuration

v1.0 intentionally models the Pragmatic Workshop solution as the reference
design. It is not intended to redesign or improve that solution yet.
*/

$fn = 36;

/* [View] */
show_worktop = true;
show_frame = true;
show_cabinet_panels = true;
show_drawers = true;
show_drawer_fronts = true;
show_reference_floor = false;
show_casters = true;
show_saw_reference = true;

/* [Overall dimensions] */
stand_length = 1100;     // X [mm]
stand_depth = 670;       // Y [mm]
frame_height = 441;      // timber frame, excluding worktop [mm]
worktop_thickness = 24;

/* [Caster wheels] */
// Photo-based working assumption. The wheel diameter appears close to 50 mm
// relative to the 60 mm timber members.
wheel_diameter = 50;          // [mm]
wheel_width = 20;             // [mm]
caster_total_height = 70;     // floor to mounting face [mm]
caster_plate_x = 60;          // [mm]
caster_plate_y = 45;          // [mm]
caster_plate_thickness = 3;   // [mm]
caster_inset_x = 70;          // wheel centre from left/right end [mm]
caster_inset_y = 22.5;        // wheel centre from front/rear face [mm]

/* [Bosch GTS 10 XC reference STL] */
saw_stl_file = "Bosch_GTS_10_XC.stl";
// Measured from the supplied STL after axis correction: approx.
// 765 mm wide x 678 mm deep x 340 mm high.
saw_stl_width = 765;
saw_stl_depth = 678;
saw_stl_height = 340;

// Default placement is centred on the 1100 mm stand. These are deliberately
// exposed because the final saw position still has to be matched to the real
// stand / photographs.
saw_x = 0;  // align left side of the saw with left side of the stand
saw_y = (stand_depth - saw_stl_depth) / 2;
saw_z_offset = 0;
saw_color = [0.12, 0.22, 0.30, 0.85];

/* [Timber frame] */
timber_face = 60;        // visible face dimension [mm]
timber_depth = 40;       // frame depth/thickness [mm]
rail_height = timber_face;
rail_depth = timber_depth;
post_x = timber_face;
post_y = timber_depth;

// Small edge radius used on the original stand.  The source article states
// that the timber edges were rounded with an edge router.  End grain / sawn
// faces are intentionally NOT rounded by the modules below.
timber_edge_radius = 2.0; // [0:0.5:5]

/* [Half-lap joinery] */
use_half_lap_joinery = true;
// 40 mm timber thickness -> a conventional half-lap removes 20 mm.
half_lap_depth = timber_depth / 2;
cross_half_lap_width = timber_face / 2;
half_lap_clearance = 0.0; // visual/model clearance, not a machining allowance

// The original drawer bay is 600 mm clear between the left and centre posts.
drawer_bay_clear_width = 600;
left_post_x = 0;
center_post_x = left_post_x + post_x + drawer_bay_clear_width;
right_post_x = stand_length - post_x;

/* [Sheet materials] */
mpx_birch_thickness = 24;
mpx_poplar_thickness = 15;
osb_thickness = 15;

// Source cut-list dimensions.
large_bottom_depth = 640;
large_bottom_width = 600;
left_side_depth = 640;
left_side_height = 326;
center_side_depth = 640;
center_side_height = 366;
rear_panel_width = 600;
rear_panel_height = 321;

/* [Drawers] */
drawer_body_depth = 610;
drawer_body_width = 544.6;
drawer_side_height = 120.5;
drawer_low_side_height = 31;
drawer_bottom_depth = 610;
drawer_bottom_width = 514.6;
drawer_low_bottom_depth = 640;
drawer_low_bottom_width = 544.6;

drawer_front_width = 596;
drawer_front_height = 120.5;
drawer_low_front_height = 46;
drawer_front_thickness = 15;

drawer_gap = 8;
drawer_front_inset_y = 3;

// Reconstructed vertical locations, preserving source front dimensions.
bottom_drawer_z = rail_height + 8;
middle_drawer_z = bottom_drawer_z + drawer_front_height + drawer_gap;
low_drawer_z = middle_drawer_z + drawer_front_height + drawer_gap;

/* [Appearance] */
// Three related wood shades make the structural direction immediately visible.
// They are deliberately close enough to still read as the same timber species.
timber_vertical_color     = [0.66, 0.50, 0.31];
timber_longitudinal_color = [0.76, 0.61, 0.39];
timber_transverse_color   = [0.61, 0.45, 0.28];
worktop_color = [0.70, 0.58, 0.34];
osb_color = [0.68, 0.61, 0.45];
poplar_color = [0.88, 0.78, 0.45];
drawer_front_color = [0.92, 0.77, 0.30];
reference_floor_color = [0.82, 0.82, 0.82, 0.20];

EPS = 0.05;
