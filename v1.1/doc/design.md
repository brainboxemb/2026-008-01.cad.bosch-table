# v1.1 design direction

Version 1.1 is the first custom-design version of the Bosch GTS 10 XC table.

The starting point is a mobile aluminium frame inspired by the previously
identified 1060 × 670 mm aluminium underframe.

## Base frame

The frame uses assumed 60-series aluminium extrusion with a 60 × 60 mm section.

The construction is:

- overall frame size: **1060 × 670 mm**;
- front and rear transverse profiles use the full **670 mm** width;
- the longitudinal profiles fit between those transverse profiles;
- longitudinal profile length: **940 mm**;
- four wheels are mounted below the profile intersections.

This base is treated as the fixed foundation for the next design steps.

## Next design layer

The upper structure will use 60 × 40 mm timber as the main construction
material. Its geometry, joints and relationship to the Bosch GTS 10 XC are not
fixed yet in v1.1.

The Pragmatic Workshop v1.0 model remains useful as a reference for ideas such
as the timber construction, half-lap joints and storage layout, but v1.1 is no
longer intended as a direct reconstruction of that stand.


## Complete STL assembly

`cad/exports/assembly.scad` is the complete-model STL export entrypoint for v1.1.
With the `table` prefix, the expected generated file is:

`v1.1/out/stl/table-assembly.stl`


## Coordinate system

v1.1 uses the same project coordinate convention as v1.0:

- `[0,0,0]` is the front-left point on the floor;
- X runs from left to right;
- Y runs from front to rear;
- Z runs upward.

The aluminium base therefore occupies approximately `X=0..1060` and
`Y=0..670`. It is deliberately not centred around the origin. This makes later
placement of the asymmetric timber structure and the Bosch saw easier to read
and dimension.
