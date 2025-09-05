using galactic from '../db/schema';

@open
service GalacticSpacefarerService {
  
  // Main entity - open for local development
  entity Spacefarers as projection on galactic.Spacefarers;
  entity Departments as projection on galactic.Departments;
  entity Positions as projection on galactic.Positions;
}