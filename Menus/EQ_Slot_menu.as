


namespace EQ {
  void Slot_menu( CBlob@ _this, CBlob@ _caller, CBitStream@ _params, CGridMenu@ _slot_menu ) { // Local Only:
    _slot_menu.SetCaptionEnabled( false );
    array< EQ::Item_data@ >@ equip_items = EQ::Get_equip_items( _caller );
    array< EQ::Class_slot@ >@ class_slots = EQ::Get_class_slots( _caller );
    if(( @equip_items == null )||( @class_slots == null ))
      return;    
    for( u8 i = 0 ; i < equip_items.length() ; ++i ) {
      CGridButton@ button;
      if( @equip_items[i] == null ) {
	// SLOT IS EMPTY:
	CBitStream params;
	params.write_u8( EQ::Cmds::BUTTON_SLOT_EMPTY );
	params.write_u16( _caller.getNetworkID());
	params.write_u8( i );
        @button = _slot_menu.AddButton("EQ_MenuIcons_Slots.png",
				       class_slots[i].m_frame,
				       "",
				       _this.getCommandID("EQ-CommandID"),
				       Vec2f( 1, 1 ),
				       params );
      }
      else {
	// SLOT IS OCCUPIED:
	CBitStream params;
	params.write_u8( EQ::Cmds::BUTTON_SLOT_ITEM );
	params.write_u16( _caller.getNetworkID());
	params.write_u8( i );
        @button = _slot_menu.AddButton("$EQItemIconEquip_"+ EQ::g_name_str[ equip_items[i].m_item.Get_name() ] +"$",
				       "",
				       _this.getCommandID("EQ-CommandID"),
				       Vec2f( 1, 1 ),
				       params );
      }
      if( @button == null ) {
	print("EQ ERROR: Create Grid-Button For 'Slot_menu' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Slot_menu'");
	printInt("          i: ", i );
	return;
      }
      string str;
      if( @equip_items[i] == null ) {
	// SLOT IS EMPTY:
	str = "Epty sloty";
      }
      else {
	// SLOT IS OCCUPIED:
	str = "my goodest items and nice itme too also!!!1";
      }
      button.SetHoverText( str );
    }//for
  }
}//EQ
