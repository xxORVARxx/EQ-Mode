


namespace EQ {
  void Storage_menu( CBlob@ _this, CBlob@ _caller, CBitStream@ _params, CGridMenu@ _storage_menu ) { // Local Only:
    _storage_menu.SetCaptionEnabled( false );
    uint8 cmdID = _this.getCommandID("EQ-CommandID");
    CPlayer@ player = _caller.getPlayer();
    if( @player == null )
      return;    
    array< EQ::Item_data@ >@ storage_array;
    getRules().get("EQ-Items Storage-Array"+ player.getUsername(), @storage_array );
    if( @storage_array == null ) {
      print("EQ ERROR: Getting 'storage_array' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Storage_menu'");
      return;
    }
    for( u16 i = 0 ; i < storage_array.length() ; ++i ) {
      EQ::Item_data@ data = storage_array[ i ];
      if( @data == null ) {
	continue;
      }
      if( @data.m_item == null ) {
	print("EQ ERROR: 'data.m_item' == null! ->'"+ getCurrentScriptName() +"'->'EQ::Storage_menu'");
	printInt("          i: ", i );
	continue;
      }
      string icon_str;
      if( data.m_equip_slot >= 0 )
	icon_str = "$EQItemIconEquip_"+ EQ::g_name_str[ data.m_item.Get_name() ] +"$";
      else
	icon_str = "$EQItemIcon_"     + EQ::g_name_str[ data.m_item.Get_name() ] +"$";
      CBitStream params;
      params.write_u8( EQ::Cmds::BUTTON_STORAGE_ITEM );
      params.write_u16( _caller.getNetworkID());
      params.write_u16( i );
      CGridButton@ button = _storage_menu.AddButton( icon_str, "", cmdID, Vec2f( 1, 1 ), params );
      if( @button == null ) {
	print("EQ ERROR: Creating 'Storage_menu' Grid-Button Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Storage_menu'");
	printInt("          i: ", i );
	return;
      }
      string str = EQ::g_name_str[ data.m_item.Get_name() ];
      if(( @data.m_func != null )&&( @data.m_variables != null )) {
	if( @data.m_func.m_print_variables_fptr != null ) {
	  data.m_variables.ResetBitIndex();
	  str = data.m_func.m_print_variables_fptr( _caller, data.m_item, data.m_variables, str );
	}
      }
      button.SetHoverText( str );
    }//for
  }
}//EQ
