
#include "EQ_Commands.as"



namespace EQ {
  void Add_class_slot( CBlob@ _this, const EQ::Slot _slot, const int _frame ) {
    if( ! _this.exists("EQ Number Of Slots")) {
      u8 number_of_slots = 0;
      _this.set("EQ Number Of Slots", number_of_slots );
    }
    if( ! _this.exists("EQ Class-Slots-Array")) {
      array< EQ::Class_slot@ > class_slots_array;
      _this.set("EQ Class-Slots-Array", class_slots_array );
    }
    if( ! _this.exists("EQ Equip-Items-Array")) {
      array< EQ::Item_data@ > equip_items_array;
      _this.set("EQ Equip-Items-Array", equip_items_array ); 
    }
    EQ::Class_slot class_slot( _slot, _frame );
    _this.push("EQ Class-Slots-Array", @class_slot );    
    _this.push("EQ Equip-Items-Array", null );
    u8 number_of_slots;
    _this.get("EQ Number Of Slots", number_of_slots );
    _this.set("EQ Number Of Slots", ++number_of_slots );
  }


  
  array< EQ::Class_slot@ >@ Get_class_slots( CBlob@ _this ) {
    if( ! _this.exists("EQ Class-Slots-Array")) {
      print("EQ ERROR: Add Some Slots First! ->'"+ getCurrentScriptName() +"'->'EQ::Get_class_slots'");
      return null;
    }
    array< EQ::Class_slot@ >@ class_slots_array;
    _this.get("EQ Class-Slots-Array", @class_slots_array );
    if( @class_slots_array == null )
      return null;
    if( class_slots_array.length() > 0 )
      return class_slots_array;
    return null;   
  }

  
  
  array< EQ::Item_data@ >@ Get_equip_items( CBlob@ _this ) {
    if( ! _this.exists("EQ Equip-Items-Array")) {
      print("EQ ERROR: Add Some Slots First! ->'"+ getCurrentScriptName() +"'->'EQ::Get_equip_items'");
      return null;
    }
    array< EQ::Item_data@ >@ equip_items_array;
    _this.get("EQ Equip-Items-Array", @equip_items_array );
    if( @equip_items_array == null )
      return null;
    if( equip_items_array.length() > 0 )
      return equip_items_array;
    return null;   
  }

  
  
  void Set_equip_item( CBlob@ _this, const int _index, EQ::Item_data@ _item ) {
    if(( ! _this.exists("EQ Number Of Slots"))||( ! _this.exists("EQ Equip-Items-Array"))) {
      print("EQ ERROR: Add Some Slots First! ->'"+ getCurrentScriptName() +"'->'EQ::Set_slot_item'");
      return;
    }
    u8 number_of_slots;
    _this.get("EQ Number Of Slots", number_of_slots );
    if( _index >= number_of_slots ) {
      print("EQ ERROR: '_index >= _number_of_slots'! ->'"+ getCurrentScriptName() +"'->'EQ::Set_slot_item'");
      return;
    }
    _this.setAt("EQ Equip-Items-Array", _index, @_item );
  }


  
  bool Remove_equip_item( CBlob@ _this, EQ::Item_data@ _item ) {
    if( ! _this.exists("EQ Equip-Items-Array")) {
      print("EQ ERROR: Add Some Slots First! ->'"+ getCurrentScriptName() +"'->'EQ::Remove_slot_item'");
      return false;
    }
    array< EQ::Item_data@ >@ equip_items_array;
    _this.get("EQ Equip-Items-Array", @equip_items_array );
    if( @equip_items_array == null )
      return false;
    bool removed = false;
    for( u8 i = 0 ; i < equip_items_array.length() ; ++i ) {
      if( @equip_items_array[i] == null )
	continue;
      if( @equip_items_array[i] == @_item ) {
	@equip_items_array[i] = null;
	removed = true;
      }
    }//for
    return removed;
  }
}//EQ



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



