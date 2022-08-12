drop Trans_SCALEVAR_1;
label SQRT_cylinders = 'Transformed cylinders';
if cylinders eq . then SQRT_cylinders = .;
else do;
Trans_SCALEVAR_1 = max(cylinders-3, 0.0)/5;
if Trans_SCALEVAR_1 >= 0 then SQRT_cylinders = Sqrt(Trans_SCALEVAR_1);
else SQRT_cylinders = .;
end;
