

/*
namespace EQ {
  bool Class_slot_fits_item_slot( EQ::Class _this_class, EQ::Class_slot _class_slot, EQ::Item_slot _item_slot ) {
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
}//EQ



namespace EQ {
  class Class_slot {
    Class_slot() {
      m_slot = EQ::Slot::NIL;
      m_frame = 0;
    }
    Class_slot( EQ::Class _class, EQ::Slot _slot, u8 _frame ) {
      m_slot = _slot;
      m_frame = _frame;
    }
    EQ::Slot m_slot;
    u8 m_frame;
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
*/
