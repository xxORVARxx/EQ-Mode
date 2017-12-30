


void onTick( CRules@ _this ) {
  FACTORY::Items@ factory;
  _this.get("factory", @factory );
  if( @factory == null ) {
    print("EQ ERROR: Getting Factory Faild! ->'"+ getCurrentScriptName() +"'->'onTick'");
    _this.RemoveScript( getCurrentScriptName());
    return;
  }
  // Register Item:
  factory.Register_item( EQ::Item_customization());
  print( "EQ::FACTORY: Item Registed: "+ g_this_name_str +".");
  // Register Item Functionality:
  EQ::Item_functionality@ func_knight = Make_items_functionality_knight();
  EQ::Item_functionality@ func_archer = Make_items_functionality_archer();
  EQ::Item_functionality@ func_builder = Make_items_functionality_builder();
  factory.Register_functionality( func_knight, g_this_name, EQ::Class::KNIGHT );
  factory.Register_functionality( func_archer, g_this_name, EQ::Class::ARCHER );
  factory.Register_functionality( func_builder, g_this_name, EQ::Class::BUILDER );
  _this.RemoveScript( getCurrentScriptName());
}



EQ::Item_functionality@ Make_items_functionality_knight() {
  EQ::Item_functionality funcy;
  print("             Knight Functions Used:");

  @funcy.m_make_sorting_number_fptr = @EQ_Make_sorting_number;
    
#ifdef HAS_VARIABLES
  print("              'Has_Variables'");
  @funcy.m_new_variables_fptr = @EQ_New_variables;
  @funcy.m_print_variables_fptr = @EQ_Print_variables;
#endif

#ifdef ON_EQUIP_ANIM_KNIGHT
  print("              'onEquip_anim_knight'");
  @funcy.m_on_equip_anim_fptr = @onEquip_anim_knight;
#endif

#ifdef ON_UNEQUIP_ANIM_KNIGHT
  print("              'onUnequip_anim_knight'");
  @funcy.m_on_unequip_anim_fptr = @onUnequip_anim_knight;
#endif
    
#ifdef ON_TICK_ANIM_KNIGHT
  print("              'onTick_anim_knight'");
  @funcy.m_on_tick_anim_fptr = @onTick_anim_knight;
#endif
    
#ifdef ON_EQUIP_KNIGHT
  print("              'onEquip_knight'");
  @funcy.m_on_equip_fptr = @onEquip_knight;
#endif
    
#ifdef ON_UNEQUIP_KNIGHT
  print("              'onUnequip_knight'");
  @funcy.m_on_unequip_fptr = @onUnequip_knight;
#endif
    
#ifdef ON_TICK_KNIGHT
  print("              'onTick_knight'");
  @funcy.m_on_tick_fptr = @onTick_knight;
#endif
    
#ifdef ON_HIT_BLOB_KNIGHT
  print("              'onHitBlob_knight'");
  @funcy.m_on_hit_blob_fptr = @onHitBlob_knight;
#endif
    
#ifdef ON_HIT_KNIGHT
  print("              'onHit_knight'");
  @funcy.m_on_hit_fptr = @onHit_knight;
#endif
    
#ifdef ON_HEALTH_CHANGE_KNIGHT
  print("              'onHealthChange_knight'");
  @funcy.m_on_health_change_fptr = @onHealthChange_knight;
#endif

#ifdef ON_COLLISION_KNIGHT
  print("              'onCollision_knight'");
  @funcy.m_on_collision_fptr = @onCollision_knight;
#endif
	
#ifdef ON_END_COLLISION_KNIGHT
  print("              'onEndCollision_knight'");
  @funcy.m_on_end_collision_fptr = @onEndCollision_knight;
#endif
	
#ifdef DOES_COLLIDE_WITH_BLOB_KNIGHT
  print("              'doesCollideWithBlob_knight'");
  @funcy.m_does_collide_with_blob_fptr = @doesCollideWithBlob_knight;
#endif
	
#ifdef ON_HIT_MAP_KNIGHT
  print("              'onHitMap_knight'");
  @funcy.m_on_hit_map_fptr = @onHitMap_knight;
#endif
	
#ifdef ON_DIE_KNIGHT
  print("              'onDie_knight'");
  @funcy.m_on_die_fptr = @onDie_knight;
#endif
      
  return funcy;
}



