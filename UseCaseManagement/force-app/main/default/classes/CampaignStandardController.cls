public class CampaignStandardController
{
    public List<Publication__c> PublicationRecords {get;set;}
    public void search()
        {
            PublicationRecords = [SELECT Name,Publication_Type__c,Publication_Cycle__c, Publication_Language__c, Cost_of_Publication__c, Publication_Revenue__c, Region_of_Operation__c, Media_Agent__c FROM Publication__c LIMIT 1000];
        }
}