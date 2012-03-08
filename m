Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:62376 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756021Ab2CHOvr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Mar 2012 09:51:47 -0500
From: Thierry Reding <thierry.reding@avionic-design.de>
To: linux-tegra@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: [PATCH 11/11] ARM: tegra: pcie: Add device tree support
Date: Thu,  8 Mar 2012 15:51:31 +0100
Message-Id: <1331218291-16119-12-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit adds support for instantiating the Tegra PCIe controller
from a device tree.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 .../devicetree/bindings/pci/tegra-pcie.txt         |   23 ++++
 arch/arm/boot/dts/tegra20.dtsi                     |    8 ++
 arch/arm/mach-tegra/pcie.c                         |  123 +++++++++++++++++++-
 3 files changed, 151 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/tegra-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/tegra-pcie.txt b/Documentation/devicetree/bindings/pci/tegra-pcie.txt
new file mode 100644
index 0000000..10bbc40
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/tegra-pcie.txt
@@ -0,0 +1,23 @@
+NVIDIA Tegra PCIe controller
+
+Required properties:
+- compatible: "nvidia,tegra20-pcie"
+- reg: physical base address and length of the controller's registers
+- interrupts: the interrupt outputs of the controller
+
+Optional properties:
+- pex-clk-supply: supply voltage for internal reference clock
+- vdd-supply: power supply for controller (1.05V)
+
+Example:
+
+	pci@80000000 {
+		compatible = "nvidia,tegra20-pcie",
+		reg = <0x80000000 0x400000   /* PCIe AFI registers */
+		       0x80400000 0x010000>; /* PCI I/O space */
+		interrupts = < 0 98 0x04    /* controller interrupt */
+		               0 99 0x04 >; /* MSI interrupt */
+
+		pex-clk-supply = <&ldo0_reg>;
+		vdd-supply = <&pcie_reg>;
+	};
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 108e894..9b4692e 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -161,6 +161,14 @@
 		reg = <0x7000f400 0x200>;
 	};
 
+	pci@80000000 {
+		compatible = "nvidia,tegra20-pcie";
+		reg = <0x80000000 0x400000   /* PCIe AFI registers */
+		       0x80400000 0x010000>; /* PCI I/O space */
+		interrupts = < 0 98 0x04    /* controller interrupt */
+		               0 99 0x04 >; /* MSI interrupt */
+	};
+
 	sdhci@c8000000 {
 		compatible = "nvidia,tegra20-sdhci";
 		reg = <0xc8000000 0x200>;
diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index 85db9fb..829af6e 100644
--- a/arch/arm/mach-tegra/pcie.c
+++ b/arch/arm/mach-tegra/pcie.c
@@ -36,6 +36,8 @@
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/msi.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
 
 #include <asm/sizes.h>
 #include <asm/mach/irq.h>
@@ -240,6 +242,9 @@ struct tegra_pcie_info {
 	struct irq_domain *msi_domain;
 	struct mutex msi_lock;
 #endif
+
+	struct regulator *pex_clk_supply;
+	struct regulator *vdd_supply;
 };
 
 static inline struct tegra_pcie_info *sys_to_pcie(struct pci_sys_data *sys)
@@ -1170,15 +1175,110 @@ static int tegra_pcie_disable_msi(struct platform_device *pdev)
 }
 #endif
 
