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
  originPlanet          : String(100) not null;
  spacesuitColor        : String(50) default 'Silver';
  // Relationships
  department            : Association to Departments;
  position              : Association to Positions;
  // Status
  adventureStatus       : String(20) default 'Preparing';
}

entity Departments : cuid {
  name                 : String(100) not null;
  description          : String(500);
  spacefarers         : Association to many Spacefarers on spacefarers.department = $self;
}

entity Positions : cuid {
  title               : String(100) not null;
  description         : String(500);
  spacefarers         : Association to many Spacefarers on spacefarers.position = $self;
}

annotate GalacticSpacefarerService.Spacefarers with @(
  UI: {
    HeaderInfo: {
      TypeName: 'Spacefarer',
      TypeNamePlural: 'Spacefarers',
      Title: { Value: firstName }
    },
    SelectionFields: [ 
      { Value: firstName, Label: 'First Name' },
      { Value: lastName, Label: 'Last Name' },
      { Value: originPlanet, Label: 'Origin Planet' },
      { Value: adventureStatus, Label: 'Status' },
      { Value: department.name, Label: 'Department' },
      { Value: position.title, Label: 'Position' }
    ],
    LineItem: [
      { Value: firstName, Label: 'First Name' },
      { Value: lastName, Label: 'Last Name' },
      { Value: originPlanet, Label: 'Origin Planet' },
      { Value: spacesuitColor, Label: 'Spacesuit Color' },
      { Value: stardustCollection, Label: 'Stardust Collection' },
      { Value: adventureStatus, Label: 'Status' },
      { Value: department.name, Label: 'Department' },
      { Value: position.title, Label: 'Position' }
    ],
    Facets: [
      {
        $Type  : 'UI.ReferenceFacet',
        Label  : 'Personal Information',
        Target : '@UI.FieldGroup#PersonalInfo'
      },
      {
        $Type  : 'UI.ReferenceFacet',
        Label  : 'Cosmic Attributes',
        Target : '@UI.FieldGroup#CosmicInfo'
      },
      {
        $Type  : 'UI.ReferenceFacet',
        Label  : 'Assignments',
        Target : '@UI.FieldGroup#Assignments'
      }
    ],
    FieldGroup#PersonalInfo: {
      Data: [
        { Value: firstName, Label: 'First Name' },
        { Value: lastName, Label: 'Last Name' },
        { Value: email, Label: 'Email Address' },
        { Value: originPlanet, Label: 'Origin Planet' }
      ]
    },
    FieldGroup#CosmicInfo: {
      Data: [
        { Value: stardustCollection, Label: 'Stardust Collection' },
        { Value: wormholeNavigationSkill, Label: 'Wormhole Navigation Skill' },
        { Value: spacesuitColor, Label: 'Spacesuit Color' },
        { Value: adventureStatus, Label: 'Status' }
      ]
    },
    FieldGroup#Assignments: {
      Data: [
        { Value: department.name, Label: 'Department' },
        { Value: position.title, Label: 'Position' }
      ]
    }
  }
);


// Annotate the CAPABILITIES for the same entity set
annotate GalacticSpacefarerService.Spacefarers with @(
  Capabilities: {
    Insertable: true,
    Updatable: true,
    Deletable: true
  }
);