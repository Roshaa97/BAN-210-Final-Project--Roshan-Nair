drop Trans_SCALEVAR_5;
label SQRT_weight = 'Transformed weight';
if weight eq . then SQRT_weight = .;
else do;
Trans_SCALEVAR_5 = max(weight-1613, 0.0)/3527;
if Trans_SCALEVAR_5 >= 0 then SQRT_weight = Sqrt(Trans_SCALEVAR_5);
else SQRT_weight = .;
end;
