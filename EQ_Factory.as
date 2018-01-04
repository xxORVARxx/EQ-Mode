
#include "EQ_Items.as"
#include "EQ_Items_functionality.as"
#include "EQ_Item_data.as"



namespace FACTORY {
  class Items {
    
    void Register_item( EQ::Item@ _new_item ) {
      if( _new_item.Get_name() >= m_items.length())
	return;
      @m_items[ _new_item.Get_name() ] = @_new_item;
    }
    EQ::Item@ Get_item( EQ::Name _index ) {
      if( _index >= m_items.length())
	return null;
      return m_items[ _index ];
    }

    void Register_functionality( EQ::Item_functionality@ _func, EQ::Name _name, EQ::Class _class ) {
      if(( _name + ( EQ::Name::ALL * _class )) >= m_functionality.length())
	return;
      @m_functionality[ _name + ( EQ::Name::ALL * _class )] = @_func;
    }
    EQ::Item_functionality@ Get_functionality( EQ::Name _name, EQ::Class _class ) {
      if(( _name + ( EQ::Name::ALL * _class )) >= m_functionality.length())
	return null;
      return m_functionality[ _name + ( EQ::Name::ALL * _class )];
    }

    array< EQ::Item@ > m_items( EQ::Name::ALL );
    array< EQ::Item_functionality@ > m_functionality( EQ::Name::ALL * EQ::Class::ALL );
  };
}//FACTORY
