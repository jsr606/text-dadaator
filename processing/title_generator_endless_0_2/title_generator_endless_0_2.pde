// text dadaator, ver 0.2
// by jacob and thea sikker remin AKA randomism
// the text dadaator is an unfinished set of open source text mashup machines,
// which builds on selected text snippets modified by machines and filtered by humans in flow

// source code, and other randomism programs can be downloaded at the dadaator website: http://campingsex.org/dadaator/

// how to use this program:
// select a .txt document for input material
// random txt snippets are created and displayed
// select wanted ones with mouse
// to generate new titles press any key
// to save selected snippets to file press 's' key
// finished by pressed escape

int minTitleWords = 2, maxTitleWords = 3, numberOfTitles = 14;
String titleComponents;

String[] title = new String[numberOfTitles]; 
String[] titleComponentsList;
ArrayList selectedOnes;

PFont font;
int fontSpacing = 46;
int fontOffset = 10;
int selection = -1;

boolean saveText = false;
String[] toSave;

void setup()  
{
  size(1000,650);
  font = loadFont("ChaparralPro-Italic-48.vlw");
  textFont(font,48);
  String loadPath = selectInput();  // Opens file chooser
  if (loadPath != null) {
    titleComponentsList = loadStrings(loadPath);
    makeNewText();
    selectedOnes = new ArrayList();
  } 
  else {
    println("nothing selected, au revoir!");
    exit();
  }
}

void draw() {
  background(100);
  printText();

  if (saveText) {
    String savePath = selectOutput();  // Opens file chooser
    if (savePath != null) {
      println("saving to: "+savePath+".txt");
      saveStrings(savePath+".txt",toSave);
    } 
    else {
      // no file was selected
      println("No output file was selected...");
    }
    saveText = false;
  }
}

void printText() {
  selection = -1;
  for(int i=0;i<numberOfTitles;i++) {    
    if (mouseY>i*fontSpacing+fontOffset && mouseY<(1+i)*fontSpacing+fontOffset) {
      fill(255,0,0);
      selection = i;
    } 
    else {
      fill(255);
    }
    text(title[i],0,(1+i)*fontSpacing);
  }
}

String generateTitle (String[] words, int _words) {
  String theTitle = "";
  for (int i = 0; i<_words; i++) {
    theTitle += words[int(random(0,words.length))];
    theTitle += " ";
  }
  return theTitle;
}

void makeNewText() {
  for(int i=0;i<numberOfTitles;i++) {
    title[i] = generateTitle(titleComponentsList, int(random(minTitleWords, maxTitleWords+1)));
  }
}

void mousePressed() {
  if (selection != -1) {
    println("selected: "+title[selection]);
    selectedOnes.add(title[selection]);
  }
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    int items = selectedOnes.size();
    print(items+" selected items ");
    toSave = new String[items];
    for (int i = 0; i < items; i++) {
      toSave[i] = (String) selectedOnes.get(i);
    }
    println("moved to toSave[]");
    saveText = true;
  } 
  else {
    makeNewText();
  }
}
