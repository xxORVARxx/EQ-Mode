
#include "EQ_Factory.as"
#include "EQ_Class_common.as"



void onInit( CBlob@ _this ) { // Server & Local:
  _this.addCommandID("EQ-CommandID");
  _this.Tag("EQ");
  _this.set_u8("EQ This Class", EQ::Class::KNIGHT ); // <---------------- 
  // Set Up Slots For Inventory:
  EQ::Add_class_slot( _this, EQ::Slot::BACK,       3 );
  EQ::Add_class_slot( _this, EQ::Slot::HEAD,       1 );
  EQ::Add_class_slot( _this, EQ::Slot::NECK,       2 );
  EQ::Add_class_slot( _this, EQ::Slot::LEFT_HAND,  9 );
  EQ::Add_class_slot( _this, EQ::Slot::CHEST,      6 );
  EQ::Add_class_slot( _this, EQ::Slot::RIGHT_HAND, 11 );
  EQ::Add_class_slot( _this, EQ::Slot::FINGER,     12 );
  EQ::Add_class_slot( _this, EQ::Slot::FEET,       13 );
  EQ::Add_class_slot( _this, EQ::Slot::LEGS,       14 ); 
  // Adding Scripts:
  _this.AddScript("EQ_Class_equip_logic.as");
}



void onSetPlayer( CBlob@ _this, CPlayer@ _player ) { // Server & Local:
  if( @_this == null || @_player == null ) {
    print("EQ ERROR: '_this' Or '_player' == null! ->'"+ getCurrentScriptName() +"'->'onSetPlayer'");
    return;
  }
  _this.Tag("EQ Player");
  getRules().set_u8("EQ-Inv-Filter Class"+ _player.getUsername(), EQ::Class::KNIGHT ); // <----------------
  // Inventory Menu Settings:
  _this.set_bool("EQ-Inv-Setting Drop", false );
  // Shop Menu Settings:
  _this.set_bool("EQ-Shop-Setting Equip", _player.get_bool("EQ-Shop-Setting Equip"+ _player.getUsername()));
  // Adding Scripts:
  _this.AddScript("EQ_Class_inventory.as");  
}



void onDie( CBlob@ _this ) { // Server & Local:
  CPlayer@ player = _this.getPlayer();
  if( @player == null ) {
    print("EQ ERROR: Getting 'player' Faild! ->'"+ getCurrentScriptName() +"'->'onDie'");
    return;
  }
  // Save Shop Menu Settings:
  getRules().set_bool("EQ-Shop-Setting Equip"+ player.getUsername(), _this.get_bool("EQ-Shop-Setting Equip"));
}
