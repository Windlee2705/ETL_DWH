MERGE INTO   FSSTRAINING.RI_X_IP_RLTNP_PHONGLQ D
     USING   (SELECT   RI_ID,
                       SRC_STM_ID,
                       IP_ID,
                       PPN_DT,
                       RI_X_IP_RLTNP_TP_ID,
                       EFF_DT,
                       END_DT
                FROM   FSSTRAINING.TWT_RI_X_IP_RLTNP_PHONGLQ ) S
        ON (D.RI_ID = S.RI_ID
              AND D.IP_ID = S.IP_ID
              AND D.RI_X_IP_RLTNP_TP_ID = S.RI_X_IP_RLTNP_TP_ID
              AND D.EFF_DT = S.EFF_DT)
WHEN MATCHED
THEN
    UPDATE SET D.PPN_DT = S.PPN_DT, D.END_DT = S.END_DT
WHEN NOT MATCHED
THEN
    INSERT              (RI_ID,
                         SRC_STM_ID,
                         IP_ID,
                         PPN_DT,
                         RI_X_IP_RLTNP_TP_ID,
                         EFF_DT,
                         END_DT)
        VALUES   (S.RI_ID,
                  S.SRC_STM_ID,
                  S.IP_ID,
                  S.PPN_DT,
                  S.RI_X_IP_RLTNP_TP_ID,
                  S.EFF_DT,
                  S.END_DT);