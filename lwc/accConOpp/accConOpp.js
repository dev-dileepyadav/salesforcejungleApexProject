import { LightningElement, track, wire } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getPicklistValues,getPicklistValuesByRecordType } from 'lightning/uiObjectInfoApi';
//import  INDUSTRY  from '@salesforce/schema/Account.Industry';
import Account from '@salesforce/schema/Account';
import Contact from '@salesforce/schema/Contact';
import opportunityCustom from '@salesforce/schema/Opportunity_custom__c'

export default class AccConOpp extends LightningElement {
  // take the values by induvidual pickList
  /*
  @track industryPickList;
  @track error;

  @wire(getPicklistValues, {recordTypeId:'012000000000000AAA',fieldApiName:INDUSTRY})
  Record type is could be dummy
  wiredIndustry({data,err}){
    if(data){
      console.log(data.values);
      this.industryPickList = data.values;
      this.error = undefined;
    }else if(err){
      console.log(error);
      this.error = err;
      this.getPicklistValues = undefined;
    }
  }*/

  // Featching all pickList of Account object
  @track pickListValuesByRecordType;
  @track industryField
  @track ratingField;
  @track typeField
  @track error
// here we need to provide real recordTypeId
  @wire(getPicklistValuesByRecordType,{recordTypeId:'0125h000001r3Q1',objectApiName:Account})
  wiredPickListValues({data,err}){
    if(data){
      console.log(data);
      this.industryField = data.picklistFieldValues.Industry.values;
      this.ratingField = data.picklistFieldValues.Rating.values;
      this.typeField = data.picklistFieldValues.Type.values;
    } else if(err){
      this.error = err;
    }
  }
  // Featching all pickList of contact object
@track contactLeadSource;
@wire(getPicklistValuesByRecordType,{recordTypeId:'0125h000001r3Q6',objectApiName:Contact})
wiredcontactPickListValues({data,err}){
  if(data){
    this.contactLeadSource = data.picklistFieldValues.LeadSource.values;
  }else if(err){
    console.log(err);
  }
}

//Featching all pickList of Opportunity custom object

@wire(getPicklistValuesByRecordType,{recordTypeId:'0125h000001r3QB',objectApiName:opportunityCustom})
wiredOpportunityPickList({data,err}){
  if(data){
    console.log(data);
  }else if(err){
    console.log(err);
  }
}
// Account section
accountId;
contactId;
//@track industry = INDUSTRY;

data;
accountAddress;

handleChange = (event) => {
    const name = event.target.name;
    const value = event.target.value;
    const detail = event.detail;
    this.data = {
      ...this.data,
      [name]: value
    };
    this.accountAddress = detail;
    console.log(this.accountAddress);
  }

  // opportunity section
  oppData;

  handleOppChange = (event) => {
    const name = event.target.name;
    const value = event.target.value;

    this.oppData = {
      ...this.oppData,
      [name]: value
    };
  }
  
  // contact section
conData;
  handleConChange = (event) => {
    const name = event.target.name;
    const value = event.target.value;

    this.conData = {
      ...this.conData,
      [name]: value
    };
  }



        salutationsList = [
            { label: 'Mr.', value: 'Mr.' },
            { label: 'Ms.', value: 'Ms.' },
            { label: 'Mrs.', value: 'Mrs.' },
            { label: 'Dr.', value: 'Dr.' },
            { label: 'Prof.', value: 'Prof.' },
        ];
        fieldsList = ['firstName', 'lastName','salutation'];


    get salutationOptions() {
        return this.salutationsList;
    }

    get fields() {
        return this.fieldsList;
    }
     
     handleName(event) {
        this.firstname = event.target.firstName;
        this.middleName = event.target.middleName;
        this.lastName = event.target.lastName;
        this.salutation = event.target.salutation;
    }

    
    
    



