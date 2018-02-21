
#include "EQ_Factory.as"
#include "EQ_Class_common.as"



void onInit( CBlob@ _this ) { // Server & Local:
  _this.addCommandID("EQ-CommandID");
  _this.Tag("EQ");
  _this.set_u8("EQ This Class", EQ::Class::BUILDER ); // <---------------- 
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
  CRules@ rules = getRules();
  if(( @_this == null )||( @_player == null )||( @rules == null )) {
    print("EQ ERROR: '_this' Or '_player' Or 'rules' == null! ->'"+ getCurrentScriptName() +"'->'onSetPlayer'");
    return;
  }
  string username = _player.getUsername();
  if( ! rules.exists("EQ-Items Storage-Array"+ username )) {
    // Give The Local Player His Unique 'storage_array': 
    array< EQ::Item_data@ > storage_array;
    rules.set("EQ-Items Storage-Array"+ username, storage_array );
    // Give The Local Player His Unique Shop Menu Settings:
    rules.set_bool("EQ-Shop-Setting Equip"+ username, true );
    // Give The Local Player His Unique Filter Menu Settings:
    rules.set_u8("EQ-Filter-Setting Material"+ username, EQ::Material::ALL );
    rules.set_u8("EQ-Filter-Setting Slot"+ username, EQ::Slot::ALL );
    rules.set_u8("EQ-Filter-Setting Type"+ username, EQ::Type::ALL );
    rules.set_u8("EQ-Filter-Setting Class"+ username, EQ::Class::BUILDER ); // <----------------
  }
  _this.Tag("EQ Player");
  // Inventory Menu Settings:
  _this.set_bool("EQ-Inv-Setting Drop", false );
  // Shop Menu Settings:
  _this.set_bool("EQ-Shop-Setting Equip", rules.get_bool("EQ-Shop-Setting Equip"+ username ));
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
