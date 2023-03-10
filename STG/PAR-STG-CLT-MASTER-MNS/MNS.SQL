( 
 SELECT CLT_CODE ,'I'  REC_IND ,#pdate# PPN_DT  
 FROM IFTB_CLT_MASTER_TDY A  
 MINUS  
 SELECT CLT_CODE, 'I'  REC_IND, #pdate# PPN_DT  
 FROM IFTB_CLT_MASTER_PDY B 
) 
UNION ALL 
( 
 SELECT CLT_CODE, 'D'  REC_IND, #pdate# PPN_DT  
 FROM IFTB_CLT_MASTER_PDY B 
 MINUS  
 SELECT CLT_CODE, 'D'  REC_IND, #pdate# PPN_DT  
 FROM IFTB_CLT_MASTER_TDY A 
 ) 
UNION ALL 
( 
 SELECT CLT_CODE, 'U'  REC_IND, #pdate# PPN_DT   
 FROM 
 ( 
  SELECT A.*
  FROM IFTB_CLT_MASTER_TDY A, IFTB_CLT_MASTER_PDY B 
  WHERE  A.CLT_CODE=B.CLT_CODE  
  MINUS  
  SELECT B.*
  FROM IFTB_CLT_MASTER_PDY B 
 ) C	 
)