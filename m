Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F535C10F14
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 08:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26AA217D4
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 08:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jjVJXoOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfDWI1z (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:27:55 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3376 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfDWI1y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 04:27:54 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbecc8f0001>; Tue, 23 Apr 2019 01:27:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Apr 2019 01:27:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Apr 2019 01:27:53 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 08:27:52 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 23 Apr 2019 08:27:52 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cbecc830000>; Tue, 23 Apr 2019 01:27:52 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kishon@ti.com>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V4 02/16] PCI/PME: Export pcie_pme_disable_msi() & pcie_pme_no_msi() APIs
Date:   Tue, 23 Apr 2019 13:57:16 +0530
Message-ID: <20190423082730.370-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423082730.370-1-vidyas@nvidia.com>
References: <20190423082730.370-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556008079; bh=s9FKB/UlKWlI0QtiVbZWlB/Un1zxv2S8d6/ZljlgP0E=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=jjVJXoOu1ZWESRPP8WvVd7KUalLA+wk1pPRmOSiBryeLE5j1q6+5iHMXeZvPa9trU
         97s2Ve2PROxIaxY9UDKfzjbKeBcOQvad596aifld6QedZgXEc8CIJVtX/muECagxkE
         fX1gSue4YQt+wo7sDWJy30RYVX9MUd2wouuMQS3rJJ1KdIDr+fYnuY5VDV2ro193ZJ
         7cfeWhmfYPkzzH6xbUmtX2PlCZzksNnBUIAvXgNSHf7kTuN/7fGVV/FfhclBVOxj6d
         Fl9pi3tMduAG5+my+zGv/am/mSjGTaZklg7zRJ07NDk2SS/zAZvczyX8JbgoL4Cr8P
         9fOr6+Ds2esiQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Export pcie_pme_disable_msi() & pcie_pme_no_msi() APIs to enable drivers
using this API be able to build as loadable modules.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes from [v3]:
* None

Changes from [v2]:
* Exported pcie_pme_no_msi() API after making pcie_pme_msi_disabled a static

Changes from [v1]:
* This is a new patch in v2 series

 drivers/pci/pcie/pme.c     | 14 +++++++++++++-
 drivers/pci/pcie/portdrv.h | 16 +++-------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 54d593d10396..d5e0ea4a62fc 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -25,7 +25,19 @@
  * that using MSI for PCIe PME signaling doesn't play well with PCIe PME-based
  * wake-up from system sleep states.
  */
-bool pcie_pme_msi_disabled;
+static bool pcie_pme_msi_disabled;
+
+void pcie_pme_disable_msi(void)
+{
+	pcie_pme_msi_disabled = true;
+}
+EXPORT_SYMBOL_GPL(pcie_pme_disable_msi);
+
+bool pcie_pme_no_msi(void)
+{
+	return pcie_pme_msi_disabled;
+}
+EXPORT_SYMBOL_GPL(pcie_pme_no_msi);
 
 static int __init pcie_pme_setup(char *str)
 {
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 1d50dc58ac40..7c8c3da4bd58 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -125,22 +125,12 @@ void pcie_port_bus_unregister(void);
 struct pci_dev;
 
 #ifdef CONFIG_PCIE_PME
-extern bool pcie_pme_msi_disabled;
-
-static inline void pcie_pme_disable_msi(void)
-{
-	pcie_pme_msi_disabled = true;
-}
-
-static inline bool pcie_pme_no_msi(void)
-{
-	return pcie_pme_msi_disabled;
-}
-
+void pcie_pme_disable_msi(void);
+bool pcie_pme_no_msi(void);
 void pcie_pme_interrupt_enable(struct pci_dev *dev, bool enable);
 #else /* !CONFIG_PCIE_PME */
 static inline void pcie_pme_disable_msi(void) {}
-static inline bool pcie_pme_no_msi(void) { return false; }
+static inline bool pcie_pme_no_msi(void) {}
 static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
 #endif /* !CONFIG_PCIE_PME */
 
-- 
2.17.1

