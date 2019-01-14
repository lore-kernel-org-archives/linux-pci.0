Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4ACC43612
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 13:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F3820896
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 13:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IJ723G5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfANN04 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:26:56 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40996 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfANN0v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2019 08:26:51 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EDQ43l041457;
        Mon, 14 Jan 2019 07:26:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547472364;
        bh=OZSg3KxEAkBQw95faHATjuj/IFNC3Uemo5moPFtSIKo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IJ723G5k3K6h3SXYv+Z4a5ah7mB+U6PkRzzBF/H8xU74bFDWfIQEsqqtvykZWADM1
         rdy2yWE/HaRTkdAp2XiWLI8QEJXHWPF5LWC3tTuZMbqCH7A2kcqI0Tl/KImXrGzqBP
         0L7BiR3TyL5TVQtRQUBFTSEydZ9a9zJ6EQ9Rht4U=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EDQ4rk057065
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 07:26:04 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 07:26:04 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 07:26:03 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EDOoWa028516;
        Mon, 14 Jan 2019 07:25:59 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-arm-kernel@axis.com>
Subject: [PATCH 14/24] PCI: keystone: Add support for PCIe RC in AM654x Platforms
Date:   Mon, 14 Jan 2019 18:54:14 +0530
Message-ID: <20190114132424.6445-15-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114132424.6445-1-kishon@ti.com>
References: <20190114132424.6445-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe RC support for AM654x Platforms in pci-keystone.c

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/Kconfig        |   2 +-
 drivers/pci/controller/dwc/pci-keystone.c | 124 +++++++++++++++++++---
 2 files changed, 113 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 548c58223868..0bb19e268a8a 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -104,7 +104,7 @@ config PCIE_SPEAR13XX
 
 config PCI_KEYSTONE
 	bool "TI Keystone PCIe controller"
-	depends on ARCH_KEYSTONE || (ARM && COMPILE_TEST)
+	depends on ARCH_KEYSTONE || ARCH_K3 || ((ARM || ARM64) && COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	help
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 9d7cedd96505..c2873339809a 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -18,6 +18,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/msi.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
@@ -88,8 +89,15 @@
 
 #define KS_PCIE_SYSCLOCKOUTEN		BIT(0)
 
+#define AM654_PCIE_DEV_TYPE_MASK	0x3
+
 #define to_keystone_pcie(x)		dev_get_drvdata((x)->dev)
 
+struct ks_pcie_of_data {
+	const struct dw_pcie_host_ops *host_ops;
+	unsigned int version;
+};
+
 struct keystone_pcie {
 	struct dw_pcie		*pci;
 	/* PCI Device ID */
@@ -229,6 +237,16 @@ static int ks_pcie_msi_host_init(struct pcie_port *pp)
 	return dw_pcie_allocate_domains(pp);
 }
 
+static int ks_pcie_am654_msi_host_init(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
+
+	dev_vdbg(dev, "dummy function so that DW core doesn't configure MSI\n");
+
+	return 0;
+}
+
 static void ks_pcie_enable_error_irq(struct keystone_pcie *ks_pcie)
 {
 	ks_pcie_app_writel(ks_pcie, ERR_IRQ_ENABLE_SET, ERR_IRQ_ALL);
@@ -325,6 +343,8 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 	u32 val;
 	u32 num_viewport = ks_pcie->num_viewport;
 	struct dw_pcie *pci = ks_pcie->pci;
+	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
 	struct pcie_port *pp = &pci->pp;
 	u64 start = pp->mem->start;
 	u64 end = pp->mem->end;
@@ -336,6 +356,9 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0);
 	ks_pcie_clear_dbi_mode(ks_pcie);
 
+	if (of_device_is_compatible(np, "ti,am654-pcie-rc"))
+		return;
+
 	val = ilog2(OB_WIN_SIZE);
 	ks_pcie_app_writel(ks_pcie, OB_SIZE, val);
 
@@ -597,6 +620,8 @@ static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
 
 	intc_np = of_get_child_by_name(np, "msi-interrupt-controller");
 	if (!intc_np) {
+		if (of_device_is_compatible(np, "ti,am654-pcie-rc"))
+			return 0;
 		dev_WARN(dev, "msi-interrupt-controller node is absent\n");
 		return -EINVAL;
 	}
@@ -732,8 +757,10 @@ static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
 	if (ret)
 		return ret;
 
+	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, id & PCIE_VENDORID_MASK);
 	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, id >> PCIE_DEVICEID_SHIFT);
+	dw_pcie_dbi_ro_wr_dis(pci);
 
 	return 0;
 }
