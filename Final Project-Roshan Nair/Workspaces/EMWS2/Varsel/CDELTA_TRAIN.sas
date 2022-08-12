if upcase(name) = 'SQRT_CYLINDERS' then role = 'REJECTED';
else
if upcase(name) = 'CAR_NAME' then role = 'REJECTED';
else
if upcase(name) = 'HORSEPOWER' then role = 'REJECTED';
if upcase(strip(name)) = "G_HORSEPOWER" then level = "NOMINAL";
