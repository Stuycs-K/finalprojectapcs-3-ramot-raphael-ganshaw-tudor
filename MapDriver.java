import java.util.*;
import java.io.*;


public class MapDriver{

public static void main(String[] args) {

Map map1 = new Map(1);
System.out.println(map1);

Ghost ghost = new Ghost(map1);
System.out.println(ghost.debugToString());

/*
System.out.println(map1.isOnScreen(7,1));
for(int i = 0; i < 5; i++)
{
  System.out.println("--------------------------------");
  ghost.move();
  System.out.println(ghost.debugToString());
  System.out.println(map1);

}
*/


}

}
