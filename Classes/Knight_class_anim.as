
#include "KnightCommon.as"
#include "RunnerCommon.as"
#include "Knocked.as"
#include "EmotesCommon.as"

#include "Factory.as"
#include "Class_common.as"



namespace EQ {
  void Play_items_animation( CSprite@ _this, array< CSpriteLayer@ >&in _sprite_layers ) {
    for( int i = 0 ; i < _sprite_layers.length() ; ++i ) {
      if( @_sprite_layers[ i ] == null )
	continue;	
      // Check If The Overlayer Has The Animation That The Class Is Playing:
      Animation@ sl_anim = _sprite_layers[ i ].getAnimation( _this.animation.name );
      if( @sl_anim == null ) {
	// If Not, Copy It: (this happens once for each animation, the first time it plays)
	//print("!!!!!!!!!!!!! copy: "+ _this.animation.name );
	@sl_anim = _sprite_layers[ i ].addAnimation( _this.animation.name,
						     _this.animation.time,
						     _this.animation.loop );
	for( int i = 0 ; i < _this.animation.getFramesCount() ; ++i )
	  sl_anim.AddFrame( _this.animation.getFrame( i ));
      }
      // Make The EQ-Item Play The Same Animation As The Class Is Playing: 
      _sprite_layers[ i ].SetAnimation( _this.animation.name );
    }//for
  }
}//EQ



namespace EQ {
  void Set_Frame_Index_in_animation( array< CSpriteLayer@ >&in _sprite_layers, const int _frame ) {
    for( int i = 0 ; i < _sprite_layers.length() ; ++i ) {
      if( @_sprite_layers[ i ] != null )
	_sprite_layers[ i ].animation.SetFrameIndex( _frame );
    }//for
  }
  void Set_Frame_in_animation( array< CSpriteLayer@ >&in _sprite_layers, const int _frame ) {
    for( int i = 0 ; i < _sprite_layers.length() ; ++i ) {
      if( @_sprite_layers[ i ] != null )
	_sprite_layers[ i ].animation.frame = _frame;
    }//for
  }  

  
  
