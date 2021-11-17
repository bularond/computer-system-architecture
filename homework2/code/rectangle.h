#ifndef TASK2_RECTANGLE_H
#define TASK2_RECTANGLE_H


#include <iostream>

#include "shape.h"
#include "point.h"

class rectangle : public shape {
public:
    explicit rectangle(shape::colour);

    explicit rectangle(shape::colour, std::istream &in);
    double Perimeter() const override;
    void Out(std::ostream &out) const override;

private:
    point f_;
    point s_;
};

#endif //TASK2_RECTANGLE_H
