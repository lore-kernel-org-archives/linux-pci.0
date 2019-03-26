Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33987C4360F
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 15:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E583120823
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 15:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GaaQF+PP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbfCZPOp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:14:45 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18276 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731715AbfCZPOo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2019 11:14:44 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9a41e00000>; Tue, 26 Mar 2019 08:14:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 08:14:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 26 Mar 2019 08:14:42 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Mar
 2019 15:14:42 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 26 Mar 2019 15:14:42 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c9a41d80002>; Tue, 26 Mar 2019 08:14:42 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <lorenzo.pieralisi@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <mperttunen@nvidia.com>, <vidyas@nvidia.com>, <tiwai@suse.de>,
        <spujar@nvidia.com>, <skomatineni@nvidia.com>,
        <liviu.dudau@arm.com>, <krzk@kernel.org>, <heiko@sntech.de>,
        <horms+renesas@verge.net.au>, <olof@lixom.net>,
        <maxime.ripard@bootlin.com>, <andy.gross@linaro.org>,
        <bjorn.andersson@linaro.org>, <jagan@amarulasolutions.com>,
        <enric.balletbo@collabora.com>, <ezequiel@collabora.com>,
        <stefan.wahren@i2se.com>, <marc.w.gonzalez@free.fr>,
        <l.stach@pengutronix.de>, <tpiepho@impinj.com>,
        <hayashi.kunihiko@socionext.com>, <yue.wang@amlogic.com>,
        <shawn.lin@rock-chips.com>, <xiaowei.bao@nxp.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>
Subject: [PATCH 03/10] PCI: dwc: Move config space capability search API
Date:   Tue, 26 Mar 2019 20:43:20 +0530
Message-ID: <1553613207-3988-4-git-send-email-vidyas@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553613207-3988-1-git-send-email-vidyas@nvidia.com>
References: <1553613207-3988-1-git-send-email-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553613281; bh=jA1rXy4IhFHqoYDqVJTpYSEhemUpZ2dfb3d4fEitaIA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=GaaQF+PPXfz2jaBMZkT6N7uOPocjgSHXdWgaK54euV50DRNX1qYoVRyKtFCL/vHjy
         Gs1fvT7wsR1L3oSqb4B0WK1VrlHfR+mOpSpU6vUvzKnx6oqIik4CwG3LAQxOTYD5Xt
         dqO++f4CNiXRQ+jmEo9mTG7duIO5KwyRkeWhz/hDPC6KU/JILbrr74GFhknU9F0nch
         1yzRgvomI30tufrr45K4m4Is9VluamMA/tvfZZG7mhab3Ot26yrOt8s3EtEYhnH+6f
         U/cU37u6wAR8U3g75jDmcvl5ICjDFI5fgQDyUEhLg4042BC2W4uhWk7mHj6cJkjlu3
         yjyer3gxrbGjg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

move PCIe config space capability search API to common designware file
as this can be used by both host and ep mode codes.
It also adds extended capability search APIs.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 37 +------------
 drivers/pci/controller/dwc/pcie-designware.c    | 73 +++++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h    |  3 +
 3 files changed, 78 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 24f5a775ad34..b9d9c9a4ba6d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -40,39 +40,6 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
 	__dw_pcie_ep_reset_bar(pci, bar, 0);
 }
 
-static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
-			      u8 cap)
-{
-	u8 cap_id, next_cap_ptr;
-	u16 reg;
-
-	reg = dw_pcie_readw_dbi(pci, cap_ptr);
-	next_cap_ptr = (reg & 0xff00) >> 8;
-	cap_id = (reg & 0x00ff);
-
-	if (!next_cap_ptr || cap_id > PCI_CAP_ID_MAX)
-		return 0;
-
-	if (cap_id == cap)
-		return cap_ptr;
-
-	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
-}
-
-static u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap)
-{
-	u8 next_cap_ptr;
-	u16 reg;
-
-	reg = dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
-	next_cap_ptr = (reg & 0x00ff);
-
-	if (!next_cap_ptr)
-		return 0;
-
-	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
-}
-
 static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no,
 				   struct pci_epf_header *hdr)
 {
@@ -591,9 +558,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		dev_err(dev, "Failed to reserve memory for MSI/MSI-X\n");
 		return -ENOMEM;
 	}
-	ep->msi_cap = dw_pcie_ep_find_capability(pci, PCI_CAP_ID_MSI);
+	ep->msi_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
 
-	ep->msix_cap = dw_pcie_ep_find_capability(pci, PCI_CAP_ID_MSIX);
+	ep->msix_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSIX);
 
 	dw_pcie_setup(pci);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 31f6331ca46f..164a63b7688a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -20,6 +20,79 @@
 #define PCIE_PHY_DEBUG_R1_LINK_UP	(0x1 << 4)
 #define PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING	(0x1 << 29)
 
+static u8 __dw_pcie_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
+				  u8 cap)
+{
+	u8 cap_id, next_cap_ptr;
+	u16 reg;
+
+	reg = dw_pcie_readw_dbi(pci, cap_ptr);
+	next_cap_ptr = (reg & 0xff00) >> 8;
+	cap_id = (reg & 0x00ff);
+
+	if (!next_cap_ptr || cap_id > PCI_CAP_ID_MAX)
+		return 0;
+
+	if (cap_id == cap)
+		return cap_ptr;
+
+	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
+}
+
+u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
+{
+	u8 next_cap_ptr;
+	u16 reg;
+
+	reg = dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
+	next_cap_ptr = (reg & 0x00ff);
+
+	if (!next_cap_ptr)
+		return 0;
+
+	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
+}
+
+static int dw_pcie_find_next_ext_capability(struct dw_pcie *pci, int start,
+					    int cap)
+{
+	u32 header;
+	int ttl;
+	int pos = PCI_CFG_SPACE_SIZE;
+
+	/* minimum 8 bytes per capability */
+	ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
+
+	if (start)
+		pos = start;
+
+	header = dw_pcie_readl_dbi(pci, pos);
+	/*
+	 * If we have no capabilities, this is indicated by cap ID,
+	 * cap version and next pointer all being 0.
+	 */
+	if (header == 0)
+		return 0;
+
+	while (ttl-- > 0) {
+		if (PCI_EXT_CAP_ID(header) == cap && pos != start)
+			return pos;
+
+		pos = PCI_EXT_CAP_NEXT(header);
+		if (pos < PCI_CFG_SPACE_SIZE)
+			break;
+
+		header = dw_pcie_readl_dbi(pci, pos);
+	}
+
+	return 0;
+}
+
+int dw_pcie_find_ext_capability(struct dw_pcie *pci, int cap)
+{
+	return dw_pcie_find_next_ext_capability(pci, 0, cap);
+}
+
 int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 {
 	if (!IS_ALIGNED((uintptr_t)addr, size)) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 70007276bc93..47996f433a57 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -246,6 +246,9 @@ struct dw_pcie {
 #define to_dw_pcie_from_ep(endpoint)   \
 		container_of((endpoint), struct dw_pcie, ep)
 
+u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
+int dw_pcie_find_ext_capability(struct dw_pcie *pci, int cap);
+
 int dw_pcie_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_write(void __iomem *addr, int size, u32 val);
 
-- 
2.7.4

