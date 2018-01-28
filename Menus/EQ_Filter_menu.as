
// Filter Menus:
const Vec2f g_menu_materials_size( 3, 6 );
const Vec2f g_menu_slots_size( 3, 6 );
const Vec2f g_menu_types_size( 3, 7 );
const Vec2f g_menu_classes_size( 3, 4 );



namespace EQ {
  void Filter_menu( CBlob@ _this, CBlob@ _caller, CBitStream@ _params, CGridMenu@ _filter_menu ) { // Local Only:
    _filter_menu.SetCaptionEnabled( false );
    uint8 cmdID = _this.getCommandID("EQ-CommandID");
    CPlayer@ player = _caller.getPlayer();
    if( @player == null )
      return;
    { // Material:
      u8 filter_material = getRules().get_u8("EQ-Filter-Setting Material"+ player.getUsername());
      CBitStream params;
      params.write_u8( EQ::Cmds::MENU_MATERIAL );
      params.write_u16( _caller.getNetworkID());
      CGridButton@ button = _filter_menu.AddButton( "$EQMenuText_"+ EQ::g_materials_str[ filter_material ] +"$",
						    "",
						    cmdID,
						    Vec2f( g_filter_menu_size.x, 1 ),
						    params );
      if( @button == null ) {
	print("EQ ERROR: Create Grid-Button For 'filter_material' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Filter_menu'");
	return;
      }
      string str = "Filter By Material";
      button.SetHoverText( str );
    }//~
    { // Slot:
      u8 filter_slot = getRules().get_u8("EQ-Filter-Setting Slot"+ player.getUsername());
      CBitStream params;
      params.write_u8( EQ::Cmds::MENU_SLOT );
      params.write_u16( _caller.getNetworkID());
      CGridButton@ button = _filter_menu.AddButton( "$EQMenuText_"+ EQ::g_slot_str[ filter_slot ] +"$",
						    "",
						    cmdID,
						    Vec2f( g_filter_menu_size.x, 1 ),
						    params );
      if( @button == null ) {
	print("EQ ERROR: Create Grid-Button For 'filter_slot' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Filter_menu'");
	return;
      }
      string str = "Filter By Slot";
      button.SetHoverText( str );
    }//~
    { // Type:
      u8 filter_type = getRules().get_u8("EQ-Filter-Setting Type"+ player.getUsername());
      CBitStream params;
      params.write_u8( EQ::Cmds::MENU_TYPE );
      params.write_u16( _caller.getNetworkID());
      CGridButton@ button = _filter_menu.AddButton( "$EQMenuText_"+ EQ::g_type_str[ filter_type ] +"$",
						    "",
						    cmdID,
						    Vec2f( g_filter_menu_size.x, 1 ),
						    params );
      if( @button == null ) {
	print("EQ ERROR: Create Grid-Button For 'filter_type' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Filter_menu'");
	return;
      }
      string str = "Filter By Type";
      button.SetHoverText( str );
    }//~
    { // Class:
      u8 filter_class = getRules().get_u8("EQ-Filter-Setting Class"+ player.getUsername());
      CBitStream params;
      params.write_u8( EQ::Cmds::MENU_CLASS );
      params.write_u16( _caller.getNetworkID());
      CGridButton@ button = _filter_menu.AddButton( "$EQMenuText_"+ EQ::g_class_str[ filter_class ] +"$",
						    "",
						    cmdID,
						    Vec2f( g_filter_menu_size.x, 1 ),
						    params );
      if( @button == null ) {
	print("EQ ERROR: Create Grid-Button For 'filter_class' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Filter_menu'");
	return;
      }
      string str = "Filter By Class";
      button.SetHoverText( str );
    }//~
  }
}//EQ



