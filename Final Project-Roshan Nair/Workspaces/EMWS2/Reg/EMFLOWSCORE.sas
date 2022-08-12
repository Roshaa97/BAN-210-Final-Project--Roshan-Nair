*************************************;
*** begin scoring code for regression;
*************************************;

length _WARN_ $4;
label _WARN_ = 'Warnings' ;

drop _Y;
_Y = mpg ;

drop _DM_BAD;
_DM_BAD=0;

*** Check SQRT_weight for missing values ;
if missing( SQRT_weight ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check model for missing values ;
if missing( model ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _LP0 =     23.5238993710691;
   goto REGDR1;
end;

*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;

***  Effect: SQRT_weight ;
_TEMP = SQRT_weight ;
_LP0 = _LP0 + (    65.2894269058927 * _TEMP);

***  Effect: SQRT_weight*model ;
_TEMP = SQRT_weight  * model ;
_LP0 = _LP0 + (   -1.25103146736732 * _TEMP);

***  Effect: model*model ;
_TEMP = model  * model ;
_LP0 = _LP0 + (    0.00989392970554 * _TEMP);
*--- Intercept ---*;
_LP0 = _LP0 + (   -16.5205178011726);

REGDR1:

*** Predicted Value, Error, and Residual;
label P_mpg = 'Predicted: mpg' ;
P_mpg = _LP0;

drop _R;
if _Y = . then do;
   R_mpg = .;
end;
else do;
   _R = _Y - _LP0;
    label R_mpg = 'Residual: mpg' ;
   R_mpg = _R;
end;

*************************************;
***** end scoring code for regression;
*************************************;
