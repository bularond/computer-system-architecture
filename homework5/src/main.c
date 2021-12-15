#include <stdio.h>
#include <pthread.h>
#include "honey_pot.h"
#include "bear.h"
#include "bee.h"

void print_help() {
    printf("Incorrect command line. Usage\n"
           "    command <bee count> <honey pot capacity> <count of pots>\n"
           "Where\n"
           "    <bee count> must be in range 1 to 16\n"
           "    <honey pot capacity> must be in range 1 to 100\n"
           "    <count of pots> must be in range 1 to 10");
}

int main(int argc, char** argv) {
    int bee_count = 0;
    int pot_capacity = 0;
    int count_of_pots = 0;
    int i = 0;
    struct HoneyPot pot;
    struct Bear bear;
    struct Bee* bees;
    pthread_t* threads = NULL;
    pthread_mutex_t end_mutex = PTHREAD_MUTEX_INITIALIZER;

    // Handle command line arguments
    if (argc != 4) {
        print_help();
        exit(EXIT_FAILURE);
    }

    bee_count = atoi(argv[1]);
    pot_capacity = atoi(argv[2]);
    count_of_pots = atoi(argv[3]);

    if (bee_count < 1 || bee_count > 16 ||
            pot_capacity < 1 || pot_capacity > 100 ||
            count_of_pots < 1 || count_of_pots > 10) {
        print_help();
        exit(EXIT_FAILURE);
    }

    bees = malloc(sizeof(struct Bee) * (bee_count + 1));
    threads = malloc(sizeof(pthread_t) * (bee_count + 1));

    // Initialize mutex and threads
    pot_init(&pot, pot_capacity);
    bear_init(&bear, count_of_pots, &pot, &end_mutex);
    pthread_create(&threads[0], NULL, bear_run, &bear);

    for (i = 1; i <= bee_count; ++i) {
        bee_init(&bees[i - 1], i, &bear, &pot);
        pthread_create(&threads[i], NULL, bee_run, &bees[i - 1]);
    }

    // Wait until thread works done
    pthread_mutex_lock(&end_mutex);

    // Stop threads and deinit mutex's
    for (i = 0; i < bee_count + 1; ++i) {
        pthread_cancel(threads[i]);
    }
    bear_deinit(&bear);
    pot_deinit(&pot);
    free(bees);
    free(threads);

    exit(EXIT_SUCCESS);
}