namespace EQ {
  bool Remove_storage_item( CBlob@ _this, EQ::Item_data@ _item ) {
    CPlayer@ player = _this.getPlayer();
    if( @player == null )
      return false;
    array< EQ::Item_data@ >@ storage_array;
    getRules().get("EQ-Items Storage-Array"+ player.getUsername(), @storage_array );
    if( @storage_array == null )
      return false;
    bool removed = false;
    for( u8 i = 0 ; i < storage_array.length() ; ++i ) {
      if( @storage_array[i] == null )
	continue;
      if( @storage_array[i] == @_item ) {
	@storage_array[i] = null;
	removed = true;
      }
    }//for
    return removed;
  }
}//EQ



namespace EQ {
  EQ::Item_data@ Get_storage_item_by_index( CBlob@ _this, u8 _index ) {
    CPlayer@ player = _this.getPlayer();
    if( @player == null )
      return null;
    array< EQ::Item_data@ >@ storage_array;
    getRules().get("EQ-Items Storage-Array"+ player.getUsername(), @storage_array );
    if( @storage_array == null ) {
      print("EQ ERROR: Getting 'storage_array' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Get_storage_item_by_index'");
      return null;
    }
    if( _index >= storage_array.length()) {
      print("EQ ERROR: Index Out Of Range ->'"+ getCurrentScriptName() +"'->'EQ::Get_storage_item_by_index'");
      return null;
    }
    return storage_array[ _index ];
  }


  
  int Get_storage_index_by_item( CBlob@ _this, EQ::Item_data@ _item ) {
    // IMPLEMENT HERE //
    return -1;
  }


  
  EQ::Item_data@ Get_equip_item_by_index( CBlob@ _this, u8 _index ) {
    // Geting All Of The Class's Slots:
    array< EQ::Item_data@ >@ equip_items = EQ::Get_equip_items( _this );
    if( @equip_items == null )
      return null;
    if( _index >= equip_items.length()) {
      print("EQ ERROR: Index Out Of Range ->'"+ getCurrentScriptName() +"'->'EQ::Get_equip_item_by_index'");
      return null;
    }
    // Geting The Item Which Is To Be Unequip:
    return equip_items[ _index ];
  }


  
  int Get_equip_index_by_item( CBlob@ _this, EQ::Item_data@ _item ) {
    // IMPLEMENT HERE //
    return -1;
  }
}//EQ



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



namespace EQ {
  void Create_item( CBlob@ _this, CBlob@ _owner, EQ::Name _item_name, const bool _equip ) { // Server & Local:
    CPlayer@ player = _this.getPlayer();
    if( @player == null ) {
      print("EQ ERROR: Getting 'player' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_item'");
      return;
    }
    print("EQ::Create_item -> '"+ EQ::g_name_str[ _item_name ] +"' For: "+ player.getUsername());//
    if( ! getRules().exists("EQ-Items Storage-Array"+ player.getUsername())) {
      print("EQ ERROR: Player's 'EQ-Items Storage-Array' Does Not Exist! ->'"+ getCurrentScriptName() +"'->'EQ::Create_item'");
      return;
    }
    FACTORY::Items@ factory;
    getRules().get("factory", @factory );
    if( @factory == null ) {
      print("EQ ERROR: Getting Factory Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_item'");
      return;
    }    
    EQ::Item@ item = factory.Get_item( _item_name );
    if( @item == null ) {
      print("EQ ERROR: Getting Item From Factory Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Create_item'");
      return;
    }
    CBitStream variables;
    EQ::Item_functionality@ func = factory.Get_functionality( _item_name, EQ::Class(_this.get_u8("EQ This Class")));
    if( @func != null ) {
      if( @func.m_new_variables_fptr != null )
	func.m_new_variables_fptr( _this, _owner, variables );
    }
    EQ::Item_data data( item, func, variables );
    getRules().push("EQ-Items Storage-Array"+ player.getUsername(), @data );
    if( _equip )
      EQ::Equip_item( _owner, @data );
  }


