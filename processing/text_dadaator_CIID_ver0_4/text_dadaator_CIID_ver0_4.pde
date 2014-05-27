// text dadaator, ver 0.4
// the text dadaator is an unfinished set of open source text mashup machines,
// which builds on selected text snippets modified by machines and filtered by humans in flow

// how to use this program:
// select a .txt document for input material
// random txt snippets are created and displayed
// select wanted ones with mouse
// to generate new titles press any key
// to reload source text press 'r'
// to save selected snippets to file press 's'
// quit by pressing escape

// text snippets should be seperated by line changes

int minTitleWords = 2, maxTitleWords = 5, numberOfTitles = 14;
String titleComponents;

String[] title = new String[numberOfTitles]; 
String[] titleComponentsList;
ArrayList selectedOnes;

PFont font;
int fontSpacing = 46;
int fontOffset = 10;
int selection = -1;

String loadPath;
String savePath = "output.txt";

boolean saveText = false;
String[] toSave;

int letterCounter = 0;
int titleCounter = 0;
boolean counting = true;

int margin = 10;

color selectColor = color(255,0,0);

boolean textLoaded = false;

void setup()  
{
  size(1000,650);
  font = loadFont("DIN-Light-48.vlw");
  textFont(font,48);
  
  selectInput("choose input text", "fileSelected");  // Opens file chooser

}

void fileSelected(File selection) {
  if (selection == null) {
    println("nothing selected, au revoir!");
    exit();
  }
  else {
    loadPath = selection.getAbsolutePath();
    println("OK, loading file: "+loadPath);
    titleComponentsList = loadStrings(loadPath);
    makeNewText();
    selectedOnes = new ArrayList();
    textLoaded = true;
  }
}


void draw() {
  background(0);
  if (textLoaded) printText();
}

void printText() { 
  
  selection = -1;
  
  for(int i=0;i<numberOfTitles;i++) {    
    if (mouseY>i*fontSpacing+fontOffset && mouseY<(1+i)*fontSpacing+fontOffset) {
      fill(selectColor);
      selection = i;
    } 
    else {
      fill(255);
    }
    if (titleCounter > i) {
      text(title[i],margin,(1+i)*fontSpacing);
    }
    
    if (titleCounter == i) {
      text(title[i].substring(0,letterCounter),margin,(1+i)*fontSpacing);
      letterCounter++;
      if (letterCounter > title[i].length() ) {
        letterCounter = 0;
        titleCounter++;
        delay(10);
      }
    }
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
  letterCounter = 0;
  titleCounter = 0;
  for(int i=0;i<numberOfTitles;i++) {
    title[i] = generateTitle(titleComponentsList, int(random(minTitleWords, maxTitleWords+1)));
  }
}

void mousePressed() {
  if (selection != -1) {
    println("selected: "+title[selection]);
    selectedOnes.add(title[selection]);
    
    selectColor = color(255,255,0);
  }
}

void mouseReleased() {
  selectColor = color(255,0,0);

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

    if (savePath != null) {
      println("saving to: "+savePath);
      saveStrings(savePath,toSave);
    } 
    else {
      // no file was selected
      println("No output file was selected...");
    }
    
  } 
  else if (key == 'r' || key == 'R') {
    titleComponentsList = null;
    titleComponentsList = loadStrings(loadPath);
    println("reloaded source text");
    makeNewText();    
  }
  else {
    makeNewText();
  }
}
