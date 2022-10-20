ArrayList<MS> get_subtable(Table ms_table){
  int numRows = ms_table.getRowCount();
  for(int i=0; i<numRows; i++){
    String ms_date = ms_table.getString(i,0);
    String ms_content = ms_table.getString(i, 2);
    ms.add(new MS(ms_date, ms_content));
}
  return ms;
}
