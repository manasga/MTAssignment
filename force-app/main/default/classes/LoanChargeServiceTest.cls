@isTest
public with sharing class LoanChargeServiceTest {
    @TestSetup
    static void makeData(){
        Account personAccount = UthAccount.buildPersonAccount();
        Loan__c aloan = UthLoan.build(personAccount.Id);
        insert aloan;
    }

    @isTest
    static void testReleaseChargeDateChange(){
        Assert.areEqual(1, UthLoanCharge.getAll().size());
        Assert.areEqual('Release Charge', UthLoanCharge.getAll()[0].Charge_Type__c);
        Date releaseChargeDate =  UthLoanCharge.getAll()[0].Date__C;
        Date releaseChargeDateAddMonth =  UthLoanCharge.getAll()[0].Date__C.addMonths(1);
        Test.startTest();
            Loan_Charge__c interestLoanCharge = new Loan_Charge__c(
                Loan__c = UthLoan.getAll()[0].Id,
                Date__c = releaseChargeDate + 5,
                Charge_Type__c = 'Interest Charge',
                Amount__c = 300

            );
            insert interestLoanCharge;
            Assert.areEqual(2, UthLoanCharge.getAll().size());
            Assert.areEqual(releaseChargeDateAddMonth, UthLoanCharge.getAll()[0].Date__c);
        Test.stopTest();
    }

    @isTest
    static void testTermChange(){
        Test.startTest();
          Loan__c aloan = UthLoan.getAll()[0];
          aloan.Term__c = 10;
          update aloan;
          Assert.areEqual(System.today().addMonths(10), UthLoanCharge.getAll()[0].Date__c);
          Assert.areEqual('Admin Fee', UthLoanCharge.getAll()[1].Charge_Type__c);

        Test.stopTest();
    }
    
}