
#include "EQ_Factory.as"
#include "EQ_Commands.as"
#include "EQ_Class_common.as"

#include "EQ_Filter_menu.as"
#include "EQ_Storage_menu.as"
#include "EQ_Scrollbar_menu.as"
#include "EQ_Shop_menu.as"



const Vec2f g_frame_size( 24, 24 );

const u8 g_grid_size = 48;
const u8 g_grid_padding = 12;

const Vec2f g_shop_menu_size( 5, 9 );
const Vec2f g_storage_menu_size( 5, 9 );
const Vec2f g_scrollbar_menu_size( 1, 9 );
const Vec2f g_filter_menu_size( 3, 4 );
const Vec2f g_settings_menu_size( 1, 2 );



namespace EQ {
  void Create_EQmenu_Shop( CBlob@ _this, CBlob@ _caller, CBitStream@ _params ) {
    Driver@ driver = getDriver();
    if( @driver == null ) {
      print("EQ ERROR: Getting 'driver' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_Shop'");
      return;
    }  
    Vec2f center_pos = driver.getScreenCenterPos();
    // Creating The Filter Menu:
    Vec2f filter_menu_pos = center_pos;
    filter_menu_pos.y += ( g_shop_menu_size.y - g_filter_menu_size.y ) * ( g_grid_size / 2 );
    CGridMenu@ filter_menu = CreateGridMenu( filter_menu_pos, _this, g_filter_menu_size, "" );
    if( @filter_menu == null ) {
      print("EQ ERROR: Create Grid-Menu For 'filter_menu' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_Shop'");
      return;
    }
    EQ::Filter_menu( _this, _caller, _params, filter_menu );
    // Creating The Storage Menu:
    Vec2f storage_menu_pos = center_pos;
    storage_menu_pos.x += ( g_filter_menu_size.x * ( g_grid_size / 2 )) + ( g_storage_menu_size.x * ( g_grid_size / 2 )) + ( g_grid_padding * 2 );
    CGridMenu@ storage_menu = CreateGridMenu( storage_menu_pos, _this, g_storage_menu_size, "" );
    if( @storage_menu == null ) {
      print("EQ ERROR: Create Grid-Menu For 'storage_menu' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_Shop'");
      return;
    }
    EQ::Storage_menu( _this, _caller, _params, storage_menu );
    // Creating The Scrollbar Menu:
    Vec2f scrollbar_menu_pos( storage_menu.getLowerRightPosition().x, center_pos.y );
    scrollbar_menu_pos.x += ( g_scrollbar_menu_size.x * ( g_grid_size / 2 )) + ( g_grid_padding / 2 );
    CGridMenu@ scrollbar_menu = CreateGridMenu( scrollbar_menu_pos, _this, g_scrollbar_menu_size, "" );
    if( @scrollbar_menu == null ) {
      print("EQ ERROR: Create Grid-Menu For 'scrollbar_menu' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_Shop'");
      return;
    }
    EQ::Scrollbar_menu( _this, _caller, _params, scrollbar_menu );
    // Creating The Shop Menu:
    Vec2f shop_menu_pos = center_pos;
    shop_menu_pos.x -= ( g_filter_menu_size.x * ( g_grid_size / 2 )) + ( g_shop_menu_size.x * ( g_grid_size / 2 )) + ( g_grid_padding * 2 );
    CGridMenu@ shop_menu = CreateGridMenu( shop_menu_pos, _this, g_shop_menu_size, "" );
    if( @shop_menu == null ) {
      print("EQ ERROR: Create Grid-Menu For 'shop_menu' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_Shop'");
      return;
    }
    EQ::Shop_menu( _this, _caller, _params, shop_menu );
    // Creating The Settings Menu:
    Vec2f settings_menu_pos = center_pos;
    settings_menu_pos.y -= ( g_shop_menu_size.y - g_settings_menu_size.y ) * ( g_grid_size / 2 );
    CGridMenu@ shop_settings_menu = CreateGridMenu( settings_menu_pos, _this, g_settings_menu_size, "" );
    if( @shop_settings_menu == null ) {
      print("EQ ERROR: Create Grid-Menu For 'shop_settings_menu' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_Shop'");
      return;
    }
    EQ::Shop_settings_menu( _this, _caller, _params, shop_settings_menu );
  }
}//EQ



void onInit( CBlob@ _this ) {
  _this.set_TileType( "background tile", CMap::tile_wood_back );
  _this.getSprite().SetZ( -50 ); // Background.
  _this.getShape().getConsts().mapCollisions = false;

  _this.addCommandID("EQ-CommandID");

  AddIconToken("$EQShopIcon_AutoSell$", "EQ_MenuIcons.png", g_frame_size, 0 );
  AddIconToken("$EQShopIcon_AutoBuy$",  "EQ_MenuIcons.png", g_frame_size, 1 );
  AddIconToken("$EQShopIcon_Shop$",     "EQ_MenuIcons.png", g_frame_size, 2 );
  AddIconToken("$EQShopIcon_Equip$",    "EQ_MenuIcons.png", g_frame_size, 3 );
  AddIconToken("$EQShopIcon_Settings$", "EQ_MenuIcons.png", g_frame_size, 6 );
}



