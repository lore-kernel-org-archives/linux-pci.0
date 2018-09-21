Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA549ECE562
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C75A2154B
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HFzUdRN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C75A2154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389812AbeIUQMG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:12:06 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51340 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeIUQMF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2018 12:12:05 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8LANFqq033222;
        Fri, 21 Sep 2018 05:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537525395;
        bh=H3avG6EwoSzk6QdC4/XcOvo10vwjEICQqWTGY5kVX/s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HFzUdRN+Wq9LEtnsLmsAl16fj1KfEYUqoQuP6ZHPcD3OBpYcKDjneezsYdQjfitU6
         KuKyvqzZtVaroM7WMRlHQ0k8UKFofYgYKHtRhvxhvnOj7srFjKHGvbEaoLhhhIJfEs
         z4TSQrtU4ANyEIWALjAeF1XG+yRX2esa/iskSNNg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LANFco029818;
        Fri, 21 Sep 2018 05:23:15 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 21
 Sep 2018 05:23:15 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 21 Sep 2018 05:23:14 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAMEtG032280;
        Fri, 21 Sep 2018 05:23:10 -0500
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
Subject: [RFC PATCH 12/40] PCI: keystone: Use syscon APIs to get device id from control module
Date:   Fri, 21 Sep 2018 15:51:27 +0530
Message-ID: <20180921102155.22839-13-kishon@ti.com>
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

Control module registers should be read using syscon APIs.
pci-keystone.c uses platform_get_resource to get control module registers.
Fix it here by using syscon APIs to get device id from control module.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 46 +++++++++++++++--------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index e19ba065ebd5..505e13b1197d 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -15,12 +15,14 @@
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/init.h>
+#include <linux/mfd/syscon.h>
 #include <linux/msi.h>
 #include <linux/of_irq.h>
 #include <linux/of.h>
 #include <linux/of_pci.h>
 #include <linux/platform_device.h>
 #include <linux/phy/phy.h>
+#include <linux/regmap.h>
 #include <linux/resource.h>
 #include <linux/signal.h>
 
@@ -28,6 +30,9 @@
 
 #define DRIVER_NAME	"keystone-pcie"
 
+#define PCIE_VENDORID_MASK	0xffff
+#define PCIE_DEVICEID_SHIFT	16
+
 /* DEV_STAT_CTRL */
 #define PCIE_CAP_BASE		0x70
 
@@ -92,8 +97,6 @@ static void ks_pcie_stop_link(struct dw_pcie *pci);
 struct keystone_pcie {
 	struct dw_pcie		*pci;
 	struct	clk		*clk;
-	/* PCI Device ID */
-	u32			device_id;
 	int			msi_host_irq;
 	struct			device_node *msi_intc_np;
 	struct irq_domain	*legacy_irq_domain;
@@ -588,6 +591,29 @@ static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
 	return 0;
 }
 
+static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
+{
+	int ret;
+	unsigned int id;
+	struct regmap *devctrl_regs;
+	struct dw_pcie *pci = ks_pcie->pci;
+	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
+
+	devctrl_regs = syscon_regmap_lookup_by_phandle(np, "ti,syscon-pcie-id");
+	if (IS_ERR(devctrl_regs))
+		return PTR_ERR(devctrl_regs);
+
+	ret = regmap_read(devctrl_regs, 0, &id);
+	if (ret)
+		return ret;
+
+	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, id & PCIE_VENDORID_MASK);
+	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, id >> PCIE_DEVICEID_SHIFT);
+
+	return 0;
+}
+
 static int __init ks_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -608,8 +634,9 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
 			pci->dbi_base + PCI_IO_BASE);
 
-	/* update the Vendor ID */
-	writew(ks_pcie->device_id, pci->dbi_base + PCI_DEVICE_ID);
+	ret = ks_pcie_init_id(ks_pcie);
+	if (ret < 0)
+		return ret;
 
 	/*
 	 * PCIe access errors that result into OCP errors are caught by ARM as
@@ -738,8 +765,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
-	struct resource *res;
-	void __iomem *reg_p;
 	struct phy *phy;
 	int ret;
 	int irq;
@@ -768,15 +793,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	/* index 2 is to read PCI DEVICE_ID */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	reg_p = devm_ioremap_resource(dev, res);
-	if (IS_ERR(reg_p))
-		return PTR_ERR(reg_p);
-	ks_pcie->device_id = readl(reg_p) >> 16;
-	devm_iounmap(dev, reg_p);
-	devm_release_mem_region(dev, res->start, resource_size(res));
-
 	ks_pcie->np = dev->of_node;
 
 	irq = platform_get_irq(pdev, 0);
-- 
2.17.1

