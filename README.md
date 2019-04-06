# 山本トロン (YamamotoTron)

3D model data of "山本トロン" (Yamamoto Tron).

![Image](yamamoto_tron_360x360.jpg)

## Overview

This is a 3D model data of the "Yamamoto Tron" in SCAD (OpenSCAD) format,
written for generating STL data to 3D print it.
"Yamamoto Tron" is a 3D model introduced in a legendary book
["パソコンによる3次元グラフィックスの実際"](https://www.amazon.co.jp/dp/B000J7AMMU)
(The art of 3D graphics by personal computers) written by
[Tsuyoshi Yamamoto, a professor of Hokkaido University](https://researchers.general.hokudai.ac.jp/profile/ja.ae649a24ea72e6aa520e17560c007669.html), in 1983.

## Needs printing quickly?

Pre-generated models are available on the market.
Please visit the creator's shop https://make.dmm.com/shop/235456/ or
search by "山本トロン" from https://make.dmm.com/market/.

## How to generate STL?

This is compliant with OpenSCAD 2015.03-2.
You need to install [OpenSCAD](http://www.openscad.org/) first.

1. Open the code with OpenSCAD.

1. Set the parts to show.

    The models consists of three parts.
    To generate buildable STL data,
    you need to generate parts one by one.
    Set the `parts_to_show` parameter to select a part to show.

    To show only the front tire part, set it as
    ```
    parts_to_show = [0, 1, 0];
    ```

1. Set scale factor.

    The default real size is around W161mm x D101mm x H85mm.

    If you want to scale it to save cost or need a bigger model,
    set the `fscale` parameter.

    To reduce the size by half, set it as
    ```
    fscale = 0.5;
    ```

1. Set precision factor.

    The default precision is optimized for a realtime preview.
    More precise configuration is recommended for STL data.

    Set the `prec` parameter as `0.1` or other.
    ```
    prec = 0.1;
    ```

1. Render and export as STL.

    Render polygon mesh of the model by pressing F6 or selecting
    "Design" > "Render".
    After rendering, export the mesh data as an STL file by selecting
    "File" > "Export" > "Export as STL...".

    See also https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/STL_Import_and_Export.
