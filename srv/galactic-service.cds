using galactic from '../db/schema';

service GalacticSpacefarerService @(requires: 'authenticated-user') {
  
  @restrict: [
    { grant: ['READ'], to: 'SpacefarerViewer' },
    { grant: ['READ', 'CREATE'], to: 'SpacefarerRecruiter' },  
    { grant: ['READ', 'CREATE', 'UPDATE'], to: 'SpacefarerManager' },
    { grant: '*', to: 'CosmicAdministrator' }
  ]
  @odata.draft.enabled
  entity Spacefarers as projection on galactic.Spacefarers;
    
  @restrict: [
    { grant: ['READ'], to: 'authenticated-user' },
    { grant: ['CREATE', 'UPDATE', 'DELETE'], to: 'CosmicAdministrator' }
  ]
  entity Departments as projection on galactic.Departments;
    
  @restrict: [
    { grant: ['READ'], to: 'authenticated-user' },
    { grant: ['CREATE', 'UPDATE', 'DELETE'], to: 'CosmicAdministrator' }
  ]
  entity Positions as projection on galactic.Positions;
}