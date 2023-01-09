WITH TMP AS (SELECT   TWT.RI_ID, TWT.VAL_LCY, TWT.VAL_FCY
             FROM   TWT_RI_VAL_FCC_PHONGLQ TWT
             WHERE   TWT.REC_IND IN ('U', 'I')
             MINUS	
             SELECT   B.RI_ID, B.VAL_LCY, B.VAL_FCY
             FROM   RI_VAL_PHONGLQ B
             WHERE   B.EFF_DT <= #pdate# AND B.END_DT > #pdate#) -- 98052 dong`
SELECT   TWT.RI_ID,                              /*Ban ghi moi hoac thay doi*/
         TWT.SRC_STM_ID,
         TWT.CCY_ID,
         TWT.VAL_LCY,
         TWT.VAL_FCY,
         #pdate# EFF_DT,
         99991231 END_DT,
         #pdate# PPN_DT
  FROM   TWT_RI_VAL_FCC_PHONGLQ TWT, TMP
 WHERE       TWT.RI_ID = TMP.RI_ID
         AND TWT.VAL_LCY = TMP.VAL_LCY
         AND TWT.VAL_FCY = TMP.VAL_FCY
UNION ALL
SELECT   A.RI_ID,                               /*End date ban ghi cu UpDate*/
         A.SRC_STM_ID,
         A.CCY_ID,
         A.VAL_LCY,
         A.VAL_FCY,
         A.EFF_DT,
         #pdate# END_DT,
         #pdate# PPN_DT
  FROM       RI_VAL_PHONGLQ A
         JOIN
             TMP
         ON 	A.RI_ID = TMP.RI_ID
--         	AND A.VAL_LCY = TMP.VAL_LCY 
            AND A.EFF_DT < #pdate#
            AND A.END_DT > #pdate#
UNION
-- CHIEU LAM
SELECT   A.RI_ID,                               /*End date ban ghi cu DELETE*/
         A.SRC_STM_ID,
         A.CCY_ID,
         A.VAL_LCY,
         A.VAL_FCY,
         A.EFF_DT,
         #pdate# END_DT,
         #pdate# PPN_DT
  FROM       RI_VAL_PHONGLQ A
         JOIN
             TWT_RI_VAL_FCC_PHONGLQ TWT
         ON     A.RI_ID = TWT.RI_ID
            AND A.EFF_DT < #pdate#
            AND A.END_DT > #pdate#
    		AND TWT.REC_IND = 'D'