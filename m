Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BACC4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 19:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C0420855
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 19:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Vb40Byuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbfDDT46 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:56:58 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13917 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfDDT45 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2019 15:56:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca6618b0000>; Thu, 04 Apr 2019 12:56:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 12:56:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Apr 2019 12:56:55 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Apr
 2019 19:56:55 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 4 Apr 2019 19:56:55 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca661810009>; Thu, 04 Apr 2019 12:56:54 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <lorenzo.pieralisi@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <mperttunen@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2 14/16] phy: tegra: Add PCIe PIPE2UPHY support
Date:   Fri, 5 Apr 2019 01:24:41 +0530
Message-ID: <1554407683-31580-15-git-send-email-vidyas@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
References: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554407819; bh=+/Zq/oNQxtNPC6RX5VsN/kv6tGY1uBcRPL48XYWZL/k=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Vb40ByucBGl9RV5WLR2fYiLLvocX3Yl8tEX7CKVGNFwK4nyD5wJcxKbvoBTrTtDqp
         dR8U1iyMrkmE62o2KlDocQiXCzPED1LK5bF9iS6zmBVGe+VXXPDl7Q8iIP423su+uL
         XdYNRI6irm7Goeai/H0ClCFauhrL1BHEQwJ2O16ssXi4L+sSPvcTVmCCe/K95IHalx
         877E85cYtVfrABABBYzkoP6DPYT8A6JM6/VAxY4BUQOqa4+7rWY0vsfUdeqEEVn6kP
         2DZNCNJHtMKlQ6OCPavDJU1dfrplB8rttV4wPN8k4hPj2it625I4TEReLV4ZfXME4Z
         0zQ7a28GeKVug==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Synopsys DesignWare core based PCIe controllers in Tegra 194 SoC interface
with Universal PHY (UPHY) module through a PIPE2UPHY (P2U) module.
For each PCIe lane of a controller, there is a P2U unit instantiated at
hardware level. This driver provides support for the programming required
for each P2U that is going to be used for a PCIe controller.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes since [v1]:
* Added COMPILE_TEST in Kconfig
* Removed empty phy_ops implementations
* Modified code according to DT documentation file modifications

 drivers/phy/tegra/Kconfig             |   7 ++
 drivers/phy/tegra/Makefile            |   1 +
 drivers/phy/tegra/pcie-p2u-tegra194.c | 120 ++++++++++++++++++++++++++++++++++
 3 files changed, 128 insertions(+)
 create mode 100644 drivers/phy/tegra/pcie-p2u-tegra194.c

diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
index a3b1de953fb7..eb93ee72ecf0 100644
--- a/drivers/phy/tegra/Kconfig
+++ b/drivers/phy/tegra/Kconfig
@@ -6,3 +6,10 @@ config PHY_TEGRA_XUSB
 
 	  To compile this driver as a module, choose M here: the module will
 	  be called phy-tegra-xusb.
+
+config PHY_TEGRA194_PCIE_P2U
+        tristate "NVIDIA Tegra P2U PHY Driver"
+        depends on ARCH_TEGRA || COMPILE_TEST
+        select GENERIC_PHY
+        help
+          Enable this to support the P2U (PIPE to UPHY) that is part of Tegra 19x SOCs.
diff --git a/drivers/phy/tegra/Makefile b/drivers/phy/tegra/Makefile
index 898589238fd9..f85b2c86643d 100644
--- a/drivers/phy/tegra/Makefile
+++ b/drivers/phy/tegra/Makefile
@@ -4,3 +4,4 @@ phy-tegra-xusb-y += xusb.o
 phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_124_SOC) += xusb-tegra124.o
 phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_132_SOC) += xusb-tegra124.o
 phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_210_SOC) += xusb-tegra210.o