namespace EQ {
  void Create_EQmenu_materials( CBlob@ _this, CBlob@ _caller, CBitStream@ _params ) { // Local Only:
    uint8 cmdID = _this.getCommandID("EQ-CommandID");
    Driver@ driver = getDriver();
    if( @driver == null ) {
      print("EQ ERROR: Getting 'driver' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_materials'");
      return;
    }  
    Vec2f center_pos = driver.getScreenCenterPos();
    CGridMenu@ menu = CreateGridMenu( center_pos, _this, g_menu_materials_size, "" );
    if( @menu == null ) {
      print("EQ ERROR: Create Grid-Menu Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_materials'");
      return;
    }
    menu.SetCaptionEnabled( false );
    {// All Materials Button:
      CBitStream params;
      params.write_u8( EQ::Cmds::FILTER_MATERIAL );
      params.write_u16( _caller.getNetworkID());
      params.write_u8( EQ::Material::ALL );
      CGridButton@ button = menu.AddButton( "$EQMenuText_"+ EQ::g_materials_str[ EQ::Material::ALL ] +"$",
					    "",
					    cmdID,
					    Vec2f( g_menu_materials_size.x, 1 ),
					    params );
      if( @button == null ) {
	print("EQ ERROR: Create Grid-Button For 'All Materials' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_materials'");
	return;
      }
      string str = EQ::g_materials_str[ EQ::Material::ALL ];
      button.SetHoverText( str );
    }//~
    // Material Buttons:
    for( u8 i = 0 ; i != EQ::Material::ALL ; ++i ) {
      CBitStream params;
      params.write_u8( EQ::Cmds::FILTER_MATERIAL );
      params.write_u16( _caller.getNetworkID());
      params.write_u8( i );
      CGridButton@ button = menu.AddButton( "$EQMenuText_"+ EQ::g_materials_str[ i ] +"$",
					    "",
					    cmdID,
					    Vec2f( 1, 1 ),
					    params );
      if( @button == null ) {
	print("EQ ERROR: Create Grid-Button Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_materials'");
	printInt("          i: ", i );
	return;
      }
      string str = EQ::g_materials_str[ i ];
      button.SetHoverText( str );
    }//for
  }


  
  void Create_EQmenu_slots( CBlob@ _this, CBlob@ _caller, CBitStream@ _params ) { // Local Only:
    uint8 cmdID = _this.getCommandID("EQ-CommandID");
    Driver@ driver = getDriver();
    if( @driver == null ) {
      print("EQ ERROR: Getting 'driver' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_slots'");
      return;
    }  
    Vec2f center_pos = driver.getScreenCenterPos();
    u8 i = 0;
    // --- Main Slots Menu: ---
    Vec2f main_pos = center_pos;
    main_pos.x -= g_menu_slots_size.x * ( g_grid_size / 2 );
    CGridMenu@ main_slots_menu = CreateGridMenu( main_pos, _this, g_menu_slots_size, "" );
    if( @main_slots_menu == null ) {
      print("EQ ERROR: Create Grid-Menu For 'main_slots_menu' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_slots'");
      return;
    }
    main_slots_menu.SetCaptionEnabled( false );
    {// All-Main Slots Button:
      CBitStream params;
      params.write_u8( EQ::Cmds::FILTER_SLOT );
      params.write_u16( _caller.getNetworkID());
      params.write_u8( EQ::Slot::ALL_MAIN );
      CGridButton@ button = main_slots_menu.AddButton( "$EQMenuText_"+ EQ::g_slot_str[ EQ::Slot::ALL_MAIN ] +"$",
						       "",
						       cmdID,
						       Vec2f( g_menu_slots_size.x, 1 ),
						       params );
      if( @button == null ) {
	print("EQ ERROR: Creating The 'All-Main Slots' Grid-Button Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_slots'");
	return;
      }
      string str = EQ::g_slot_str[ EQ::Slot::ALL_MAIN ];
      button.SetHoverText( str );
    }//~
    // Main Slot Buttons:
    for( ; i < EQ::Slot::ALL_MAIN ; ++i ) {
      CBitStream params;
      params.write_u8( EQ::Cmds::FILTER_SLOT );
      params.write_u16( _caller.getNetworkID());
      params.write_u8( i );
      CGridButton@ button = main_slots_menu.AddButton( "$EQMenuText_"+ EQ::g_slot_str[ i ] +"$",
						       "",
						       cmdID,
						       Vec2f( g_menu_slots_size.x, 1 ),
						       params );
      if( @button == null ) {
	print("EQ ERROR: Creating 'Main Slot' Grid-Button Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_slots'");
	printInt("          i: ", i );
	return;
      }
      string str = EQ::g_slot_str[ i ];
      button.SetHoverText( str );
    }//for
    ++i;    
    // --- Secondary Slots Menu: ---
    Vec2f secondary_pos = center_pos;
    secondary_pos.x += g_menu_slots_size.x * ( g_grid_size / 2 );
    CGridMenu@ secondary_slots_menu = CreateGridMenu( secondary_pos, _this, g_menu_slots_size, "" );
    if( @secondary_slots_menu == null ) {
      print("EQ ERROR: Create Grid-Menu For 'secondary_slots_menu' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_slots'");
      return;
    }
    secondary_slots_menu.SetCaptionEnabled( false );
    {// All-Secondary Slots Button:
      CBitStream params;
      params.write_u8( EQ::Cmds::FILTER_SLOT );
      params.write_u16( _caller.getNetworkID());
      params.write_u8( EQ::Slot::ALL_SECONDARY );
      CGridButton@ button = secondary_slots_menu.AddButton( "$EQMenuText_"+ EQ::g_slot_str[ EQ::Slot::ALL_SECONDARY ] +"$",
							    "",
							    cmdID,
							    Vec2f( g_menu_slots_size.x, 1 ),
							    params );
      if( @button == null ) {
	print("EQ ERROR: Creating The 'All-Secondary Slots' Grid-Button Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_slots'");
	return;
      }
      string str = EQ::g_slot_str[ EQ::Slot::ALL_SECONDARY ];
      button.SetHoverText( str );
    }//~
    // Secondary Slot Buttons:
    for( ; i < EQ::Slot::ALL_SECONDARY ; ++i ) {
      CBitStream params;
      params.write_u8( EQ::Cmds::FILTER_SLOT );
      params.write_u16( _caller.getNetworkID());
      params.write_u8( i );
      CGridButton@ button = secondary_slots_menu.AddButton( "$EQMenuText_"+ EQ::g_slot_str[ i ] +"$",
							    "",
							    cmdID,
							    Vec2f( g_menu_slots_size.x, 1 ),
							    params );
      if( @button == null ) {
	print("EQ ERROR: Creating 'Secondary Slot' Grid-Button Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_slots'");
	printInt("          i: ", i );
	return;
      }
      string str = EQ::g_slot_str[ i ];
      button.SetHoverText( str );
    }//for
    // --- All Slots Menu: ---
    Vec2f all_pos = center_pos;
    all_pos.y = main_slots_menu.getUpperLeftPosition().y - ( g_grid_size / 2 );
    CGridMenu@ all_slots_menu = CreateGridMenu( all_pos, _this, Vec2f( g_menu_slots_size.x * 2 , 1 ), "" );
    if( @all_slots_menu == null ) {
      print("EQ ERROR: Create Grid-Menu For 'all_slots_menu' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_slots'");
      return;
    }
    all_slots_menu.SetCaptionEnabled( false );
    {// All Slots Button:
      CBitStream params;
      params.write_u8( EQ::Cmds::FILTER_SLOT );
      params.write_u16( _caller.getNetworkID());
      params.write_u8( EQ::Slot::ALL );
      CGridButton@ button = all_slots_menu.AddButton( "$EQMenuText_"+ EQ::g_slot_str[ EQ::Slot::ALL ] +"$",
						      "",
						      cmdID,
						      Vec2f( g_menu_slots_size.x * 2, 1 ),
						      params );
      if( @button == null ) {
	print("EQ ERROR: Creating The 'All Slots' Grid-Button Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_slots'");
	return;
      }
      string str = EQ::g_slot_str[ EQ::Slot::ALL ];
      button.SetHoverText( str );
    }//~
  }



