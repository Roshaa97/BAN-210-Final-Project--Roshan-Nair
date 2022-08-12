*------------------------------------------------------------*;
* Computed Code;
*------------------------------------------------------------*;

if NAME="SQRT_cylinders" then do;
   COMMENT = "sqrt(max(cylinders-3, 0.0)/5) ";
ROLE ="INPUT";
REPORT ="N";
LEVEL  ="INTERVAL";
end;
if NAME="cylinders" then delete;

if NAME="PWR_displacement" then do;
   COMMENT = "(max(displacement-68, 0.0)/387)**0.25 ";
ROLE ="INPUT";
REPORT ="N";
LEVEL  ="INTERVAL";
end;
if NAME="displacement" then delete;

if NAME="SQRT_weight" then do;
   COMMENT = "sqrt(max(weight-1613, 0.0)/3527) ";
ROLE ="INPUT";
REPORT ="N";
LEVEL  ="INTERVAL";
end;
if NAME="weight" then delete;
