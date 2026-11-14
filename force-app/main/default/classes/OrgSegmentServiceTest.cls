@IsTest
private class OrgSegmentServiceTest {
  @IsTest
  static void testGetSegmentBoundaries() {
    Test.startTest();
    String enterprise = OrgSegmentService.getSegment(100000000);
    String upperMidCap = OrgSegmentService.getSegment(99999999);
    String lowerMidCap = OrgSegmentService.getSegment(1000000);
    String startup = OrgSegmentService.getSegment(999999);
    String blank = OrgSegmentService.getSegment(null);
    Test.stopTest();

    Assert.areEqual(
      'Enterprise',
      enterprise,
      '100,000,000 should be Enterprise'
    );
    Assert.areEqual('Mid Cap', upperMidCap, '99,999,999 should be Mid Cap');
    Assert.areEqual('Mid Cap', lowerMidCap, '1,000,000 should be Mid Cap');
    Assert.areEqual('Startup', startup, '999,999 should be Startup');
    Assert.areEqual('Startup', blank, 'Null revenue should be Startup');
  }

  @IsTest
  static void testClassifyAccounts() {
    Account enterpriseAccount = new Account(
      Name = 'Enterprise Co',
      AnnualRevenue = 250000000
    );
    Account midCapAccount = new Account(
      Name = 'Mid Cap Co',
      AnnualRevenue = 5000000
    );
    Account startupAccount = new Account(
      Name = 'Startup Co',
      AnnualRevenue = 5000
    );
    Account blankAccount = new Account(Name = 'Blank Co');
    List<Account> accounts = new List<Account>{
      enterpriseAccount,
      midCapAccount,
      startupAccount,
      blankAccount
    };

    Test.startTest();
    OrgSegmentService.classifyAccounts(accounts);
    Test.stopTest();

    Assert.areEqual(
      'Enterprise',
      enterpriseAccount.Org_Segment__c,
      'High revenue account should be Enterprise'
    );
    Assert.areEqual(
      'Mid Cap',
      midCapAccount.Org_Segment__c,
      'Mid revenue account should be Mid Cap'
    );
    Assert.areEqual(
      'Startup',
      startupAccount.Org_Segment__c,
      'Low revenue account should be Startup'
    );
    Assert.areEqual(
      'Startup',
      blankAccount.Org_Segment__c,
      'Account without revenue should be Startup'
    );
  }
}
