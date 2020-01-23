public class PublicationController
{
    private  Campaign Camp;
     public PublicationController(ApexPages.StandardController Campaign) {

        this.camp = (Campaign)Campaign.getRecord();
         camp = [select Language__c, Current_Region__c from campaign where id=:camp.id];
         search();
     }

   public List<Publication__c> PublicationRecords {get;set;}
    public List<Campaign> CampaignRecords {get;set;}
    public void search()
        {
            List<string> lang = new list<string>();
            lang=camp.Language__c.split(';');
                       
            //CampaignRecords= [SELECT Language__c,Current_Region__c FROM Campaign LIMIT 100];
            PublicationRecords= [SELECT Name,Publication_Type__c,Publication_Cycle__c, Publication_Language__c, Cost_of_Publication__c, Publication_Revenue__c, Region_of_Operation__c FROM Publication__c WHERE Publication_Language__c =:lang LIMIT 1000];
        }
    
}