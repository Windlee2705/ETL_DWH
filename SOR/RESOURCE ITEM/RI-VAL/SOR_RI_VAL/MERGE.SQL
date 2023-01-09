MERGE INTO   FSSTRAINING.RI_VAL_PHONGLQ D
     USING   (SELECT   RI_ID,
                       SRC_STM_ID,
                       CCY_ID,
                       VAL_LCY,
                       VAL_FCY,
                       EFF_DT,
                       END_DT,
                       PPN_DT
                FROM   FSSTRAINING.TWT_RI_VAL_PHONGLQ ) S
        ON (D.RI_ID = S.RI_ID
              AND D.VAL_LCY = S.VAL_LCY
              AND D.VAL_FCY = S.VAL_FCY
              AND D.EFF_DT = S.EFF_DT)
WHEN MATCHED
THEN
    UPDATE SET D.PPN_DT = S.PPN_DT, D.END_DT = S.END_DT
WHEN NOT MATCHED
THEN
    INSERT              (RI_ID,
                       SRC_STM_ID,
                       CCY_ID,
                       VAL_LCY,
                       VAL_FCY,
                       EFF_DT,
                       END_DT,
                       PPN_DT)
        VALUES   (S.RI_ID,
                  S.SRC_STM_ID,
                  S.CCY_ID,
                  S.VAL_LCY,
                  S.VAL_FCY,
                  S.EFF_DT,
                  S.END_DT,
                  S.PPN_DT);