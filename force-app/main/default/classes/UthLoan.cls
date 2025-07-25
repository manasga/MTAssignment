public with sharing class UthLoan {
    public static Loan__c build(Id personAccountId){
        Loan__c aloan = new Loan__c(
            Gross_Loan_Amount__c = 300,
            Name = 'Test Loan',
            Term__c = 12,
            Date_Loan_Issued__c = System.today(),
            Account__c = personAccountId
        );
        return aloan;
    }

    public static List<Loan__c> getAll(){
        return Database.query('SELECT '+
            String.join(new List<String>(Loan__c.getSObjectType().getDescribe().fields.getMap().keySet()), ',') +
            ' FROM Loan__c ' + 
            ' ORDER BY Id'
        );
    }
}