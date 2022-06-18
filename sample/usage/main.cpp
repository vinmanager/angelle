/******************************************************************************
 Copyright (C) 2021 Vin Manager All rights reserved
 *Author: vin manager
 *Date: 2022-06-13
 *****************************************************************************/

#include "src/usage.h"
#include <iostream>

int main(int argc, const char** argv) {
  mngr::Usage usage;
  usage.Show();

  std::cout << "hello world !" << std::endl;
  return 0;
}