/******************************************************************************
 Copyright (C) 2022 Vin Manager All rights reserved
 *Author: vin manager
 *Date: 2022-06-13
 *****************************************************************************/

#include "src/usage.h"
#include "iostream"

namespace mngr {

Usage::Usage(/* args */) {
}

Usage::~Usage() {
}

void Usage::Show() {
  std::cout << "add_module: should to do add project for building ! " << std::endl;
  std::cout << "build_app: build excutable binary file to run " << std::endl;
  std::cout << "build_test: build gtest binary file to some TEST " << std::endl;
}

}  // namespace mngr
