Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511FBC71130
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 13:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176DA20652
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 13:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fgizKdNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176DA20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeJOUyU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:54:20 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47964 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeJOUyU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Oct 2018 16:54:20 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9FD8Xid123815;
        Mon, 15 Oct 2018 08:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539608913;
        bh=I+8oB3slUMP8h64wG5S3UqrQQp1pEImCeexOuq//BTs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fgizKdNvy5mPKPo/4QrZKVnn5YTB7KYLVHhSJ0YpezWODF3V4aPFCDGePshJanU2d
         DxQ9sdf8wVfs5kQPjJtN51W2211/ASAMJCE+jNsgGo2oDdrbe6j7bYoWC/p6/8UEcW
         cU2dYfxFtpojYJPWhp4/AHcDCthXXgBXI0U3D8AY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9FD8Xvn011585;
        Mon, 15 Oct 2018 08:08:33 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 15
 Oct 2018 08:08:32 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 15 Oct 2018 08:08:32 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9FD7tLD009433;
        Mon, 15 Oct 2018 08:08:29 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 10/19] PCI: keystone: Use syscon APIs to get device id from control module
Date:   Mon, 15 Oct 2018 18:37:12 +0530
Message-ID: <20181015130721.5535-11-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181015130721.5535-1-kishon@ti.com>
References: <20181015130721.5535-1-kishon@ti.com>
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
 drivers/pci/controller/dwc/pci-keystone.c | 45 ++++++++++++++++-------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index e2045b5d2af2..e22328f89c84 100644
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
 
@@ -744,10 +749,34 @@ static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
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
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+	int ret;
 
 	dw_pcie_setup_rc(pp);
 
@@ -757,8 +786,9 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
 			pci->dbi_base + PCI_IO_BASE);
 
-	/* update the Vendor ID */
-	writew(ks_pcie->device_id, pci->dbi_base + PCI_DEVICE_ID);
+	ret = ks_pcie_init_id(ks_pcie);
+	if (ret < 0)
+		return ret;
 
 	/*
 	 * PCIe access errors that result into OCP errors are caught by ARM as
@@ -864,8 +894,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
-	struct resource *res;
-	void __iomem *reg_p;
 	struct phy *phy;
 	int ret;
 
@@ -893,15 +921,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
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
 	platform_set_drvdata(pdev, ks_pcie);
 	ks_pcie->clk = devm_clk_get(dev, "pcie");
-- 
2.17.1

