Return-Path: <SRS0=y4Wk=RD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590EDC43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 15:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225222184A
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 15:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SoR2uEOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733296AbfB1PAQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:00:16 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12686 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731020AbfB1PAP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Feb 2019 10:00:15 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c77f7880000>; Thu, 28 Feb 2019 07:00:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 28 Feb 2019 07:00:15 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 28 Feb 2019 07:00:15 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 28 Feb
 2019 15:00:14 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 28 Feb 2019 15:00:14 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c77f77b000e>; Thu, 28 Feb 2019 07:00:14 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <treding@nvidia.com>, <swarren@nvidia.com>,
        <mperttunen@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>
Subject: [PATCH] PCI: tegra: Do not allocate MSI target memory
Date:   Thu, 28 Feb 2019 20:30:04 +0530
Message-ID: <1551366004-32547-1-git-send-email-vidyas@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551366024; bh=nh8FOpw/sDroE+nyf1n7xvWkRJGLxIBBTeikoCbhhZA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=SoR2uEOsL2G6qvvGqDRbCtDxgU768+6vDuaGzpdp88Oo8Aym8/VZPSOzw3w69z+wf
         8rJdK2lK7MF1QFLS2c5SndyZMpnDxy7jyXau8mu+ZmEbJmbnrUdxf+UM6CQCeVGC9v
         A46KxahLN1dvusp2aJBG/CWsy6q6pq4idVDfPUhpxTAkNqEejdKs23ug7pVzDw7I3z
         s9ObPiPX7mrWmY0cdGMsVVhM5/W37dkE3E546pxXl2VeCCEbuu2S+kVMzPMphzxx1k
         LVknieF2oVOH7kecDnvUJX8p/sd8feURCdyTA35gk8KTXsCbCHifgqYs64KYt6Zj1S
         mYuXuwaf4nbrw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI host bridge found on Tegra SoCs doesn't require the MSI target
address to be backed by physical system memory. Writes are intercepted
within the controller and never make it to the memory pointed to.

Since no actual system memory is required, remove the allocation of a
single page and hardcode the MSI target address with a special address
on a per-SoC basis. Ideally this would be an address to an MMIO memory
region (such as where the controller's register are located). However,
those addresses don't work reliably across all Tegra generations. The
only set of addresses that work consistently are those that point to
external memory.

This is not ideal, since those addresses could technically be used for
DMA and hence be confusing. However, the first page of external memory
is unlikely to be used and special enough to avoid confusion.

Original base patch was posted by Thierry Reding <treding@nvidia.com>
( http://patchwork.ozlabs.org/patch/848569/ )
Current patch removes hardcoding of external RAM starting address instead
gets it using memblock_start_of_DRAM() API

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/pci-tegra.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index f4f53d092e00..b33de7c78425 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -23,6 +23,7 @@
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/memblock.h>
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
@@ -231,9 +232,8 @@ struct tegra_msi {
 	struct msi_controller chip;
 	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
 	struct irq_domain *domain;
-	unsigned long pages;
 	struct mutex lock;
-	u64 phys;
+	phys_addr_t phys;
 	int irq;
 };
 
@@ -1548,9 +1548,7 @@ static int tegra_pcie_msi_setup(struct tegra_pcie *pcie)
 		goto err;
 	}
 
-	/* setup AFI/FPCI range */
-	msi->pages = __get_free_pages(GFP_KERNEL, 0);
-	msi->phys = virt_to_phys((void *)msi->pages);
+	msi->phys = memblock_start_of_DRAM();
 	host->msi = &msi->chip;
 
 	return 0;
@@ -1592,8 +1590,6 @@ static void tegra_pcie_msi_teardown(struct tegra_pcie *pcie)
 	struct tegra_msi *msi = &pcie->msi;
 	unsigned int i, irq;
 
-	free_pages(msi->pages, 0);
-
 	if (msi->irq > 0)
 		free_irq(msi->irq, pcie);
 
-- 
2.7.4

