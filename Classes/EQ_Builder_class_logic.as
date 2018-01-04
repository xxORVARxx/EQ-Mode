
#include "EQ_Factory.as"
#include "EQ_Class_common.as"



namespace EQ {
  void On_init_builder( CBlob@ _this ) {
    // This Is Not For Bots, So Putting This Here Rather Than Into The Real 'onInit' Function:
    _this.addCommandID("EQ-CommandID");
    _this.Tag("EQ");
    _this.set_u8("EQ This Class", EQ::Class::BUILDER ); // <----------------
    if( ! _this.exists("EQ-Items Slot-Array")) {
      array< EQ::Item_data@ > slot_array;
      _this.set("EQ-Items Slot-Array", slot_array );
    }
    // Adding Scripts:
    _this.AddScript("EQ_Class_inventory.as");
    _this.AddScript("EQ_Class_equip_logic.as");

    // Set Up Slots For Inventory:
    EQ::Add_class_slot( _this, EQ::Slot::BACK,       0 );
    EQ::Add_class_slot( _this, EQ::Slot::HEAD,       1 );
    EQ::Add_class_slot( _this, EQ::Slot::NECK,       2 );
    EQ::Add_class_slot( _this, EQ::Slot::LEFT_HAND,  6 );
    EQ::Add_class_slot( _this, EQ::Slot::CHEST,      7 );
    EQ::Add_class_slot( _this, EQ::Slot::RIGHT_HAND, 8 );
    EQ::Add_class_slot( _this, EQ::Slot::FINGER,     12 );
    EQ::Add_class_slot( _this, EQ::Slot::FEET,       13 );
    EQ::Add_class_slot( _this, EQ::Slot::LEGS,       14 );
  }
}//EQ



void onTick( CBlob@ _this ) {
  if(( ! _this.hasTag("EQ") )|| _this.hasTag("dead"))
    return;
  // vvvvvvvvv TEMP vvvvvvvvvvvv
  CControls@ controls = _this.getControls();
  if( @controls == null ) {
    print("EQ ERROR: Getting 'controls' Faild! ->'"+ getCurrentScriptName() +"'->'onTick'");
    return;
  }
  if( controls.isKeyJustPressed( EKEY_CODE::KEY_KEY_G )) {
    print("G was pressed!");

  }
  //^^^^^^^^^ TEMP ^^^^^^^^^^^^
}



void onSetPlayer( CBlob@ _this, CPlayer@ _player ) {
  if( @_this == null || @_player == null ) {
    print("EQ ERROR: '_this' Or '_player' == null! ->'"+ getCurrentScriptName() +"'->'onSetPlayer'");
    return;
  }
  if( ! _player.isMyPlayer())
    return;
  print("EQ:: Player Is Set: "+ _player.getUsername());
  // RULES:
  getRules().set_u8(      "EQ-Inv-Filter Class"+ _player.getUsername(), EQ::Class::BUILDER ); // <----------------
  getRules().SyncToPlayer("EQ-Inv-Filter Class"+ _player.getUsername(), _player );
  // PLAYER:
  // Putting The Array On The Player Instead Of The Character/Class,
  // That Way There Is No Need To Recreate The Array Each Time The Class-Blob Dies.
  if( ! _player.exists("EQ-Items Storage-Array")) {
    array< EQ::Item_data@ > storage_array;
    _player.set("EQ-Items Storage-Array", storage_array );
  }
  // BUILDER CLASS:
  EQ::On_init_builder( _this );
}
