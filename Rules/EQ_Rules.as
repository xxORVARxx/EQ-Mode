
#include "EQ_Factory.as"
#include "EQ_Commands.as"
#include "EQ_Class_common.as"



const u8 g_frame_size = 24;
const Vec2f g_menu_text_frame( g_frame_size * 3, g_frame_size );
const Vec2f g_menu_icon_frame( g_frame_size, g_frame_size );



namespace EQ {
  void Load_menu_text() { // Server & Local:
    // Material Menu Text:
    for( u8 i = 0 ; i != EQ::Material::ALL ; ++i )
      AddIconToken("$EQMenuText_"+ EQ::g_materials_str[ i ] +"$", "EQ_MenuText_Materials.png", g_menu_icon_frame, i );
    AddIconToken("$EQMenuText_"+ EQ::g_materials_str[ EQ::Material::ALL ] +"$", "EQ_MenuText.png", g_menu_text_frame, 0 );
    // Slot Menu Text:
    for( u8 i = 0 ; i <= EQ::Slot::ALL ; ++i )
      AddIconToken("$EQMenuText_"+ EQ::g_slot_str[ i ] +"$", "EQ_MenuText_Slots.png", g_menu_text_frame, i );
    // Type Menu Text:
    for( u8 i = 0 ; i <= EQ::Type::ALL ; ++i )
      AddIconToken("$EQMenuText_"+ EQ::g_type_str[ i ] +"$", "EQ_MenuText_Types.png", g_menu_text_frame, i );
    // Class Menu Text:
    for( u8 i = 0 ; i <= EQ::Class::ALL ; ++i )
      AddIconToken("$EQMenuText_"+ EQ::g_class_str[ i ] +"$", "EQ_MenuText_Classes.png", g_menu_text_frame, i );
  }
}//EQ



namespace EQ {
  void Set_new_player( CRules@ _this, CPlayer@ _player ) { // Server & Local:
    print("EQ::Rules: New Player Is Set: "+ _player.getUsername());
    // Give Each Player Their Unique 'storage_array': 
    array< EQ::Item_data@ > storage_array;
    _this.set("EQ-Items Storage-Array"+ _player.getUsername(), storage_array );
    // Give Each Player Their Unique Shop Menu Settings:
    _this.set_bool("EQ-Shop-Setting Equip"+ _player.getUsername(), true );
  }
}//EQ



void onInit( CRules@ _this ) { // Server & Local:
  _this.addCommandID("EQ-CommandID");
  // Factory:
  FACTORY::Items factory;
  _this.set("factory", factory );
  for( uint i = 0 ; i < EQ::Name::ALL ; ++i ) {
    _this.AddScript( EQ::g_name_str[ i ] +"Equip.as" );
    AddIconToken("$EQItemIcon_"     + EQ::g_name_str[ i ] +"$", EQ::g_name_str[ i ] +"Icon.png", g_menu_icon_frame, 0 );
    AddIconToken("$EQItemIconEquip_"+ EQ::g_name_str[ i ] +"$", EQ::g_name_str[ i ] +"Icon.png", g_menu_icon_frame, 1 );
    AddIconToken("$EQItemIconRed_"  + EQ::g_name_str[ i ] +"$", EQ::g_name_str[ i ] +"Icon.png", g_menu_icon_frame, 3 );
  }//for
  EQ::Load_menu_text();			      
}



