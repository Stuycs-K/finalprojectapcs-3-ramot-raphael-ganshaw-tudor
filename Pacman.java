public class Pacman {
    private int[] location;
    private int direction;
    private boolean poweredUp;

    public Pacman(int[] loc, int dir) {
        location = loc;
        direction = dir;
        poweredUp = false;
    }

    public void changeLocation(int[] loc) {
        location = loc;
    }
    public int[] getLocation() {
        return location;
    }

    public void changeDirection(int dir) {
        direction = dir;
    }
    public int getDirection() {
        return direction;
    }

    public void powerUp(boolean pow) {
        poweredUp = pow;
    }
    public boolean isPoweredUp() {
        return poweredUp;
    }
}