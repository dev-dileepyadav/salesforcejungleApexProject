import { LightningElement, api } from 'lwc';
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { NavigationMixin } from "lightning/navigation";
export default class LdsDeleteRecord extends LightningElement {
    @api
    recordId;
    @api
    objectApiName;

    handleClick(event){
        deleteRecord(this.recordId).then(()=>{
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Success",
                    message: "Record deleted",
                    variant: "success",
                }),
            );
            this[NavigationMixin.Navigate]({
                type: "standard__objectPage",
                attributes: {
                  objectApiName: this.objectApiName,
                  actionName: "home",
                },
              });
        }).catch((error)=>{
            this.dispatchEvent(
                new ShowToastEvent({
                  title: "Error deleting record",
                  message: error.body.message,
                  variant: "error",
                }),
              );
        })
    }
}