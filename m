Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:56231 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755589Ab2FKPFk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jun 2012 11:05:40 -0400
From: Thierry Reding <thierry.reding@avionic-design.de>
To: linux-tegra@vger.kernel.org
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
Date: Mon, 11 Jun 2012 17:05:15 +0200
Message-Id: <1339427118-32263-8-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit adds support for instantiating the Tegra PCIe controller
from a device tree.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

---
Changes in v2:
- increase compile coverage by using the IS_ENABLED() macro
- disable node by default
---
 .../devicetree/bindings/pci/tegra-pcie.txt         |   23 ++++
 arch/arm/boot/dts/tegra20.dtsi                     |    9 ++
 arch/arm/mach-tegra/pcie.c                         |  120 +++++++++++++++++++-
 3 files changed, 149 insertions(+), 3 deletions(-)
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
index fa56519..b212658 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -199,6 +199,15 @@
 		#size-cells = <0>;
 	};
 
+	pci {
+		compatible = "nvidia,tegra20-pcie";
+		reg = <0x80000000 0x400000   /* PCIe AFI registers */
+		       0x80400000 0x010000>; /* PCI I/O space */
+		interrupts = < 0 98 0x04    /* controller interrupt */
+		               0 99 0x04 >; /* MSI interrupt */
+		status = "disable";
+	};
+
 	usb@c5000000 {
 		compatible = "nvidia,tegra20-ehci", "usb-ehci";
 		reg = <0xc5000000 0x4000>;
diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index 3c8c953..f24923b 100644
--- a/arch/arm/mach-tegra/pcie.c
+++ b/arch/arm/mach-tegra/pcie.c
@@ -37,6 +37,8 @@
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/msi.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
 
 #include <asm/sizes.h>
 #include <asm/mach/irq.h>
@@ -242,6 +244,9 @@ struct tegra_pcie_info {
 	struct clk		*pll_e;
 
 	struct tegra_pcie_msi	*msi;
+
+	struct regulator *pex_clk_supply;
+	struct regulator *vdd_supply;
 };
 
 static inline struct tegra_pcie_info *sys_to_pcie(struct pci_sys_data *sys)
@@ -1194,6 +1199,99 @@ static int tegra_pcie_disable_msi(struct platform_device *pdev)
 	return 0;
 }
 
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
+#ifdef CONFIG_OF
+static const struct of_device_id tegra_pcie_of_match[] = {
+	{ .compatible = "nvidia,tegra20-pcie", },
+	{ },
+};
+#endif
+
 static int __devinit tegra_pcie_probe(struct platform_device *pdev)
 {
 	struct tegra_pcie_pdata *pdata = pdev->dev.platform_data;
@@ -1202,9 +1300,6 @@ static int __devinit tegra_pcie_probe(struct platform_device *pdev)
 	struct hw_pci hw;
 	int err;
 
-	if (!pdata->enable_ports[0] && !pdata->enable_ports[1])
-		return -ENODEV;
-
 	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
@@ -1212,6 +1307,20 @@ static int __devinit tegra_pcie_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pcie);
 	pcie->dev = &pdev->dev;
 
+	if (IS_ENABLED(CONFIG_OF)) {
+		if (!pdata && pdev->dev.of_node) {
+			pdata = tegra_pcie_parse_dt(pdev);
+			if (IS_ERR(pdata))
+				return PTR_ERR(pdata);
+		}
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
@@ -1266,6 +1375,7 @@ static int __devinit tegra_pcie_probe(struct platform_device *pdev)
 
 static int __devexit tegra_pcie_remove(struct platform_device *pdev)
 {
+	struct tegra_pcie_info *pcie = platform_get_drvdata(pdev);
 	struct tegra_pcie_pdata *pdata = pdev->dev.platform_data;
 	int err;
 
@@ -1285,6 +1395,9 @@ static int __devexit tegra_pcie_remove(struct platform_device *pdev)
 			return err;
 	}
 
+	regulator_put(pcie->pex_clk_supply);
+	regulator_put(pcie->vdd_supply);
+
 	return 0;
 }
 
@@ -1292,6 +1405,7 @@ static struct platform_driver tegra_pcie_driver = {
 	.driver = {
 		.name = "tegra-pcie",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(tegra_pcie_of_match),
 	},
 	.probe = tegra_pcie_probe,
 	.remove = __devexit_p(tegra_pcie_remove),
-- 
1.7.10.4

