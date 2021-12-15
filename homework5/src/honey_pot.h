#ifndef HEADER_POT
#define HEADER_POT

#include <pthread.h>

struct HoneyPot {
    int capacity;
    int count;
    pthread_mutex_t mutex;
};

void pot_init(struct HoneyPot* pot, int capacity) {
    pot->capacity = capacity;
    pot->count = 0;
    pthread_mutex_init(&pot->mutex, NULL);
}

void pot_deinit(struct HoneyPot* pot) {
    pthread_mutex_destroy(&pot->mutex);
}

void pot_lock(struct HoneyPot* pot) {
    pthread_mutex_lock(&pot->mutex);
}

void pot_unlock(struct HoneyPot* pot) {
    pthread_mutex_unlock(&pot->mutex);
}

int pot_add_one_sip(struct HoneyPot* pot) {
    ++pot->count;
    return pot->count == pot->capacity;
}

void pot_drink_all(struct HoneyPot* pot) {
    pot->count = 0;
}

#endif //HEADER_POT
