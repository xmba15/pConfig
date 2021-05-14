/**
 * @file    Testtemporary_project_name.cpp
 *
 * @author  btran
 *
 * Copyright (c) organization
 *
 */

#include <gtest/gtest.h>

#include <temporary_project_name/temporary_project_name.hpp>

class Testtemporary_project_name : public ::testing::Test
{
 protected:
    void SetUp() override
    {
        start_time_ = time(nullptr);
    }

    void TearDown() override
    {
        const time_t end_time = time(nullptr);

        // expect test time less than 10 sec
        EXPECT_LE(end_time - start_time_, 10);
    }

    time_t start_time_;
};

TEST_F(Testtemporary_project_name, TestInitialization)
{
    ASSERT_TRUE(true);
}
