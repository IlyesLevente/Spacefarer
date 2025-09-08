namespace galactic;

using { cuid, managed } from '@sap/cds/common';
using GalacticSpacefarerService from '../srv/galactic-service';

entity Spacefarers : cuid, managed {
firstName              : String(100) not null;
lastName               : String(100) not null;
email                  : String(255) not null;
// Cosmic fields
stardustCollection     : Integer default 0;
wormholeNavigationSkill: Integer default 1;
originPlanet           : String(100) not null;
spacesuitColor         : String(50) default 'Silver';
// Relationships
department_ID          : Integer;
position_ID            : Integer;
department             : Association to Departments on department.ID = $self.department_ID;
position               : Association to Positions on position.ID = $self.position_ID;
adventureStatus       : String(20) default 'Preparing';
}

entity Departments {
key ID               : Integer;
name                 : String(100) not null;
description          : String(500);
spacefarers          : Association to many Spacefarers on spacefarers.department_ID = $self.ID;
}

entity Positions {
key ID              : Integer;
title               : String(100) not null;
description         : String(500);
spacefarers         : Association to many Spacefarers on spacefarers.position_ID = $self.ID;
}

annotate GalacticSpacefarerService.Spacefarers with @(
    UI: {
        HeaderInfo : {
            TypeName       : 'Spacefarer',
            TypeNamePlural : 'Spacefarers',
            Title          : { Value : firstName },
            Description    : { Value : position.title }
        },
        SelectionFields : [
            firstName,
            lastName,
            originPlanet,
            department_ID,
            position_ID
        ],
        LineItem : [
            { Value: firstName },
            { Value: lastName },
            { Value: originPlanet },
            { Value: department.name, Label: 'Department' },
            { Value: position.title, Label: 'Position' }
        ],
        Facets : [ {
            $Type : 'UI.ReferenceFacet',
            Label : 'Details',
            Target: '@UI.FieldGroup#Details'
        } ],
        FieldGroup#Details : {
            Data : [
                { Value: firstName, Label: 'First Name' },
                { Value: lastName, Label: 'Last Name' },
                { Value: email, Label: 'Email Address' },
                { Value: originPlanet, Label: 'Origin Planet' },
                { Value: stardustCollection, Label: 'Stardust Collection' },
                { Value: wormholeNavigationSkill, Label: 'Wormhole Navigation Skill' },
                { Value: adventureStatus, Label: 'Status' },
                { Value: department_ID },
                { Value: position_ID }
            ]
        }
    }
);

// Add Value Help annotations to the new ID fields
annotate GalacticSpacefarerService.Spacefarers with {
    department_ID @(Common : {
        Label : 'Department',
        Text: department.name,
        ValueList       : {
            CollectionPath : 'Departments',
            Parameters     : [
                { $Type: 'Common.ValueListParameterInOut', LocalDataProperty: department_ID, ValueListProperty: 'ID' },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'name' }
            ]
        }
    });

    position_ID @(Common : {
        Label : 'Position',
        Text: position.title,
        ValueList       : {
            CollectionPath : 'Positions',
            Parameters     : [
                { $Type: 'Common.ValueListParameterInOut', LocalDataProperty: position_ID, ValueListProperty: 'ID' },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'title' }
            ]
        }
    });
}
