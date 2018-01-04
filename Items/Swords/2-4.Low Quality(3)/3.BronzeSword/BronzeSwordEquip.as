
#include "EQ_Factory.as"
//#include "EQ_Items_common.as"



const EQ::Name g_this_name = EQ::Name::BRONZE_SWORD; // <------------------
const string g_this_name_str = EQ::g_name_str[ g_this_name ];



EQ::Item@ Make_new_item_type() {
  // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  array< EQ::Class > classes = { EQ::Class::KNIGHT };
  array< EQ::Slot > slots = { EQ::Slot::LEFT_HAND, EQ::Slot::RIGHT_HAND, EQ::Slot::BACK };
  array< EQ::Type > type = { EQ::Type::WEAPON, EQ::Type::SWORD };
  EQ::Item item( g_this_name,
		 Gold( 005 ) + Silver( 000 ) + Bronze( 000 ),
		 EQ::Rarity::LOW_QUALITY,
		 EQ::Material::BRONZE,
		 classes, slots, type );
  // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  return item;
}



void onTick( CRules@ _this ) {
  FACTORY::Items@ factory;
  _this.get("factory", @factory );
  if( @factory == null ) {
    print("EQ ERROR: Getting Factory Faild! ->'"+ getCurrentScriptName() +"'->'onTick'");
    _this.RemoveScript( getCurrentScriptName());
    return;
  }
  // Register Item Type:
  factory.Register_type( Make_new_item_type());
  print( "FACTORY: "+ g_this_name_str +" Type Registed.");
  // Register Item Funcunality:
  /*
  EQ::Item_funcunality@ func_knight = Make_items_funcunality( EQ::Class::KNIGHT );
  EQ::Item_funcunality@ func_archer = Make_items_funcunality( EQ::Class::ARCHER );
  EQ::Item_funcunality@ func_builder = Make_items_funcunality( EQ::Class::BUILDER );
  factory.Register_funcunality( func_knight, g_this_name, EQ::Class::KNIGHT );
  factory.Register_funcunality( func_archer, g_this_name, EQ::Class::ARCHER );
  factory.Register_funcunality( func_builder, g_this_name, EQ::Class::BUILDER );
  */ 
  _this.RemoveScript( getCurrentScriptName());
}
