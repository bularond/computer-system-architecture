    #ifndef TASK2_CONTAINER_H
#define TASK2_CONTAINER_H

#include <iostream>

#include "rectangle.h"
#include "triangle.h"
#include "circle.h"
#include "shape.h"

//------------------------------------------------------------------------------
// container.h - содержит тип данных,
// представляющий простейший контейнер
//------------------------------------------------------------------------------

class container {
public:
    // Максимальный размер массива
    static const size_t MAX_SIZE = 10000;

    // Пустая инициализация
    container();
    container(container& other) = delete;
    // Инициализация из потока
    explicit container(std::istream &in);
    // Инициализация случайными значениями
    explicit container(int size);
    // Деструктор
    ~container();

    // Очистка контейнера
    void Clear();
    // Вывод содержимого в поток
    void Out(std::ostream &out) const;
    // Посчитать общий периметер
    double PerimeterSum();
    // Отсортировать контейнер
    void Sort();

private:
    // Текущая длинна контейнера
    size_t len_;
    // Массив
    shape *array_[MAX_SIZE];
};


#endif //TASK2_CONTAINER_H
