public class MapNode {
    private int[] location;
    private MapNode up, left, down, right;
    private int obj;

    public MapNode(int[] loc, int object) {
        location = loc;
        obj = object;
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

}