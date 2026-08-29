# v1.0 source

v1.0 is intentionally a model of the existing Bosch GTS 10 XC stand described by
Pragmatic Workshop. It is the reference/baseline version before introducing a
different mobile base or other design changes.

Source:

- [My Bosch GTS 10 XC Stand – Pragmatic Workshop](https://pragmatic-workshop.amon.de/blog/my-bosch-gts-10-xc-stand/)

The Bosch GTS 10 XC itself is shown using the supplied STL reference model.


## External CAD reference

The Bosch GTS 10 XC geometry is an externally supplied STL and is stored under:

`v1.0/cad/external/bosch-gts10xc/Bosch_GTS_10_XC.stl`

The OpenSCAD wrapper that positions and displays that external model is:

`v1.0/cad/components/bosch-gts10xc-reference.scad`


## Complete STL assembly

`cad/exports/assembly.scad` is the complete-model STL export entrypoint for v1.0.
With the `table` prefix, the expected generated file is:

`v1.0/out/stl/table-assembly.stl`
