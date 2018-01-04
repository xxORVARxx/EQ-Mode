
#include "EQ_Factory.as"
#include "EQ_Class_common.as"



namespace EQ {
  void On_init_knight( CBlob@ _this ) {
    // This Is Not For Bots, So Putting This Here Rather Than Into The Real 'onInit' Function:
    _this.addCommandID("EQ-CommandID");
    _this.Tag("EQ");
    _this.set_u8("EQ This Class", EQ::Class::KNIGHT ); // <----------------
    if( ! _this.exists("EQ-Items Slot-Array")) {
      array< EQ::Item_data@ > slot_array;
      _this.set("EQ-Items Slot-Array", slot_array );
    }
    // Adding Scripts:
    _this.AddScript("EQ_Class_inventory.as");
    _this.AddScript("EQ_Class_equip_logic.as");
  
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
  }
}//EQ



void onSetPlayer( CBlob@ _this, CPlayer@ _player ) {
  if( @_this == null || @_player == null ) {
    print("EQ ERROR: '_this' Or '_player' == null! ->'"+ getCurrentScriptName() +"'->'onSetPlayer'");
    return;
  }
  if( ! _player.isMyPlayer())
    return;
  print("EQ:: Player Is Set: "+ _player.getUsername()); 
  getRules().set_u8(      "EQ-Inv-Filter Class"+ _player.getUsername(), EQ::Class::KNIGHT ); // <----------------
  getRules().SyncToPlayer("EQ-Inv-Filter Class"+ _player.getUsername(), _player );
  // PLAYER:
  // Putting The Array On The Player Instead Of The Character/Class,
  // That Way There Is No Need To Recreate The Array Each Time The Character Dies.
  if( ! _player.exists("EQ-Items Storage-Array")) {
    array< EQ::Item_data@ > storage_array;
    _player.set("EQ-Items Storage-Array", storage_array );
  }
  // KNIGHT CLASS:
  EQ::On_init_knight( _this );
}
