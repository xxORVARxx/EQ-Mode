


typedef int64 Money;

Money Gold( int64 _money ) {
  return _money * 1000000;
}
Money Silver( int64 _money ) {
  return _money * 1000;
}
Money Bronze( int64 _money ) {
  return _money;
}

int64 Get_gold( Money _money ) {
  return _money / 1000000;
}
int64 Get_silver( Money _money ) {
  _money /= 1000;
  Money silver = ( _money / 1000 ) * 1000;
  return _money - silver;
}
int64 Get_bronze( Money _money ) {
  Money bronze = ( _money / 1000 ) * 1000;
  return _money - bronze;
}



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



namespace EQ {
  enum Class { KNIGHT, ARCHER, BUILDER, ALL, END, NIL };
  const array<string> g_class_str = { "Knight",
				      "Archer",
				      "Builder",
				      "All Classes",
				      "END",
				      "NIL" };

  enum Rarity { PRACTISE, LOW_QUALITY, HIGH_QUALITY, SPECIAL_MATERIALS, SPECIAL, ALL, ADMIN, END, NIL };
  const array<string> g_rarity_str = { "Practise",
				       "Low Quality",
				       "High Quality",
				       "Special Materials",
				       "Special",
				       "All Rarities",
				       "Admin",
				       "END",
				       "NIL" };

  enum Material { WOOD, LEATHER, COPPER, BRONZE, WROUGHT_IRON, IRON, STEEL, PLATINUM, DURASTEEL, MITHRIL, IRIDIUM, PALLADIUM, OBSIDIAN, GOLD, ALL, END, NIL };
  // FIX NAME FROM 'g_materials_str' TO 'g_material_str'!!
  const array<string> g_materials_str = { "Wood",
					  "Leather",
					  "Copper",
					  "Bronze",
					  "Wrought Iron",
					  "Iron",
					  "Steel",
					  "Platinum",
					  "Durasteel",
					  "Mithril",
					  "Iridium",
					  "Palladium",
					  "Obsidian",
					  "Gold",
					  "All Materials",
					  "END",
					  "NIL" };

  enum Slot { HEAD, LEFT_HAND, RIGHT_HAND, CHEST, FEET, ALL_MAIN, NECK, BACK, FINGER, LEGS, ALL_SECONDARY, ALL, END, NIL };
  const array<string> g_slot_str = { "Head",
				     "Left Hand",
				     "Right Hand",
				     "Chest",
				     "Feet",
				     "All Main Slots",
				     "Neck",
				     "Back",
				     "Finger",
				     "Legs",
				     "All Secondary",
				     "All Slots",
				     "END",
				     "NIL" };

  enum Type { /*Armour:*/ HELM, SHIELD, SCALEMAIL, PLATEMAIL, CHAINMAIL, BOOTS, ALL_ARMOUR, /*Weapons:*/ SWORD, BOW, KNIVE, DAGGER, PICKAXE, MAUL, ALL_WEAPONS, /*Accessories:*/ RING, AMULET, HOOK, CLOAK, GREAVES, ALL_ACCESSORIES, ALL, WEAPON, ARMOUR, ACCESSORY, END, NIL };
  const array<string> g_type_str = { "Helm",
				     "Shield",
				     "Scalemail",
				     "Platemail",
				     "Chainmail",
				     "Boots",
				     "All Armour",
				     "Sword",
				     "Bow",
				     "Knive",
				     "Dagger",
				     "Pickaxe",
				     "Maul",
				     "All Weapons",
				     "Ring",
				     "Amulet",
				     "Hook",
				     "Cloak",
				     "Greaves",
				     "All Accessories",
				     "ALL Types",
				     "Weapons",
				     "Armour",
				     "ACCESSORY",
				     "END",
				     "NIL" };

  enum Name { WOODEN_SWORD, COPPER_SWORD, WROUGHT_IRON_SWORD, WROUGHT_IRON_SCALEMAIL, ALL/*temp all*/, BRONZE_SWORD, IRON_SWORD, STEEL_SWORD, PLATINUM_SWORD, DURASTEEL_SWORD, IRON_SCALEMAIL, ALL_real/*real all*/, MITHRIL_SWORD, IRIDUM_SWORD, PALLADIUM_SWORD, OBSIDIAN_SWORD, GOLD_SWORD, END, NIL };
  const array<string> g_name_str = { "WoodenSword",
				     "CopperSword",
				     "WroughtIronSword",
				     "WroughtIronScalemail",
				     "All Names",
				     "BronzeSword",
				     "IronSword",
				     "SteelSword",
				     "PlatinumSword",
				     "DurasteelSword",
				     "IronScalemail",
				     "MithrilSword",
				     "IridiumSword",
				     "PalladiumSword",
				     "ObsidianSword",
				     "GoldSword",
				     "END",
				     "NIL" };
}//EQ



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



namespace EQ {
  bool Class_slot_fits_item_slot( EQ::Class _this_class, EQ::Class_slot@ _class_slot, EQ::Item_slot@ _item_slot ) {
    if(( _item_slot.m_class == EQ::Class::NIL )||
       ( _item_slot.m_slot == EQ::Slot::NIL ))
      return false;
    if(( _class_slot.m_slot == _item_slot.m_slot )||
       ( _class_slot.m_slot == EQ::Slot::ALL )||
       ( _item_slot.m_slot == EQ::Slot::ALL )) {
      if( _this_class == _item_slot.m_class )
	return true;
    }
    return false;
  }
  
  class Class_slot {
    Class_slot() {
      m_slot = EQ::Slot::NIL;
      m_frame = 0;
    }
    Class_slot( EQ::Slot _slot, int _frame ) {
      m_slot = _slot;
      m_frame = _frame;
    }
    EQ::Slot m_slot;
    int m_frame;
  };
      
  class Item_slot {
    Item_slot() {
      m_class = EQ::Class::NIL;
      m_slot = EQ::Slot::NIL;
    }
    Item_slot( EQ::Class _class, EQ::Slot _slot ) {
      m_class = _class;
      m_slot = _slot;
    }    
    EQ::Class m_class;
    EQ::Slot m_slot;
  };
}//EQ



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



namespace EQ {
  // EQ-Item's Type Class:
  class Item {
    Item( EQ::Name _name,
	  Money _price,
	  EQ::Rarity _rarity,
	  EQ::Material _material,
	  array< EQ::Item_slot > _item_slots,
	  array< EQ::Type > _types ) {
      m_name = _name;
      m_price = _price;
      m_rarity = _rarity;
      m_material = _material;
      m_item_slots = _item_slots;
      m_types = _types;
    }
                  EQ::Name Get_name() { return m_name; }
                     Money Get_price() { return m_price; }
                EQ::Rarity Get_rarity() { return m_rarity; }
              EQ::Material Get_material() { return m_material; }
    array< EQ::Item_slot > Get_item_slots() { return m_item_slots; }
         array< EQ::Type > Get_types() { return m_types; }

              int Get_item_slots_length() { return m_item_slots.length(); }
              int Get_types_length() { return m_types.length(); }
    EQ::Item_slot Get_item_slot_at( const int _index ) { return m_item_slots[ _index ]; }
         EQ::Type Get_type_at( const int _index ) { return m_types[ _index ]; }

    private EQ::Name m_name;
    private Money m_price;
    private EQ::Rarity m_rarity;
    private EQ::Material m_material;
    private array< EQ::Item_slot > m_item_slots;
    private array< EQ::Type > m_types;
  };
}//EQ
