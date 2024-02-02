using {ibm.db.master,ibm.db.transaction} from '../srv/datamodel';
// using {cappo.cds} from '../srv/CDSViews';
service CatelogService @(path: 'CatelogService',requires:'authenticated-user'){
    entity BusinessPartnerSet as projection on master.businesspartner;
    entity BPAddress as projection on master.address;
    entity EmployeeSet@(restrict:[{
        grant:['READ'],to:'Viewer',where:'bankName==$user.BankName'
    },
    {
      grant:['WRITE'],to:'Admin' 
    }
    
    
    ]) as projection on master.employees;
    entity ProductSet as projection on master.product;
    entity POs@(odata.draft.enabled:true
  
    )  as projection on transaction.purchaseorder{
        *,ROUND(GROSS_AMOUNT,0) as GROSS_AMOUNT:Int64,
        Items,
        case OVERALL_STATUS
        when 'A' then 3
        when 'P' then 2
        when 'N' then 2
        when 'X' then 1
        else 4
        end as Spiderman:Int16
    }
    actions{
        @cds.odata.bindingparameter.name:'mahesh'
        @Common.SideEffects:{
            TargetProperties:['mahesh/GROSS_AMOUNT']
        }
        
        action boost();
        action setOrderProcessing();
        function largestOrder() returns array of POs;
        function defaddress() returns array of POs;
    };
    entity POItems as projection on transaction.poitems;
  
}