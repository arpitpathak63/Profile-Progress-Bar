public with sharing class Header {
     @AuraEnabled
    public static integer converttointeger(decimal result) {
        Integer intConvertedValue = result.intValue();
        return intConvertedValue;

}
}