Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8F6C43461
	for <linux-pci@archiver.kernel.org>; Wed, 12 May 2021 03:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ABA460FE3
	for <linux-pci@archiver.kernel.org>; Wed, 12 May 2021 03:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhELDvS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 May 2021 23:51:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2450 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhELDvS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 23:51:18 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fg12S1CkbzCrKr;
        Wed, 12 May 2021 11:47:28 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 11:50:00 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <thierry.reding@gmail.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] PCI: tegra: Add missing MODULE_DEVICE_TABLE
Date:   Wed, 12 May 2021 12:07:02 +0800
Message-ID: <1620792422-16535-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/pci/controller/pci-tegra.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 8069bd9..c979229 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2539,6 +2539,7 @@ static const struct of_device_id tegra_pcie_of_match[] = {
 	{ .compatible = "nvidia,tegra20-pcie", .data = &tegra20_pcie },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, tegra_pcie_of_match);
 
 static void *tegra_pcie_ports_seq_start(struct seq_file *s, loff_t *pos)
 {
-- 
2.6.2

