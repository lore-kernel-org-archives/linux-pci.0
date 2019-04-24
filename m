Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A97FC10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 05:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49458218FD
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 05:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dMZkZdai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfDXFUl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 01:20:41 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6573 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfDXFUl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 01:20:41 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbff20f0000>; Tue, 23 Apr 2019 22:20:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 23 Apr 2019 22:20:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 23 Apr 2019 22:20:40 -0700
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Apr
 2019 05:20:39 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 24 Apr 2019 05:20:39 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cbff2220000>; Tue, 23 Apr 2019 22:20:39 -0700
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
Subject: [PATCH V5 02/16] PCI/PME: Export pcie_pme_disable_msi() & pcie_pme_no_msi() APIs
Date:   Wed, 24 Apr 2019 10:49:50 +0530
Message-ID: <20190424052004.6270-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424052004.6270-1-vidyas@nvidia.com>
References: <20190424052004.6270-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556083215; bh=IiOzdeBKzL22tHGCI5w4QPNVTsJP5Kz18SS1lXZ+Ys8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=dMZkZdaibjuuh2Y9UN0YerBvYdQLdb9mbWmCFF1s6ybpFikYgx/hoocFnOLKPGYKf
         NmJto0m6AKTDpI0Y9KeOe/0gEVuVy1T6BcsTynEhNy3TYE3jVt7k4akSb7tXnZ7ItL
         u9bXEtwq0Xs6Zo3dZ/94FeXFf9tWGSUsnSRDt+ZygbkG4ZQChWs28XEjKshjGXiD2H
         W4dMc5bsJdHZOpnTzDH3dsx//svJ2MTIqGCH42vvqA++db5DklceeOpWNQC7w7vMRA
         BeLlUuw/WjoYwkNs+FOeBEt8YFhBkO4+QXfOuVFwSC38CAYWggUVFcanW3R0Vp1SNG
         8VMX9vkE1WArg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Export pcie_pme_disable_msi() & pcie_pme_no_msi() APIs to enable drivers
using this API be able to build as loadable modules.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes from [v4]:
* None

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