  void Create_EQmenu_types( CBlob@ _this, CBlob@ _caller, CBitStream@ _params ) { // Local Only:
    uint8 cmdID = _this.getCommandID("EQ-CommandID");
    Driver@ driver = getDriver();
    if( @driver == null ) {
      print("EQ ERROR: Getting 'driver' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_types'");
      return;
    }  
    Vec2f center_pos = driver.getScreenCenterPos();
    u8 i = 0;
    // --- Armour Menu: ---
    CGridMenu@ armour_menu = CreateGridMenu( center_pos, _this, g_menu_types_size, "" );
    if( @armour_menu == null ) {
      print("EQ ERROR: Create Grid-Menu For 'armour_menu' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_types'");
      return;
    }
    armour_menu.SetCaptionEnabled( false );
    {// All Armour Types Button:
      CBitStream params;
      params.write_u8( EQ::Cmds::FILTER_TYPE );
      params.write_u16( _caller.getNetworkID());
      params.write_u8( EQ::Type::ALL_ARMOUR );
      CGridButton@ button = armour_menu.AddButton( "$EQMenuText_"+ EQ::g_type_str[ EQ::Type::ALL_ARMOUR ] +"$",
						   "",
						   cmdID,
						   Vec2f( g_menu_types_size.x, 1 ),
						   params );
      if( @button == null ) {
	print("EQ ERROR: Creating The 'All Armour Types' Grid-Button Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_types'");
	return;
      }
      string str = EQ::g_type_str[ EQ::Type::ALL_ARMOUR ];
      button.SetHoverText( str );
    }//~
    // Armour Type Buttons:
    for( ; i < EQ::Type::ALL_ARMOUR ; ++i ) {
      CBitStream params;
      params.write_u8( EQ::Cmds::FILTER_TYPE );
      params.write_u16( _caller.getNetworkID());
      params.write_u8( i );
      CGridButton@ button = armour_menu.AddButton( "$EQMenuText_"+ EQ::g_type_str[ i ] +"$",
						   "",
						   cmdID,
						   Vec2f( g_menu_types_size.x, 1 ),
						   params );
      if( @button == null ) {
	print("EQ ERROR: Creating 'Armour Type' Grid-Button Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_types'");
	printInt("          i: ", i );
	return;
      }
      string str = EQ::g_type_str[ i ];
      button.SetHoverText( str );
    }//for
    ++i;   
    // --- Weapons Menu: ---
    Vec2f weapon_pos = center_pos;
    weapon_pos.x = armour_menu.getUpperLeftPosition().x - ( g_menu_types_size.x * g_grid_size / 2 );
    CGridMenu@ weapons_menu = CreateGridMenu( weapon_pos, _this, g_menu_types_size, "" );
    if( @weapons_menu == null ) {
      print("EQ ERROR: Create Grid-Menu For 'weapons_menu' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_types'");
      return;
    }
    weapons_menu.SetCaptionEnabled( false );
    {// All Weapon Types Button:
      CBitStream params;
      params.write_u8( EQ::Cmds::FILTER_TYPE );
      params.write_u16( _caller.getNetworkID());
      params.write_u8( EQ::Type::ALL_WEAPONS );
      CGridButton@ button = weapons_menu.AddButton( "$EQMenuText_"+ EQ::g_type_str[ EQ::Type::ALL_WEAPONS ] +"$",
						    "",
						    cmdID,
						    Vec2f( g_menu_types_size.x, 1 ),
						    params );
      if( @button == null ) {
	print("EQ ERROR: Creating The 'All Weapon Types' Grid-Button Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_types'");
	return;
      }
      string str = EQ::g_type_str[ EQ::Type::ALL_WEAPONS ];
      button.SetHoverText( str );
    }//~
    // Weapon Type Buttons:
    for( ; i < EQ::Type::ALL_WEAPONS ; ++i ) {
      CBitStream params;
      params.write_u8( EQ::Cmds::FILTER_TYPE );
      params.write_u16( _caller.getNetworkID());
      params.write_u8( i );
      CGridButton@ button = weapons_menu.AddButton( "$EQMenuText_"+ EQ::g_type_str[ i ] +"$",
						    "",
						    cmdID,
						    Vec2f( g_menu_types_size.x, 1 ),
						    params );
      if( @button == null ) {
	print("EQ ERROR: Creating 'Weapon Type' Grid-Button Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_types'");
	printInt("          i: ", i );
	return;
      }
      string str = EQ::g_type_str[ i ];
      button.SetHoverText( str );
    }//for
    ++i;          
    // --- Accessories Menu: ---
    Vec2f accessory_pos = center_pos;
    accessory_pos.x = armour_menu.getLowerRightPosition().x + ( g_menu_types_size.x * g_grid_size / 2 );
    CGridMenu@ accessories_menu = CreateGridMenu( accessory_pos, _this, g_menu_types_size, "" );
    if( @accessories_menu == null ) {
      print("EQ ERROR: Create Grid-Menu For 'accessories_menu' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_types'");
      return;
    }
    accessories_menu.SetCaptionEnabled( false );
    {// All Accessory Types Button:
      CBitStream params;
      params.write_u8( EQ::Cmds::FILTER_TYPE );
      params.write_u16( _caller.getNetworkID());
      params.write_u8( EQ::Type::ALL_ACCESSORIES );
      CGridButton@ button = accessories_menu.AddButton( "$EQMenuText_"+ EQ::g_type_str[ EQ::Type::ALL_ACCESSORIES ] +"$",
							"",
							cmdID,
							Vec2f( g_menu_types_size.x, 1 ),
							params );
      if( @button == null ) {
	print("EQ ERROR: Creating The 'All Accessory Types' Grid-Button Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_types'");
	return;
      }
      string str = EQ::g_type_str[ EQ::Type::ALL_ACCESSORIES ];
      button.SetHoverText( str );
    }//~  
    // Accessory Type Buttons:
    for( ; i < EQ::Type::ALL_ACCESSORIES ; ++i ) {
      CBitStream params;
      params.write_u8( EQ::Cmds::FILTER_TYPE );
      params.write_u16( _caller.getNetworkID());
      params.write_u8( i );
      CGridButton@ button = accessories_menu.AddButton( "$EQMenuText_"+ EQ::g_type_str[ i ] +"$",
							"",
							cmdID,
							Vec2f( g_menu_types_size.x, 1 ),
							params );
      if( @button == null ) {
	print("EQ ERROR: Creating 'Accessory Type' Grid-Button Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_types'");
	printInt("          i: ", i );
	return;
      }
      string str = EQ::g_type_str[ i ];
      button.SetHoverText( str );
    }//for
    // --- All Types Menu: ---
    Vec2f all_pos = center_pos;
    all_pos.y = armour_menu.getUpperLeftPosition().y - ( g_grid_size / 2 );
    CGridMenu@ all_types_menu = CreateGridMenu( all_pos, _this, Vec2f( g_menu_types_size.x * 3 , 1 ), "" );
    if( @all_types_menu == null ) {
      print("EQ ERROR: Create Grid-Menu For 'all_types_menu' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_types'");
      return;
    }
    all_types_menu.SetCaptionEnabled( false );
    {// All Types Button:
      CBitStream params;
      params.write_u8( EQ::Cmds::FILTER_TYPE );
      params.write_u16( _caller.getNetworkID());
      params.write_u8( EQ::Type::ALL );
      CGridButton@ button = all_types_menu.AddButton( "$EQMenuText_"+ EQ::g_type_str[ EQ::Type::ALL ] +"$",
						      "",
						      cmdID,
						      Vec2f( g_menu_types_size.x * 3, 1 ),
						      params );
      if( @button == null ) {
	print("EQ ERROR: Creating The 'All Types' Grid-Button Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_types'");
	return;
      }
      string str = EQ::g_type_str[ EQ::Type::ALL ];
      button.SetHoverText( str );
    }//~
  }



