#include <gtest/gtest.h>
#include <math/add.hpp>

TEST(MathTest, CanAddInteger) {
    EXPECT_EQ(add(1, 2), 3);
}