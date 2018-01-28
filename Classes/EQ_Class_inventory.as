
#include "EQ_Factory.as"
#include "EQ_Commands.as"
#include "EQ_Class_common.as"

#include "EQ_Class_menu.as"
#include "EQ_Filter_menu.as"
#include "EQ_Slot_menu.as"
#include "EQ_Storage_menu.as"
#include "EQ_Scrollbar_menu.as"



const Vec2f g_frame_size( 24, 24 );

const u8 g_grid_size = 48;
const u8 g_grid_padding = 12;

const Vec2f g_class_menu_size( 2, 1 );
const Vec2f g_slot_menu_size( 3, 3 );
const Vec2f g_storage_menu_size( 5, 9 );
const Vec2f g_scrollbar_menu_size( 1, 9 );
const Vec2f g_filter_menu_size( 3, 4 );



namespace EQ {
  void Create_EQmenu_inventory( CBlob@ _this, CBlob@ _caller, CBitStream@ _params ) { // Local Only:
    Driver@ driver = getDriver();
    if( @driver == null ) {
      print("EQ ERROR: Getting 'driver' Faild! ->'"+ getCurrentScriptName() +"'->'Create_EQinventory_menu'");
      return;
    }  
    Vec2f center_pos = driver.getScreenCenterPos();
    // Creating The Slot Menu:
    Vec2f slot_menu_pos = center_pos;
    slot_menu_pos.x -= ( g_filter_menu_size.x * ( g_grid_size / 2 )) + ( g_grid_padding * 2 );
    slot_menu_pos.y -= g_storage_menu_size.y * ( g_grid_size / 2 );
    slot_menu_pos.y += g_slot_menu_size.y * ( g_grid_size / 2 );
    CGridMenu@ slot_menu = CreateGridMenu( slot_menu_pos, _this, g_slot_menu_size, "" );
    if( @slot_menu == null ) {
      print("EQ ERROR: Create Grid-Menu For 'slot_menu' Faild! ->'"+ getCurrentScriptName() +"'->'Create_EQinventory_menu'");
      return;
    }
    EQ::Slot_menu( _this, _caller, _params, slot_menu );
    // Creating The Storage Menu:
    Vec2f storage_menu_pos = center_pos;
    storage_menu_pos.x += ( g_storage_menu_size.x * ( g_grid_size / 2 )) + ( g_grid_padding * 2 );
    CGridMenu@ storage_menu = CreateGridMenu( storage_menu_pos, _this, g_storage_menu_size, "" );
    if( @storage_menu == null ) {
      print("EQ ERROR: Create Grid-Menu For 'storage_menu' Faild! ->'"+ getCurrentScriptName() +"'->'Create_EQinventory_menu'");
      return;
    }
    EQ::Storage_menu( _this, _caller, _params, storage_menu );
    // Creating The Scrollbar Menu:
    Vec2f scrollbar_menu_pos( storage_menu.getLowerRightPosition().x, center_pos.y );
    scrollbar_menu_pos.x += ( g_scrollbar_menu_size.x * ( g_grid_size / 2 )) + ( g_grid_padding / 2 );
    CGridMenu@ scrollbar_menu = CreateGridMenu( scrollbar_menu_pos, _this, g_scrollbar_menu_size, "" );
    if( @scrollbar_menu == null ) {
      print("EQ ERROR: Create Grid-Menu For 'scrollbar_menu' Faild! ->'"+ getCurrentScriptName() +"'->'Create_EQinventory_menu'");
      return;
    }
    EQ::Scrollbar_menu( _this, _caller, _params, scrollbar_menu );
    // Creating The Filter Menu:
    Vec2f filter_menu_pos = center_pos;
    filter_menu_pos.x -= ( g_filter_menu_size.x * ( g_grid_size / 2 )) + ( g_grid_padding * 2 );
    filter_menu_pos.y += g_storage_menu_size.y * ( g_grid_size / 2 );
    filter_menu_pos.y -= g_filter_menu_size.y * ( g_grid_size / 2 );
    CGridMenu@ filter_menu = CreateGridMenu( filter_menu_pos, _this, g_filter_menu_size, "" );
    if( @filter_menu == null ) {
      print("EQ ERROR: Create Grid-Menu For 'filter_menu' Faild! ->'"+ getCurrentScriptName() +"'->'Create_EQinventory_menu'");
      return;
    }
    EQ::Filter_menu( _this, _caller, _params, filter_menu );
    // Creating The Class Menu:
    Vec2f class_menu_pos( slot_menu.getUpperLeftPosition().x, slot_menu.getLowerRightPosition().y );
    class_menu_pos.x += ( slot_menu.getLowerRightPosition().x - slot_menu.getUpperLeftPosition().x ) / 2;
    class_menu_pos.y += ( filter_menu.getUpperLeftPosition().y - slot_menu.getLowerRightPosition().y ) / 2;
    CGridMenu@ class_menu = CreateGridMenu( class_menu_pos, _this, g_class_menu_size, "" );
    if( @class_menu == null ) {
      print("EQ ERROR: Create Grid-Menu For 'class_menu' Faild! ->'"+ getCurrentScriptName() +"'->'Create_EQinventory_menu'");
      return;
    }
    EQ::Class_menu( _this, _caller, _params, class_menu ); 
  }
}//EQ



