#ifndef TASK2_SHAPE_H
#define TASK2_SHAPE_H

//------------------------------------------------------------------------------
// shape.h - содержит описание обобщающей геометрической фигуры,
//------------------------------------------------------------------------------

#include <iostream>

class shape {
public:
    enum colour {
        RED, ORANGE, YELLOW, GREEN, BLUE, INDIGO, VIOLET
    };

    shape();

    shape(colour color);

    // Абстрактный метод вывода текущей структуры
    virtual void Out(std::ostream &out) const = 0;

    // Абстрактный метод подсчета периметра
    virtual double Perimeter() const = 0;

    colour GetColour();

protected:
    colour colour_;
};


#endif //TASK2_SHAPE_H
