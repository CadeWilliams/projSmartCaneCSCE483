import numpy as np
import time


def polar_to_cartesian(r, t):
    x = r * np.cos(t)
    y = r * np.sin(t)
    return x, y


def cartesian_to_polar(x, y):
    r = np.sqrt(x**2 + y**2)
    t = np.arctan2(y, x)
    return r, t


class Indoor:
    def __init__(self):
        self.anchor = False
        self.loc = (0, 0)
        self._current_angle = 0
        self.trail = []

    @property
    def current_angle(self):
        return self._current_angle

    @current_angle.setter
    def current_angle(self, x):
        if int(x) < 2*np.pi:
            self._current_angle = x
        else:
            self.current_angle = x - 2*np.pi

    def drop_anchor(self):
        if self.anchor:
            self.trail.append(self.loc)
        else:
            self.anchor = True
        self.loc = (0, 0)

    def lift_anchor(self):
        if len(self.trail) > 0:
            temp = polar_to_cartesian(self.trail[-1][0], self.trail[-1][1])
            temp2 = polar_to_cartesian(self.loc[0], self.loc[1])
            self.loc = cartesian_to_polar(temp[0] + temp2[0], temp[1] + temp2[1])
            del self.trail[-1]
        else:
            self.anchor = False

    def update_location(self, dist, angle):
        if self.anchor:
            temp = polar_to_cartesian(dist, angle)
            temp2 = polar_to_cartesian(self.loc[0], self.loc[1])
            self.loc = cartesian_to_polar(temp[0] + temp2[0], temp[1] + temp2[1])

    def ping_location(self):

        # Adjust angle to be relative to user's current view
        angle = 180 - round((self.loc[1] - self.current_angle) * 180 / np.pi)
        if angle < 0:
            angle += 360

        # To user's left
        dist = round(self.loc[0], 2)
        if 0 < angle < 180:
            print("Anchor is " + str(angle) + " degrees to your right, and " + str(dist) + " feet away")
        # To user's right
        else:
            angle = 360 - angle
            if angle == 180 and dist == 0:
                angle = 0
            print("Anchor is " + str(angle) + " degrees to your left, and " + str(dist) + " feet away")


def main():
    ind = Indoor()
    # 6 commands:
    # 'ping'   : ping current location
    # 'drop'   : drop anchor
    # 'lift'   : lift anchor
    # 'wait #' : wait # seconds
    # 'turn #' : turn to face #
    # '# *'    : move (#,*)
    with open("input.txt") as f:
        for line in f:
            if line[0:4] == "ping":
                ind.ping_location()
            elif line[0:4] == "drop":
                print("Anchor dropped.")
                ind.drop_anchor()
            elif line[0:4] == "lift":
                print("Anchor lifted.")
                ind.lift_anchor()
            elif line[0:4] == "wait":
                print("Waiting " + line.split()[-1] + " seconds.")
                time.sleep(int(line.split()[-1]))
            elif line[0:4] == 'turn':
                print("Turning to " + line.split()[-1] + ".")
                ind.current_angle = float(line.split()[-1]) * np.pi / 180.0
            elif len(line.split()) == 2:
                print("Move " + str(line.split()[-2]) + " feet at angle " + str(line.split()[-1]))
                ind.update_location(float(line.split()[-2]), float(line.split()[-1]) * np.pi / 180.0)


if __name__ == "__main__":
    main()