+#ifdef CONFIG_OF
+static int tegra_pcie_dt_init(struct platform_device *pdev)
+{
+	struct tegra_pcie_info *pcie = platform_get_drvdata(pdev);
+	int err;
+
+	if (!IS_ERR_OR_NULL(pcie->vdd_supply)) {
+		err = regulator_enable(pcie->vdd_supply);
+		if (err < 0) {
+			dev_err(&pdev->dev,
+				"failed to enable VDD regulator: %d\n", err);
+			return err;
+		}
+	}
+
+	if (!IS_ERR_OR_NULL(pcie->pex_clk_supply)) {
+		err = regulator_enable(pcie->pex_clk_supply);
+		if (err < 0) {
+			dev_err(&pdev->dev,
+				"failed to enable pex-clk regulator: %d\n",
+				err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int tegra_pcie_dt_exit(struct platform_device *pdev)
+{
+	struct tegra_pcie_info *pcie = platform_get_drvdata(pdev);
+	int err;
+
+	if (!IS_ERR_OR_NULL(pcie->pex_clk_supply)) {
+		err = regulator_disable(pcie->pex_clk_supply);
+		if (err < 0) {
+			dev_err(&pdev->dev,
+				"failed to disable pex-clk regulator: %d\n",
+				err);
+			return err;
+		}
+	}
+
+	if (!IS_ERR_OR_NULL(pcie->vdd_supply)) {
+		err = regulator_disable(pcie->vdd_supply);
+		if (err < 0) {
+			dev_err(&pdev->dev,
+				"failed to disable VDD regulator: %d\n", err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static struct tegra_pcie_pdata *tegra_pcie_parse_dt(struct platform_device *pdev)
+{
+	struct tegra_pcie_info *pcie = platform_get_drvdata(pdev);
+	struct device_node *node = pdev->dev.of_node;
+	struct tegra_pcie_pdata *pdata;
+	unsigned int i;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return NULL;
+
+	pdata->init = tegra_pcie_dt_init;
+	pdata->exit = tegra_pcie_dt_exit;
+
+	if (of_find_property(node, "vdd-supply", NULL)) {
+		pcie->vdd_supply = regulator_get(&pdev->dev, "vdd");
+		if (IS_ERR_OR_NULL(pcie->vdd_supply))
+			return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	if (of_find_property(node, "pex-clk-supply", NULL)) {
+		pcie->pex_clk_supply = regulator_get(&pdev->dev, "pex-clk");
+		if (IS_ERR_OR_NULL(pcie->pex_clk_supply))
+			return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	for (i = 0; i < TEGRA_PCIE_MAX_PORTS; i++)
+		pdata->enable_ports[i] = true;
+
+	return pdata;
+}
+
+static struct of_device_id tegra_pcie_of_match[] = {
+	{ .compatible = "nvidia,tegra20-pcie", },
+	{ },
+};
+#else
+static struct tegra_pcie_pdata *tegra_pcie_parse_dt(struct platform_device *pdev)
+{
+	return NULL;
+}
+#endif
+
 static int __devinit tegra_pcie_probe(struct platform_device *pdev)
 {
 	struct tegra_pcie_pdata *pdata = pdev->dev.platform_data;
 	struct tegra_pcie_info *pcie;
 	int err;
 
-	if (!pdata->enable_ports[0] && !pdata->enable_ports[1])
-		return -ENODEV;
-
 	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
@@ -1186,6 +1286,18 @@ static int __devinit tegra_pcie_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pcie);
 	pcie->dev = &pdev->dev;
 
+	if (!pdata && pdev->dev.of_node) {
+		pdata = tegra_pcie_parse_dt(pdev);
+		if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
+	}
+
+	if (!pdata)
+		return -ENODEV;
+
+	if (!pdata->enable_ports[0] && !pdata->enable_ports[1])
+		return -ENODEV;
+
 	pcibios_min_mem = 0;
 
 	err = tegra_pcie_get_resources(pdev);
@@ -1232,6 +1344,7 @@ static int __devinit tegra_pcie_probe(struct platform_device *pdev)
 
 static int __devexit tegra_pcie_remove(struct platform_device *pdev)
 {
+	struct tegra_pcie_info *pcie = platform_get_drvdata(pdev);
 	struct tegra_pcie_pdata *pdata = pdev->dev.platform_data;
 	int err;
 
@@ -1249,6 +1362,9 @@ static int __devexit tegra_pcie_remove(struct platform_device *pdev)
 			return err;
 	}
 
+	regulator_put(pcie->pex_clk_supply);
+	regulator_put(pcie->vdd_supply);
+
 	return 0;
 }
 
@@ -1256,6 +1372,7 @@ static struct platform_driver tegra_pcie_driver = {
 	.driver = {
 		.name = "tegra-pcie",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(tegra_pcie_of_match),
 	},
 	.probe = tegra_pcie_probe,
 	.remove = __devexit_p(tegra_pcie_remove),
-- 
1.7.9.3

