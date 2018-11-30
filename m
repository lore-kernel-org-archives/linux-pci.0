Return-Path: <SRS0=gDpg=OJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAABFC64EB4
	for <linux-pci@archiver.kernel.org>; Fri, 30 Nov 2018 18:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9624220867
	for <linux-pci@archiver.kernel.org>; Fri, 30 Nov 2018 18:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9624220867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wwwdotorg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeLAFrr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:47:47 -0500
Received: from avon.wwwdotorg.org ([104.237.132.123]:53346 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeLAFrq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Dec 2018 00:47:46 -0500
Received: from swarren-lx1.nvidia.com (unknown [216.228.112.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPSA id 739471C00E7;
        Fri, 30 Nov 2018 11:37:34 -0700 (MST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at avon.wwwdotorg.org
From:   Stephen Warren <swarren@wwwdotorg.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Vidya Sagar <vidyas@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>
Subject: [PATCH V3] PCI: dwc: Don't hard-code DBI/ATU offset
Date:   Fri, 30 Nov 2018 11:37:19 -0700
Message-Id: <20181130183719.27142-1-swarren@wwwdotorg.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Stephen Warren <swarren@nvidia.com>

The DWC PCIe core contains various separate register spaces: DBI, DBI2,
ATU, DMA, etc. The relationship between the addresses of these register
spaces is entirely determined by the implementation of the IP block, not
by the IP block design itself. Hence, the DWC driver must not make
assumptions that one register space can be accessed at a fixed offset from
any other register space. To avoid such assumptions, introduce an
explicit/separate register pointer for the ATU register space. In
particular, the current assumption is not valid for NVIDIA's T194 SoC.

The ATU register space is only used on systems that require unrolled ATU
access. This property is detected at run-time for host controllers, and
when this is detected, this patch provides a default value for atu_base
that matches the previous assumption re: register layout. An alternative
would be to update all drivers for HW that requires unrolled access to
explicitly set atu_base. However, it's hard to tell which drivers would
require atu_base to be set. The unrolled property is not detected for
endpoint systems, and so any endpoint driver that requires unrolled access
must explicitly set the iatu_unroll_enabled flag (none do at present), and
so a check is added to require the driver to also set atu_base while at
it.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Vidya Sagar <vidyas@nvidia.com>
---
v3:
* Added DEFAULT_DBI_ATU_OFFSET define and associated comment.
v2:
* Modified patch subject
* Added missing outer brackets to PCIE_GET_ATU_INB_UNR_REG_OFFSET macro
---
 .../pci/controller/dwc/pcie-designware-ep.c   |  4 +++
 .../pci/controller/dwc/pcie-designware-host.c |  3 ++
 drivers/pci/controller/dwc/pcie-designware.c  |  8 +++---
 drivers/pci/controller/dwc/pcie-designware.h  | 28 ++++++++++++++++---
 4 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 1e7b02221eac..880210366e71 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -504,6 +504,10 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		dev_err(dev, "dbi_base/dbi_base2 is not populated\n");
 		return -EINVAL;
 	}
+	if (pci->iatu_unroll_enabled && !pci->atu_base) {
+		dev_err(dev, "atu_base is not populated\n");
+		return -EINVAL;
+	}
 
 	ret = of_property_read_u32(np, "num-ib-windows", &ep->num_ib_windows);
 	if (ret < 0) {
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 29a05759a294..692dd1b264fb 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -699,6 +699,9 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		dev_dbg(pci->dev, "iATU unroll: %s\n",
 			pci->iatu_unroll_enabled ? "enabled" : "disabled");
 
+		if (pci->iatu_unroll_enabled && !pci->atu_base)
+			pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
+
 		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
 					  PCIE_ATU_TYPE_MEM, pp->mem_base,
 					  pp->mem_bus_addr, pp->mem_size);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 2153956a0b20..93ef8c31fb39 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -93,7 +93,7 @@ static u32 dw_pcie_readl_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg)
 {
 	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
 
-	return dw_pcie_readl_dbi(pci, offset + reg);
+	return dw_pcie_readl_atu(pci, offset + reg);
 }
 
 static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
@@ -101,7 +101,7 @@ static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
 {
 	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
 
-	dw_pcie_writel_dbi(pci, offset + reg, val);
+	dw_pcie_writel_atu(pci, offset + reg, val);
 }
 
 static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
@@ -187,7 +187,7 @@ static u32 dw_pcie_readl_ib_unroll(struct dw_pcie *pci, u32 index, u32 reg)
 {
 	u32 offset = PCIE_GET_ATU_INB_UNR_REG_OFFSET(index);
 
-	return dw_pcie_readl_dbi(pci, offset + reg);
+	return dw_pcie_readl_atu(pci, offset + reg);
 }
 
 static void dw_pcie_writel_ib_unroll(struct dw_pcie *pci, u32 index, u32 reg,
@@ -195,7 +195,7 @@ static void dw_pcie_writel_ib_unroll(struct dw_pcie *pci, u32 index, u32 reg,
 {
 	u32 offset = PCIE_GET_ATU_INB_UNR_REG_OFFSET(index);
 
-	dw_pcie_writel_dbi(pci, offset + reg, val);
+	dw_pcie_writel_atu(pci, offset + reg, val);
 }
 
 static int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, int index,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 0989d880ac46..9943d8c68335 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -92,12 +92,20 @@
 #define PCIE_ATU_UNR_LOWER_TARGET	0x14
 #define PCIE_ATU_UNR_UPPER_TARGET	0x18
 
+/*
+ * The default address offset between dbi_base and atu_base. Root controller
+ * drivers are not required to initialize atu_base if the offset matches this
+ * default; the driver core automatically derives atu_base from dbi_base using
+ * this offset, if atu_base not set.
+ */
+#define DEFAULT_DBI_ATU_OFFSET (0x3 << 20)
+
 /* Register address builder */
-#define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region)	\
-			((0x3 << 20) | ((region) << 9))
+#define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region) \
+		((region) << 9)
 
-#define PCIE_GET_ATU_INB_UNR_REG_OFFSET(region)				\
-			((0x3 << 20) | ((region) << 9) | (0x1 << 8))
+#define PCIE_GET_ATU_INB_UNR_REG_OFFSET(region) \
+		(((region) << 9) | (0x1 << 8))
 
 #define MAX_MSI_IRQS			256
 #define MAX_MSI_IRQS_PER_CTRL		32
@@ -219,6 +227,8 @@ struct dw_pcie {
 	struct device		*dev;
 	void __iomem		*dbi_base;
 	void __iomem		*dbi_base2;
+	/* Used when iatu_unroll_enabled is true */
+	void __iomem		*atu_base;
 	u32			num_viewport;
 	u8			iatu_unroll_enabled;
 	struct pcie_port	pp;
@@ -289,6 +299,16 @@ static inline u32 dw_pcie_readl_dbi2(struct dw_pcie *pci, u32 reg)
 	return __dw_pcie_read_dbi(pci, pci->dbi_base2, reg, 0x4);
 }
 
+static inline void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u32 val)
+{
+	__dw_pcie_write_dbi(pci, pci->atu_base, reg, 0x4, val);
+}
+
+static inline u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 reg)
+{
+	return __dw_pcie_read_dbi(pci, pci->atu_base, reg, 0x4);
+}
+
 static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
 {
 	u32 reg;
-- 
2.19.2

