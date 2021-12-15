#ifndef HEADER_BEER
#define HEADER_BEER

#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include "honey_pot.h"

struct Bear {
    struct HoneyPot* pot;
    int count_pots;
    pthread_mutex_t mutex;
    pthread_mutex_t* end_mutex;
};

void bear_init(struct Bear* bear, int count_pots, struct HoneyPot* pot, pthread_mutex_t* end_mutex) {
    bear->count_pots = count_pots;
    bear->pot = pot;
    pthread_mutex_init(&bear->mutex, NULL);
    pthread_mutex_lock(&bear->mutex);
    bear->end_mutex = end_mutex;
    pthread_mutex_lock(end_mutex);
}

void bear_deinit(struct Bear* bear) {
    pthread_mutex_destroy(&bear->mutex);
}

void bear_wake_up(struct Bear* bear) {
    pthread_mutex_unlock(&bear->mutex);
    printf("Bear woke up\n");
}

void* bear_run(void *arg) {
    struct Bear* bear = (struct Bear*) arg;
    int i = 0;
    for (; i < bear->count_pots; ++i) {
        pthread_mutex_lock(&bear->mutex);
        pot_drink_all(bear->pot);
        printf("Bear drink all from honey pot\n");
        pot_unlock(bear->pot);
    }
    pthread_mutex_unlock(bear->end_mutex);
    return NULL;
}

#endif //HEADER_BEER
