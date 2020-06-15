public with sharing class Questionnaire {
    public class wrapper {
        @AuraEnabled
        public List < Progress_Bar_Question__c > pb {
            get;
            set;
        }
        @AuraEnabled
        public Boolean showPrevious {
            get;
            set;
        }
        @AuraEnabled
        public Boolean showNext {
            get;
            set;
        }
    }

    @AuraEnabled
    public static wrapper getQue(Integer recLimit, Integer recOffset) {
        List < ID > I = new List < ID > ();
        Set<ID> se=new Set<ID>();
        String cu = userinfo.getUserId();
        System.debug('cu----->'+cu);
        I.add('0032x000003Zze3AAC');
        I.add('0012x00000508l4AAA');
        I.add(cu);
        if (recLimit == null || recOffset == null) {
            return null;
        }
        Integer localRecLimit = recLimit + 1;
         List < Progress_Bar_Question__c > pk = [select id, Question__c, Object_Name__c,Field_Api_Name__c  from Progress_Bar_Question__c];
        for(Progress_Bar_Question__c p:pk)
        {
               if(p.Object_Name__c=='User')
            {
            System.debug('p.Object_Name__c------>'+p.Object_Name__c); 
            System.debug('p.field name----->'+p.Field_Api_Name__c);    
           String query = 'select ' + 'SmallPhotoUrl' + ' from ' + p.Object_Name__c + ' ' + 'where' + ' ' + 'Id =' + ':' + 'cu';
           System.debug('Query------>'+query);
           String use = String.valueof(Database.query(query)); 
           System.debug('Use------->'+use);     
            if(use.contains('/profilephoto/005/T')) 
              //pb.add(p);
                se.add(p.Id);
            
        }
             else
            {
               String query1 = 'select ' + p.Field_Api_Name__c + ' from ' + p.Object_Name__c + ' ' + 'where' + ' ' + 'Id IN' + ':'+'I'; 
                System.debug('Query 1---->'+query1);
                String use1=String.valueof(Database.query(query1));
                System.debug('Query result----->'+use1);
                if(!use1.contains(p.Field_Api_Name__c))
                 //pb.add(p);
                se.add(p.Id);
            }
         }
        List < Progress_Bar_Question__c > pb = [select id, Question__c, Object_Name__c,Field_Api_Name__c  from Progress_Bar_Question__c where id IN:se LIMIT: localRecLimit OFFSET: recOffset];
        Integer pbSize = pb.size();
        if (pbSize > recLimit)
            pb.remove(localRecLimit - 1);
        if (!pb.isEmpty()) {
            wrapper wr = new wrapper();
            wr.pb = pb;
            wr.showPrevious = (recOffset == 0 ? false : true);
            wr.showNext = (pbSize > recLimit);
            return wr;
        } else {
            return null;
        }
    }

    @AuraEnabled
    public static Decimal getcalculateweightage(Decimal total) {
        Decimal c = 0;
        List < Progress_Bar_Question__c > pq = [select id, Weightage__c, Object_Name__c, Field_Api_Name__c from Progress_Bar_Question__c];
        for (Progress_Bar_Question__c p: pq) {
            c = c + p.Weightage__c;
        }
        return c;
    }
    @AuraEnabled
    public static Decimal getcalculateactual(Decimal kw) {
        Decimal actual = 0;
        List < ID > I = new List < ID > ();
        String cu = userinfo.getUserId();
        I.add('0032x000003Zze3AAC');
        I.add('0012x00000508l4AAA');
        I.add(cu);
        List < Progress_Bar_Question__c > pb = [select id, Weightage__c, Object_Name__c, Field_Api_Name__c from Progress_Bar_Question__c];
        Map < String, List < String >> ma = new Map < String, List < String >> ();


        for (Progress_Bar_Question__c p: pb) {
            if (ma.containskey(p.Object_Name__c) && !p.Object_Name__c.equals('User')) {
                List < String > field = ma.get(p.Object_Name__c);
                field.add(p.Field_Api_Name__c);
                ma.put(p.Object_Name__c, field);
            } else if (ma.containskey(p.Object_Name__c) && p.Object_Name__c.equals('User')) {
                List < String > field = ma.get(p.Object_Name__c);
                field.add('SmallPhotoUrl');
                ma.put(p.Object_Name__c, field);
            } else if (p.Object_Name__c.equals('User')) {
                List < String > field = new List < String > ();
                field.add('SmallPhotoUrl');
                ma.put(p.Object_Name__c, field);
            } else {
                List < String > field = new List < String > ();
                field.add(p.Field_Api_Name__c);
                ma.put(p.Object_Name__c, field);
            }
        }
        for (String keys: ma.keyset()) {
            for (String ss: ma.get(keys)) {
                Map < String, List < sObject >> m = new Map < String, List < sObject >> ();

                if (keys.equalsIgnoreCase('User')) {

                    String querystring = 'select ' + ss + ' from ' + keys + ' ' + 'where' + ' ' + 'Id =' + ':' + 'cu';
                    List < Sobject > res = Database.query(querystring);
                    m.put(keys, res);
                    String soBjectTypeString = String.valueOf(res[0].getSObjectType());
                    Type t = Type.forName('Map<String,' + soBjectTypeString + '>');
                    Map < String, Sobject > sobjectMap = (Map < String, Sobject > ) t.newInstance();
                    for (SObject currentSObject: res) {
                        sobjectMap.put(String.valueOf(currentSObject.get(ss)), currentSObject);
                        String k = String.valueOf(currentSObject.get(ss));
                        if (!k.contains('/profilephoto/005/T')) {
                            Progress_Bar_Question__c qu = [select id, Weightage__c, Object_Name__c, Field_Api_Name__c from Progress_Bar_Question__c where Object_Name__c =: keys];
                            actual = actual + qu.Weightage__c;
                        }
                    }
                } else {
                    String querystring = 'select ' + ss + ' from ' + keys + ' ' + 'where' + ' ' + 'Id' + ' ' + 'IN' + ':' + 'I';
                    List < Sobject > res = Database.query(querystring);
                    m.put(keys, res);
                    String soBjectTypeString = String.valueOf(res[0].getSObjectType());
                    Type t = Type.forName('Map<String,' + soBjectTypeString + '>');
                    Map < String, Sobject > sobjectMap = (Map < String, Sobject > ) t.newInstance();
                    for (SObject currentSObject: res) {
                        sobjectMap.put(String.valueOf(currentSObject.get(ss)), currentSObject);
                        String k = String.valueOf(currentSObject.get(ss));
                        if (!String.isBlank(k)) {
                            Progress_Bar_Question__c qu = [select id, Weightage__c, Object_Name__c, Field_Api_Name__c from Progress_Bar_Question__c where Object_Name__c =: keys and Field_Api_Name__c =: ss];
                            actual = actual + qu.Weightage__c;
                        }
                    }
                }
            }
        }
        return actual;
    }
}