@@ -786,6 +813,11 @@ static const struct dw_pcie_host_ops ks_pcie_host_ops = {
 	.scan_bus = ks_pcie_v3_65_scan_bus,
 };
 
+static const struct dw_pcie_host_ops ks_pcie_am654_host_ops = {
+	.host_init = ks_pcie_host_init,
+	.msi_host_init = ks_pcie_am654_msi_host_init,
+};
+
 static irqreturn_t ks_pcie_err_irq_handler(int irq, void *priv)
 {
 	struct keystone_pcie *ks_pcie = priv;
@@ -809,7 +841,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
 
 	pp->va_cfg1_base = pp->va_cfg0_base;
 
-	pp->ops = &ks_pcie_host_ops;
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "failed to initialize host\n");
@@ -819,14 +850,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
 	return 0;
 }
 
-static const struct of_device_id ks_pcie_of_match[] = {
-	{
-		.type = "pci",
-		.compatible = "ti,keystone-pcie",
-	},
-	{ },
-};
-
 static const struct dw_pcie_ops ks_pcie_dw_pcie_ops = {
 	.start_link = ks_pcie_start_link,
 	.stop_link = ks_pcie_stop_link,
@@ -896,14 +919,66 @@ static int ks_pcie_set_mode(struct device *dev)
 	return 0;
 }
 
+static int ks_pcie_am654_set_mode(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct regmap *syscon;
+	u32 val;
+	u32 mask;
+	int ret = 0;
+
+	syscon = syscon_regmap_lookup_by_phandle(np, "ti,syscon-pcie-mode");
+	if (IS_ERR(syscon))
+		return 0;
+
+	mask = AM654_PCIE_DEV_TYPE_MASK;
+	val = RC;
+
+	ret = regmap_update_bits(syscon, 0, mask, val);
+	if (ret) {
+		dev_err(dev, "failed to set pcie mode\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct ks_pcie_of_data ks_pcie_rc_of_data = {
+	.host_ops = &ks_pcie_host_ops,
+	.version = 0x365A,
+};
+
+static const struct ks_pcie_of_data ks_pcie_am654_rc_of_data = {
+	.host_ops = &ks_pcie_am654_host_ops,
+	.version = 0x490A,
+};
+
+static const struct of_device_id ks_pcie_of_match[] = {
+	{
+		.type = "pci",
+		.data = &ks_pcie_rc_of_data,
+		.compatible = "ti,keystone-pcie",
+	},
+	{
+		.data = &ks_pcie_am654_rc_of_data,
+		.compatible = "ti,am654-pcie-rc",
+	},
+	{ },
+};
+
 static int __init ks_pcie_probe(struct platform_device *pdev)
 {
+	const struct dw_pcie_host_ops *host_ops;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
+	const struct ks_pcie_of_data *data;
+	const struct of_device_id *match;
 	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
 	struct device_link **link;
+	void __iomem *atu_base;
 	struct resource *res;
+	unsigned int version;
 	void __iomem *base;
 	u32 num_viewport;
 	struct phy **phy;
@@ -913,6 +988,14 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	int irq;
 	int i;
 
+	match = of_match_device(of_match_ptr(ks_pcie_of_match), dev);
+	data = (struct ks_pcie_of_data *)match->data;
+	if (!data)
+		return -EINVAL;
+
+	version = data->version;
+	host_ops = data->host_ops;
+
 	ks_pcie = devm_kzalloc(dev, sizeof(*ks_pcie), GFP_KERNEL);
 	if (!ks_pcie)
 		return -ENOMEM;
@@ -936,6 +1019,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	pci->dbi_base = base;
 	pci->dev = dev;
 	pci->ops = &ks_pcie_dw_pcie_ops;
+	pci->version = version;
 
 	ret = of_property_read_u32(np, "num-viewport", &num_viewport);
 	if (ret < 0) {
@@ -1008,10 +1092,26 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 		goto err_get_sync;
 	}
 
-	ret = ks_pcie_set_mode(dev);
-	if (ret < 0)
-		goto err_get_sync;
+	if (pci->version >= 0x480A) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
+		atu_base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(atu_base)) {
+			ret = PTR_ERR(atu_base);
+			goto err_get_sync;
+		}
+
+		pci->atu_base = atu_base;
+
+		ret = ks_pcie_am654_set_mode(dev);
+		if (ret < 0)
+			goto err_get_sync;
+	} else {
+		ret = ks_pcie_set_mode(dev);
+		if (ret < 0)
+			goto err_get_sync;
+	}
 
+	pci->pp.ops = host_ops;
 	ret = ks_pcie_add_pcie_port(ks_pcie, pdev);
 	if (ret < 0)
 		goto err_get_sync;
-- 
2.17.1

