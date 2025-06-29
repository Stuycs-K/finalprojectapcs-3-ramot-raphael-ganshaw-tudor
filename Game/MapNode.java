import java.util.*;
import java.io.*;


public class MapNode {
    private int[] location;
    private MapNode up, left, down, right;
    private int obj;

    public MapNode(int[] loc, int object) {
        location = Arrays.copyOf(loc,loc.length);
        obj = object;
        
        up = null;
        left = null;
        down = null;
        right = null;
    }

    public void setUp(MapNode above) {
        up = above;
    }
    public void setDown(MapNode below) {
        down = below;
    }
    public void setLeft(MapNode lef) {
        left = lef;
    }
    public void setRight(MapNode righ) {
        right = righ;
    }

    public MapNode getUp() {
        return up;
    }
    public MapNode getDown() {
        return down;
    }
    public MapNode getLeft() {
        return left;
    }
    public MapNode getRight() {
        return right;
    }

    public int getObject() {
        return obj;
    }
    public void setObject(int object) {
        obj = object;
    }

    public int[] getLocation() {
        return new int[]{location[0],location[1]};
    }

    public String toString(){
        return Arrays.toString(location) + " " + obj;
    }
}
