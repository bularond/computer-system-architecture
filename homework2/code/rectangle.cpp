#include "rectangle.h"

rectangle::rectangle(shape::colour colour, std::istream& in): shape(colour) {
    in >> f_.x >> f_.y;
    in >> s_.y >> s_.y;
}

rectangle::rectangle(shape::colour colour): shape(colour) {
    f_.x = rand() % 20;
    s_.x = f_.x + rand() % 20 + 1;

    f_.y = rand() % 20;
    s_.y = f_.y + rand() % 20 + 1;
}

double rectangle::Perimeter() const {
    return (s_.x - f_.x) * 2 + (s_.y - f_.y) * 2;
}

void rectangle::Out(std::ostream &out) const {
    out << "Rectangle A=(" << f_.x << ", " << f_.y << "), "
        << "B=(" << s_.x << ", " << s_.y << ")";
}

