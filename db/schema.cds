namespace galactic;

using { cuid, managed } from '@sap/cds/common';

// Task 1: Spacefarer Data Model
entity Spacefarers : cuid, managed {
  firstName              : String(100) not null;
  lastName               : String(100) not null;
  email                  : String(255) not null;
  
  // Cosmic fields
  stardustCollection     : Integer default 0;
  wormholeNavigationSkill: Integer default 1; // Scale 1-10
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

// UI Annotations
annotate Spacefarers with @(
  UI.HeaderInfo: {
    TypeName: 'Spacefarer',
    TypeNamePlural: 'Spacefarers',
    Title: { Value: firstName }
  },
  UI.SelectionFields: [ 
    firstName, 
    lastName, 
    originPlanet, 
    adventureStatus
  ],
  UI.LineItem: [
    { Value: firstName, Label: 'First Name' },
    { Value: lastName, Label: 'Last Name' },
    { Value: originPlanet, Label: 'Origin Planet' },
    { Value: spacesuitColor, Label: 'Spacesuit Color' },
    { Value: stardustCollection, Label: 'Stardust Collection' },
    { Value: adventureStatus, Label: 'Status' }
  ],
  UI.Facets: [
    {
      $Type: 'UI.ReferenceFacet',
      Target: '@UI.FieldGroup#PersonalInfo',
      Label: 'Personal Information'
    },
    {
      $Type: 'UI.ReferenceFacet', 
      Target: '@UI.FieldGroup#CosmicInfo',
      Label: 'Cosmic Attributes'
    }
  ],
  UI.FieldGroup#PersonalInfo: {
    Data: [
      { Value: firstName },
      { Value: lastName },
      { Value: email },
      { Value: originPlanet }
    ]
  },
  UI.FieldGroup#CosmicInfo: {
    Data: [
      { Value: stardustCollection },
      { Value: wormholeNavigationSkill },
      { Value: spacesuitColor },
      { Value: adventureStatus }
    ]
  },
  // Enable Create, Update, Delete operations
  Capabilities: {
    InsertRestrictions: {
      Insertable: true
    },
    UpdateRestrictions: {
      Updatable: true
    },
    DeleteRestrictions: {
      Deletable: true
    }
  }
);