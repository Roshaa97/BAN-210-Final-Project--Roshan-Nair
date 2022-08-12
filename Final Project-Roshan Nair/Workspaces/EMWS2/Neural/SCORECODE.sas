***********************************;
*** Begin Scoring Code for Neural;
***********************************;
DROP _DM_BAD _EPS _NOCL_ _MAX_ _MAXP_ _SUM_ _NTRIALS;
 _DM_BAD = 0;
 _NOCL_ = .;
 _MAX_ = .;
 _MAXP_ = .;
 _SUM_ = .;
 _NTRIALS = .;
 _EPS =                1E-10;
LENGTH _WARN_ $4 
;
      label S_PWR_displacement = 'Standard: PWR_displacement' ;

      label S_SQRT_weight = 'Standard: SQRT_weight' ;

      label S_acceleration = 'Standard: acceleration' ;

      label S_model = 'Standard: model' ;

      label S_origin = 'Standard: origin' ;

      label G_horsepower0 = 'Dummy: G_horsepower=0' ;

      label G_horsepower1 = 'Dummy: G_horsepower=1' ;

      label G_horsepower2 = 'Dummy: G_horsepower=2' ;

      label G_horsepower3 = 'Dummy: G_horsepower=3' ;

      label G_horsepower4 = 'Dummy: G_horsepower=4' ;

      label G_horsepower5 = 'Dummy: G_horsepower=5' ;

      label G_horsepower6 = 'Dummy: G_horsepower=6' ;

      label H11 = 'Hidden: H1=1' ;

      label H12 = 'Hidden: H1=2' ;

      label H13 = 'Hidden: H1=3' ;

      label H14 = 'Hidden: H1=4' ;

      label H15 = 'Hidden: H1=5' ;

      label P_mpg = 'Predicted: mpg' ;

      label  _WARN_ = "Warnings"; 

*** Generate dummy variables for G_horsepower ;
drop G_horsepower0 G_horsepower1 G_horsepower2 G_horsepower3 G_horsepower4 
        G_horsepower5 G_horsepower6 ;
*** encoding is sparse, initialize to zero;
G_horsepower0 = 0;
G_horsepower1 = 0;
G_horsepower2 = 0;
G_horsepower3 = 0;
G_horsepower4 = 0;
G_horsepower5 = 0;
G_horsepower6 = 0;
if missing( G_horsepower ) then do;
   G_horsepower0 = .;
   G_horsepower1 = .;
   G_horsepower2 = .;
   G_horsepower3 = .;
   G_horsepower4 = .;
   G_horsepower5 = .;
   G_horsepower6 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( G_horsepower , BEST12. );
   %DMNORMIP( _dm12 )
   _dm_find = 0; drop _dm_find;
   if _dm12 <= '3'  then do;
      if _dm12 <= '1'  then do;
         if _dm12 = '0'  then do;
            G_horsepower0 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm12 = '1'  then do;
               G_horsepower1 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm12 = '2'  then do;
            G_horsepower2 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm12 = '3'  then do;
               G_horsepower3 = 1;
               _dm_find = 1;
            end;
         end;
      end;
   end;
   else do;
      if _dm12 <= '5'  then do;
         if _dm12 = '4'  then do;
            G_horsepower4 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm12 = '5'  then do;
               G_horsepower5 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm12 = '6'  then do;
            G_horsepower6 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm12 = '7'  then do;
               G_horsepower0 = -1;
               G_horsepower1 = -1;
               G_horsepower2 = -1;
               G_horsepower3 = -1;
               G_horsepower4 = -1;
               G_horsepower5 = -1;
               G_horsepower6 = -1;
               _dm_find = 1;
            end;
         end;
      end;
   end;
   if not _dm_find then do;
      G_horsepower0 = .;
      G_horsepower1 = .;
      G_horsepower2 = .;
      G_horsepower3 = .;
      G_horsepower4 = .;
      G_horsepower5 = .;
      G_horsepower6 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** *************************;
*** Checking missing input Interval
*** *************************;

