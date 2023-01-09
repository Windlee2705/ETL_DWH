SELECT   A.RI_ID,
         A.UNQ_ID_IN_SRC_STM,
         A.RI_TP_ID,
         A.PPN_DT,
         A.REC_IND
  FROM    TWT_RI_FCC_PHONGLQ    A
         LEFT JOIN
             RI_PHONGLQ C
         ON A.RI_ID = C.RI_ID