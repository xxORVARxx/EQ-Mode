
#include "EQ_Factory.as"
#include "EQ_Class_common.as"



void onTick( CBlob@ _this ) {
  // Geting All Of The Currently Equip Items:
  array< EQ::Item_data@ >@ equip_items = EQ::Get_equip_items( _this );
  // Geting All Of The Class's Slots:
  array< EQ::Class_slot@ >@ class_slots = EQ::Get_class_slots( _this );
  if(( @equip_items == null )||( @class_slots == null ))
    return;
  for( u8 i = 0 ; i < equip_items.length() ; ++i ) {
    if( @equip_items[i] == null )
      continue;
    if( @equip_items[i].m_func == null )
      continue;
    if( @equip_items[i].m_func.m_on_tick_fptr == null )
      continue;
    // Calling The 'on_tick' Function For All Equip EQ-Items:
    equip_items[i].m_func.m_on_tick_fptr( _this, equip_items[i], class_slots[i].m_slot );
  }//for
}



void onHitBlob( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, CBlob@ _hit_blob, u8 _custom_data ) {
  // Geting All Of The Currently Equip Items:
  array< EQ::Item_data@ >@ equip_items = EQ::Get_equip_items( _this );
  // Geting All Of The Class's Slots:
  array< EQ::Class_slot@ >@ class_slots = EQ::Get_class_slots( _this );
  if(( @equip_items == null )||( @class_slots == null ))
    return;
  for( u8 i = 0 ; i < equip_items.length() ; ++i ) {
    if( @equip_items[i] == null )
      continue;
    if( @equip_items[i].m_func == null )
      continue;
    if( @equip_items[i].m_func.m_on_hit_blob_fptr == null )
      continue;
    // Calling The 'on_Hit_Blob' Function For All Equip EQ-Items:
    equip_items[i].m_func.m_on_hit_blob_fptr( _this, _world_point, _velocity, _damage, _hit_blob, _custom_data, equip_items[i], class_slots[i].m_slot );
  }//for
}



f32 onHit( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, CBlob@ _hitter_blob, u8 _custom_data ) {
  // Geting All Of The Currently Equip Items:
  array< EQ::Item_data@ >@ equip_items = EQ::Get_equip_items( _this );
  // Geting All Of The Class's Slots:
  array< EQ::Class_slot@ >@ class_slots = EQ::Get_class_slots( _this );
  if(( @equip_items == null )||( @class_slots == null ))
    return _damage;
  f32 damage = 0;
  for( u8 i = 0 ; i < equip_items.length() ; ++i ) {
    if( @equip_items[i] == null )
      continue;
    if( @equip_items[i].m_func == null )
      continue;
    if( @equip_items[i].m_func.m_on_hit_fptr == null )
      continue;
    // Calling The 'on_Hit' Function For All Equip EQ-Items:
    damage += equip_items[i].m_func.m_on_hit_fptr( _this, _world_point, _velocity, _damage, _hitter_blob, _custom_data, equip_items[i], class_slots[i].m_slot );
  }//for
  return _damage + damage;
}



void onHealthChange( CBlob@ _this, f32 _old_health ) {
  // Geting All Of The Currently Equip Items:
  array< EQ::Item_data@ >@ equip_items = EQ::Get_equip_items( _this );
  // Geting All Of The Class's Slots:
  array< EQ::Class_slot@ >@ class_slots = EQ::Get_class_slots( _this );
  if(( @equip_items == null )||( @class_slots == null ))
    return;
  for( u8 i = 0 ; i < equip_items.length() ; ++i ) {
    if( @equip_items[i] == null )
      continue;
    if( @equip_items[i].m_func == null )
      continue;
    if( @equip_items[i].m_func.m_on_health_change_fptr == null )
      continue;
    // Calling The 'on_health_change' Function For All Equip EQ-Items:
    equip_items[i].m_func.m_on_health_change_fptr( _this, _old_health, equip_items[i], class_slots[i].m_slot );
  }//for
}



