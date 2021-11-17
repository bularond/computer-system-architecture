#include "shape.h"
#include "circle.h"
#include "triangle.h"
#include "rectangle.h"

shape::shape() {
    int colour = rand() % 7;
    switch (colour) {
        case 0:
            colour_ = colour::RED;
            break;
        case 1:
            colour_ = colour::ORANGE;
            break;
        case 2:
            colour_ = colour::YELLOW;
            break;
        case 3:
            colour_ = colour::GREEN;
            break;
        case 4:
            colour_ = colour::BLUE;
            break;
        case 5:
            colour_ = colour::INDIGO;
            break;
        case 6:
            colour_ = colour::VIOLET;
    }
}

shape::shape(colour colour) : colour_(colour) {
}

shape::colour shape::GetColour() {
    return colour_;
}


#if 0
shape* shape::In(std::istream &stream) {
    std::string name;
    stream >> name;

    colour colour;
    if (name == "red") {
        colour = colour::RED;
    } else if (name == "orange") {
        colour = colour::ORANGE;
    } else if (name == "yellow") {
        colour = colour::YELLOW;
    } else if (name == "green") {
        colour = colour::GREEN;
    } else if (name == "blue") {
        colour = colour::BLUE;
    } else if (name == "indigo") {
        colour = colour::INDIGO;
    } else if (name == "violet") {
        colour = colour::VIOLET;
    } else {
        printf("Incorrect colour provided");
        exit(2);
    }

    std::string type;
    std::cin >> type;

    shape* shape;
    if (type == "circle") {
        shape = new circle(stream);
    } else if (type == "rectangle") {
        shape = new rectangle(stream);
    } else if (type == "triangle") {
        shape = new triangle(stream);
    } else {
        printf("Incorrect name of the shape provided");
        exit(2);
    }

    shape->colour_ = colour;
    return shape;
}
#endif