  void Create_EQmenu_classes( CBlob@ _this, CBlob@ _caller, CBitStream@ _params ) { // Local Only:
    uint8 cmdID = _this.getCommandID("EQ-CommandID");
    Driver@ driver = getDriver();
    if( @driver == null ) {
      print("EQ ERROR: Getting 'driver' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_classes'");
      return;
    }  
    Vec2f center_pos = driver.getScreenCenterPos();
    // --- Classes Menu: ---
    CGridMenu@ classes_menu = CreateGridMenu( center_pos, _this, g_menu_classes_size, "" );
    if( @classes_menu == null ) {
      print("EQ ERROR: Create Grid-Menu For 'classes_menu' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_classes'");
      return;
    }
    classes_menu.SetCaptionEnabled( false );
    {// All Classes Button:
      CBitStream params;
      params.write_u8( EQ::Cmds::FILTER_CLASS );
      params.write_u16( _caller.getNetworkID());
      params.write_u8( EQ::Class::ALL );
      CGridButton@ button = classes_menu.AddButton( "$EQMenuText_"+ EQ::g_class_str[ EQ::Class::ALL ] +"$",
						    "",
						    cmdID,
						    Vec2f( g_menu_classes_size.x, 1 ),
						    params );
      if( @button == null ) {
	print("EQ ERROR: Creating The 'All Classes' Grid-Button Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_classes'");
	return;
      }
      string str = EQ::g_class_str[ EQ::Class::ALL ];
      button.SetHoverText( str );
    }//~
    // Class Buttons:
    for( u8 i = 0 ; i < EQ::Class::ALL ; ++i ) {
      CBitStream params;
      params.write_u8( EQ::Cmds::FILTER_CLASS );
      params.write_u16( _caller.getNetworkID());
      params.write_u8( i );
      CGridButton@ button = classes_menu.AddButton( "$EQMenuText_"+ EQ::g_class_str[ i ] +"$",
						    "",
						    cmdID,
						    Vec2f( g_menu_classes_size.x, 1 ),
						    params );
      if( @button == null ) {
	print("EQ ERROR: Creating 'Class' Grid-Button Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_EQmenu_classes'");
	printInt("          i: ", i );
	return;
      }
      string str = EQ::g_class_str[ i ];
      button.SetHoverText( str );
    }//for
  }
}//EQ



