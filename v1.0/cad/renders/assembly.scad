/* Render entrypoint. Output prefix is supplied by GitHub: table- */
include <../assemblies/table.scad>

// Flatter three-quarter camera for documentation render.
$vpr = [64, 0, 38];
$vpt = [550, 335, 280];
$vpd = 2450;

table_assembly();
