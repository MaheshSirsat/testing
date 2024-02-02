using CatelogService as service from '../../srv/CatalogService';

annotate CatelogService.POs with @(
    //   Common.DefaultValuesFunction:'Catelog.defaddress',

    UI.SelectionFields   : [
        PO_ID,
        GROSS_AMOUNT,
        PARTNER_GUID.COMPANY_NAME,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY
    ],
    UI.LineItem          : [
        {
            $Type: 'UI.DataField',
            Value: PO_ID
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.COMPANY_NAME
        },
        {
            $Type:'UI.DataFieldForAction',
            Action:'CatelogService.boost',
            Inline:true,
            Label:'Boost'
        },
        
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: NET_AMOUNT
        },
        {
            $Type                    : 'UI.DataField',
            Value                    : OVERALL_STATUS,
            Criticality              : Spiderman,
            CriticalityRepresentation: #WithIcon
        },
        {
            $Type: 'UI.DataField',
            Value: TAX_AMOUNT
        }
    ],
    UI.HeaderInfo        : {
        TypeName      : 'Purchase Order',
        TypeNamePlural: 'Purchase Orders',
        Title         : {Value: PO_ID},
        Description   : {Value: PARTNER_GUID.COMPANY_NAME},
        ImageUrl      : 'https://logos.textgiraffe.com/logos/logo-name/Mahesh-designstyle-boots-m.png'
    },
    UI.Facets            : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'More Info',
            Facets: [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'More Iqnfo',
                    Target: '@UI.Identification'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'More Infoq',
                    Target: '@UI.FieldGroup#Price'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'More Infqo',
                    Target: '@UI.FieldGroup#Status'
                }
            ]
        },
        
        {
            $Type : 'UI.ReferenceFacet',
            Label:'PO Items',
            Target: 'Items/@UI.LineItem'
        }
    ],
    UI.Identification    : [
        {
            $Type: 'UI.DataField',
            Label: 'More info',
            Value: PO_ID
        },
        {
            $Type: 'UI.DataField',
            Label: 'More info1',
            Value: PARTNER_GUID_NODE_KEY
        },
        {
            $Type: 'UI.DataField',
            Label: 'More info2',
            Value: OVERALL_STATUS

        },{
            $Type:'UI.DataFieldForAction',
            Action:'CatelogService.setOrderProcessing',
       
            Label:'Set to Delivered'
        },

    ],
    UI.FieldGroup #Price : {Data: [
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: NET_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: TAX_AMOUNT,
        }
    ], },
    UI.FieldGroup #Status: {
        Label: 'Prices',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: GROSS_AMOUNT,
            },
            {
                $Type: 'UI.DataField',
                Value: NET_AMOUNT,
            },
            {
                $Type: 'UI.DataField',
                Value: TAX_AMOUNT,
            },
            {
                $Type: 'UI.DataField',
                Value: CURRENCY_code,
            },
        ],
    }


);
annotate CatelogService.POs with{
    PARTNER_GUID @(
        Common.Text:PARTNER_GUID.COMPANY_NAME,
         ValueList.entity: CatalogService.POs
    )
    
} ;
@cds.odata.valuelist
annotate CatelogService.BusinessPartnerSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : COMPANY_NAME,
    }]
);

@cds.odata.valuelist
annotate CatelogService.ProductSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : DESCRIPTION,
    }]
);
annotate CatalogService.POItems with {
    PRODUCT_GUID @(
        Common.Text:PRODUCT_GUID.DESCRIPTION,
         ValueList.entity: CatalogService.POItems
    )
    
    
}

annotate CatelogService.POItems with @(
    UI.LineItem:[
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        },{
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY,
        },{
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },{
            $Type : 'UI.DataField',
            Value : NET_AMOUNT,
        },{
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT,
        },{
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        }

    ],
    UI.HeaderInfo:{
        TypeName : 'Item',
        TypeNamePlural : 'Items',
        Title : {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        }
    },
    UI.Facets:[
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Item Details',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Item Data',
                    Target : '@UI.FieldGroup#ItemData',
                },{
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Product Data',
                    Target : '@UI.FieldGroup#ProductData',
                }
            ],
        },
    ],
    UI.FieldGroup #ItemData:{
        Label : 'Item Data',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : PO_ITEM_POS,
            },{
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID_NODE_KEY,
            },{
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },{
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },{
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },{
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            },
        ],
    },
    UI.FieldGroup #ProductData:{
        Label: 'Product Details',
        Data: [
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.CATEGORY,
            },{
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.DESCRIPTION,
            },{
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.PRICE,
            },{
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.SUPPLIER_GUID.ADDRESS_GUID.COUNTRY,
            },{
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.SUPPLIER_GUID.COMPANY_NAME,
            }
        ]
    }
);