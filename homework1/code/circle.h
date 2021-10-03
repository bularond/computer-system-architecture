#ifndef __circle__
#define __circle__

//------------------------------------------------------------------------------
// rectangle.h - содержит описание прямоугольника  и его интерфейса
//------------------------------------------------------------------------------

#include <fstream>
using namespace std;

#include <cmath>
#include "rnd.h"
#include "point.h"

// круг
struct circle {
    point s;
    double r;
};

// Ввод параметров круга из файла
void In(circle &r, ifstream &ifst);

// Случайный ввод параметров круга
void InRnd(circle &r);

// Вывод параметров круга в форматируемый поток
void Out(circle &r, ofstream &ofst);

// Вычисление периметра круга
double Perimeter(circle &r);

#endif //__circle__
