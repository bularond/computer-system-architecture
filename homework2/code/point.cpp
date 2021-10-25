#include "point.h"

point::point() : x(0), y(0) {
}

point::point(int x, int y) : x(x), y(y) {
}

double point::Distance(const point &other) const {
    return sqrt((x - other.x) * (x - other.x) + (y - other.y) * (y - other.y));
}