void GetButtonsFor( CBlob@ _this, CBlob@ _caller ) {
  u8 cmdID = _this.getCommandID("EQ-CommandID");
  {// Shop:
    CBitStream params;
    params.write_u8( EQ::Cmds::MAIN_MENU );
    params.write_u16( _caller.getNetworkID());
    CButton@ button = _caller.CreateGenericButton("$EQShopIcon_Shop$",           // Icon Token.
						  Vec2f( 0, -3 ),                // Button Offset.
						  _this,                         // Button Attachment.
						  cmdID,                         // Command ID.
						  "Open Shop",                   // Description.
						  params );                      // Bit Stream.
    if( @button == null ) {
      print("EQ ERROR: Creating 'Shop' Button Faild! ->'"+ getCurrentScriptName() +"'->'GetButtonsFor'");
      return;
    }
    button.enableRadius = 32;
  }//~
  {// Auto Sell:
    CBitStream params;
    params.write_u8( EQ::Cmds::SHOP_AUTO_SELL );
    params.write_u16( _caller.getNetworkID());
    CButton@ button = _caller.CreateGenericButton("$EQShopIcon_AutoSell$",
						  Vec2f( -8, 10 ),
						  _this,
						  cmdID,
						  "Auto Sell",
						  params );
    if( @button == null ) {
      print("EQ ERROR: Creating 'Auto Sell' Button Faild! ->'"+ getCurrentScriptName() +"'->'GetButtonsFor'");
      return;
    }
    button.enableRadius = 40;
  }//~
  {// Auto Buy:
    CBitStream params;
    params.write_u8( EQ::Cmds::SHOP_AUTO_BUY );
    params.write_u16( _caller.getNetworkID());
    CButton@ button = _caller.CreateGenericButton("$EQShopIcon_AutoBuy$",
						  Vec2f( 8, 10 ),
						  _this,
						  cmdID,
						  "Auto Buy",
						  params );
    if( @button == null ) {
      print("EQ ERROR: Creating 'Auto Buy' Button Faild! ->'"+ getCurrentScriptName() +"'->'GetButtonsFor'");
      return;
    }
    button.enableRadius = 40;
  }//~
}



void onCommand( CBlob@ _this, u8 _cmd, CBitStream@ _params ) {
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
  if( caller.isMyPlayer()) {
    EQ::Cmds state = EQ::On_command_shop( _this, caller, _cmd, _params );
    // Show Main Menu:
    if( state == EQ::Cmds::MAIN_MENU ) {
      caller.ClearGridMenusExceptInventory();
      EQ::Create_EQmenu_Shop( _this, caller, _params );
    }
  }
}



namespace EQ {
  EQ::Cmds On_command_shop( CBlob@ _this, CBlob@ _caller, u8 _cmd, CBitStream@ _params ) {
    CPlayer@ player = _caller.getPlayer();
    if( @player == null )
      return EQ::Cmds::NIL;
    switch( _cmd ) {
      // SHOP AUTO SELL:
    case EQ::Cmds::SHOP_AUTO_SELL :
      return EQ::Cmds::TRUE;
      // SHOP AUTO BUY:
    case EQ::Cmds::SHOP_AUTO_BUY :
      return EQ::Cmds::TRUE;
      // MAIN MENU & MENU:
    case EQ::Cmds::MAIN_MENU :
    case EQ::Cmds::MENU :
      return EQ::Cmds::MAIN_MENU;
      // BUTTON SHOP ITEM:
    case EQ::Cmds::BUTTON_SHOP_ITEM : {
      EQ::Name item_name = EQ::Name(_params.read_u16());
      const bool epuip = getRules().get_bool("EQ-Shop-Setting Equip"+ player.getUsername());
      EQ::Create_item( _caller, _caller, item_name, epuip );
      return EQ::Cmds::MAIN_MENU;
    }
      // BUTTON STORAGE ITEM:
    case EQ::Cmds::BUTTON_STORAGE_ITEM :
      return EQ::Cmds::MAIN_MENU;
      // BUTTON SETTINGS:
    case EQ::Cmds::BUTTON_SETTINGS :
      return EQ::Cmds::MAIN_MENU;
      // BUTTON EQUIP:
    case EQ::Cmds::BUTTON_EQUIP : {
      bool equip = getRules().get_bool("EQ-Shop-Setting Equip"+ player.getUsername());
      getRules().set_bool(    "EQ-Shop-Setting Equip"+ player.getUsername(), ! equip );
      return EQ::Cmds::MAIN_MENU;
    }
    }//switch
    // FILTER:
    EQ::Cmds state = EQ::On_command_filter( _this, _caller, _cmd, _params );
    return state;
  }
}//EQ
