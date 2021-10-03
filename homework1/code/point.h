#ifndef TASK1_POINT_H
#define TASK1_POINT_H

#include <cmath>
#include "rnd.h"

struct point {
    int x;
    int y;
};

double Distance(const point &a, const point &b);

void InRnd(point &p);

#endif //TASK1_POINT_H