+obj-$(CONFIG_PHY_TEGRA194_PCIE_P2U) += pcie-p2u-tegra194.o
diff --git a/drivers/phy/tegra/pcie-p2u-tegra194.c b/drivers/phy/tegra/pcie-p2u-tegra194.c
new file mode 100644
index 000000000000..d4df8bfa9979
--- /dev/null
+++ b/drivers/phy/tegra/pcie-p2u-tegra194.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * P2U (PIPE to UPHY) driver for Tegra T194 SoC
+ *
+ * Copyright (C) 2019 NVIDIA Corporation.
+ *
+ * Author: Vidya Sagar <vidyas@nvidia.com>
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/phy/phy.h>
+#include <linux/of.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/of_platform.h>
+#include <soc/tegra/bpmp-abi.h>
+
+#define P2U_PERIODIC_EQ_CTRL_GEN3	0xc0
+#define P2U_PERIODIC_EQ_CTRL_GEN3_PERIODIC_EQ_EN		BIT(0)
+#define P2U_PERIODIC_EQ_CTRL_GEN3_INIT_PRESET_EQ_TRAIN_EN	BIT(1)
+#define P2U_PERIODIC_EQ_CTRL_GEN4	0xc4
+#define P2U_PERIODIC_EQ_CTRL_GEN4_INIT_PRESET_EQ_TRAIN_EN	BIT(1)
+
+#define P2U_RX_DEBOUNCE_TIME				0xa4
+#define P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_MASK	0xFFFF
+#define P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_VAL		160
+
+struct tegra_p2u {
+	void __iomem		*base;
+};
+
+static int tegra_p2u_power_on(struct phy *x)
+{
+	u32 val;
+	struct tegra_p2u *phy = phy_get_drvdata(x);
+
+	val = readl(phy->base + P2U_PERIODIC_EQ_CTRL_GEN3);
+	val &= ~P2U_PERIODIC_EQ_CTRL_GEN3_PERIODIC_EQ_EN;
+	val |= P2U_PERIODIC_EQ_CTRL_GEN3_INIT_PRESET_EQ_TRAIN_EN;
+	writel(val, phy->base + P2U_PERIODIC_EQ_CTRL_GEN3);
+
+	val = readl(phy->base + P2U_PERIODIC_EQ_CTRL_GEN4);
+	val |= P2U_PERIODIC_EQ_CTRL_GEN4_INIT_PRESET_EQ_TRAIN_EN;
+	writel(val, phy->base + P2U_PERIODIC_EQ_CTRL_GEN4);
+
+	val = readl(phy->base + P2U_RX_DEBOUNCE_TIME);
+	val &= ~P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_MASK;
+	val |= P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_VAL;
+	writel(val, phy->base + P2U_RX_DEBOUNCE_TIME);
+
+	return 0;
+}
+
+static const struct phy_ops ops = {
+	.power_on	= tegra_p2u_power_on,
+	.owner		= THIS_MODULE,
+};
+
+static int tegra_p2u_probe(struct platform_device *pdev)
+{
+	struct tegra_p2u *phy;
+	struct phy *generic_phy;
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+
+	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctl");
+	phy->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(phy->base))
+		return PTR_ERR_OR_ZERO(phy->base);
+
+	platform_set_drvdata(pdev, phy);
+
+	generic_phy = devm_phy_create(dev, NULL, &ops);
+	if (IS_ERR(generic_phy))
+		return PTR_ERR_OR_ZERO(generic_phy);
+
+	phy_set_drvdata(generic_phy, phy);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(phy_provider))
+		return PTR_ERR_OR_ZERO(phy_provider);
+
+	return 0;
+}
+
+static int tegra_p2u_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static const struct of_device_id tegra_p2u_id_table[] = {
+	{
+		.compatible = "nvidia,tegra194-p2u",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, tegra_p2u_id_table);
+
+static struct platform_driver tegra_p2u_driver = {
+	.probe		= tegra_p2u_probe,
+	.remove		= tegra_p2u_remove,
+	.driver		= {
+		.name	= "tegra194-p2u",
+		.of_match_table = tegra_p2u_id_table,
+	},
+};
+
+module_platform_driver(tegra_p2u_driver);
+
+MODULE_AUTHOR("Vidya Sagar <vidyas@nvidia.com>");
+MODULE_DESCRIPTION("NVIDIA Tegra PIPE_To_UPHY phy driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

