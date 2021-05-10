public with sharing class ContractDao {

    
      /**
       * 契約を全件取得します。
       *     
       * @return contList
       */      
    public static List<Contract> findContractAll(String rowLimit, String offset){
        
        String soqlStr = 'SELECT Id ';
        soqlStr +=' ,Name ';
        soqlStr +=',ContractNumber ';
        soqlStr +=',StartDate ';
        soqlStr +=' ,EndDate ';
        //soqlStr +=',ActivatedDate ';
        //soqlStr +=' ,Status';
        soqlStr +=',ContractTerm ';
        soqlStr +=',CustomerSignedDate ';
        soqlStr +=',AccountId ';
        soqlStr +='FROM ';
        soqlStr +='Contract ';
        //LIMIT
        if (rowLimit != null) {
            soqlStr += 'LIMIT ' + rowLimit;
        }
        //OFFSET
        if (offset != null) {
            soqlStr =+ 'OFFSET ' + offset;
        }
        
       return Database.query(soqlStr);    
    
    }
    
    
      /**
       * contractIdから、契約を取得します。
       *     
       * @param contractId
       * @return contList
       */  
    public  static List<Contract> findContractById(String contractId) {
      return  [SELECT Id
                                  ,Name
                                  ,ContractNumber
                                  ,StartDate
                                  ,EndDate
                                  ,ContractTerm
                                  ,AccountId
                    FROM
                       Contract
                    WHERE
                        Id =: contractId	
                    ];
    }
    
    
  /**
   * accountIdから、契約を取得します。(表示用の項目))
   *     
   * @param accountId
   * @return conList
   */  
    public  static List<Contract> findContractListByAccountId(String accountId) {
       return   [SELECT Id
                                     ,Name
                                     ,ContractNumber
                                     ,StartDate
                                     ,EndDate
                                     ,ContractTerm
                                       ,AccountId
                         FROM
                               Contract
                         WHERE
                                AccountId =: accountId
                         ];
    }

 
  /**
   * 契約を取得します。(顧客一覧表示用の項目))
   * 
   * @param rowLimit
   * @param offset
   */  
    public static List<Contract> findContractAllForContractRelatedList(String rowLimit, String offset) {
        String soqlStr = 'SELECT Id ';
        soqlStr +=' ,Name ';
        soqlStr +=',ContractNumber ';
        soqlStr +=',StartDate ';
        soqlStr +=',EndDate ';
        soqlStr +=',ActivatedDate ';
        soqlStr +=' ,SpecialTerms ';
        soqlStr +=' ,ContractTerm ';
        soqlStr +=',Description ';
        soqlStr +=' ,CustomerSignedDate ';
       soqlStr +='FROM ';
       soqlStr +='Contract ';
        //LIMIT
        if (rowLimit != null) {
            soqlStr += 'LIMIT ' + rowLimit;
        }
        //OFFSET
        if (offset != null) {
            soqlStr =+ 'OFFSET ' + offset;
        }
        
       return Database.query(soqlStr);
    }
    


  /**
   * 契約IDから、契約を取得します。(UPDATE用の項目))
   *     
   * @param contractId
   * @return con
   */  
    public static Contract findContractForUpdateByAccountId(String accountId) {
        List<Contract> conList = [SELECT Id
                                  								 ,Name
                                                                //TODO 更新する項目を追加する
                                                                //,KeiyakuStatus__c
                                                            FROM
                                                                Contract
                                                            WHERE 
                                                               AccountId =: accountId
                                   							 ];
        if (conList == null || !conList.isEmpty()) {
            return null;
        }

        return conList.get(0);
    }
    
}