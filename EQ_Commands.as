


namespace EQ {
  enum Cmds {
    BEGIN = 128,
    /* For Menus: */
    MAIN_MENU,
    MENU,
    /* For Buttons: */
    BUTTON_STORAGE_ITEM,
    BUTTON_SLOT_ITEM,
    BUTTON_SLOT_EMPTY,
    BUTTON_SHOP_ITEM,
    BUTTON_SETTINGS,
    BUTTON_EQUIP,
    BUTTON_CLEAR,
    BUTTON_DROP,
    /* For Shop: */
    SHOP_AUTO_SELL,
    SHOP_AUTO_BUY,
    /* For Filter: */
    MENU_MATERIAL,
    MENU_SLOT,
    MENU_TYPE,
    MENU_CLASS,
    FILTER_MATERIAL,
    FILTER_SLOT,
    FILTER_TYPE,
    FILTER_CLASS,
    /* For Logic: */
    LOGIC_CREATE_ITEM,
    LOGIC_DROP_ITEM,
    LOGIC_PICKUP_ITEM,
    //LOGIC_DROP_ALL_ITEMS,
    //LOGIC_SELL_ITEM,
    //LOGIC_SELL_ALL_ITEMS,
    /* Other: */
    TRUE,
    FALSE,
    END,
    NIL
  };
}//EQ