void onNewPlayerJoin( CRules@ _this, CPlayer@ _player ) { // Server Only:
  if( @_this == null || @_player == null ) {
    print("EQ ERROR: '_this' Or '_player' == null! ->'"+ getCurrentScriptName() +"'->'onNewPlayerJoin'");
    return;
  }
  CBitStream params;
  params.write_u8( EQ::Cmds::NEW_PLAYER );
  params.write_u16( _player.getNetworkID()); 
  _this.SendCommand( _this.getCommandID("EQ-CommandID"), params );
  // Give Each Player Their Unique Filter Menu Settings:
  _this.set_u8(      "EQ-Filter-Setting Material"+ _player.getUsername(), EQ::Material::ALL );
  _this.SyncToPlayer("EQ-Filter-Setting Material"+ _player.getUsername(), _player );
  _this.set_u8(      "EQ-Filter-Setting Slot"+ _player.getUsername(), EQ::Slot::ALL );
  _this.SyncToPlayer("EQ-Filter-Setting Slot"+ _player.getUsername(), _player );
  _this.set_u8(      "EQ-Filter-Setting Type"+ _player.getUsername(), EQ::Type::ALL );
  _this.SyncToPlayer("EQ-Filter-Setting Type"+ _player.getUsername(), _player );
  _this.set_u8(      "EQ-Filter-Setting Class"+ _player.getUsername(), EQ::Class::ALL );
  _this.SyncToPlayer("EQ-Filter-Setting Class"+ _player.getUsername(), _player );
}



void onCommand( CRules@ _this, u8 _cmd, CBitStream@ _params ) { // Server & Local:
  if( _cmd != _this.getCommandID("EQ-CommandID"))
    return;
  _cmd = _params.read_u8();
  if( _cmd <= EQ::Cmds::BEGIN || _cmd >= EQ::Cmds::END ) {
    if( _cmd == EQ::Cmds::NIL )
      return;
    print("EQ ERROR: 'EQ::Cmds::BEGIN = "+ EQ::Cmds::BEGIN +"' And 'EQ::Cmds::END = "+ EQ::Cmds::END +"' But the '_cmd = "+ _cmd +"'! ->'"+ getCurrentScriptName() +"'->'onCommand'");
    return;
  }
  uint16 net_id = _params.read_u16();
  CBlob@ caller_blob = getBlobByNetworkID( net_id );
  if( @caller_blob == null ) {
    CPlayer@ caller_player = getPlayerByNetworkId( net_id );
    if( @caller_player == null ) {      
      print("EQ ERROR: Getting 'caller_blob' Or 'caller_player' Faild! ->'"+ getCurrentScriptName() +"'->'onCommand'");
      return;
    }
    EQ::On_command_rules( _this, caller_player, _cmd, _params );
  }
  EQ::On_command_rules( _this, caller_blob, _cmd, _params );
}



namespace EQ {
  EQ::Cmds On_command_rules( CRules@ _this, CBlob@ _caller, u8 _cmd, CBitStream@ _params ) { // Server & Local:
    switch( _cmd ) {
      // LOGIC PICKUP ITEM:
    case EQ::Cmds::LOGIC_PICKUP_ITEM : {
      CBlob@ item_blob = getBlobByNetworkID( _params.read_u16());
      if( @item_blob == null )
	return EQ::Cmds::TRUE;
      // If Tagged: 'EQ Ghost', The Item Is Already Being Picked-Up By Another Player:
      if( item_blob.hasTag("EQ Ghost"))
	return EQ::Cmds::TRUE;
      item_blob.Tag("EQ Ghost");
      EQ::Name item_name = EQ::Name(item_blob.get_u16("EQ This Item"));
      CBitStream variables;
      item_blob.get_CBitStream("EQ Variables", variables );
      // Kill The EQ-Item's Blob:
      item_blob.server_Die();
      EQ::Pickup_item( _caller, item_name, variables );
      return EQ::Cmds::TRUE;
    }
    }//switch
    return EQ::Cmds::FALSE; // '_cmd' Not Found, So Return False.
  }



  EQ::Cmds On_command_rules( CRules@ _this, CPlayer@ _caller, u8 _cmd, CBitStream@ _params ) { // Server & Local:
    switch( _cmd ) {
      // NEW PLAYER:
    case EQ::Cmds::NEW_PLAYER :
      EQ::Set_new_player( _this, _caller );
    }//switch
    return EQ::Cmds::FALSE; // '_cmd' Not Found, So Return False.
  }
}//EQ
