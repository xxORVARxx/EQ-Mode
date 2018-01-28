


namespace EQ {
  void Class_menu( CBlob@ _this, CBlob@ _caller, CBitStream@ _params, CGridMenu@ _class_menu ) { // Local Only:
    _class_menu.SetCaptionEnabled( false );
    uint8 cmdID = _this.getCommandID("EQ-CommandID");
    CPlayer@ player = _caller.getPlayer();
    if( @player == null )
      return;    
    {// Clear Slots:
      CBitStream params;
      params.write_u8( EQ::Cmds::BUTTON_CLEAR );
      params.write_u16( _caller.getNetworkID());
      CGridButton@ button = _class_menu.AddButton( "$EQClassIcon_Clear_Slots$",
						   "",
						   cmdID,
						   Vec2f( 1, 1 ),
						   params );
      if( @button == null ) {
	print("EQ ERROR: Creating 'Class_menu' Grid-Button Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Class_menu'");
	return;
      }
      string str = "Clear Slots.";
      button.SetHoverText( str );
    }//~   
    {// Drop Items:
      CBitStream params;
      params.write_u8( EQ::Cmds::BUTTON_DROP );
      params.write_u16( _caller.getNetworkID());
      CGridButton@ button = _class_menu.AddButton( "$EQClassIcon_Drop_Items$",
						   "",
						   cmdID,
						   Vec2f( 1, 1 ),
						   params );
      if( @button == null ) {
	print("EQ ERROR: Creating 'class_menu' Grid-Button Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Class_menu'");
	return;
      }
      const bool drop = _caller.get_bool("EQ-Inv-Setting Drop");
      if( drop )
	button.SetSelected( 1 );
      string str = "Drop Items.";
      button.SetHoverText( str );
    }//~
  }
}//EQ
