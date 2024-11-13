class HideBalance {
  HideBalance._();

  static  String balance(String balance, bool hide){
    if(hide){
      return "****";
    }
    return balance;
  } 
}
