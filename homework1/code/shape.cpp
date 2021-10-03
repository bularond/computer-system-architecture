//------------------------------------------------------------------------------
// shape.cpp - содержит процедуры связанные с обработкой обобщенной фигуры
// и создания произвольной фигуры
//------------------------------------------------------------------------------

#include "shape.h"

//------------------------------------------------------------------------------
shape::colors InColor(ifstream &ifst) {
    char color[20];
    ifst >> color;

    if (strcmp(color, "red") == 0) {
        return shape::RED;
    } else if (strcmp(color, "orange") == 0) {
        return shape::ORANGE;
    } else if (strcmp(color, "yellow") == 0) {
        return shape::YELLOW;
    } else if (strcmp(color, "green") == 0) {
        return shape::GREEN;
    } else if (strcmp(color, "blue") == 0) {
        return shape::BLUE;
    } else if (strcmp(color, "indigo") == 0) {
        return shape::INDIGO;
    } else {
        return shape::VIOLET;
    }
}

//------------------------------------------------------------------------------
// Ввод параметров обобщенной фигуры из файла
shape* In(ifstream &ifst) {
    shape *sp = new shape;
    int k;
    ifst >> k;
    sp->color = InColor(ifst);
    switch(k) {
        case 1:
            sp->k = shape::RECTANGLE;
            In(sp->r, ifst);
            break;
        case 2:
            sp->k = shape::TRIANGLE;
            In(sp->t, ifst);
            break;
        case 3:
            sp->k = shape::CIRCLE;
            In(sp->c, ifst);
            break;
        default:
            delete sp;
    }
    return sp;
}

// Случайный ввод обобщенной фигуры
shape *InRnd() {
    shape *sp = new shape;
    auto k = rand() % 3 + 1;
    sp->color = static_cast<shape::colors>(rand() % 7);
    switch(k) {
        case 1:
            sp->k = shape::RECTANGLE;
            InRnd(sp->r);
            break;
        case 2:
            sp->k = shape::TRIANGLE;
            InRnd(sp->t);
            break;
        case 3:
            sp->k = shape::CIRCLE;
            InRnd(sp->c);
            break;
        default:
            delete sp;
    }
    return sp;
}

//------------------------------------------------------------------------------
// Вывод цвета фигуры

void OutColor(shape::colors color, ofstream &ofst) {
    ofst << "Color ";
    switch (color) {
        case shape::RED:
            ofst << "red";
            break;
        case shape::ORANGE:
            ofst << "orange";
            break;
        case shape::YELLOW:
            ofst << "yellow";
            break;
        case shape::GREEN:
            ofst << "green";
            break;
        case shape::BLUE:
            ofst << "blue";
            break;
        case shape::INDIGO:
            ofst << "indigo";
            break;
        case shape::VIOLET:
            ofst << "violet";
            break;
    }
    ofst << ". ";
}

//------------------------------------------------------------------------------
// Вывод параметров текущей фигуры в поток
void Out(shape &s, ofstream &ofst) {
    OutColor(s.color, ofst);
    switch(s.k) {
        case shape::RECTANGLE:
            Out(s.r, ofst);
            break;
        case shape::TRIANGLE:
            Out(s.t, ofst);
            break;
        case shape::CIRCLE:
            Out(s.c, ofst);
            break;
        default:
            ofst << "Incorrect figure!" << endl;
    }
}

//------------------------------------------------------------------------------
// Вычисление периметра фигуры
double Perimeter(shape &s) {
    switch(s.k) {
        case shape::RECTANGLE:
            return Perimeter(s.r);
            break;
        case shape::TRIANGLE:
            return Perimeter(s.t);
            break;
        case shape::CIRCLE:
            return Perimeter(s.c);
        default:
            return 0.0;
    }
}