  void Set_fixed_frames( CBlob@ _blob, array< CSpriteLayer@ >&in _sprite_layers ) {
    KnightInfo@ knight;
    if (!_blob.get("knightInfo", @knight)) {
      return;
    }
    const u8 knocked = getKnocked(_blob);
    bool walking = (_blob.isKeyPressed(key_left) || _blob.isKeyPressed(key_right));
    bool inair = (!_blob.isOnGround() && !_blob.isOnLadder());
    Vec2f vel = _blob.getVelocity();
    if (_blob.hasTag("dead")) {
      if (vel.y < -1.0f)
	{
	  //_this.SetFrameIndex(1);
	  EQ::Set_Frame_Index_in_animation( _sprite_layers, 1 );
	}
      else if (vel.y > 1.0f)
	{
	  //_this.SetFrameIndex(3);
	  EQ::Set_Frame_Index_in_animation( _sprite_layers, 3 );
	}
      else
	{
	  //_this.SetFrameIndex(2);
	  EQ::Set_Frame_Index_in_animation( _sprite_layers, 2 );
	}
      return;
    }
    Vec2f vec;
    int direction = _blob.getAimDirection(vec);
    if (knocked > 0) {
    }
    else if (_blob.hasTag("seated")) {
    }
    else if (knight.state == KnightStates::shieldgliding) {
    }
    else if (knight.state == KnightStates::shielddropping) {
    }
    else if (knight.state == KnightStates::shielding)
      {
	if( ! walking ) {
	  if (direction == 1)
	    {
	      //_this.animation.frame = 2;
	      EQ::Set_Frame_in_animation( _sprite_layers, 2 );
	    }
	  else if (direction == -1)
	    {
	      if (vec.y > -0.97)
		{
		  //_this.animation.frame = 1;
		  EQ::Set_Frame_in_animation( _sprite_layers, 1 );
		}
	      else
		{
		  //_this.animation.frame = 3;
		  EQ::Set_Frame_in_animation( _sprite_layers, 3 );
		}
	    }
	  else
	    {
	      //_this.animation.frame = 0;
	      EQ::Set_Frame_in_animation( _sprite_layers, 0 );
	    }
	}
      }
    else if (knight.state == KnightStates::sword_drawn)
      {
	if (knight.swordTimer < KnightVars::slash_charge) {
	}
	else if (knight.swordTimer < KnightVars::slash_charge_level2)
	  {
	    //_this.animation.frame = 0;
	    EQ::Set_Frame_in_animation( _sprite_layers, 0 );
	  }
	else if (knight.swordTimer < KnightVars::slash_charge_limit)
	  {
	    //_this.animation.frame = 1;
	    EQ::Set_Frame_in_animation( _sprite_layers, 1 );
	  }
      }
    else if (knight.state == KnightStates::sword_cut_mid) {
    }
    else if (knight.state == KnightStates::sword_cut_mid_down) {
    }
    else if (knight.state == KnightStates::sword_cut_up) {
    }
    else if (knight.state == KnightStates::sword_cut_down) {
    }
    else if (knight.state == KnightStates::sword_power || knight.state == KnightStates::sword_power_super)
      {
	if (knight.swordTimer <= 1) {
	  //_this.animation.SetFrameIndex(0);
	  EQ::Set_Frame_Index_in_animation( _sprite_layers, 0 );
	}
      }
    else if (inair)
      {
	RunnerMoveVars@ moveVars;
	if (!_blob.get("moveVars", @moveVars)) {
	  return;
	}
	f32 vy = vel.y;
	if (vy < -0.0f && moveVars.walljumped) {
	}
	else {
	  if (vy < -1.5)
	    {
	      //_this.animation.frame = 0;
	      EQ::Set_Frame_in_animation( _sprite_layers, 0 );
	    }
	  else if (vy > 1.5)
	    {
	      //_this.animation.frame = 2;
	      EQ::Set_Frame_in_animation( _sprite_layers, 2 );
	    }
	  else
	    {
	      //_this.animation.frame = 1;
	      EQ::Set_Frame_in_animation( _sprite_layers, 1 );
	    }
	}
      }
  }
}//EQ



void onTick( CSprite@ _this ) {
  CBlob@ blob = _this.getBlob();
  if( @blob == null ) {
    print("EQ ERROR: Getting 'Blob' Faild! ->'"+ getCurrentScriptName() +"'->'onTick'");
    return;
  }
  if(( @blob.getPlayer() == null )||( ! blob.hasTag('EQ'))) // Bot.
    return;
  array< EQ::Item_data@ >@ equip_items = EQ::Get_equip_items( blob );  
  array< CSpriteLayer@ > sprite_layers;
  for( u8 i = 0 ; i < equip_items.length() ; ++i ) {
    if( @equip_items[i] == null )
      continue;
    if( @equip_items[i].m_func == null )
      continue;
    // If The EQ-Item's 'on_tick_anim' Function Returns True,
    // Then The EQ-Item's Animation Will Follow The Class Animation.
    bool do_play = true;
    // Call EQ-Item's 'on_tick_anim' Function:
    if( @equip_items[i].m_func.m_on_tick_anim_fptr != null )
      do_play = equip_items[i].m_func.m_on_tick_anim_fptr( _this, blob );
    if( do_play ) {
      CSpriteLayer@ sl = _this.getSpriteLayer( EQ::g_name_str[ equip_items[i].m_item.Get_name() ]);
      if( @sl == null )
	continue;   
      sprite_layers.insertLast( @sl );
    }
  }//for
  // Make EQ-Items Follow The Class Animation:
  EQ::Play_items_animation( _this, sprite_layers );
  EQ::Set_fixed_frames( blob, sprite_layers );
  
  /*
  // TEMP:
  for( int i = 0 ; i < sprite_layers.length() ; ++i ) {
    if( _this.animation.frame > 0 || sprite_layers[ i ].animation.frame > 0 ) {
      printInt("Class: ", _this.animation.frame );
      for( int j = 0 ; j < sprite_layers.length() ; ++j )
	printInt("Item:  ", sprite_layers[ j ].animation.frame );
      print(" ");
      break;
    }
  }//for
  */
}