IF NMISS(
   PWR_displacement , 
   SQRT_weight , 
   acceleration , 
   model , 
   origin   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';

   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_PWR_displacement  =    -3.85946672878638 +     5.56143158103166 * 
        PWR_displacement ;
   S_SQRT_weight  =     -2.8995832574349 +      4.9516224140926 * SQRT_weight
         ;
   S_acceleration  =    -5.65655377081867 +      0.3645839108031 * 
        acceleration ;
   S_model  =    -20.4776175489859 +     0.26959850875952 * model ;
   S_origin  =    -1.96077366996082 +     1.22260005303439 * origin ;
END;
ELSE DO;
   IF MISSING( PWR_displacement ) THEN S_PWR_displacement  = . ;
   ELSE S_PWR_displacement  =    -3.85946672878638 +     5.56143158103166 * 
        PWR_displacement ;
   IF MISSING( SQRT_weight ) THEN S_SQRT_weight  = . ;
   ELSE S_SQRT_weight  =     -2.8995832574349 +      4.9516224140926 * 
        SQRT_weight ;
   IF MISSING( acceleration ) THEN S_acceleration  = . ;
   ELSE S_acceleration  =    -5.65655377081867 +      0.3645839108031 * 
        acceleration ;
   IF MISSING( model ) THEN S_model  = . ;
   ELSE S_model  =    -20.4776175489859 +     0.26959850875952 * model ;
   IF MISSING( origin ) THEN S_origin  = . ;
   ELSE S_origin  =    -1.96077366996082 +     1.22260005303439 * origin ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -0.22561664220788 * S_PWR_displacement  +     0.29279986935289 * 
        S_SQRT_weight  +    -0.08154144101082 * S_acceleration
          +    -1.57373487646847 * S_model  +    -0.56643338809607 * S_origin
         ;
   H12  =     4.93599986000727 * S_PWR_displacement  +    -3.01836024392518 * 
        S_SQRT_weight  +     0.41423051735248 * S_acceleration
          +      0.9905881549869 * S_model  +     5.10007136657153 * S_origin
         ;
   H13  =    -1.53185013413527 * S_PWR_displacement  +     2.07646959989326 * 
        S_SQRT_weight  +     0.62803777105863 * S_acceleration
          +    -0.48474075845178 * S_model  +    -2.46960471429882 * S_origin
         ;
   H14  =     1.96220002879875 * S_PWR_displacement  +    -2.87264187685342 * 
        S_SQRT_weight  +    -0.33516368597319 * S_acceleration
          +    -2.66240440595274 * S_model  +     2.74431141979393 * S_origin
         ;
   H15  =    -4.48005247601382 * S_PWR_displacement  +    -0.00584042704999 * 
        S_SQRT_weight  +    -1.88583017304181 * S_acceleration
          +     0.28789605983299 * S_model  +     0.01833307183986 * S_origin
         ;
   H11  = H11  +    -0.32589822322206 * G_horsepower0
          +    -2.11513303881614 * G_horsepower1  +     0.24624362754708 * 
        G_horsepower2  +    -0.20585055130122 * G_horsepower3
          +    -0.19436717896363 * G_horsepower4  +     0.16856024419836 * 
        G_horsepower5  +     -0.3165843590158 * G_horsepower6 ;
   H12  = H12  +      -1.053307301652 * G_horsepower0
          +    -1.34604130948168 * G_horsepower1  +     2.53331408689217 * 
        G_horsepower2  +    -0.88094896944232 * G_horsepower3
          +    -0.04212737578867 * G_horsepower4  +     1.70833493332698 * 
        G_horsepower5  +     0.50679394243914 * G_horsepower6 ;
   H13  = H13  +    -1.10735170928115 * G_horsepower0
          +    -1.27815205151561 * G_horsepower1  +    -2.93732966593975 * 
        G_horsepower2  +     0.26560257283006 * G_horsepower3
          +     1.27772842560416 * G_horsepower4  +      0.4182236705835 * 
        G_horsepower5  +     0.96211923165101 * G_horsepower6 ;
   H14  = H14  +     0.70529046022495 * G_horsepower0
          +        5.00762903292 * G_horsepower1  +     3.12940883992694 * 
        G_horsepower2  +    -0.47131349103044 * G_horsepower3
          +    -2.50517134874503 * G_horsepower4  +    -0.23400568544976 * 
        G_horsepower5  +    -4.01167816695482 * G_horsepower6 ;
   H15  = H15  +    -0.83580412810395 * G_horsepower0
          +     0.33584823926172 * G_horsepower1  +     1.47861687233833 * 
        G_horsepower2  +     0.29972014231897 * G_horsepower3
          +    -0.40796294853021 * G_horsepower4  +    -0.61530226688032 * 
        G_horsepower5  +    -1.22502721368356 * G_horsepower6 ;
   H11  =    -1.25220742338907 + H11 ;
   H12  =     3.55054085911683 + H12 ;
   H13  =    -1.57744423775478 + H13 ;
   H14  =     1.61611384879506 + H14 ;
   H15  =    -2.43404899996786 + H15 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
END;
*** *************************;
*** Writing the Node intervalTargets ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_mpg  =     4.35521208192278 * H11  +    -3.55839496594162 * H12
          +    -5.14861993092215 * H13  +    -2.82316167679099 * H14
          +     2.90190723352924 * H15 ;
   P_mpg  = P_mpg  +     3.23232456419777 * S_PWR_displacement
          +    -2.67328859312353 * S_SQRT_weight  +     1.92259283968828 * 
        S_acceleration  +     3.07674646933812 * S_model
          +     1.60808322499289 * S_origin ;
   P_mpg  = P_mpg  +    -9.00526279781947 * G_horsepower0
          +    -2.85437315145606 * G_horsepower1  +    -4.83234195044209 * 
        G_horsepower2  +    -1.19030839841495 * G_horsepower3
          +      1.2579767801169 * G_horsepower4  +     2.09998268656574 * 
        G_horsepower5  +     2.95490641856222 * G_horsepower6 ;
   P_mpg  =     29.6876860089066 + P_mpg ;
END;
ELSE DO;
   P_mpg  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_mpg  =     23.5238993710691;
END;
********************************;
*** End Scoring Code for Neural;
********************************;
