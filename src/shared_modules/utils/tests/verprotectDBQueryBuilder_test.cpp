/*
 * Verprotect shared modules utils
 * Copyright (C) 2015, Verprotect Inc.
 * Nov 1, 2023.
 *
 * This program is free software; you can redistribute it
 * and/or modify it under the terms of the GNU General Public
 * License (version 2) as published by the FSF - Free Software
 * Foundation.
 */

#include "wazuhDBQueryBuilder_test.hpp"
#include "wazuhDBQueryBuilder.hpp"
#include <string>

TEST_F(VerprotectDBQueryBuilderTest, GlobalTest)
{
    std::string message = VerprotectDBQueryBuilder::builder().global().selectAll().fromTable("agent").build();
    EXPECT_EQ(message, "global sql SELECT * FROM agent ");
}

TEST_F(VerprotectDBQueryBuilderTest, AgentTest)
{
    std::string message = VerprotectDBQueryBuilder::builder().agent("0").selectAll().fromTable("sys_programs").build();
    EXPECT_EQ(message, "agent 0 sql SELECT * FROM sys_programs ");
}

TEST_F(VerprotectDBQueryBuilderTest, WhereTest)
{
    std::string message = VerprotectDBQueryBuilder::builder()
                              .agent("0")
                              .selectAll()
                              .fromTable("sys_programs")
                              .whereColumn("name")
                              .equalsTo("bash")
                              .build();
    EXPECT_EQ(message, "agent 0 sql SELECT * FROM sys_programs WHERE name = 'bash' ");
}

TEST_F(VerprotectDBQueryBuilderTest, WhereAndTest)
{
    std::string message = VerprotectDBQueryBuilder::builder()
                              .agent("0")
                              .selectAll()
                              .fromTable("sys_programs")
                              .whereColumn("name")
                              .equalsTo("bash")
                              .andColumn("version")
                              .equalsTo("1")
                              .build();
    EXPECT_EQ(message, "agent 0 sql SELECT * FROM sys_programs WHERE name = 'bash' AND version = '1' ");
}

TEST_F(VerprotectDBQueryBuilderTest, WhereOrTest)
{
    std::string message = VerprotectDBQueryBuilder::builder()
                              .agent("0")
                              .selectAll()
                              .fromTable("sys_programs")
                              .whereColumn("name")
                              .equalsTo("bash")
                              .orColumn("version")
                              .equalsTo("1")
                              .build();
    EXPECT_EQ(message, "agent 0 sql SELECT * FROM sys_programs WHERE name = 'bash' OR version = '1' ");
}

TEST_F(VerprotectDBQueryBuilderTest, WhereIsNullTest)
{
    std::string message = VerprotectDBQueryBuilder::builder()
                              .agent("0")
                              .selectAll()
                              .fromTable("sys_programs")
                              .whereColumn("name")
                              .isNull()
                              .build();
    EXPECT_EQ(message, "agent 0 sql SELECT * FROM sys_programs WHERE name IS NULL ");
}

TEST_F(VerprotectDBQueryBuilderTest, WhereIsNotNullTest)
{
    std::string message = VerprotectDBQueryBuilder::builder()
                              .agent("0")
                              .selectAll()
                              .fromTable("sys_programs")
                              .whereColumn("name")
                              .isNotNull()
                              .build();
    EXPECT_EQ(message, "agent 0 sql SELECT * FROM sys_programs WHERE name IS NOT NULL ");
}

TEST_F(VerprotectDBQueryBuilderTest, InvalidValue)
{
    EXPECT_THROW(VerprotectDBQueryBuilder::builder()
                     .agent("0")
                     .selectAll()
                     .fromTable("sys_programs")
                     .whereColumn("name")
                     .equalsTo("bash'")
                     .build(),
                 std::runtime_error);
}

TEST_F(VerprotectDBQueryBuilderTest, InvalidColumn)
{
    EXPECT_THROW(VerprotectDBQueryBuilder::builder()
                     .agent("0")
                     .selectAll()
                     .fromTable("sys_programs")
                     .whereColumn("name'")
                     .equalsTo("bash")
                     .build(),
                 std::runtime_error);
}

TEST_F(VerprotectDBQueryBuilderTest, InvalidTable)
{
    EXPECT_THROW(VerprotectDBQueryBuilder::builder()
                     .agent("0")
                     .selectAll()
                     .fromTable("sys_programs'")
                     .whereColumn("name")
                     .equalsTo("bash")
                     .build(),
                 std::runtime_error);
}

TEST_F(VerprotectDBQueryBuilderTest, GlobalGetCommand)
{
    std::string message = VerprotectDBQueryBuilder::builder().globalGetCommand("agent-info 1").build();
    EXPECT_EQ(message, "global get-agent-info 1 ");
}

TEST_F(VerprotectDBQueryBuilderTest, GlobalFindCommand)
{
    std::string message = VerprotectDBQueryBuilder::builder().globalFindCommand("agent 1").build();
    EXPECT_EQ(message, "global find-agent 1 ");
}

TEST_F(VerprotectDBQueryBuilderTest, GlobalSelectCommand)
{
    std::string message = VerprotectDBQueryBuilder::builder().globalSelectCommand("agent-name 1").build();
    EXPECT_EQ(message, "global select-agent-name 1 ");
}

TEST_F(VerprotectDBQueryBuilderTest, AgentGetOsInfoCommand)
{
    std::string message = VerprotectDBQueryBuilder::builder().agentGetOsInfoCommand("1").build();
    EXPECT_EQ(message, "agent 1 osinfo get ");
}

TEST_F(VerprotectDBQueryBuilderTest, AgentGetHotfixesCommand)
{
    std::string message = VerprotectDBQueryBuilder::builder().agentGetHotfixesCommand("1").build();
    EXPECT_EQ(message, "agent 1 hotfix get ");
}

TEST_F(VerprotectDBQueryBuilderTest, AgentGetPackagesCommand)
{
    std::string message = VerprotectDBQueryBuilder::builder().agentGetPackagesCommand("1").build();
    EXPECT_EQ(message, "agent 1 package get ");
}
