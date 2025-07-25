public with sharing class LoanChargeService {
    public static void  processRecords(Map<Id, Loan_Charge__c> newLoanChargeMap, Map<Id, Loan_Charge__c> oldLoanChargeMap){
        List<Id> loanIds = new List<Id>();
        List<Loan_Charge__c> nonReleaseChargeRecords = new List<Loan_Charge__c>();
        for(Loan_Charge__c aLoanCharge: newLoanChargeMap.values()){
            if(aLoanCharge.Charge_Type__c != 'Release Charge'
              		&& (aLoanCharge.Date__c != null && (oldLoanChargeMap == null || aLoanCharge.Date__c != oldLoanChargeMap.get(aLoanCharge.Id).Date__c))){
            	loanIds.add(aLoanCharge.Loan__c);
                nonReleaseChargeRecords.add(aLoanCharge);
            }
        }
        
        // check for existing release charge
        List<Loan_Charge__c> loanCharges = [SELECT Id, Loan__c, Date__c, Charge_Type__c FROM Loan_Charge__c
                                          WHERE Loan__c in :loanIds AND Charge_Type__c = 'Release Charge'];
        Map<Id, Loan_Charge__c> mapOfReleaseChargeByLoanIds =  new Map<Id, Loan_Charge__c>();
        for(Loan_Charge__c loanCharge: loanCharges){
            mapOfReleaseChargeByLoanIds.put(loanCharge.Loan__c, loanCharge);
        }
        
        List<Loan_Charge__c> toUpdateReleaseChargeRecordsList = new List<Loan_Charge__c>();
        for(Loan_Charge__c loanCharge : nonReleaseChargeRecords){
            Loan_Charge__c loanReleaseCharge = mapOfReleaseChargeByLoanIds.get(loanCharge.Loan__c);
            if(loanReleaseCharge != null){
                if(loanCharge.Date__c >= loanReleaseCharge.Date__c){
                    loanReleaseCharge.Date__c = loanReleaseCharge.Date__c.addMonths(1);
                    toUpdateReleaseChargeRecordsList.add(loanReleaseCharge);
                }
        	}
        }
        if(!toUpdateReleaseChargeRecordsList.isEmpty()){
            update  toUpdateReleaseChargeRecordsList;
        }
    }
}