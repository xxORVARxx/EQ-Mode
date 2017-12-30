
#include "Factory.as"
#include "Class_common.as"



void onTick( CBlob@ _this ) {  
  if( !_this.exists("EQ This Class")) {
    print("EQ ERROR: 'EQ This Class' Does Not Exist! ->'"+ getCurrentScriptName() +"'->'onTick'");
    return;
  }
  FACTORY::Items@ factory;
  getRules().get("factory", @factory );
  if( @factory == null ) {
    print("EQ ERROR: Getting Factory Faild! ->'"+ getCurrentScriptName() +"'->'onTick'");
    return;
  }
  // Calling The 'on_tick' Function For All Equip EQ-Items:
  u8 number_of_slots = _this.get_u8("EQ number of slots");
  for( u8 i = 0 ; i < number_of_slots ; ++i ) {
    EQ::Name slot_item_name = EQ::Get_slot_item( _this, number_of_slots, i );
    if( slot_item_name != EQ::Name::NIL )
      continue;
    EQ::Item_functionality@ func = factory.Get_functionality( slot_item_name, EQ::Class(_this.get_u8("EQ This Class")));
    if( @func == null )
      continue;
    if( @func.m_on_tick_fptr == null )
      continue;
    func.m_on_tick_fptr( _this );
  }//for
}



void onHitBlob( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, CBlob@ _hit_blob, u8 _custom_data ) {
  if( !_this.exists("EQ This Class")) {
    print("EQ ERROR: 'EQ This Class' Does Not Exist! ->'"+ getCurrentScriptName() +"'->'onHitBlob'");
    return;
  }
  FACTORY::Items@ factory;
  getRules().get("factory", @factory );
  if( @factory == null ) {
    print("EQ ERROR: Getting Factory Faild! ->'"+ getCurrentScriptName() +"'->'onHitBlob'");
    return;
  }
  u8 number_of_slots = _this.get_u8("EQ number of slots");
  for( u8 i = 0 ; i < number_of_slots ; ++i ) {
    EQ::Name slot_item_name = EQ::Get_slot_item( _this, number_of_slots, i );
    if( slot_item_name != EQ::Name::NIL )
      continue;
    EQ::Item_functionality@ func = factory.Get_functionality( slot_item_name, EQ::Class(_this.get_u8("EQ This Class")));
    if( @func == null )
      continue;
    if( @func.m_on_hit_blob_fptr == null )
      continue;
    func.m_on_hit_blob_fptr( _this, _world_point, _velocity, _damage, _hit_blob, _custom_data );
  }//for
}



f32 onHit( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, CBlob@ _hitter_blob, u8 _custom_data ) {
  return _damage;
}



void onHealthChange( CBlob@ _this, f32 _old_health ) {
  
}



void onCollision( CBlob@ _this, CBlob@ _blob, bool _solid, Vec2f _normal, Vec2f _point_1, Vec2f _point_2 ) {
  
}



void onEndCollision( CBlob@ _this, CBlob@ _blob ) {
  
}



bool doesCollideWithBlob( CBlob@ _this, CBlob@ _blob ) {
  return false;
}



void onHitMap( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, u8 _custom_data ) {
  
}



void onDie( CBlob@ this ) {
  
}