void onInit( CBlob@ _this ) { // Server & Local:
  _this.addCommandID("EQ-CommandID");
  AddIconToken("$EQClassIcon_Clear_Slots$", "EQ_MenuIcons.png", g_frame_size, 4 );
  AddIconToken("$EQClassIcon_Drop_Items$",  "EQ_MenuIcons.png", g_frame_size, 5 );
}



void onTick( CBlob@ _this ) { // Server & Local:
  CControls@ controls = _this.getControls();
  if( @controls == null ) {
    print("EQ ERROR: Getting 'controls' Faild! ->'"+ getCurrentScriptName() +"'->'onTick'");
    return;
  }
  if( controls.isKeyJustPressed( EKEY_CODE::KEY_KEY_I )) { // Local Only:
    CPlayer@ player = _this.getPlayer();
    if( @player == null )
      return;
    // Reset The Inventory-Menu 'Drop' Setting to 'false':
    _this.set_bool("EQ-Inv-Setting Drop", false );
    _this.Sync("EQ-Inv-Setting Drop", false );
    // Open Inventory:
    CBitStream params;
    params.write_u8( EQ::Cmds::MAIN_MENU );
    params.write_u16( _this.getNetworkID());
    _this.SendCommand( _this.getCommandID("EQ-CommandID"), params );
  }
}



void onCollision( CBlob@ _this, CBlob@ _blob, bool _solid ) { // Server & Local:
  if(( @_this == null )||( @_blob == null ))
    return;
  // Check To See If It's EQ-Item:
  if( ! _blob.exists("EQ This Item"))
    return;
  // Do Not Pick It Up If You Just Dropped It:
  if( _this.getNetworkID() == _blob.get_u16("EQ Last Carrier")) {
    if( ! _blob.hasTag("EQ Last Carrier Can Pickup")) {
      _blob.Tag("EQ Last Carrier Can Pickup");
      return;
    }
  }
  // The Server Has To Kill The EQ-Item's Blob:
  CBitStream params;
  params.write_u8( EQ::Cmds::LOGIC_PICKUP_ITEM );
  params.write_u16( _this.getNetworkID());  
  params.write_u16( _blob.getNetworkID());  
  getRules().SendCommand( getRules().getCommandID("EQ-CommandID"), params );
}



