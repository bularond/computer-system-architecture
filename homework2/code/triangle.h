#ifndef TASK2_TRIANGLE_H
#define TASK2_TRIANGLE_H

#include <istream>

#include "shape.h"
#include "point.h"

class triangle : public shape {
public:
    triangle(shape::colour colour);
    explicit triangle(shape::colour colour, std::istream &in);

    void Out(std::ostream &out) const override;
    double Perimeter() const override;

private:
    point f_;
    point s_;
    point t_;
};


#endif //TASK2_TRIANGLE_H
