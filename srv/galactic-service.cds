using galactic from '../db/schema';

service GalacticSpacefarerService @(requires: 'authenticated-user') {
  
  @restrict: [
    { 
      grant: ['READ'], 
      to: 'SpacefarerViewer',
      where: 'originPlanet != ''Planet Y'' or $user.planet is null or $user.planet != ''Planet X'''
    },
    { 
      grant: ['READ', 'CREATE'], 
      to: 'SpacefarerRecruiter',  
      where: 'originPlanet != ''Planet Y'' or $user.planet is null or $user.planet != ''Planet X''' 
    },  
    { 
      grant: ['READ', 'CREATE', 'UPDATE'], 
      to: 'SpacefarerManager',  
      where: 'originPlanet != ''Planet Y'' or $user.planet is null or $user.planet != ''Planet X''' 
    },
    { 
      grant: '*', 
      to: 'CosmicAdministrator', 
      where: 'originPlanet != ''Planet Y'' or $user.planet is null or $user.planet != ''Planet X''' 
    }
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