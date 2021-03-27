Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3435DC433E4
	for <linux-pci@archiver.kernel.org>; Sat, 27 Mar 2021 12:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A57B619A3
	for <linux-pci@archiver.kernel.org>; Sat, 27 Mar 2021 12:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhC0MLS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 27 Mar 2021 08:11:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15020 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhC0MLQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 08:11:16 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6yKt5Vc4zPqLZ;
        Sat, 27 Mar 2021 20:08:34 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 20:11:00 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <rui.zhang@intel.com>,
        <bhelgaas@google.com>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v3 05/12] ACPI: acpi_pad: add a missed blank line after declarations
Date:   Sat, 27 Mar 2021 20:08:17 +0800
Message-ID: <1616846904-25719-6-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616846904-25719-1-git-send-email-tanxiaofei@huawei.com>
References: <1616846904-25719-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a missed blank line after declarations, reported by checkpatch.pl.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/acpi/acpi_pad.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index b84ab72..df4adeb 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -128,6 +128,7 @@ static void round_robin_cpu(unsigned int tsk_index)
 static void exit_round_robin(unsigned int tsk_index)
 {
 	struct cpumask *pad_busy_cpus = to_cpumask(pad_busy_cpus_bits);
+
 	cpumask_clear_cpu(tsk_in_cpu[tsk_index], pad_busy_cpus);
 	tsk_in_cpu[tsk_index] = -1;
 }
@@ -265,6 +266,7 @@ static ssize_t rrtime_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	unsigned long num;
+
 	if (kstrtoul(buf, 0, &num))
 		return -EINVAL;
 	if (num < 1 || num >= 100)
@@ -286,6 +288,7 @@ static ssize_t idlepct_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	unsigned long num;
+
 	if (kstrtoul(buf, 0, &num))
 		return -EINVAL;
 	if (num < 1 || num >= 100)
@@ -307,6 +310,7 @@ static ssize_t idlecpus_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	unsigned long num;
+
 	if (kstrtoul(buf, 0, &num))
 		return -EINVAL;
 	mutex_lock(&isolated_cpus_lock);
-- 
2.8.1

