Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D53C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 09:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2631020870
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 09:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rAofOe+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbfCYJnU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:43:20 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45008 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730435AbfCYJnT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 05:43:19 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2P9h3gC068066;
        Mon, 25 Mar 2019 04:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553506983;
        bh=SUjfsDqc2WaNEpc2fxVl73YDMqaMFKKCWCaYoaLaUs0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rAofOe+PWTgmCS1ywNXn3VFysyyWti9/kJ4Jk2LFxWSSyc7hJfonilHlVCRMnwNBJ
         ACdEgw9jEqyYOvQh67kq6b7F18yq/Ze/ngTDF/UxsMuROtju1UFslaXqJ3wHscMg2E
         zzelHzsyqQWvAL6YO7JmJ9HiLoumMxzG0MPMrgOg=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2P9h2Sm053684
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 04:43:03 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 04:43:02 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 25 Mar 2019 04:43:02 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2P9feaT028077;
        Mon, 25 Mar 2019 04:42:57 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Murali Karicheri <m-karicheri2@ti.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-kernel@axis.com>, Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>
Subject: [PATCH v3 14/26] PCI: keystone: Add support for PCIe RC in AM654x Platforms
Date:   Mon, 25 Mar 2019 15:09:35 +0530
Message-ID: <20190325093947.32633-15-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190325093947.32633-1-kishon@ti.com>
References: <20190325093947.32633-1-kishon@ti.com>
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
 drivers/pci/controller/dwc/pci-keystone.c | 161 ++++++++++++++++++++--
 2 files changed, 148 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 6ea74b1c0d94..d1d00833e0b3 100644
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
index 93296d434f40..a6a482bd648f 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -11,6 +11,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irqchip/chained_irq.h>
@@ -18,6 +19,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/msi.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
@@ -65,6 +67,7 @@
 #define ERR_IRQ_STATUS			0x1c4
 #define ERR_IRQ_ENABLE_SET		0x1c8
 #define ERR_AER				BIT(5)	/* ECRC error */
+#define AM6_ERR_AER			BIT(4)	/* AM6 ECRC error */
 #define ERR_AXI				BIT(4)	/* AXI tag lookup fatal error */
 #define ERR_CORR			BIT(3)	/* Correctable error */
 #define ERR_NONFATAL			BIT(2)	/* Non-fatal error */
@@ -88,8 +91,15 @@
 
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
@@ -109,6 +119,7 @@ struct keystone_pcie {
 	/* Application register space */
 	void __iomem		*va_app_base;	/* DT 1st resource */
 	struct resource		app;
+	bool			is_am6;
 };
 
 static u32 ks_pcie_app_readl(struct keystone_pcie *ks_pcie, u32 offset)
@@ -250,6 +261,16 @@ static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
 	ks_pcie_app_writel(ks_pcie, IRQ_EOI, offset);
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
@@ -276,10 +297,10 @@ static irqreturn_t ks_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
 	if (reg & ERR_CORR)
 		dev_dbg(dev, "Correctable Error\n");
 
-	if (reg & ERR_AXI)
+	if (!ks_pcie->is_am6 && (reg & ERR_AXI))
 		dev_err(dev, "AXI tag lookup fatal Error\n");
 
-	if (reg & ERR_AER)
+	if (reg & ERR_AER || (ks_pcie->is_am6 && (reg & AM6_ERR_AER)))
 		dev_err(dev, "ECRC Error\n");
 
 	ks_pcie_app_writel(ks_pcie, ERR_IRQ_STATUS, reg);
@@ -377,6 +398,9 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0);
 	ks_pcie_clear_dbi_mode(ks_pcie);
 
+	if (ks_pcie->is_am6)
+		return;
+
 	val = ilog2(OB_WIN_SIZE);
 	ks_pcie_app_writel(ks_pcie, OB_SIZE, val);
 
@@ -619,6 +643,8 @@ static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
 
 	intc_np = of_get_child_by_name(np, "msi-interrupt-controller");
 	if (!intc_np) {
+		if (ks_pcie->is_am6)
+			return 0;
 		dev_warn(dev, "msi-interrupt-controller node is absent\n");
 		return -EINVAL;
 	}
@@ -668,6 +694,12 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
 
 	intc_np = of_get_child_by_name(np, "legacy-interrupt-controller");
 	if (!intc_np) {
+		/*
+		 * Since legacy interrupts are modeled as edge-interrupts in
+		 * AM6, keep it disabled for now.
+		 */
+		if (ks_pcie->is_am6)
+			return 0;
 		dev_warn(dev, "legacy-interrupt-controller node is absent\n");
 		return -EINVAL;
 	}
@@ -749,8 +781,10 @@ static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
 	if (ret)
 		return ret;
 
+	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, id & PCIE_VENDORID_MASK);
 	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, id >> PCIE_DEVICEID_SHIFT);
+	dw_pcie_dbi_ro_wr_dis(pci);
 
 	return 0;
 }
@@ -803,6 +837,11 @@ static const struct dw_pcie_host_ops ks_pcie_host_ops = {
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
@@ -826,7 +865,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
 
 	pp->va_cfg1_base = pp->va_cfg0_base;
 
-	pp->ops = &ks_pcie_host_ops;
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "failed to initialize host\n");
@@ -836,14 +874,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
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
@@ -913,14 +943,67 @@ static int ks_pcie_set_mode(struct device *dev)
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
+	struct gpio_desc *gpiod;
+	void __iomem *atu_base;
 	struct resource *res;
+	unsigned int version;
 	void __iomem *base;
 	u32 num_viewport;
 	struct phy **phy;
@@ -930,6 +1013,14 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
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
@@ -950,9 +1041,13 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	if (of_device_is_compatible(np, "ti,am654-pcie-rc"))
+		ks_pcie->is_am6 = true;
+
 	pci->dbi_base = base;
 	pci->dev = dev;
 	pci->ops = &ks_pcie_dw_pcie_ops;
+	pci->version = version;
 
 	ret = of_property_read_u32(np, "num-viewport", &num_viewport);
 	if (ret < 0) {
@@ -1011,6 +1106,15 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	ks_pcie->num_viewport = num_viewport;
 	ks_pcie->phy = phy;
 
+	gpiod = devm_gpiod_get_optional(dev, "reset",
+					GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod)) {
+		ret = PTR_ERR(gpiod);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get reset GPIO\n");
+		goto err_link;
+	}
+
 	ret = ks_pcie_enable_phy(ks_pcie);
 	if (ret) {
 		dev_err(dev, "failed to enable phy\n");
@@ -1025,10 +1129,39 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
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
+
+	/*
+	 * "Power Sequencing and Reset Signal Timings" table in
+	 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 2.0
+	 * indicates PERST# should be deasserted after minimum of 100us
+	 * once REFCLK is stable. The REFCLK to the connector in RC
+	 * mode is selected while enabling the PHY. So deassert PERST#
+	 * after 100 us.
+	 */
+	if (gpiod) {
+		usleep_range(100, 200);
+		gpiod_set_value_cansleep(gpiod, 1);
+	}
 
+	pci->pp.ops = host_ops;
 	ret = ks_pcie_add_pcie_port(ks_pcie, pdev);
 	if (ret < 0)
 		goto err_get_sync;
-- 
2.17.1

