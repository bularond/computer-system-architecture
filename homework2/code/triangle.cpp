#include "triangle.h"

triangle::triangle(shape::colour colour, std::istream &in) : shape(colour) {
    in >> f_.x >> f_.y;
    in >> s_.x >> s_.y;
    in >> t_.x >> t_.y;
}

triangle::triangle(shape::colour colour) : shape(colour) {
    f_.x = rand() % 20;
    f_.y = rand() % 20;
    s_.x = rand() % 20;
    s_.y = rand() % 20;

    t_.x = f_.x + s_.x + 1;
    t_.y = f_.y + s_.y + 1;
}

void triangle::Out(std::ostream &out) const {
    out << "Triangle A=(" << f_.x << ", " << s_.y << ") "
        << "B=(" << s_.x << ", " << s_.y << ") "
        << "C=(" << t_.x << ", " << t_.y << ")";
}

double triangle::Perimeter() const {
    return f_.Distance(s_) + f_.Distance(t_) + s_.Distance(t_);
}
