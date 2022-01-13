// namespace app.interactions;
using {API_BUSINESS_PARTNER as bupa} from '../srv/external/API_BUSINESS_PARTNER';
using {Country} from '@sap/cds/common';

context app.interactions {
    type BusinessKey : String(10);
    type SDate : DateTime;
    type LText : String(1024);


    entity Interactions_Header {
        key ID        : Integer;
            ITEMS     : Composition of many Interactions_Items
                            on ITEMS.INTHeader = $self;
            PARTNER   : BusinessKey;
            LOG_DATE  : SDate;
            BPCOUNTRY : Country;

    };

    entity Interactions_Items {

        key INTHeader : Association to Interactions_Header;
        key TEXT_ID   : BusinessKey;
            LANGU     : String(2);
            LOGTEXT   : LText;
    };

    entity Suppliers as projection on bupa.A_BusinessPartner {
        key BusinessPartner as ID, BusinessPartnerFullName as fullName, BusinessPartnerIsBlocked as isBlocked,
    }
}

@cds.persistence.exists
@cds.persistence.calcview
entity![V_INTERACTION]{
    key![ID]             : Integer     @title : 'ID: ID';
    key![PARTNER]        : String(10)  @title : 'PARTNER: PARTNER';
    key![LOG_DATE]       : String      @title : 'LOG_DATE: LOG_DATE';
    key![BPCOUNTRY_CODE] : String(3)   @title : 'BPCOUNTRY_CODE: BPCOUNTRY_CODE';
    key![TEXT_ID]        : String(10)  @title : 'TEXT_ID: TEXT_ID';
    key![LANGU]          : String(2)   @title : 'LANGU: LANGU';
    key![LOGTEXT]        : String(1024)@title : 'LOGTEXT: LOGTEXT';
}