namespace EQ {
  EQ::Cmds On_command_filter( CBlob@ _this, CBlob@ _caller, u8 _cmd, CBitStream@ _params ) { // Local Only:
    CPlayer@ player = _caller.getPlayer();
    if( @player == null )
      return EQ::Cmds::NIL;
    switch( _cmd ) {
      // MENU MATERIAL:
    case EQ::Cmds::MENU_MATERIAL :
      _caller.ClearGridMenusExceptInventory();
      EQ::Create_EQmenu_materials( _this, _caller, _params );
      return EQ::Cmds::TRUE;
      // MENU SLOT:
    case EQ::Cmds::MENU_SLOT :
      _caller.ClearGridMenusExceptInventory();
      EQ::Create_EQmenu_slots( _this, _caller, _params );
      return EQ::Cmds::TRUE;
      // MENU TYPE:
    case EQ::Cmds::MENU_TYPE :
      _caller.ClearGridMenusExceptInventory();
      EQ::Create_EQmenu_types( _this, _caller, _params );
      return EQ::Cmds::TRUE;
      // MENU CLASS:
    case EQ::Cmds::MENU_CLASS :
      _caller.ClearGridMenusExceptInventory();
      EQ::Create_EQmenu_classes( _this, _caller, _params );
      return EQ::Cmds::TRUE;
      // FILTER MATERIAL:
    case EQ::Cmds::FILTER_MATERIAL : {
      getRules().set_u8(      "EQ-Filter-Setting Material"+ player.getUsername(), _params.read_u8());
      getRules().SyncToPlayer("EQ-Filter-Setting Material"+ player.getUsername(), player );
      return EQ::Cmds::MAIN_MENU;
    }
      // FILTER SLOT:
    case EQ::Cmds::FILTER_SLOT : {
      getRules().set_u8(      "EQ-Filter-Setting Slot"+ player.getUsername(), _params.read_u8());
      getRules().SyncToPlayer("EQ-Filter-Setting Slot"+ player.getUsername(), player );
      return EQ::Cmds::MAIN_MENU;
    }
      // FILTER TYPE:
    case EQ::Cmds::FILTER_TYPE : {
      getRules().set_u8(      "EQ-Filter-Setting Type"+ player.getUsername(), _params.read_u8());
      getRules().SyncToPlayer("EQ-Filter-Setting Type"+ player.getUsername(), player );
      return EQ::Cmds::MAIN_MENU;
    }
      // FILTER CLASS:
    case EQ::Cmds::FILTER_CLASS : {
      getRules().set_u8(      "EQ-Filter-Setting Class"+ player.getUsername(), _params.read_u8());
      getRules().SyncToPlayer("EQ-Filter-Setting Class"+ player.getUsername(), player );
      return EQ::Cmds::MAIN_MENU;
    }
    }//switch
    return EQ::Cmds::FALSE; // '_cmd' Not Found, So Return False.
  }
}//EQ
