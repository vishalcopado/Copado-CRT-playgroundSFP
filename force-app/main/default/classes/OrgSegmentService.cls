/**
 * Calculates the Org Segment of an Account from its Annual Revenue.
 * Performs no SOQL or DML, so it is safe to call from before insert / before update contexts.
 */
public with sharing class OrgSegmentService {
  public static final String SEGMENT_ENTERPRISE = 'Enterprise';
  public static final String SEGMENT_MID_CAP = 'Mid Cap';
  public static final String SEGMENT_STARTUP = 'Startup';

  private static final Decimal ENTERPRISE_MIN = 100000000;
  private static final Decimal MID_CAP_MIN = 1000000;

  /**
   * Returns the segment for a single Annual Revenue value. A null value returns Startup.
   * @param annualRevenue Account Annual Revenue, may be null
   * @return Segment name: Enterprise, Mid Cap or Startup
   */
  public static String getSegment(Decimal annualRevenue) {
    if (annualRevenue == null) {
      return SEGMENT_STARTUP;
    }
    if (annualRevenue >= ENTERPRISE_MIN) {
      return SEGMENT_ENTERPRISE;
    }
    if (annualRevenue >= MID_CAP_MIN) {
      return SEGMENT_MID_CAP;
    }
    return SEGMENT_STARTUP;
  }

  /**
   * Sets Org_Segment__c on every Account in the list, in memory only.
   * @param accounts Accounts to classify; AnnualRevenue must be populated on each record
   */
  public static void classifyAccounts(List<Account> accounts) {
    for (Account acc : accounts) {
      acc.Org_Segment__c = getSegment(acc.AnnualRevenue);
    }
  }
}
