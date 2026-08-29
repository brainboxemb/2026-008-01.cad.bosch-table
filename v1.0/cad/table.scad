/*
Main interactive entrypoint for v1.0.
Open this file in OpenSCAD.
*/

include <main.scad>

/* [View] */
view_mode = "assembly"; // [assembly,frame_only,left_lower_corner,cabinet_only,drawers_only,worktop_only,saw_only,casters_only]

if (view_mode == "assembly") {
    table_assembly();
} else if (view_mode == "frame_only") {
    timber_frame();
} else if (view_mode == "left_lower_corner") {
    left_lower_corner_view();
} else if (view_mode == "cabinet_only") {
    cabinet_panels();
} else if (view_mode == "drawers_only") {
    drawers();
} else if (view_mode == "worktop_only") {
    worktop();
} else if (view_mode == "saw_only") {
    bosch_gts10xc_reference();
} else if (view_mode == "casters_only") {
    casters();
} else {
    table_assembly();
}
