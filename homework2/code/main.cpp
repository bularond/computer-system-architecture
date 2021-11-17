#include <iostream>
#include <fstream>
#include <cstdlib>
#include <ctime>
#include <cstring>

#include "container.h"

void errMessage1() {
    std::cout << "incorrect command line!\n"
                 "  Waited:\n"
                 "     command -f infile outfile01 outfile02\n"
                 "  Or:\n"
                 "     command -n number outfile01 outfile02\n";
}

void errMessage2() {
    std::cout << "incorrect qualifier value!\n"
                 "  Waited:\n"
                 "     command -f infile outfile01 outfile02\n"
                 "  Or:\n"
                 "     command -n number outfile01 outfile02\n";
}

int main(int argc, char* argv[]) {
    if (argc != 5) {
        errMessage1();
    }

    // C++ is my favorite language

    std::cout << "Start" << std::endl;
    container *c = nullptr;
    if(!strcmp(argv[1], "-f")) {
        FILE *file = fopen(argv[2], "rw");
        if (file == nullptr) {
            printf("File '%s' is not available at the moment. Please, try again later.", argv[2]);
            exit(1);
        }

        fclose(file);
        std::ifstream inst(argv[2]);
        c = new container(inst);
    } else if(!strcmp(argv[1], "-n")) {
        auto size = atoi(argv[2]);
        if((size < 1) || (size > 10000)) {
            std::cout << "incorrect number of figures = "
                      << size
                      << ". Set 0 < number <= 10000\n";
            return 3;
        }
        // системные часы в качестве инициализатора
        srand(static_cast<unsigned int>(time(0)));
        // Заполнение контейнера генератором случайных чисел
        c = new container(size);
    } else {
        errMessage2();
        return 2;
    }

    std::ofstream ofst1(argv[3]);
    ofst1 << "Filled container:\n";
    c->Out(ofst1);

    // The 2nd part of task
    c->Sort();
    std::ofstream ofst2(argv[4]);
    c->Out(ofst2);

    delete c;
    std::cout << "Stop" << '\n';
    return 0;
}