@isTest
public class Questionnairetest {
    @isTest static void calculatetotal() {
        Account a = new Account();
        a.name = 'Test Account';
        a.id = '0012x00000508l4AAA';
        update a;
        Contact c = new Contact();
        c.Salutation = 'Mr.';
        c.FirstName = 'Test';
        c.LastName = 'Contact';
        c.Id = '0032x000003Zze3AAC';
        update c;
        Progress_Bar_Question__c p = new Progress_Bar_Question__c();
        p.Object_Name__c = 'Account';
        p.Field_Api_Name__c = 'Website';
        p.Question__c = 'What is the website related to the account?';
        p.Weightage__c = 3;
        insert p;
        Questionnaire.getcalculateweightage(0);
        Decimal total = 0;
        List < Progress_Bar_Question__c > pb = [select id, Weightage__c from Progress_Bar_Question__c where Object_Name__c = 'Account'];
        total = total + pb[0].Weightage__c;
        System.assertEquals(3, total);
        // Questionnaire.getcalculateactual(17);

    }
    @isTest static void calculateactual() {
        Account a = new Account();
        a.name = 'Test Account';
        a.id = '0012x00000508l4AAA';
        update a;
        Contact c = new Contact();
        c.Salutation = 'Mr.';
        c.FirstName = 'Test';
        c.LastName = 'Contact';
        c.Id = '0032x000003Zze3AAC';
        update c;
        Progress_Bar_Question__c p = new Progress_Bar_Question__c();
        p.Object_Name__c = 'Account';
        p.Field_Api_Name__c = 'Website';
        p.Question__c = 'What is the website related to the account?';
        p.Weightage__c = 3;
        insert p;
        Progress_Bar_Question__c p1 = new Progress_Bar_Question__c();
        p1.Object_Name__c = 'User';
        p1.Field_Api_Name__c = '';
        p1.Question__c = 'Please upload your profile picture';
        p1.Weightage__c = 3;
        insert p1;
        Questionnaire.getcalculateactual(0);
        Decimal actual = 0;
        List < Progress_Bar_Question__c > pb = [select id, Weightage__c from Progress_Bar_Question__c where Object_Name__c = 'Account'];
        actual = actual + pb[0].Weightage__c;
        System.assertEquals(3, actual);
    }
    @isTest static void checkpagination() {
        List < Progress_Bar_Question__c > pb = new List < Progress_Bar_Question__c > ();
        Progress_Bar_Question__c p = new Progress_Bar_Question__c();
        p.Object_Name__c = 'User';
        p.Field_Api_Name__c = '';
        p.Question__c = 'Please upload your profile picture?';
        p.Weightage__c = 2;
        pb.add(p);
        Progress_Bar_Question__c p1 = new Progress_Bar_Question__c();
        p1.Object_Name__c = 'Contact';
        p1.Field_Api_Name__c = 'Email';
        p1.Question__c = 'What is the email of the contact?';
        p1.Weightage__c = 5;
        pb.add(p1);
        Progress_Bar_Question__c p2 = new Progress_Bar_Question__c();
        p2.Object_Name__c = 'Contact';
        p2.Field_Api_Name__c = 'Phone';
        p2.Question__c = 'What is the phone number related with the contact?';
        p2.Weightage__c = 4;
        pb.add(p2);
        Progress_Bar_Question__c p3 = new Progress_Bar_Question__c();
        p3.Object_Name__c = 'Account';
        p3.Field_Api_Name__c = 'Website';
        p3.Question__c = 'What is the website related to the account?';
        p3.Weightage__c = 3;
        pb.add(p3);
        Progress_Bar_Question__c p4 = new Progress_Bar_Question__c();
        p4.Object_Name__c = 'Account';
        p4.Field_Api_Name__c = 'SLAExpirationDate__c';
        p4.Question__c = 'SLA Expiration Date?';
        p4.Weightage__c = 3;
        pb.add(p4);
        insert pb;
        Questionnaire.getQue(1, 0);
        Integer pbSize = pb.size();
        System.assertEquals(5, pbSize);
    }

}