EQ::Item_functionality@ Make_items_functionality_archer() {
  EQ::Item_functionality funcy;
  print("             Archer Functions Used:");

  @funcy.m_make_sorting_number_fptr = @EQ_Make_sorting_number;
  
#ifdef HAS_VARIABLES
  print("              'Has_Variables'");
  @funcy.m_new_variables_fptr = @EQ_New_variables;
  @funcy.m_print_variables_fptr = @EQ_Print_variables;
#endif
  
#ifdef ON_EQUIP_ANIM_ARCHER
  print("              'onEquip_anim_archer'");
  @funcy.m_on_equip_anim_fptr = @onEquip_anim_archer;
#endif

#ifdef ON_UNEQUIP_ANIM_ARCHER
  print("              'onUnequip_anim_archer'");
  @funcy.m_on_unequip_anim_fptr = @onUnequip_anim_archer;
#endif
    
#ifdef ON_TICK_ANIM_ARCHER
  print("              'onTick_anim_archer'");
  @funcy.m_on_tick_anim_fptr = @onTick_anim_archer;
#endif
    
#ifdef ON_EQUIP_ARCHER
  print("              'onEquip_archer'");
  @funcy.m_on_equip_fptr = @onEquip_archer;
#endif
    
#ifdef ON_UNEQUIP_ARCHER
  print("              'onUnequip_archer'");
  @funcy.m_on_unequip_fptr = @onUnequip_archer;
#endif
    
#ifdef ON_TICK_ARCHER
  print("              'onTick_archer'");
  @funcy.m_on_tick_fptr = @onTick_archer;
#endif
    
#ifdef ON_HIT_BLOB_ARCHER
  print("              'onHitBlob_archer'");
  @funcy.m_on_hit_blob_fptr = @onHitBlob_archer;
#endif
    
#ifdef ON_HIT_ARCHER
  print("              'onHit_archer'");
  @funcy.m_on_hit_fptr = @onHit_archer;
#endif
    
#ifdef ON_HEALTH_CHANGE_ARCHER
  print("              'onHealthChange_archer'");
  @funcy.m_on_health_change_fptr = @onHealthChange_archer;
#endif

#ifdef ON_COLLISION_ARCHER
  print("              'onCollision_archer'");
  @funcy.m_on_collision_fptr = @onCollision_archer;
#endif
	
#ifdef ON_END_COLLISION_ARCHER
  print("              'onEndCollision_archer'");
  @funcy.m_on_end_collision_fptr = @onEndCollision_archer;
#endif
	
#ifdef DOES_COLLIDE_WITH_BLOB_ARCHER
  print("              'doesCollideWithBlob_archer'");
  @funcy.m_does_collide_with_blob_fptr = @doesCollideWithBlob_archer;
#endif
	
#ifdef ON_HIT_MAP_ARCHER
  print("              'onHitMap_archer'");
  @funcy.m_on_hit_map_fptr = @onHitMap_archer;
#endif
	
#ifdef ON_DIE_ARCHER
  print("              'onDie_archer'");
  @funcy.m_on_die_fptr = @onDie_archer;
#endif

  return funcy;
}

  

EQ::Item_functionality@ Make_items_functionality_builder() {
  EQ::Item_functionality funcy;
  print("             Builder Functions Used:");

  @funcy.m_make_sorting_number_fptr = @EQ_Make_sorting_number;
    
#ifdef HAS_VARIABLES
  print("              'Has_Variables'");
  @funcy.m_new_variables_fptr = @EQ_New_variables;
  @funcy.m_print_variables_fptr = @EQ_Print_variables;
#endif
  
#ifdef ON_EQUIP_ANIM_BUILDER
  print("              'onEquip_anim_builder'");
  @funcy.m_on_equip_anim_fptr = @onEquip_anim_builder;
#endif

#ifdef ON_UNEQUIP_ANIM_BUILDER
  print("              'onUnequip_anim_builder'");
  @funcy.m_on_unequip_anim_fptr = @onUnequip_anim_builder;
#endif
    
#ifdef ON_TICK_ANIM_BUILDER
  print("              'onTick_anim_builder'");
  @funcy.m_on_tick_anim_fptr = @onTick_anim_builder;
#endif
    
#ifdef ON_EQUIP_BUILDER
  print("              'onEquip_builder'");
  @funcy.m_on_equip_fptr = @onEquip_builder;
#endif
    
#ifdef ON_UNEQUIP_BUILDER
  print("              'onUnequip_builder'");
  @funcy.m_on_unequip_fptr = @onUnequip_builder;
#endif
    
#ifdef ON_TICK_BUILDER
  print("              'onTick_builder'");
  @funcy.m_on_tick_fptr = @onTick_builder;
#endif
    
#ifdef ON_HIT_BLOB_BUILDER
  print("              'onHitBlob_builder'");
  @funcy.m_on_hit_blob_fptr = @onHitBlob_builder;
#endif
    
#ifdef ON_HIT_BUILDER
  print("              'onHit_builder'");
  @funcy.m_on_hit_fptr = @onHit_builder;
#endif
    
#ifdef ON_HEALTH_CHANGE_BUILDER
  print("              'onHealthChange_builder'");
  @funcy.m_on_health_change_fptr = @onHealthChange_builder;
#endif

#ifdef ON_COLLISION_BUILDER
  print("              'onCollision_builder'");
  @funcy.m_on_collision_fptr = @onCollision_builder;
#endif
	
#ifdef ON_END_COLLISION_BUILDER
  print("              'onEndCollision_builder'");
  @funcy.m_on_end_collision_fptr = @onEndCollision_builder;
#endif
	
#ifdef DOES_COLLIDE_WITH_BLOB_BUILDER
  print("              'doesCollideWithBlob_builder'");
  @funcy.m_does_collide_with_blob_fptr = @doesCollideWithBlob_builder;
#endif
	
#ifdef ON_HIT_MAP_BUILDER
  print("              'onHitMap_builder'");
  @funcy.m_on_hit_map_fptr = @onHitMap_builder;
#endif
	
#ifdef ON_DIE_BUILDER
  print("              'onDie_builder'");
  @funcy.m_on_die_fptr = @onDie_builder;
#endif
    
  return funcy;
}
