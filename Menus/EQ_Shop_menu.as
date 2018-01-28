


namespace EQ {
  void Shop_menu( CBlob@ _this, CBlob@ _caller, CBitStream@ _params, CGridMenu@ _shop_menu ) { // Local Only:
    _shop_menu.SetCaptionEnabled( false );
    uint8 cmdID = _this.getCommandID("EQ-CommandID");
    for( u16 i = 0 ; i < EQ::Name::ALL ; ++i ) {
      CBitStream params;
      params.write_u8( EQ::Cmds::BUTTON_SHOP_ITEM );
      params.write_u16( _caller.getNetworkID());
      params.write_u16( i );
      CGridButton@ button = _shop_menu.AddButton( "$EQItemIcon_"+ EQ::g_name_str[ i ] +"$",
						  "",
						  cmdID,
						  Vec2f( 1, 1 ),
						  params );
      if( @button == null ) {
	print("EQ ERROR: Creating 'Shop_menu' Grid-Button Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Shop_menu'");
	printInt("          i: ", i );
	return;
      }
      string str = EQ::g_name_str[ i ];
      button.SetHoverText( str );
    }//for
  }
}//EQ



namespace EQ {
  void Shop_settings_menu( CBlob@ _this, CBlob@ _caller, CBitStream@ _params, CGridMenu@ _shop_settings_menu ) { // Local Only:
    _shop_settings_menu.SetCaptionEnabled( false );
    uint8 cmdID = _this.getCommandID("EQ-CommandID");
    CPlayer@ player = _caller.getPlayer();
    if( @player == null )
      return;
    {// Equip On Buy:
      CBitStream params;
      params.write_u8( EQ::Cmds::BUTTON_EQUIP );
      params.write_u16( _caller.getNetworkID());
      CGridButton@ button = _shop_settings_menu.AddButton( "$EQShopIcon_Equip$",
							   "",
							   cmdID,
							   Vec2f( 1, 1 ),
							   params );
      if( @button == null ) {
	print("EQ ERROR: Creating 'shop_settings_menu' Grid-Button Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Shop_settings_menu'");
	return;
      }
      const bool equip = _caller.get_bool("EQ-Shop-Setting Equip");
      if( equip )
	button.SetSelected( 1 );
      string str = "Auto-Equip The Bought Items.";
      button.SetHoverText( str );
    }//~
    {// Auto-Buy Settings:
      CBitStream params;
      params.write_u8( EQ::Cmds::BUTTON_SETTINGS );
      params.write_u16( _caller.getNetworkID());
      CGridButton@ button = _shop_settings_menu.AddButton( "$EQShopIcon_Settings$",
							   "",
							   cmdID,
							   Vec2f( 1, 1 ),
							   params );
      if( @button == null ) {
	print("EQ ERROR: Creating 'shop_settings_menu' Grid-Button Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Shop_settings_menu'");
	return;
      }
      string str = "Set Up Auto Buy.";
      button.SetHoverText( str );
    }//~
  }
}//EQ
