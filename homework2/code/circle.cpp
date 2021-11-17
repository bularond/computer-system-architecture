//
// Created by bularond on 24/10/21.
//

#include "circle.h"

circle::circle(shape::colour colour): shape(colour) {
    radius_ = rand() % (1000 - 1) + 1;
    centre_.x = rand() % 20;
    centre_.y = rand() % 20;
}

void circle::Out(std::ostream &out) const {
    out << "Circle C=(" << centre_.x << ", " << centre_.y << ") " << "radius=" << radius_;
}

double circle::Perimeter() const {
    return M_2_PI * radius_;
}

circle::circle(shape::colour colour, std::istream& in): shape(colour) {
    in >> radius_ >> centre_.x >> centre_.y;
}

circle::circle(shape::colour colour, int radius, point centre) : radius_(radius), centre_(centre), shape(colour) {
}
