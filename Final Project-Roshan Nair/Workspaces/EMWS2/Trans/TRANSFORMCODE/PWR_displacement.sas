drop Trans_SCALEVAR_2;
label PWR_displacement = 'Transformed displacement';
if displacement eq . then PWR_displacement = .;
else do;
Trans_SCALEVAR_2 = max(displacement-68, 0.0)/387;
PWR_displacement = (Trans_SCALEVAR_2)**0.25;
end;
