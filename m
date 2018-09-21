Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D757ECE562
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C9A21531
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VwuDKgWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C9A21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389910AbeIUQMQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:12:16 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35058 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389870AbeIUQMQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2018 12:12:16 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8LANiKA030497;
        Fri, 21 Sep 2018 05:23:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537525424;
        bh=aLOPdoi1dv1LS3olqchzfw2j8dRX8NpDokKZcMrJhcI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VwuDKgWwiZZnUMcTG6ntXNhTAKBZhvx6XGQ69PM+L5pWZIL5gruYD8nEZrJKEXRcg
         6LVA9t2XmB+i59ob8J5Ee6aGbJU7EigKWScnXGqUC8Ui2Sc+5iYEVR60OWnlxGDyUp
         lj4+VWOT6VNMj5eriHo0R+h02rHPvLk5xiuSFiOs=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LANihS030188;
        Fri, 21 Sep 2018 05:23:44 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 21
 Sep 2018 05:23:44 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 21 Sep 2018 05:23:44 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAMEtM032280;
        Fri, 21 Sep 2018 05:23:40 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <Gustavo.Pimentel@synopsys.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 18/40] PCI: keystone: Get number of OB windows from DT and cleanup MEM space configuration
Date:   Fri, 21 Sep 2018 15:51:33 +0530
Message-ID: <20180921102155.22839-19-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of having a fixed outbound window count, get the number of
outbound windows from device tree. Also cleanup memory space configuration
here by adding macros for constants.

While at that also use BIT() macro for OB_XLAT_EN_VAL.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 86 +++++++++++++----------
 1 file changed, 49 insertions(+), 37 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 3ead1162235f..d5304c4a1eb5 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -41,7 +41,7 @@
 #define LTSSM_STATE_MASK		0x1f
 #define LTSSM_STATE_L0			0x11
 #define DBI_CS2_EN_VAL			0x20
-#define OB_XLAT_EN_VAL		        2
+#define OB_XLAT_EN_VAL		        BIT(1)
 
 /* Application registers */
 #define CMD_STATUS			0x004
@@ -53,10 +53,7 @@
 #define CFG_TYPE1			BIT(24)
 
 #define OB_SIZE				0x030
-#define CFG_PCIM_WIN_SZ_IDX		3
-#define CFG_PCIM_WIN_CNT		32
-#define OB_OFFSET_INDEX(n)		(0x200 + (8 * n))
-#define OB_OFFSET_HI(n)			(0x204 + (8 * n))
+#define OB_WIN_SIZE			8	/* 8MB */
 
 /* IRQ register defines */
 #define IRQ_EOI				0x050
@@ -85,6 +82,11 @@
 #define ERR_IRQ_ENABLE_SET		0x1c8
 #define ERR_IRQ_ENABLE_CLR		0x1cc
 
+#define OB_OFFSET_INDEX(n)		(0x200 + (8 * (n)))
+#define OB_ENABLEN			BIT(0)
+
+#define OB_OFFSET_HI(n)			(0x204 + (8 * (n)))
+
 /* Config space registers */
 #define DEBUG0				0x728
 
@@ -102,6 +104,7 @@ static void ks_pcie_stop_link(struct dw_pcie *pci);
 struct keystone_pcie {
 	struct dw_pcie		*pci;
 	int			num_lanes;
+	u32			num_viewport;
 	struct phy		**phy;
 	struct device_link	**link;
 	int			msi_host_irq;
@@ -236,37 +239,6 @@ static void ks_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
 	} while (val & DBI_CS2_EN_VAL);
 }
 
-static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
-{
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
-	u32 start = pp->mem->start, end = pp->mem->end;
-	int i, tr_size;
-	u32 val;
-
-	/* Disable BARs for inbound access */
-	ks_pcie_set_dbi_mode(ks_pcie);
-	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
-	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0);
-	ks_pcie_clear_dbi_mode(ks_pcie);
-
-	/* Set outbound translation size per window division */
-	ks_pcie_app_writel(ks_pcie, OB_SIZE, CFG_PCIM_WIN_SZ_IDX & 0x7);
-
-	tr_size = (1 << (CFG_PCIM_WIN_SZ_IDX & 0x7)) * SZ_1M;
-
-	/* Using Direct 1:1 mapping of RC <-> PCI memory space */
-	for (i = 0; (i < CFG_PCIM_WIN_CNT) && (start < end); i++) {
-		ks_pcie_app_writel(ks_pcie, OB_OFFSET_INDEX(i), start | 1);
-		ks_pcie_app_writel(ks_pcie, OB_OFFSET_HI(i), 0);
-		start += tr_size;
-	}
-
-	/* Enable OB translation */
-	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
-	ks_pcie_app_writel(ks_pcie, CMD_STATUS, OB_XLAT_EN_VAL | val);
-}
-
 static int ks_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 				 unsigned int devfn, int where, int size,
 				 u32 *val)
@@ -562,6 +534,33 @@ static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
 	return 0;
 }
 
+static void ks_pcie_setup_mem_space(struct keystone_pcie *ks_pcie)
+{
+	u32 val;
+	u32 num_viewport = ks_pcie->num_viewport;
+	struct dw_pcie *pci = ks_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+	u64 start = pp->mem->start;
+	u64 end = pp->mem->end;
+	int i;
+
+	val = ilog2(OB_WIN_SIZE);
+	ks_pcie_app_writel(ks_pcie, OB_SIZE, val);
+
+	/* Using Direct 1:1 mapping of RC <-> PCI memory space */
+	for (i = 0; i < num_viewport && (start < end); i++) {
+		ks_pcie_app_writel(ks_pcie, OB_OFFSET_INDEX(i),
+				   lower_32_bits(start) | OB_ENABLEN);
+		ks_pcie_app_writel(ks_pcie, OB_OFFSET_HI(i),
+				   upper_32_bits(start));
+		start += OB_WIN_SIZE;
+	}
+
+	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
+	val |= OB_XLAT_EN_VAL;
+	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);
+}
+
 static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
 {
 	int ret;
@@ -601,7 +600,12 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_setup_rc(pp);
 
-	ks_pcie_setup_rc_app_regs(ks_pcie);
+	ks_pcie_set_dbi_mode(ks_pcie);
+	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
+	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0);
+	ks_pcie_clear_dbi_mode(ks_pcie);
+
+	ks_pcie_setup_mem_space(ks_pcie);
 	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
 			pci->dbi_base + PCI_IO_BASE);
 
@@ -770,6 +774,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
 	struct device_link **link;
+	u32 num_viewport;
 	struct phy **phy;
 	u32 num_lanes;
 	char name[10];
@@ -788,6 +793,12 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	pci->dev = dev;
 	pci->ops = &ks_pcie_dw_pcie_ops;
 
+	ret = of_property_read_u32(np, "num-viewport", &num_viewport);
+	if (ret < 0) {
+		dev_err(dev, "unable to read *num-viewport* property\n");
+		return ret;
+	}
+
 	ret = of_property_read_u32(np, "num-lanes", &num_lanes);
 	if (ret)
 		num_lanes = 1;
@@ -831,6 +842,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	ks_pcie->link = link;
 	ks_pcie->np = np;
 	ks_pcie->num_lanes = num_lanes;
+	ks_pcie->num_viewport = num_viewport;
 	ks_pcie->phy = phy;
 
 	irq = platform_get_irq(pdev, 0);
-- 
2.17.1

