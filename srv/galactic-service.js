const cds = require('@sap/cds');

module.exports = cds.service.impl(async function() {
  
  const { Spacefarers } = this.entities;

  this.before(['CREATE', 'UPDATE'], Spacefarers, async (req) => {
    const spacefarer = req.data;
    
    console.log('🌟 COSMIC PREPARATION: Preparing spacefarer for journey');
    console.log('Received data:', JSON.stringify(spacefarer, null, 2));
    
    if (req.event === 'CREATE') {
      spacefarer.firstName = spacefarer.firstName || 'Unknown';
      spacefarer.lastName = spacefarer.lastName || 'Spacefarer';
      spacefarer.email = spacefarer.email || 'spacefarer@galaxy.com';
      spacefarer.originPlanet = spacefarer.originPlanet || 'Earth';
      spacefarer.spacesuitColor = spacefarer.spacesuitColor || 'Silver';
      spacefarer.stardustCollection = spacefarer.stardustCollection || 0;
      spacefarer.wormholeNavigationSkill = spacefarer.wormholeNavigationSkill || 1;
      spacefarer.adventureStatus = spacefarer.adventureStatus || 'Preparing';
    }
    
    // Validate stardust collection
    if (spacefarer.stardustCollection !== undefined && spacefarer.stardustCollection < 0) {
      req.error(400, 'Stardust collection cannot be negative!');
    }
    
    // Validate wormhole navigation skill
    if (spacefarer.wormholeNavigationSkill !== undefined) {
      if (spacefarer.wormholeNavigationSkill < 1 || spacefarer.wormholeNavigationSkill > 10) {
        req.error(400, 'Wormhole navigation skill must be between 1 and 10');
      }
    }

    // Auto-increment navigation skill for high stardust collectors
    if (req.event === 'CREATE' && spacefarer.stardustCollection > 100) {
      spacefarer.wormholeNavigationSkill = Math.min(
        (spacefarer.wormholeNavigationSkill || 1) + 1, 
        10 
      );
      console.log('✨ Navigation skills enhanced due to high stardust collection!');
    }
    
    console.log('✅ Cosmic preparation complete!');
  });
  
  this.after('CREATE', Spacefarers, async (spacefarer, req) => {
    console.log('🌟 COSMIC NOTIFICATION: Sending welcome message');
    
    const message = `🚀 Welcome to the cosmic adventure, ${spacefarer.firstName}! 
    Your journey from ${spacefarer.originPlanet} begins now. 
    Your ${spacefarer.spacesuitColor} spacesuit suits you perfectly!
    Starting stardust collection: ${spacefarer.stardustCollection}`;
    
    console.log('📧 COSMIC EMAIL SENT:');
    console.log(`To: ${spacefarer.email}`);
    console.log(`Subject: Welcome to Galactic Adventure!`);
    console.log(`Message: ${message}`);
    console.log('✨ Cosmic notification successfully delivered!');
  });
  
  console.log('🌟 Galactic Spacefarer Service is operational and secured!');
  console.log('🛡️  Cosmic Defense Systems: ACTIVE');
});
