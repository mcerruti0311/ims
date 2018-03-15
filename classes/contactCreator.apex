public class contactCreator {
  public static void createContacts() {

// Create a list of first names

    List<String> firstNames = new List<String>();
      firstNames.add('Robert');
      firstNames.add('John');
      firstNames.add('James');
      firstNames.add('William');
      firstNames.add('Charles');
      firstNames.add('George');
      firstNames.add('Joseph');

    List<String> lastNames = new List<String>();
      lastNames.add('Abraham');
      lastNames.add('Elliott');
      lastNames.add('Kegley');
      lastNames.add('Raslo');
      lastNames.add('Lehman');
      lastNames.add('Rosenthal');
      lastNames.add('Bentz');

      Double firstNameIndex = Math.roundToLong(Math.random() * 7);

      System.debug(firstNameIndex);

  }
}
