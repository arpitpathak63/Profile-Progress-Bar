@isTest
 public class ProfileModalControllerTest {
    
    @TestSetup
    static void setup()
    {
        Account a= new Account();
        a.Id = '0012x00000508l4AAA';
        a.Name='Test Account';
        a.Type='Prospect';
        update a;

        Contact c = new Contact();
        c.Id = '0032x000003Zze3AAC';
        c.lastName='test Contact';
        c.Phone = '9088762522';
        c.email = 'shadab.alam@grazitti.com';
        update c;
    }
    @isTest public static void testModal1(){
        
        Account ac=[SELECT Id, SLAExpirationDate__c FROM Account WHERE Id ='0012x00000508l4AAA'];
        ac.SLAExpirationDate__c = Date.valueOf( '2020-12-13' );
        Test.startTest();
        System.debug('Dates : '+ac.SLAExpirationDate__c);
        ProfileModalController.updateProfile('Account', 'SLAExpirationDate__c');
        ProfileModalController.updateRecord('Account', 'SLAExpirationDate__c', String.valueOf(ac.SLAExpirationDate__c));
        Test.stopTest();
        ac=[SELECT Id, SLAExpirationDate__c FROM Account WHERE Id =:ac.Id];
        System.debug('Date : '+ac.SLAExpirationDate__c);
        System.assertEquals(Date.valueOf( '2020-12-13' ), ac.SLAExpirationDate__c);
    }
    @isTest public static void testModal2(){
        
        Account ac=[SELECT Id, website FROM Account WHERE Id ='0012x00000508l4AAA'];
        ac.website = 'www.google.com';
        Test.startTest();
        ProfileModalController.updateProfile('Account', 'website');
        ProfileModalController.updateRecord('Account', 'website', ac.website);
        Test.stopTest();
        ac=[SELECT Id, website FROM Account WHERE Id =:ac.Id];
        System.assertEquals( 'www.google.com' , ac.website);
     }
}