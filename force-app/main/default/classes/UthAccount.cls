public with sharing class UthAccount {
    public static final Id RECORD_TYPE_ID_PERSONACCOUNT{
        get{
            if (RECORD_TYPE_ID_PERSONACCOUNT == null) {
                RECORD_TYPE_ID_PERSONACCOUNT = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();
            }
            return RECORD_TYPE_ID_PERSONACCOUNT;
        }
        set;
    }
    public static Account buildPersonAccount(){
        return new Account(
            FirstName = 'fname',
            LastName = 'lname',
            RecordTypeId = RECORD_TYPE_ID_PERSONACCOUNT
        );
    }
}