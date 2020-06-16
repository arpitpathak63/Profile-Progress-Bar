@istest
public  class CircularProgressControllerTest {
    @isTest public static void computePercentageif() {
        
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Description = '0';
        acc.Website = '2';
        Insert acc;

        CircularProgressController.computePercentage('Account', acc.Id,'Description','Website');

        List<Account> acclist = [SELECT Id,Name,Website FROM Account WHERE ID =: acc.Id];
        system.assertEquals('2',  acclist[0].Website);
    }

    @isTest public static void computePercentageelse() {
      
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Description = 'Testing Account';
        Insert acc;

        CircularProgressController.computePercentage('Account', acc.Id,null,'Description');

        List<Account> acclist = [SELECT Id,Name,Description FROM Account WHERE ID =: acc.Id];
        system.assertEquals('Testing Account',  acclist[0].Description);
    } 

    @isTest public static void computePercentageelsescene1() {
        Decimal actualval;
        Decimal totalval;
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Description = '3';
        acc.Website = '1';
        Insert acc;

        CircularProgressController.computePercentage('Account', acc.Id,'Description','Website');

        List<Account> acclist = [SELECT Id,Name,Description,Website FROM Account WHERE ID =: acc.Id];
        actualval = Decimal.valueOf(String.valueOf(acclist[0].Website));
        totalval = Decimal.valueOf(String.valueOf(acclist[0].Description));
        System.assertEquals(33, Integer.valueOf((actualval / totalval) * 100));
    } 
}