#ifndef __shape__
#define __shape__

//------------------------------------------------------------------------------
// shape.h - содержит описание обобщающей геометрической фигуры,
//------------------------------------------------------------------------------

#include <string.h>
#include "rectangle.h"
#include "triangle.h"
#include "circle.h"


//------------------------------------------------------------------------------
// структура, обобщающая все имеющиеся фигуры
struct shape {
    // возможные цвета фигур
    enum colors {RED, ORANGE, YELLOW, GREEN, BLUE, INDIGO, VIOLET};
    colors color; // цвет
    // значения ключей для каждой из фигур
    enum key {CIRCLE, RECTANGLE, TRIANGLE};
    key k; // ключ
    // используемые альтернативы
    union { // используем простейшую реализацию
        circle c;
        rectangle r;
        triangle t;
    };
};

// Ввод обобщенной фигуры
shape *In(ifstream &ifdt);

// Случайный ввод обобщенной фигуры
shape *InRnd();

// Вывод обобщенной фигуры
void Out(shape &s, ofstream &ofst);

// Вычисление периметра обобщенной фигуры
double Perimeter(shape &s);

#endif
