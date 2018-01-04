


namespace EQ {
  // Defining a Function Signatures For Function Handles/Pointers:
  funcdef float Make_sorting_number_fptr( CBlob@ _blob, EQ::Item@ m_item, CBitStream@ _variables );
  
  funcdef void New_variables_fptr( CBlob@ _blob, CBlob@ _owner, CBitStream&inout _variables );
  funcdef string Print_variables_fptr( CBlob@ _blob, EQ::Item@ m_item, CBitStream@ _variables, string&in _str );
  
  funcdef void On_equip_anim_fptr( CSprite@ _this, CBlob@ _blob );
  funcdef void On_unequip_anim_fptr( CSprite@ _this, CBlob@ _blob );
  funcdef bool On_tick_anim_fptr( CSprite@ _this, CBlob@ _blob );
  
  funcdef void On_equip_fptr( CBlob@ _this );
  funcdef void On_unequip_fptr( CBlob@ _this );
  funcdef void On_tick_fptr( CBlob@ _this, EQ::Item_data@ _item_data, EQ::Slot _slot );
  funcdef void On_hit_blob_fptr( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, CBlob@ _hit_blob, u8 _custom_data, EQ::Item_data@ _item_data, EQ::Slot _slot );
  funcdef  f32 On_hit_fptr( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, CBlob@ _hitter_blob, u8 _custom_data, EQ::Item_data@ _item_data, EQ::Slot _slot );
  funcdef void On_health_change_fptr( CBlob@ _this, f32 _old_health, EQ::Item_data@ _item_data, EQ::Slot _slot );
  funcdef void On_collision_fptr( CBlob@ _this, CBlob@ _blob, bool _solid, Vec2f _normal, Vec2f _point_1, Vec2f _point_2, EQ::Item_data@ _item_data, EQ::Slot _slot );
  funcdef void On_end_collision_fptr( CBlob@ _this, CBlob@ _blob, EQ::Item_data@ _item_data, EQ::Slot _slot );
  funcdef bool Does_collide_with_blob_fptr( CBlob@ _this, CBlob@ _blob, EQ::Item_data@ _item_data, EQ::Slot _slot );
  funcdef void On_hit_map_fptr( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, u8 _custom_data, EQ::Item_data@ _item_data, EQ::Slot _slot );
  funcdef void On_die_fptr( CBlob@ this, EQ::Item_data@ _item_data, EQ::Slot _slot );
}//EQ



namespace EQ {
  class Item_functionality {
       EQ::Make_sorting_number_fptr@ m_make_sorting_number_fptr = null;
             EQ::New_variables_fptr@ m_new_variables_fptr = null;
           EQ::Print_variables_fptr@ m_print_variables_fptr = null;
             EQ::On_equip_anim_fptr@ m_on_equip_anim_fptr = null;
           EQ::On_unequip_anim_fptr@ m_on_unequip_anim_fptr = null;    
              EQ::On_tick_anim_fptr@ m_on_tick_anim_fptr = null;
                  EQ::On_equip_fptr@ m_on_equip_fptr = null;
                EQ::On_unequip_fptr@ m_on_unequip_fptr = null;
                   EQ::On_tick_fptr@ m_on_tick_fptr = null;
               EQ::On_hit_blob_fptr@ m_on_hit_blob_fptr = null;   
                    EQ::On_hit_fptr@ m_on_hit_fptr = null;    
          EQ::On_health_change_fptr@ m_on_health_change_fptr = null;
              EQ::On_collision_fptr@ m_on_collision_fptr = null;
          EQ::On_end_collision_fptr@ m_on_end_collision_fptr = null;    
    EQ::Does_collide_with_blob_fptr@ m_does_collide_with_blob_fptr = null;    
                EQ::On_hit_map_fptr@ m_on_hit_map_fptr = null;
                    EQ::On_die_fptr@ m_on_die_fptr = null;  
  };
}//EQ

