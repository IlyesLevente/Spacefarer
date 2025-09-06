using galactic from '../db/schema';

// Remove @open - this makes it secured by default
service GalacticSpacefarerService @(requires: 'authenticated-user') {
  
  // Spacefarers entity with role-based access
  @restrict: [
    { grant: ['READ'], to: 'SpacefarerViewer' },
    { grant: ['READ', 'CREATE'], to: 'SpacefarerRecruiter' },  
    { grant: ['READ', 'CREATE', 'UPDATE'], to: 'SpacefarerManager' },
    { grant: ['READ', 'CREATE', 'UPDATE', 'DELETE'], to: 'CosmicAdministrator' }
  ]
  entity Spacefarers as projection on galactic.Spacefarers;
    
  // Departments - read access for all authenticated users
  @restrict: [
    { grant: ['READ'], to: 'authenticated-user' },
    { grant: ['CREATE', 'UPDATE', 'DELETE'], to: 'CosmicAdministrator' }
  ]
  entity Departments as projection on galactic.Departments;
    
  // Positions - read access for all authenticated users  
  @restrict: [
    { grant: ['READ'], to: 'authenticated-user' },
    { grant: ['CREATE', 'UPDATE', 'DELETE'], to: 'CosmicAdministrator' }
  ]
  entity Positions as projection on galactic.Positions;
}