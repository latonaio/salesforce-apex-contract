@isTest
private class ContractDaoTest {

    // テストデータ作成
    static void createTestData(String sObjectType, String developerName) {
    }

    static testMethod void getAccountTest() {
        createTestData('Account', 'PersonAccount');

        Test.startTest();
        Account a = [select id from Account limit 1];

        ContractDao.getAccount(null);
        ContractDao.getAccount(a.Id);
        Test.stopTest();
    }
    
    static testMethod void getValidContractsTest() {
        createTestData('Account', 'PersonAccount');

        Test.startTest();
        Account a = [select id from Account limit 1];

        // ContractDao.getValidContracts(null);
        ContractDao.getValidContracts(a.Id);
        Test.stopTest();
    }
}