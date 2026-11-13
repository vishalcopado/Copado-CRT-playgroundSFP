/**
 * Calculates the Customer Tier of an Account from its Annual Revenue.
 * Performs no SOQL or DML, so it is safe to call from before insert / before update contexts.
 */
public with sharing class AccountTierService {
    public static final String TIER_PLATINUM = 'Platinum';
    public static final String TIER_GOLD = 'Gold';
    public static final String TIER_SILVER = 'Silver';
    public static final String TIER_BRONZE = 'Bronze';

    private static final Decimal PLATINUM_MIN = 10000000;
    private static final Decimal GOLD_MIN = 1000000;
    private static final Decimal SILVER_MIN = 100000;

    /**
     * Returns the tier for a single Annual Revenue value. A null value returns Bronze.
     * @param annualRevenue Account Annual Revenue, may be null
     * @return Tier name: Platinum, Gold, Silver or Bronze
     */
    public static String getTier(Decimal annualRevenue) {
        if (annualRevenue == null) {
            return TIER_BRONZE;
        }
        if (annualRevenue >= PLATINUM_MIN) {
            return TIER_PLATINUM;
        }
        if (annualRevenue >= GOLD_MIN) {
            return TIER_GOLD;
        }
        if (annualRevenue >= SILVER_MIN) {
            return TIER_SILVER;
        }
        return TIER_BRONZE;
    }

    /**
     * Sets Customer_Tier__c on every Account in the list, in memory only.
     * @param accounts Accounts to classify; AnnualRevenue must be populated on each record
     */
    public static void classifyAccounts(List<Account> accounts) {
        for (Account acc : accounts) {
            acc.Customer_Tier__c = getTier(acc.AnnualRevenue);
        }
    }
}
