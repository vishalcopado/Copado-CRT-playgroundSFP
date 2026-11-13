@IsTest
private class AccountTierServiceTest {
    @IsTest
    static void testGetTierBoundaries() {
        Test.startTest();
        String platinum = AccountTierService.getTier(10000000);
        String gold = AccountTierService.getTier(1000000);
        String silver = AccountTierService.getTier(100000);
        String bronze = AccountTierService.getTier(99999);
        String blank = AccountTierService.getTier(null);
        Test.stopTest();

        Assert.areEqual('Platinum', platinum, '10,000,000 should be Platinum');
        Assert.areEqual('Gold', gold, '1,000,000 should be Gold');
        Assert.areEqual('Silver', silver, '100,000 should be Silver');
        Assert.areEqual('Bronze', bronze, '99,999 should be Bronze');
        Assert.areEqual('Bronze', blank, 'Null revenue should be Bronze');
    }

    @IsTest
    static void testClassifyAccounts() {
        Account platinumAccount = new Account(Name = 'Platinum Co', AnnualRevenue = 25000000);
        Account bronzeAccount = new Account(Name = 'Bronze Co', AnnualRevenue = 5000);
        List<Account> accounts = new List<Account>{ platinumAccount, bronzeAccount };

        Test.startTest();
        AccountTierService.classifyAccounts(accounts);
        Test.stopTest();

        Assert.areEqual('Platinum', platinumAccount.Customer_Tier__c, 'High revenue account should be Platinum');
        Assert.areEqual('Bronze', bronzeAccount.Customer_Tier__c, 'Low revenue account should be Bronze');
    }
}
