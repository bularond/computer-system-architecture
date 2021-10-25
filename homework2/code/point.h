#ifndef TASK2_POINT_H
#define TASK2_POINT_H

#include <cmath>

class point {
public:
    point();
    point(int x, int y);

    double Distance(const point& other) const;

    int x;
    int y;
};

#endif //TASK2_POINT_H