void onCollision( CBlob@ _this, CBlob@ _blob, bool _solid, Vec2f _normal, Vec2f _point_1, Vec2f _point_2 ) {
  // Geting All Of The Currently Equip Items:
  array< EQ::Item_data@ >@ equip_items = EQ::Get_equip_items( _this );
  // Geting All Of The Class's Slots:
  array< EQ::Class_slot@ >@ class_slots = EQ::Get_class_slots( _this );
  if(( @equip_items == null )||( @class_slots == null ))
    return;
  for( u8 i = 0 ; i < equip_items.length() ; ++i ) {
    if( @equip_items[i] == null )
      continue;
    if( @equip_items[i].m_func == null )
      continue;
    if( @equip_items[i].m_func.m_on_collision_fptr == null )
      continue;
    // Calling The 'on_collision' Function For All Equip EQ-Items:
    equip_items[i].m_func.m_on_collision_fptr( _this, _blob, _solid, _normal, _point_1, _point_2, equip_items[i], class_slots[i].m_slot );
  }//for
}



void onEndCollision( CBlob@ _this, CBlob@ _blob ) {
  // Geting All Of The Currently Equip Items:
  array< EQ::Item_data@ >@ equip_items = EQ::Get_equip_items( _this );
  // Geting All Of The Class's Slots:
  array< EQ::Class_slot@ >@ class_slots = EQ::Get_class_slots( _this );
  if(( @equip_items == null )||( @class_slots == null ))
    return;
  for( u8 i = 0 ; i < equip_items.length() ; ++i ) {
    if( @equip_items[i] == null )
      continue;
    if( @equip_items[i].m_func == null )
      continue;
    if( @equip_items[i].m_func.m_on_end_collision_fptr == null )
      continue;
    // Calling The 'on_end_collision' Function For All Equip EQ-Items:
    equip_items[i].m_func.m_on_end_collision_fptr( _this, _blob, equip_items[i], class_slots[i].m_slot );
  }//for
}



/* // DO NOT USE THIS FUNCTION!
bool doesCollideWithBlob( CBlob@ _this, CBlob@ _blob ) {
  // Geting All Of The Currently Equip Items:
  array< EQ::Item_data@ >@ equip_items = EQ::Get_equip_items( _this );
  // Geting All Of The Class's Slots:
  array< EQ::Class_slot@ >@ class_slots = EQ::Get_class_slots( _this );
  if(( @equip_items == null )||( @class_slots == null ))
    return;
  for( u8 i = 0 ; i < equip_items.length() ; ++i ) {
    if( @equip_items[i] == null )
      continue;
    if( @equip_items[i].m_func == null )
      continue;
    if( @equip_items[i].m_func.m_does_collide_with_blob_fptr == null )
      continue;
    // Calling The 'does_collide_with_blob' Function For All Equip EQ-Items:
    equip_items[i].m_func.m_does_collide_with_blob_fptr( _this, equip_items[i], class_slots[i].m_slot )
  }//for 
  return true; // /Entities/Characters/Scripts/RunnerCollision.as
}
*/



void onHitMap( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, u8 _custom_data ) {
  // Geting All Of The Currently Equip Items:
  array< EQ::Item_data@ >@ equip_items = EQ::Get_equip_items( _this );
  // Geting All Of The Class's Slots:
  array< EQ::Class_slot@ >@ class_slots = EQ::Get_class_slots( _this );
  if(( @equip_items == null )||( @class_slots == null ))
    return;
  for( u8 i = 0 ; i < equip_items.length() ; ++i ) {
    if( @equip_items[i] == null )
      continue;
    if( @equip_items[i].m_func == null )
      continue;
    if( @equip_items[i].m_func.m_on_hit_map_fptr == null )
      continue;
    // Calling The 'on_hit_map' Function For All Equip EQ-Items:
    equip_items[i].m_func.m_on_hit_map_fptr( _this, _world_point, _velocity, _damage, _custom_data, equip_items[i], class_slots[i].m_slot );
  }//for
}



void onDie( CBlob@ _this ) {
  // Geting All Of The Currently Equip Items:
  array< EQ::Item_data@ >@ equip_items = EQ::Get_equip_items( _this );
  // Geting All Of The Class's Slots:
  array< EQ::Class_slot@ >@ class_slots = EQ::Get_class_slots( _this );
  if(( @equip_items == null )||( @class_slots == null ))
    return;
  for( u8 i = 0 ; i < equip_items.length() ; ++i ) {
    if( @equip_items[i] == null )
      continue;
    if( @equip_items[i].m_func == null )
      continue;
    if( @equip_items[i].m_func.m_on_die_fptr == null )
      continue;
    // Calling The 'on_die' Function For All Equip EQ-Items:
    equip_items[i].m_func.m_on_die_fptr( _this, equip_items[i], class_slots[i].m_slot );
  }//for
}

