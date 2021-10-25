#ifndef TASK2_CIRCLE_H
#define TASK2_CIRCLE_H

#include <iostream>

#include "shape.h"
#include "point.h"

class circle : public shape {
private:
    int radius_;
    point centre_;

public:
    circle();

    circle(int radius, point centre);

    explicit circle(std::istream &in);

    void Out(std::ostream &out) const override;

    double Perimeter() const override;
};


#endif //TASK2_CIRCLE_H
