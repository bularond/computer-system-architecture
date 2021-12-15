#ifndef HEADER_BEE
#define HEADER_BEE

#include <unistd.h>
#include <stdlib.h>
#include "honey_pot.h"
#include "bear.h"

struct Bee {
    struct HoneyPot* pot;
    struct Bear* bear;
    int id;
};

void bee_init(struct Bee* bee, int id, struct Bear* bear, struct HoneyPot* pot) {
    bee->id = id;
    bee->pot = pot;
    bee->bear = bear;
}

_Noreturn void * bee_run(void *arg) {
    struct Bee* bee = (struct Bee*)arg;
    int sleep_duration = 0;
    while (1) {
        sleep_duration = (int)random() % 9 + 1;
        printf("Bee %i will sleep %i seconds\n", bee->id, sleep_duration);
        sleep(sleep_duration);

        pot_lock(bee->pot);
        printf("Bee %i add sip to pot\n", bee->id);
        if (pot_add_one_sip(bee->pot)) {
            printf("Bee %i wakes up beer\n", bee->id);
            bear_wake_up(bee->bear);
        } else {
            pot_unlock(bee->pot);
        }
    }
}

#endif //HEADER_BEE