  void Pickup_item( CBlob@ _carrier, EQ::Name _item_name, CBitStream@ _variables ) { // Server & Local:
    CPlayer@ player = _carrier.getPlayer();
    if( @player == null ) {
      print("EQ ERROR: Getting 'player' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Pickup_item'");
      return;
    }
    print("EQ::Pickup_item -> '"+ EQ::g_name_str[ _item_name ] +"' For: "+ player.getUsername());//
    if( ! getRules().exists("EQ-Items Storage-Array"+ player.getUsername())) {
      print("EQ ERROR: Player's 'EQ-Items Storage-Array' Does Not Exist! ->'"+ getCurrentScriptName() +"'->'EQ::Pickup_item'");
      return;
    }
    FACTORY::Items@ factory;
    getRules().get("factory", @factory );
    if( @factory == null ) {
      print("EQ ERROR: Getting Factory Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Pickup_item'");
      return;
    }
    EQ::Item@ item = factory.Get_item( _item_name );
    if( @item == null ) {
      print("EQ ERROR: Getting Item From Factory Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Pickup_item'");
      return;
    }
    EQ::Item_functionality@ func = factory.Get_functionality( _item_name, EQ::Class(_carrier.get_u8("EQ This Class")));
    EQ::Item_data data( item, func, _variables );
    getRules().push("EQ-Items Storage-Array"+ player.getUsername(), @data );
  }
}//EQ



namespace EQ {
  void Equip_item( CBlob@ _this, EQ::Item_data@ _item ) { // Server & Local:
    if( @_item == null )
      return;
    print("EQ::Equip_item -> '"+ EQ::g_name_str[ _item.m_item.Get_name() ] );//
    // Geting All Of The Currently Equip Items:
    array< EQ::Item_data@ >@ equip_items = EQ::Get_equip_items( _this );
    // Geting All Of The Class's Slots:
    array< EQ::Class_slot@ >@ class_slots = EQ::Get_class_slots( _this );
    if(( @equip_items == null )||( @class_slots == null ))
      return;   
    // If The Item Is Already Equip This Number Is Not -1:
    s8 start = _item.m_equip_slot;
    s8 search = _item.m_equip_slot;
    // Looping Thru All Of The Class's Slots:
    for( u8 i = 0 ; i < equip_items.length() ; ++i ) {
      ++search;
      if( search >= equip_items.length())
	search = 0;
      // Slot Is Occupied:
      if( @equip_items[ search ] != null )
	continue;
      // Looping Thru All Of The Items's Slots To See If Any Fits The Class's Slot:      
      for( u8 j = 0 ; j < _item.m_item.Get_item_slots_length() ; ++j ) {	
	// Does The Item Fit/Match The Class Slot?:
	if( ! EQ::Class_slot_fits_item_slot( EQ::Class(_this.get_u8("EQ This Class")),
					     class_slots[ search ],
					     _item.m_item.Get_item_slot_at( j )))
	  continue;
	// A Matching Slot Was Found.
	// If The Item Was Already Equipt In A Other Slot, Remove It:
	if( start >= 0 ) {
	  // Calling 'on_unequip':
	  if( @_item.m_func.m_on_unequip_fptr != null )
	    _item.m_func.m_on_unequip_fptr( _this );
	  // Calling 'on_unequip_anim':
	  if( @_item.m_func.m_on_unequip_anim_fptr != null ) {
	    CSprite@ sprite = _this.getSprite();
	    if( @sprite == null ) {
	      print("EQ ERROR: Getting 'sprite' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Equip_item'");
	      return;
	    }
	    _item.m_func.m_on_unequip_anim_fptr( sprite, _this );
	  }
	  @equip_items[ start ] = null;
	}
	// Equipt The Item:
	_item.m_equip_slot = search;
	EQ::Set_equip_item( _this, search, _item );	
	if( @_item.m_func != null ) {
	  // Calling 'on_equip':
	  if( @_item.m_func.m_on_equip_fptr != null )
	    _item.m_func.m_on_equip_fptr( _this );
	  // Calling 'on_equip_anim':
	  if( @_item.m_func.m_on_equip_anim_fptr != null ) {
	    CSprite@ sprite = _this.getSprite();
	    if( @sprite == null ) {
	      print("EQ ERROR: Getting 'sprite' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Equip_item'");
	      return;
	    }
	    _item.m_func.m_on_equip_anim_fptr( sprite, _this );
	  }
	}
	// Congrats! The Item Is Equipt!
	print("EQ::Equip_item -> Congrats! The Item Is Equipt!" );//
	return;
      }//for
    }//for
  }


  
  void Unequip_item( CBlob@ _this, EQ::Item_data@ _item ) { // Server & Local:
    if( @_item == null )
      return;
    print("EQ::Unequip_item -> '"+ EQ::g_name_str[ _item.m_item.Get_name() ] );//
    // Remove Equip Item From Slot:
    if( ! EQ::Remove_equip_item( _this, _item ))
      return;
    // Unequipping The Item:
    _item.m_equip_slot = -1;
    if( @_item.m_func != null ) {
      // Calling 'on_unequip':
      if( @_item.m_func.m_on_unequip_fptr != null )
	_item.m_func.m_on_unequip_fptr( _this );
      // Calling 'on_unequip_anim':
      if( @_item.m_func.m_on_unequip_anim_fptr != null ) {
	CSprite@ sprite = _this.getSprite();
	if( @sprite == null ) {
	  print("EQ ERROR: Getting 'sprite' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Unequip_item'");
	  return;
	}
	_item.m_func.m_on_unequip_anim_fptr( sprite, _this );
      }
    }
  }
}//EQ



