Return-Path: <SRS0=VYo7=45=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D71FC10DCE
	for <linux-pci@archiver.kernel.org>; Thu, 12 Mar 2020 11:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C725206F1
	for <linux-pci@archiver.kernel.org>; Thu, 12 Mar 2020 11:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgCLL1G (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 12 Mar 2020 07:27:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11639 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725268AbgCLL1G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 07:27:06 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 907182A9F5E0C91E64CD;
        Thu, 12 Mar 2020 19:27:00 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 12 Mar 2020 19:26:50 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <rajatja@google.com>
CC:     <f.fangjian@huawei.com>, <huangdaode@huawei.com>
Subject: [PATCH] PCI/PM: Fix wrong field set when config L1SS
Date:   Thu, 12 Mar 2020 19:23:11 +0800
Message-ID: <1584012191-34129-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We enable proper L1 substates in the end of pcie_config_aspm_l1ss(). It's
PCI_L1SS_CTL1_L1SS_MASK field should we set in PCI_L1SS_CTL1 register
rather than PCI_L1SS_CAP_L1_PM_SS.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/pcie/aspm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 0dcd443..c2596e7 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -747,9 +747,9 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 
 	/* Enable what we need to enable */
 	pci_clear_and_set_dword(parent, up_cap_ptr + PCI_L1SS_CTL1,
-				PCI_L1SS_CAP_L1_PM_SS, val);
+				PCI_L1SS_CTL1_L1SS_MASK, val);
 	pci_clear_and_set_dword(child, dw_cap_ptr + PCI_L1SS_CTL1,
-				PCI_L1SS_CAP_L1_PM_SS, val);
+				PCI_L1SS_CTL1_L1SS_MASK, val);
 }
 
 static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
-- 
2.8.1