void onCommand( CBlob@ _this, u8 _cmd, CBitStream@ _params ) { // Server & Local:
  if( _cmd != _this.getCommandID("EQ-CommandID"))
    return;
  _cmd = _params.read_u8();
  if( _cmd <= EQ::Cmds::BEGIN || _cmd >= EQ::Cmds::END ) {
    if( _cmd == EQ::Cmds::NIL )
      return;
    print("EQ ERROR: 'EQ::Cmds::BEGIN = "+ EQ::Cmds::BEGIN +"' And 'EQ::Cmds::END = "+ EQ::Cmds::END +"' But the '_cmd = "+ _cmd +"'! ->'"+ getCurrentScriptName() +"'->'onCommand'");
    return;
  }
  CBlob@ caller = getBlobByNetworkID( _params.read_u16());
  if( @caller == null ) {
    print("EQ ERROR: Getting 'caller' Faild! ->'"+ getCurrentScriptName() +"'->'onCommand'");
    return;
  }
  EQ::Cmds state = EQ::On_command_inventory( _this, caller, _cmd, _params );
  if( caller.isMyPlayer()) { // Local Only:
    if( state == EQ::Cmds::FALSE ) {
      state = EQ::On_command_inventory_local( _this, caller, _cmd, _params );
    }
    // Refresh Inventory Menu:
    if( state == EQ::Cmds::MAIN_MENU ) {
      caller.ClearGridMenusExceptInventory();
      EQ::Create_EQmenu_inventory( _this, caller, _params );
    }
  }
}



namespace EQ {
  EQ::Cmds On_command_inventory( CBlob@ _this, CBlob@ _caller, u8 _cmd, CBitStream@ _params ) { // Server & Local:
    CPlayer@ player = _caller.getPlayer();
    if( @player == null )
      return EQ::Cmds::NIL;
    switch( _cmd ) {
      // BUTTON STORAGE ITEM:
    case EQ::Cmds::BUTTON_STORAGE_ITEM : {
      u8 index = _params.read_u16();
      EQ::Item_data@ item = EQ::Get_storage_item_by_index( _caller, index );
      const bool drop = _caller.get_bool("EQ-Inv-Setting Drop");
      if( drop )
	EQ::Drop_item( _caller, item );
      else 
	EQ::Equip_item( _caller, item );
      return EQ::Cmds::MAIN_MENU;
    }
      // BUTTON SLOT ITEM:
    case EQ::Cmds::BUTTON_SLOT_ITEM : {
      u8 index = _params.read_u8();
      EQ::Item_data@ item = EQ::Get_equip_item_by_index( _caller, index );
      const bool drop = _caller.get_bool("EQ-Inv-Setting Drop");
      if( drop )
	EQ::Drop_item( _caller, item );
      else 
	EQ::Unequip_item( _caller, item );
      return EQ::Cmds::MAIN_MENU;
    }
    }//switch
    return EQ::Cmds::FALSE;
  }

  
  
  EQ::Cmds On_command_inventory_local( CBlob@ _this, CBlob@ _caller, u8 _cmd, CBitStream@ _params ) { // Local Only:
    CPlayer@ player = _caller.getPlayer();
    if( @player == null )
      return EQ::Cmds::NIL;
    switch( _cmd ) {
      // MAIN MENU & MENU & BUTTON_SLOT_EMPTY:
    case EQ::Cmds::MAIN_MENU :
    case EQ::Cmds::MENU :
    case EQ::Cmds::BUTTON_SLOT_EMPTY:
      return EQ::Cmds::MAIN_MENU;
      // BUTTON DROP:
    case EQ::Cmds::BUTTON_DROP : {
      const bool drop = _caller.get_bool("EQ-Inv-Setting Drop");
      _caller.set_bool("EQ-Inv-Setting Drop", ! drop );
      _caller.Sync("EQ-Inv-Setting Drop", false );
      return EQ::Cmds::MAIN_MENU;
    }
      // BUTTON CLEAR:
    case EQ::Cmds::BUTTON_CLEAR :
      return EQ::Cmds::MAIN_MENU;
    }//switch
    // FILTER:
    EQ::Cmds state = EQ::On_command_filter( _this, _caller, _cmd, _params );
    return state;
  }
}//EQ