namespace EQ {
  void Drop_item( CBlob@ _caller, EQ::Item_data@ _item ) { // Server & Local:
    if( @_item == null ) {
      print("EQ ERROR: No 'Item_data': @_item == null! ->'"+ getCurrentScriptName() +"'->'EQ::Drop_item'");
      return;
    }
    print("EQ::Drop_item -> '"+ EQ::g_name_str[ _item.m_item.Get_name() ] );//
    EQ::Unequip_item( _caller, _item );
    // Remove Item From Starage:
    if( ! EQ::Remove_storage_item( _caller, _item )) {
      print("EQ ERROR: Faild To Remove Itme From Storage: "+ EQ::g_name_str[ _item.m_item.Get_name() ] +
	    "! ->'"+ getCurrentScriptName() +"'->'EQ::Drop_item'");
      return;
    }
    if( getNet().isServer()) { // Server Only:
      CBlob@ item_blob = server_CreateBlob( EQ::g_name_str[ _item.m_item.Get_name() ],
					    _caller.getTeamNum(),
					    _caller.getPosition());
      if( @item_blob == null ) {
	print("EQ ERROR: 'server_CreateBlob' Faild For Item: "+ EQ::g_name_str[ _item.m_item.Get_name() ] +
	      "! ->'"+ getCurrentScriptName() +"'->'EQ::Spawn_item_into_world'");
	return;
      }
      // Carry The EQ-Item When It's Dropped:
      CBlob@ carrying = _caller.getCarriedBlob();
      if( @carrying == null ) {
	if( _caller.server_Pickup( item_blob )) {
	  item_blob.Tag("EQ Last Carrier Can Pickup");
	  item_blob.Sync("EQ Last Carrier Can Pickup", true );
	}
      }
      // Giving The 'blob' All The Data:
      item_blob.Tag( "EQ");
      item_blob.Sync("EQ", true );
      item_blob.set_u16("EQ This Item", _item.m_item.Get_name());
      item_blob.Sync(   "EQ This Item", true );
      item_blob.set_CBitStream("EQ Variables", _item.m_variables );
      item_blob.Sync(          "EQ Variables", true );
      item_blob.set_u16("EQ Last Carrier", _caller.getNetworkID());
      item_blob.Sync(   "EQ Last Carrier", true );
    }     
  }
}//EQ
