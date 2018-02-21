


namespace EQ {
  void Serialize_storage_array_to_sync( CRules@ _this, CPlayer@ _local_player ) { // Server Only:
    //print("EQ::Sync_storage_array_serialize()");//
    CBitStream params;
    int player_count = getPlayerCount();
    params.write_u8( EQ::Cmds::NEW_PLAYER );
    params.write_u16( _local_player.getNetworkID());
    params.write_u8( player_count - 1 );
    // Loop Through All The Players:
    for( int i = 0 ; i < player_count ; ++i ) {
      CPlayer@ player = getPlayer( i );
      if(( @player == @_local_player )||( @player == null )) {
	continue;
      }
      // Get Player's Storage Array:
      array< EQ::Item_data@ >@ storage_array;
      getRules().get("EQ-Items Storage-Array"+ player.getUsername(), @storage_array );
      if( @storage_array == null ) {
	print("EQ ERROR: Getting 'storage_array' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Serialize_storage_array_to_sync'");
	continue;
      }
      CBitStream stream;
      stream.write_u16( player.getNetworkID());
      // Loop Through All Of The Player's EQ-Items:
      for( u16 j = 0 ; j < storage_array.length() ; ++j ) {
	EQ::Item_data@ data = storage_array[ j ];
	if( @data == null ) {
	  continue;
	}
	if( @data.m_item == null ) {
	  print("EQ ERROR: 'data.m_item' == null! ->'"+ getCurrentScriptName() +"'->'EQ::Serialize_storage_array_to_sync'");
	  printInt("          j: ", j );
	  continue;
	}
	// Serialize The EQ-Item:
	EQ::Serialize_item( data, stream );
      }//for
      params.write_CBitStream( stream );
    }//for
    _this.SendCommand( _this.getCommandID("EQ-CommandID"), params, _local_player );
  }


  
  void Unserialize_storage_array_after_sync( CRules@ _this, CPlayer@ _local_player, CBitStream@ _params ) { // Local Only:
    //print("EQ::Sync_storage_array_unserialize()");//
    u8 player_count = _params.read_u8();    
    for( u8 i = 0 ; i < player_count ; ++i ) {
      //print("- - - - - - - - - - - - - - - Here Is Player!");//
      CBitStream stream;
      if( ! _params.saferead_CBitStream( stream )) {
	print("EQ ERROR: Data Stream Corrupted, Getting 'stream' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Unserialize_storage_array_after_sync'");
	return;
      }
      // Resteting The Bit Stream, So It Starts Reading From The Begining Of The Stream:
      stream.ResetBitIndex();
      u16 net_id;
      if( ! stream.saferead_u16( net_id )) {
	print("EQ ERROR: Data Stream Corrupted, Getting 'net_id' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Unserialize_storage_array_after_sync'");
	return;
      }
      CPlayer@ player = getPlayerByNetworkId( net_id );
      if( @player == null ) {
	print("EQ ERROR: Getting 'player' Faild! ->'"+ getCurrentScriptName() +"'->'EQ::Unserialize_storage_array_after_sync'");
	return;
      }
      // Give All The Other Players Their Unique 'storage_array':
      array< EQ::Item_data@ > storage_array;
      _this.set("EQ-Items Storage-Array"+ player.getUsername(), storage_array );
      // Unserialize All The EQ-Item:
      while( ! stream.isBufferEnd()) {
	//print(" ... Unserializeing EQ_items.");//
	EQ::Item_data data( null, null, null );
	EQ::Unserialize_item( player.getBlob(), data, stream );
	getRules().push("EQ-Items Storage-Array"+ player.getUsername(), @data );
	if( data.m_equip_slot > -1 )
	  EQ::Set_equip_item( player.getBlob(), data.m_equip_slot, data );
      }//while
    }//for
  }
}//EQ