    handleClick(){
    const accountfields =   {"Name":this.data.accountName,
                            "Phone":this.data.phone,
                            "AccountNumber":this.data.accountNumber,
                            "Industry":this.data.Industry,
                            "Type":this.data.Type,
                            "Rating":this.data.Rating,
                            "AnnualRevenue":this.data.revenue,
                            "Description":this.data.description,
                            "ShippingPostalCode":this.data.shippingPostalCode,
                            "ShippingCountry":this.data.shippingCountry,
                            "ShippingState":this.data.shippingState,
                            "ShippingStreet":this.data.shippingStreet,
                            "ShippingCity":this.data.shippingCity,
                            "BillingPostalCode":this.accountAddress,
                            "BillingCountry":this.accountAddress,
                            "BillingState":this.accountAddress,
                            "BillingStreet":this.accountAddress,
                            "BillingCity":this.accountAddress
                            
                    }

                    /*
    const contactFileds = {"AccountId":this.accountId,
                            "Salutation":this.salutation,
                            "FirstName":this.firstName,
                            "LastName":this.lastName,
                            "Phone":this.conData.phone,
                            "Email":this.conData.email,
                            "OtherPhone":this.conData.otherPhone,
                            "AssistantPhone":this.conData.assPhone,
                            "Birthdate":this.conData.dateOfBirth,
                            "AssistantName":this.conData.assiatant,
                            "LeadSource":this.conData.leadSource,
                            "Description":this.conData.description,
                            "Fax":this.conData.fax
    }

    const opportunityFields = {
                                "Account__c":this.accountId,
                                "Stage__c":this.oppData.stage,
                                "Remarks__c":this.oppData.remarks,
                                "Reason_For_Lost__c":this.oppData.reasonForLost,
                                "Other_Reason_For_Lost__c":this.oppData.otherReasonForLost,
                                "Other_Lead_Source__c":this.oppData.OtherLeadSource,
                                "Lead_Source__c":this.oppData.leadSource,
                                "Email__c":this.oppData.email,
                                "Contact__c":this.contactId,
                                "Close_Date__c":this.oppData.closeData,
                                "Fax__c":this.oppData.oppfax}
*/
    const accountRecordDetails = {apiName:"Account",fields:accountfields};
    //const contacttRecordDetails = {apiName:"Contact",fields:contactFileds};
    //const opportunityDetails = {apiName:"Opportunity_custom__c",fields:opportunityFields}
    
    createRecord(accountRecordDetails).then(x=>{
      console.log(x);
    }).catch(err =>{
      console.log(JSON.stringify(err));
    })

/*
    createRecord(accountRecordDetails).then(x=>{
      console.log(JSON.stringify(x));
        const accRec = new ShowToastEvent({
            title: 'Account Record created',
            message: 'New Account record created and Id is: '+x.id,
            variant: 'success'
          });
          this.dispatchEvent(accRec);
       

        createRecord(contacttRecordDetails).then(con=>{
            this.accountId = x.id;
            console.log(JSON.stringify("Account ID FROM Contact ==>"+ this.accountId));
            const accRec = new ShowToastEvent({
                title: 'Contact Record created',
                message: 'New Contact record created and Id is: '+con.id,
                variant: 'success'
              });
              this.dispatchEvent(accRec);
            this.contactId = con.id;
            createRecord(opportunityDetails).then(opp =>{
                const accRec = new ShowToastEvent({
                    title: 'Opportunity Record created',
                    message: 'New Opportunity record created and Id is: '+opp.id,
                    variant: 'success'
                  });
                  this.dispatchEvent(accRec);
                  
            }).catch(oppErro =>{
                const evt = new ShowToastEvent({
                    title: 'Unable to create Account record '+oppErro,
                    message: 'Can not create record',
                    variant: 'error'
                  });
                  this.dispatchEvent(evt);
                  console.log(JSON.stringify(oppErro));
            })
        }).catch(conErro =>{

            const evt = new ShowToastEvent({
                title: 'Unable to create Contact record '+conErro,
                message: 'Can not create record',
                variant: 'error'
              });
              this.dispatchEvent(evt);
        })
    }).catch(accErr=>{
        const evt = new ShowToastEvent({
            title: 'Unable to create opportunity record '+ accErr,
            message: 'Can not create record',
            variant: 'error'
          });
          this.dispatchEvent(evt);
    })*/

    }
}