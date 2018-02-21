


namespace EQ {
  void Serialize_item( EQ::Item_data@ _item_data, CBitStream@ _stream ) {
    if( @_item_data == null )
      return;
    _stream.write_u16( _item_data.m_item.Get_name()); //   1: write_u16.
    _stream.write_s8( _item_data.m_equip_slot ); //        2: write_s8.
    _stream.write_CBitStream( _item_data.m_variables ); // 3: write_CBitStream.
  }


  
  bool Unserialize_item( CBlob@ _this, EQ::Item_data&inout _item_data, CBitStream@ _stream ) {
    FACTORY::Items@ factory;
    getRules().get("factory", @factory );
    if( @factory == null ) {
      print("EQ ERROR: Getting Factory Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Unserialize'");
      return false;
    }
    // Get 'item_name', This Must Be In The Stream:
    u16 item_name;
    if( ! _stream.saferead_u16( item_name )) { //        1: read_u16.
      print("EQ ERROR: Data Stream Corrupted, Getting 'item_name' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Unserialize_item'");
      return false;
    }
    @_item_data.m_item = @factory.Get_item( EQ::Name(item_name) );
    if( @_item_data.m_item == null ) {
      print("EQ ERROR: Getting Item From Factory Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Unserialize_item'");
      return false;
    }
    @_item_data.m_func = @factory.Get_functionality( EQ::Name(item_name), EQ::Class(_this.get_u8("EQ This Class")));
    // Get 'equip_slot', If It's In The Stream:
    s8 equip_slot;
    if( ! _stream.saferead_s8( equip_slot )) { //        2: read_s8.
      print("EQ ERROR: Data Stream Corrupted, Getting 'equip_slot' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Unserialize_item'");
      return false;
    }
    _item_data.m_equip_slot = equip_slot;
    // Get 'variables', If It's In The Stream:
    CBitStream variables;
    if( ! _stream.saferead_CBitStream( variables )) { // 3: read_CBitStream.
      print("EQ ERROR: Data Stream Corrupted, Getting 'variables' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Unserialize_item'");
      return false;
    }
    @_item_data.m_variables = @variables;
    return true;
  }  

  

  /*
  void Serialize( array< EQ::Item_data@ >@ _data_array, CBitStream@ _stream ) {
    for( uint i = 0 ; i < _data_array.length() ; ++i ) {
      if( @_data_array[ i ] == null ) {
	print("EQ ERROR: Element In '_data_array' == null! ->'"+ getCurrentScriptName() +"'->'EQ::Serialize'");
	printInt("          i: ", i );
	return;
      }
      //_stream.write_bool( _data_array[ i ].m_fits_filter );
      //_stream.write_u8( _data_array[ i ].m_equip_slot );
      //_stream.write_f32( _data_array[ i ].m_sorting_num );
      _stream.write_u16( _data_array[ i ].m_item.Get_name());
                              //printInt("222222222222 m_variables size: ", _data_array[ i ].m_variables.Length());
      _stream.write_CBitStream( _data_array[ i ].m_variables );
    }//for
  }

  bool Unserialize( CBlob@ _this, array< EQ::Item_data@ >@ _data_array, CBitStream@ _stream ) {
    FACTORY::Items@ factory;
    getRules().get("factory", @factory );
    if( @factory == null ) {
      print("EQ ERROR: Getting Factory Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Unserialize'");
      return false;
    }
                      //printInt("444444444444 stream size: ", _stream.Length());	  
    _stream.ResetBitIndex();
    while( ! _stream.isBufferEnd()) {
      //if( ! _stream.saferead_bool( data.m_fits_filter ))  return false;
      //if( ! _stream.saferead_u8( data.m_equip_slot ))  return false;
      //if( ! _stream.saferead_f32( data.m_sorting_num ))  return false;
      EQ::Item_data data;
      u16 item_type;
      CBitStream variables;
      if( ! _stream.saferead_u16( item_type ))
	return false;
      if( ! _stream.saferead_CBitStream( variables ))
	return false;
                                 //printInt(" 6 !!!!!!! m_variables size: ", data.m_variables.Length());
      @data.m_variables = @variables;
      @data.m_item = factory.Get_item( EQ::Name(item_type) );
      if( @data.m_item == null ) {
	print("EQ ERROR: Getting Item From Factory Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Unserialize'");
	return false;
      }
                           //printInt("444444444444 data: ", data.m_item.Get_name());
      @data.m_func = factory.Get_functionality( EQ::Name(item_type), EQ::Class(_this.get_u8("EQ This Class")));     
      _data_array.insertLast( @data );
    }//while
    print(" done !!!!!!!");
    return true;
  }
  */
}//EQ



namespace EQ {
  class Item_data {
    Item_data( EQ::Item@ _item, EQ::Item_functionality@ _func, CBitStream@ _variables ) {
      m_fits_filter = false;
      m_equip_slot =  -1;
      m_sorting_num = -1;
      @m_item =       @_item;
      @m_func =       @_func;
      @m_variables =  @_variables;
    }
    EQ::Item_data@ opAssign( const EQ::Item_data&in _other) {
      m_fits_filter = _other.m_fits_filter;
      m_equip_slot =  _other.m_equip_slot;
      m_sorting_num = _other.m_sorting_num;
      @m_item =       @_other.m_item;
      @m_func =       @_other.m_func;
      @m_variables =  @_other.m_variables;
      return this;
    }
    int opCmp( const EQ::Item_data&in _other ) {
      if( m_sorting_num > _other.m_sorting_num )
	return 1;
      else if( m_sorting_num < _other.m_sorting_num )
	return -1;
      return 0;
    }
    void Set_sorting_number( float _sorting_num ) {
      m_sorting_num = _sorting_num;
    }
    bool m_fits_filter;
    s8 m_equip_slot;
    float m_sorting_num;
    EQ::Item@ m_item;
    EQ::Item_functionality@ m_func;
    CBitStream@ m_variables;
  }
}//EQ
