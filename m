Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A19C4345B
	for <linux-pci@archiver.kernel.org>; Sat, 27 Mar 2021 07:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B100619F7
	for <linux-pci@archiver.kernel.org>; Sat, 27 Mar 2021 07:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhC0Htp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 27 Mar 2021 03:49:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15347 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhC0HtU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 03:49:20 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F6rXK5qBWz93ym;
        Sat, 27 Mar 2021 15:47:13 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 15:49:06 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <rui.zhang@intel.com>,
        <bhelgaas@google.com>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v2 13/15] ACPI: PM: fix some coding style issues
Date:   Sat, 27 Mar 2021 15:46:31 +0800
Message-ID: <1616831193-17920-14-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616831193-17920-1-git-send-email-tanxiaofei@huawei.com>
References: <1616831193-17920-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix the following coding style issue reported by checkpatch.pl

WARNING: Missing a blank line after declarations

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/acpi/device_pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 0961537..16c0fe8 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -966,6 +966,7 @@ EXPORT_SYMBOL_GPL(acpi_dev_resume);
 int acpi_subsys_runtime_suspend(struct device *dev)
 {
 	int ret = pm_generic_runtime_suspend(dev);
+
 	return ret ? ret : acpi_dev_suspend(dev, true);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_runtime_suspend);
@@ -980,6 +981,7 @@ EXPORT_SYMBOL_GPL(acpi_subsys_runtime_suspend);
 int acpi_subsys_runtime_resume(struct device *dev)
 {
 	int ret = acpi_dev_resume(dev);
+
 	return ret ? ret : pm_generic_runtime_resume(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_runtime_resume);
@@ -1171,6 +1173,7 @@ EXPORT_SYMBOL_GPL(acpi_subsys_freeze);
 int acpi_subsys_restore_early(struct device *dev)
 {
 	int ret = acpi_dev_resume(dev);
+
 	return ret ? ret : pm_generic_restore_early(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_restore_early);
-- 
2.8.1

