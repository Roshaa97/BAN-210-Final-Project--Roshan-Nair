*------------------------------------------------------------*;
* Computed Code;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TRANSFORM: cylinders , sqrt(max(cylinders-3, 0.0)/5);
*------------------------------------------------------------*;
drop Trans_SCALEVAR_1;
label SQRT_cylinders = 'Transformed cylinders';
if cylinders eq . then SQRT_cylinders = .;
else do;
Trans_SCALEVAR_1 = max(cylinders-3, 0.0)/5;
if Trans_SCALEVAR_1 >= 0 then SQRT_cylinders = Sqrt(Trans_SCALEVAR_1);
else SQRT_cylinders = .;
end;
*------------------------------------------------------------*;
* TRANSFORM: displacement , (max(displacement-68, 0.0)/387)**0.25;
*------------------------------------------------------------*;
drop Trans_SCALEVAR_2;
label PWR_displacement = 'Transformed displacement';
if displacement eq . then PWR_displacement = .;
else do;
Trans_SCALEVAR_2 = max(displacement-68, 0.0)/387;
PWR_displacement = (Trans_SCALEVAR_2)**0.25;
end;
*------------------------------------------------------------*;
* TRANSFORM: weight , sqrt(max(weight-1613, 0.0)/3527);
*------------------------------------------------------------*;
drop Trans_SCALEVAR_5;
label SQRT_weight = 'Transformed weight';
if weight eq . then SQRT_weight = .;
else do;
Trans_SCALEVAR_5 = max(weight-1613, 0.0)/3527;
if Trans_SCALEVAR_5 >= 0 then SQRT_weight = Sqrt(Trans_SCALEVAR_5);
else SQRT_weight = .;
end;
