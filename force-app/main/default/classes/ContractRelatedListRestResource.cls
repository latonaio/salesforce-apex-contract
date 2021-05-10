/**
 * 契約一覧取得のREST API
 * 
 */
@RestResource(urlMapping='/ContractRelatedList/*')
global with sharing class ContractRelatedListRestResource {

    @HttpGet
    global static void doGetContractRelatedList() {
        RestRequest req = RestContext.request;
        String rowLimit = req.params.get('rowLimit');
        String offset = req.params.get('offset');
        List<Contract> contList = ContractDao.findContractAll(rowLimit, offset);
        
        RestContext.response.addHeader('Content-Type', 'application/json');
        RestContext.response.responseBody = Blob.valueOf(JSON.serialize(contList));
    }
    
}