/******************************************************************************
 Copyright (C) 2022 Vin Manager All rights reserved
 *Author: vin manager
 *Date: 2022-06-18
 *****************************************************************************/

#include <gtest/gtest.h>
#include "thread/thread.h"

TEST(t, default) {
  mngr::Thread t;
  t.start();
  return;
}

int main(int argc, char** argv) {
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
