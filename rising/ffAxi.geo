// axisymmetric rising bubble using fixed frame
Case = -1;
l1 = 0.08; // fine
l2 = 0.1;  // coarse

slipWalls = 0;
D = 8.0; // channel diameter (case 0)
l = 12.0; // total length of the domain
dist = 2.0; // distance between the center and bottom (left) boundary
If( Case == -1 )
 Printf("Mirco");
 slipWalls = 1;
EndIf
If( Case == 0 )
 Printf("NumMetHeaTra");
 D = 10.0;
 //l = 20.0;
 dist = 10.0 / 6.0;
EndIf
If( Case > 0 )
 Printf("Gustavo");
 l = 15.0;
 dist = 3.0;
EndIf

/* Defining bubble shape (circel with diameter 1, cetered at origin): */
Point(1) = {  0.0, 0.0, 0.0, l1}; // center
Point(2) = {  0.0, 0.5, 0.0, l1}; // up
Point(3) = {  0.5, 0.0, 0.0, l1}; // right
Point(4) = { -0.5, 0.0, 0.0, l1}; // left
Ellipse(1) = { 2, 1, 1, 3 };
Ellipse(2) = { 4, 1, 1, 2 };

k = newp;
/*  k+2                                   k+3
 *    o------------------------------------o
 *
 *
 *   k+1   4       3                      k+4
 *    o----o-------o-----------------------o
 */
Point(k+1) = {  -dist,   0.0, 0.0, l2};
Point(k+2) = {  -dist, D/2.0, 0.0, l2};
Point(k+3) = { l-dist, D/2.0, 0.0, l2};
Point(k+4) = { l-dist,   0.0, 0.0, l2};

top = newl; Line(top) = { k+2, k+3 };
bl = newl; Line(bl) = { 1, 4 };
br = newl; Line(br) = { 3, 1 };
left = newl; Line(left) = { 4, k+1 };
right = newl; Line(right) = { k+4, 3 };
in = newl; Line(in) = {k+1, k+2};
out = newl; Line(out) = {k+3, k+4};

/* Boundary conditions: */
Physical Line(Sprintf("bubble%g",1)) = {1, 2};
If ( slipWalls )
 Printf("Slip walls");
 Physical Line('wallNoSlip') = { in, out };
 Physical Line('wallNormalY') = { top, bl, br, left, right };  // symmetry bc
EndIf
If ( !slipWalls )
 Printf("No-slip walls");
 Physical Line('wallNoSlip') = { top, in, out };
 Physical Line('wallNormalY') = { bl, br, left, right };  // symmetry bc
EndIf
