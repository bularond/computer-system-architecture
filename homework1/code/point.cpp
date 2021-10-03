#include "point.h"

double Distance(const point &a, const point &b) {
    return sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y));
}

void InRnd(point &p) {
    p.x = Random();
    p.y = Random();
}
