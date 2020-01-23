trigger Cal_revenue on Campaign (after insert,after update) 
{
    
set<id> camp=new set<id>();
set<id> accid= new set<id>();
if(trigger.isInsert)
 {
     for(campaign c:trigger.new)
     {
         if((c.Status =='Aborted') || (c.Status =='Completed'))
         {
             camp.add(c.Id);
             accid.add(c.Client__c);
             
             
             
         }
     }
     
 }
    if(trigger.isUpdate)
    {
      
        
        for(campaign c:trigger.new)
        {
            Campaign cold= trigger.oldmap.get(c.Id);
            if((cold.Status!='Completed' && cold.Status!='Aborted') && (c.Status =='Completed' || c.Status=='Aborted'))
            {
                camp.add(c.Id);
                 accid.add(c.Client__c);
                
            }
        }      
    }
    
   list<Account> acup=new list<Account>();
    acup=[Select id,Current_Revenue__c,(SELECT Current_Revenue__c, Id, Name, Status FROM Campaigns__r where id=:camp) from Account where id=:accid];

   
for(Account a:acup)
{
    system.debug('@@');
    system.debug(a.campaigns__r.size());
    for(campaign c: a.campaigns__r)
    {
        //System.debug('##');
        
        System.debug(a.Current_Revenue__c);
        if(a.Current_Revenue__c==NULL)
        {
            a.Current_Revenue__c=0.0;
        }
        //system.debug(c.Current_Revenue__c);
       a.Current_Revenue__c=a.Current_Revenue__c+c.Current_Revenue__c;
    }
    system.debug('*');
    System.debug(a.Current_Revenue__c);
}
    
    
    database.update(acup, FALSE);
    
}