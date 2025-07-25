trigger LoanChargeTrigger on Loan_Charge__c (after insert, after update) {
	LoanChargeService.processRecords(trigger.newMap, trigger.oldMap);
}