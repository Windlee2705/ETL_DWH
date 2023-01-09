WITH TMP AS (SELECT   TWT.RI_ID, TWT.IP_ID, TWT.RI_X_IP_RLTNP_TP_ID
             FROM   TWT_RI_X_IP_RLTNP_FCC_PHONGLQ TWT
             WHERE   TWT.REC_IND IN ('U', 'I')
             MINUS
             SELECT   B.RI_ID, B.IP_ID, B.RI_X_IP_RLTNP_TP_ID
             FROM   RI_X_IP_RLTNP_PHONGLQ B
             WHERE   B.EFF_DT <= #pdate# AND B.END_DT > #pdate#) -- 98052 dong`
SELECT   TWT.RI_ID,                              /*Ban ghi moi hoac thay doi*/
         TWT.IP_ID,
         TWT.SRC_STM_ID,
         #pdate# PPN_DT,
         TWT.RI_X_IP_RLTNP_TP_ID,
         #pdate# EFF_DT,
         99991231 END_DT
  FROM   TWT_RI_X_IP_RLTNP_FCC_PHONGLQ TWT, TMP
 WHERE       TWT.RI_ID = TMP.RI_ID
         AND TWT.IP_ID = TMP.IP_ID
         AND TWT.RI_X_IP_RLTNP_TP_ID = TMP.RI_X_IP_RLTNP_TP_ID
UNION ALL
SELECT   A.RI_ID,                               /*End date ban ghi cu UpDate*/
         A.IP_ID,
         A.SRC_STM_ID,
         #pdate# PPN_DT,
         A.RI_X_IP_RLTNP_TP_ID,
         A.EFF_DT,
         #pdate# END_DT
  FROM       RI_X_IP_RLTNP_PHONGLQ A
         JOIN
             TMP
         ON     A.RI_ID = TMP.RI_ID
            AND A.RI_X_IP_RLTNP_TP_ID = TMP.RI_X_IP_RLTNP_TP_ID
            AND A.EFF_DT < #pdate#
            AND A.END_DT > #pdate#
UNION
SELECT   A.RI_ID,                               /*End date ban ghi cu DELETE*/
         A.IP_ID,
         A.SRC_STM_ID,
         #pdate# PPN_DT,
         A.RI_X_IP_RLTNP_TP_ID,
         A.EFF_DT,
         #pdate# END_DT
  FROM       RI_X_IP_RLTNP_PHONGLQ A
         JOIN
             TWT_RI_X_IP_RLTNP_FCC_PHONGLQ TWT
         ON     A.RI_ID = TWT.RI_ID
            AND A.RI_X_IP_RLTNP_TP_ID = TWT.RI_X_IP_RLTNP_TP_ID
            AND A.EFF_DT < #pdate#
            AND A.END_DT > #pdate#
    		AND TWT.REC_IND = 'D'