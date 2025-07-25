public with sharing class UthLoanCharge {
    public static List<Loan_Charge__c> getAll(){
        return Database.query('SELECT '+
            String.join(new List<String>(Loan_Charge__c.getSObjectType().getDescribe().fields.getMap().keySet()), ',') +
            ' FROM Loan_Charge__c ' + 
            ' ORDER BY Id'
        );
    }
}