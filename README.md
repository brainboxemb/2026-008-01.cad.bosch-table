# Bosch GTS 10 XC table stand

The model and documentation were developed with the assistance of ChatGPT.

This repository models a mobile/workshop stand for the Bosch GTS 10 XC table saw.

## v1.0 — reference design

Version 1.0 models the existing solution published by Pragmatic Workshop as a reference baseline before making our own structural changes.

**Source / inspiration:**  
[My Bosch GTS 10 XC Stand – Pragmatic Workshop](https://pragmatic-workshop.amon.de/blog/my-bosch-gts-10-xc-stand/)

The timber construction uses 60 × 40 mm members, including the visible half-lap connections used in the original design.

## Render

The GitHub OpenSCAD render pipeline uses the project prefix **`table`**. Therefore `v1.0/cad/renders/assembly.scad` is expected to generate:

`v1.0/out/png/table-assembly.png`

![Bosch GTS 10 XC table stand v1.0](v1.0/out/png/table-assembly.png)

## Repository layout

```text
v1.0/
├── cad/
│   ├── components/
│   │   ├── bosch-gts10xc-reference.scad
│   │   ├── cabinet.scad
│   │   ├── casters.scad
│   │   ├── geometry-helpers.scad
│   │   └── timber-frame.scad
│   ├── external/
│   │   └── bosch-gts10xc/
│   │       └── Bosch_GTS_10_XC.stl
│   ├── renders/
│   │   ├── assembly.scad
│   │   ├── frame.scad
│   │   └── left-lower-corner.scad
│   ├── exports/
│   ├── config.scad
│   ├── main.scad
│   └── table.scad
├── doc/
│   └── source.md
└── out/
    ├── png/
    └── stl/
```

Open `v1.0/cad/table.scad` for interactive use in OpenSCAD.

## GitHub render configuration

The intended project mapping is:

```text
v1.0/cad|v1.0/out/png|table
```

The final field is the output prefix. The render entrypoint filename is appended to that prefix by the render pipeline, for example:

`assembly.scad` → `table-assembly.png`

`exports/` is intentionally empty in v1.0. There is currently no useful standalone printable geometry to export.
