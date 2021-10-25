#include "container.h"


container::container() : len_(0), array_() {
    for (auto & i : array_) {
        i = nullptr;
    }
}

container::container(std::istream &in) : container() {
    while (!in.eof()) {
        int type;
        std::string name;
        in >> type >> name;

        shape::colour colour;
        if (name == "red") {
            colour = shape::colour::RED;
        } else if (name == "orange") {
            colour = shape::colour::ORANGE;
        } else if (name == "yellow") {
            colour = shape::colour::YELLOW;
        } else if (name == "green") {
            colour = shape::colour::GREEN;
        } else if (name == "blue") {
            colour = shape::colour::BLUE;
        } else if (name == "indigo") {
            colour = shape::colour::INDIGO;
        } else if (name == "violet") {
            colour = shape::colour::VIOLET;
        } else {
            printf("Incorrect colour provided");
            exit(2);
        }

        if (type == 1) {
            array_[len_] = static_cast<shape *>(new rectangle(colour, in));
        } else if (type == 2) {
            array_[len_] = static_cast<shape *>(new triangle(colour, in));
        } else if (type == 3) {
            array_[len_] = static_cast<shape *>(new circle(in));
        } else {
            throw std::logic_error("Unknown shape type");
        }

        ++len_;
    }
}

container::container(int size): len_(size) {
    for (size_t i = 0; i < len_; ++i) {
        int type = rand() % (3 - 1) + 1;
        if (type == 1) {
            array_[len_] = new rectangle();
        } else if (type == 2) {
            array_[i] = new triangle(colour);
        } else if (type == 3) {
            array_[i] = new circle(colour);
        }
    }
}

void container::Clear() {
    for (size_t i = 0; i < len_; ++i) {
        delete array_[i];
        array_[i] = nullptr;
    }
    len_ = 0;
}

std::string getColourText(shape::colour color) {
    switch (color) {
        case shape::RED:
            return "Red";
        case shape::ORANGE:
            return "Orange";
        case shape::YELLOW:
            return "Yellow";
        case shape::GREEN:
            return "Green";
        case shape::BLUE:
            return "Blue";
        case shape::INDIGO:
            return "Indigo";
        case shape::VIOLET:
            return "Violet";
        default:
            exit(-1);
    }
}

void container::Out(std::ostream &out) const {
    for (size_t i = 0; i < len_; ++i) {
        array_[i]->Out(out);
        out << ", Colour = " << getColourText(array_[i]->GetColour())
            << ". Perimeter (sort key) = " << array_[i]->Perimeter() << std::endl;
    }
}

double container::PerimeterSum() {
    double sum = 0;
    for (size_t i = 0; i < len_; ++i) {
        sum += array_[i]->Perimeter();
    }
}

void container::Sort() {
    int i = 0, j, k;
    shape *sp;
    while (i < len_) {
        k = i;
        for (j = i + 1; j < len_; ++j) {
            if (array_[j]->Perimeter() > array_[k]->Perimeter()) {
                k = j;
            }
        }
        sp = array_[i];
        array_[i] = array_[k];
        array_[k] = sp;
        i++;
    }
}

container::~container() {
    Clear();
}
