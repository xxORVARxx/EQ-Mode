
#include "EQ_Factory.as"
#include "EQ_Items_common.as"



const EQ::Name g_this_name = EQ::Name::WROUGHT_IRON_SCALEMAIL; // <------------------
const string g_this_name_str = EQ::g_name_str[ g_this_name ];



namespace EQ {
  EQ::Item@ Item_customization() {
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    array< EQ::Item_slot > item_slot = { EQ::Item_slot( EQ::Class::KNIGHT,  EQ::Slot::CHEST ),
					 EQ::Item_slot( EQ::Class::BUILDER, EQ::Slot::CHEST ),
					 EQ::Item_slot( EQ::Class::ARCHER,  EQ::Slot::CHEST )};
    array< EQ::Type > type = { EQ::Type::ARMOUR, EQ::Type::SCALEMAIL };
    Money price = Gold( 002 ) + Silver( 499 ) + Bronze( 900 );
    EQ::Rarity rarity = EQ::Rarity::LOW_QUALITY;
    EQ::Material material = EQ::Material::WROUGHT_IRON;
    // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    
    EQ::Item item( g_this_name, price, rarity, material, item_slot, type );
    return item;
  }
}//EQ

float EQ_Make_sorting_number( CBlob@ _blob, EQ::Item@ m_item, CBitStream@ _variables ) {
  // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  return -1.0;
  // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}



/*
#define HAS_VARIABLES
void EQ_New_variables( CBlob@ _blob, CBlob@ _owner, CBitStream&inout _variables ) {
}

string EQ_Print_variables( CBlob@ _blob, EQ::Item@ m_item, CBitStream@ _variables, string&in _str ) {  
  return _str;
}
*/



// ---------------------------------------------------------------
// Function Hooks For EQ-Item Equip By Knight:
//*
#define ON_EQUIP_ANIM_KNIGHT
void onEquip_anim_knight( CSprite@ _this, CBlob@ _blob ) {
  print("onEquip_anim_knight! "+ g_this_name_str );
}//*/

/*
#define ON_UNEQUIP_ANIM_KNIGHT
void onUnequip_anim_knight( CSprite@ _this, CBlob@ _blob ) {
  print("onUnequip_anim_knight! "+ g_this_name_str );
}*/

//*
#define ON_TICK_ANIM_KNIGHT
bool onTick_anim_knight( CSprite@ _this, CBlob@ _blob ) {
  //print("onTick_anim_knight! "+ g_this_name_str );
  return true;
}//*/

/*
#define ON_EQUIP_KNIGHT
void onEquip_knight( CBlob@ _this ) {
  print("onEquip_knight! "+ g_this_name_str );
}*/

/*
#define ON_UNEQUIP_KNIGHT
void onUnequip_knight( CBlob@ _this ) {
  print("onUnequip_knight! "+ g_this_name_str );
}*/

/*
#define ON_TICK_KNIGHT
void onTick_knight( CBlob@ _this ) {
  print("onTick_knight! "+ g_this_name_str );
}*/

/*
#define ON_HIT_BLOB_KNIGHT
void onHitBlob_knight( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, CBlob@ _hit_blob, u8 _custom_data ) {
  print("onHitBlob_knight! "+ g_this_name_str );
}*/

/*
#define ON_HIT_KNIGHT
f32 onHit_knight( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, CBlob@ _hitter_blob, u8 _custom_data ) {
  print("onHit_knight! "+ g_this_name_str );
  return _damage;
}*/

/*
#define ON_HEALTH_CHANGE_KNIGHT
void onHealthChange_knight( CBlob@ _this, f32 _old_health ) {
  print("onHealthChange_knight! "+ g_this_name_str );
}*/

/*
#define ON_COLLISION_KNIGHT
void onCollision_knight( CBlob@ _this, CBlob@ _blob, bool _solid, Vec2f _normal, Vec2f _point_1, Vec2f _point_2 ) {
  print("onCollision_knight! "+ g_this_name_str );
}*/

/*
#define ON_END_COLLISION_KNIGHT
void onEndCollision_knight( CBlob@ _this, CBlob@ _blob ) {
  print("onEndCollision_knight! "+ g_this_name_str );
}*/

/*
#define DOES_COLLIDE_WITH_BLOB_KNIGHT
bool doesCollideWithBlob_knight( CBlob@ _this, CBlob@ _blob ) {
  print("doesCollideWithBlob_knight! "+ g_this_name_str );
  return false;
}*/

/*
#define ON_HIT_MAP_KNIGHT
void onHitMap_knight( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, u8 _custom_data ) {
  print("onHitMap_knight! "+ g_this_name_str );
}*/

/*
#define ON_DIE_KNIGHT
void onDie_knight( CBlob@ this ) {
  print("onDie_knight! "+ g_this_name_str );
}*/



// ---------------------------------------------------------------
// Function Hooks For EQ-Item Equip By Archer:
/*
#define ON_EQUIP_ANIM_ARCHER
void onEquip_anim_archer( CSprite@ _this, CBlob@ _blob ) {
  print("onEquip_anim_archer! "+ g_this_name_str );
}*/

/*
#define ON_UNEQUIP_ANIM_ARCHER
void onUnequip_anim_archer( CSprite@ _this, CBlob@ _blob ) {
  print("onUnequip_anim_archer! "+ g_this_name_str );
}*/

/*
#define ON_TICK_ANIM_ARCHER
bool onTick_anim_archer( CSprite@ _this, CBlob@ _blob ) {
  print("onTick_anim_archer! "+ g_this_name_str );
  return true;
}*/

/*
#define ON_EQUIP_ARCHER
void onEquip_archer( CBlob@ _this ) {
  print("onEquip_archer! "+ g_this_name_str );
}*/

/*
#define ON_UNEQUIP_ARCHER
void onUnequip_archer( CBlob@ _this ) {
  print("onUnequip_archer! "+ g_this_name_str );
}*/

/*
#define ON_TICK_ARCHER
void onTick_archer( CBlob@ _this ) {
  print("onTick_archer! "+ g_this_name_str );
}*/

/*
#define ON_HIT_BLOB_ARCHER
void onHitBlob_archer( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, CBlob@ _hit_blob, u8 _custom_data ) {
  print("onHitBlob_archer! "+ g_this_name_str );
}*/

/*
#define ON_HIT_ARCHER
f32 onHit_archer( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, CBlob@ _hitter_blob, u8 _custom_data ) {
  print("onHit_archer! "+ g_this_name_str );
  return _damage;
}*/

/*
#define ON_HEALTH_CHANGE_ARCHER
void onHealthChange_archer( CBlob@ _this, f32 _old_health ) {
  print("onHealthChange_archer! "+ g_this_name_str );
}*/

/*
#define ON_COLLISION_ARCHER
void onCollision_archer( CBlob@ _this, CBlob@ _blob, bool _solid, Vec2f _normal, Vec2f _point_1, Vec2f _point_2 ) {
  print("onCollision_archer! "+ g_this_name_str );
}*/

/*
#define ON_END_COLLISION_ARCHER
void onEndCollision_archer( CBlob@ _this, CBlob@ _blob ) {
  print("onEndCollision_archer! "+ g_this_name_str );
}*/

/*
#define DOES_COLLIDE_WITH_BLOB_ARCHER
bool doesCollideWithBlob_archer( CBlob@ _this, CBlob@ _blob ) {
  print("doesCollideWithBlob_archer! "+ g_this_name_str );
  return false;
}*/

/*
#define ON_HIT_MAP_ARCHER
void onHitMap_archer( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, u8 _custom_data ) {
  print("onHitMap_archer! "+ g_this_name_str );
}*/

/*
#define ON_DIE_ARCHER
void onDie_archer( CBlob@ this ) {
  print("onDie_archer! "+ g_this_name_str );
}*/



// ---------------------------------------------------------------
// Function Hooks For EQ-Item Equip By Builder:
/*
#define ON_EQUIP_ANIM_BUILDER
void onEquip_anim_builder( CSprite@ _this, CBlob@ _blob ) {
  print("onEquip_anim_builder! "+ g_this_name_str );
}*/

/*
#define ON_UNEQUIP_ANIM_BUILDER
void onUnequip_anim_builder( CSprite@ _this, CBlob@ _blob ) {
  print("onUnequip_anim_builder! "+ g_this_name_str );
}*/

/*
#define ON_TICK_ANIM_BUILDER
bool onTick_anim_builder( CSprite@ _this, CBlob@ _blob ) {
  print("onTick_anim_builder! "+ g_this_name_str );
  return true;
}*/

/*
#define ON_EQUIP_BUILDER
void onEquip_builder( CBlob@ _this ) {
  print("onEquip_builder! "+ g_this_name_str );
}*/

/*
#define ON_UNEQUIP_BUILDER
void onUnequip_builder( CBlob@ _this ) {
  print("onUnequip_builder! "+ g_this_name_str );
}*/

/*
#define ON_TICK_BUILDER
void onTick_builder( CBlob@ _this ) {
  print("onTick_builder! "+ g_this_name_str );
}*/

/*
#define ON_HIT_BLOB_BUILDER
void onHitBlob_builder( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, CBlob@ _hit_blob, u8 _custom_data ) {
  print("onHitBlob_builder! "+ g_this_name_str );
}*/

/*
#define ON_HIT_BUILDER
f32 onHit_builder( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, CBlob@ _hitter_blob, u8 _custom_data ) {
  print("onHit_builder! "+ g_this_name_str );
  return _damage;
}*/

/*
#define ON_HEALTH_CHANGE_BUILDER
void onHealthChange_builder( CBlob@ _this, f32 _old_health ) {
  print("onHealthChange_builder! "+ g_this_name_str );
}*/

/*
#define ON_COLLISION_BUILDER
void onCollision_builder( CBlob@ _this, CBlob@ _blob, bool _solid, Vec2f _normal, Vec2f _point_1, Vec2f _point_2 ) {
  print("onCollision_builder! "+ g_this_name_str );
}*/

/*
#define ON_END_COLLISION_BUILDER
void onEndCollision_builder( CBlob@ _this, CBlob@ _blob ) {
  print("onEndCollision_builder! "+ g_this_name_str );
}*/

/*
#define DOES_COLLIDE_WITH_BLOB_BUILDER
bool doesCollideWithBlob_builder( CBlob@ _this, CBlob@ _blob ) {
  print("doesCollideWithBlob_builder! "+ g_this_name_str );
  return false;
}*/

/*
#define ON_HIT_MAP_BUILDER
void onHitMap_builder( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, u8 _custom_data ) {
  print("onHitMap_builder! "+ g_this_name_str );
}*/

/*
#define ON_DIE_BUILDER
void onDie_builder( CBlob@ this ) {
  print("onDie_builder! "+ g_this_name_str );
}*/
