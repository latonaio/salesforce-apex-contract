/**
 * 契約オブジェクトのREST API
 * 
 */
@RestResource(urlMapping='/Contract/*')
global with sharing class ContractRestResource {

     /**
      * 契約IDをもとに、契約を取得します。
      *     
      * @param contractId
      * @return con
      */
    @HttpGet
    global static List<Contract> doGetContract() {
        RestRequest req = RestContext.request;

        //---- クエリパラメータがnullでない場合(/Contract/doGetContract/?accountId={accountId}) ----
        String accountId = req.params.get('accountId');
        if (accountId != null) {
            // nullの場合でも項目を表示させるために、新しいContractに詰め替える
            List<Contract> retContList = ContractDao.findContractListByAccountId(accountId);
            
            List<Contract> contList = new List<Contract>();
            for (Contract retCont : retContList) {
                Contract cont = new Contract();
                cont.Id = retCont.Id;
                cont.Name = retCont.Name;
                cont.StartDate = retCont.StartDate;
                cont.ContractTerm = retCont.ContractTerm;
                cont.AccountId = retCont.AccountId;
                
                contList.add(cont);
            }
            
            return contList;
        }
        
       //---- パスパラメータがnullでない場合(/Contract/doGetContract/{contractId})  ----
       String contractId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
       List<Contract> retContList = ContractDao.findContractById(contractId);
         
        // nullの場合でも項目を表示させるために、新しいAccountに詰め替える
        List<Contract> contList = new List<Contract>();
        for (Contract retCont : retContList) {
        	Contract cont = new Contract();
       		cont.Id = retCont.Id;
       		cont.Name = retCont.Name;
       		cont.StartDate = retCont.StartDate;
        	cont.ContractTerm = retCont.ContractTerm;
        	cont.AccountId = retCont.AccountId;
            
            contList.add(cont);
        }

       return contList;
    }


  /**
   * 契約IDから、契約オブジェクトを更新します。
   *     
   * @param contractId
   * @body
   * @return cont
   */  
    @HttpPut
    global static Contract doPutContract() {
        RestRequest req = RestContext.request;
        String contractId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        
        JSONParser parser = JSON.createParser(req.requestBody.toString());
        Contract cont = (Contract)parser.readValueAs(Contract.class);        
        
        if (cont == null) {
        	return null;
        }
        cont.Id = contractId;
        
        try {
            UPDATE cont;

       } catch(Exception e) {
           return new Contract(Description=e.getMessage());
       }
        
        return cont;

    }

    
  /**
   * 仮契約（空の契約）を作成します
   *     
   * @param accountId
   * @return con.Id
   */  
    @HttpPost
    global static Contract doPostContract() {
        RestRequest req = RestContext.request;
        String contractId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
                
        JSONParser parser = JSON.createParser(req.requestBody.toString());
        Contract cont = (Contract)parser.readValueAs(Contract.class);
        
        if (cont == null) {
        	return null;
        } 

        try {
            INSERT cont;
        } catch (Exception e) {
            return new Contract(Description=e.getMessage());
        }
        
        return cont;
    }

  /**
   * 契約IDから、契約を削除します
   *     
   * @param contractId
   * @return contractId
   */  
   @HttpDelete
    global static String doDeleteContract() {
        RestRequest req = RestContext.request;
        String contractId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        
        try {
            Database.delete(contractId);
        } catch(Exception e) {
            return e.getStackTraceString();
        }
        
        return contractId;
    }

}