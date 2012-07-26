Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:50208 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664Ab2GZTzo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jul 2012 15:55:44 -0400
From: Thierry Reding <thierry.reding@avionic-design.de>
To: linux-tegra@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 10/10] ARM: tegra: pcie: Add device tree support
Date: Thu, 26 Jul 2012 21:55:12 +0200
Message-Id: <1343332512-28762-11-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit adds support for instantiating the Tegra PCIe controller
from a device tree.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v3:
- rewrite the DT binding and adapt driver correspondingly

Changes in v2:
- increase compile coverage by using the IS_ENABLED() macro
- disable node by default

 .../bindings/pci/nvidia,tegra20-pcie.txt           |  94 ++++++++++
 arch/arm/boot/dts/tegra20.dtsi                     |  62 +++++++
 arch/arm/mach-tegra/board-dt-tegra20.c             |   7 +-
 arch/arm/mach-tegra/pcie.c                         | 195 +++++++++++++++++++++
 4 files changed, 353 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
new file mode 100644
index 0000000..b181d4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
@@ -0,0 +1,94 @@
+NVIDIA Tegra PCIe controller
+
+Required properties:
+- compatible: "nvidia,tegra20-pcie"
+- reg: physical base address and length of the controller's registers
+- interrupts: the interrupt outputs of the controller
+- pex-clk-supply: supply voltage for internal reference clock
+- vdd-supply: power supply for controller (1.05V)
+- ranges: describes the translation of addresses for root ports
+- #address-cells: address representation for root ports (must be 3)
+  - cell 0 specifies the port index
+  - cell 1 denotes the address type
+      0: root port register space
+      1: PCI configuration space
+      2: PCI extended configuration space
+      3: downstream I/O
+      4: non-prefetchable memory
+      5: prefetchable memory
+  - cell 2 provides a number space that can include the size (should be 0)
+- #size-cells: size representation for root ports (must be 1)
+
+Root ports are defined as subnodes of the PCIe controller node.
+
+Required properties:
+- device_type: must be "pciex"
+- reg: address and size of the port configuration registers
+- #address-cells: must be 3
+- #size-cells: must be 2
+- ranges: sub-ranges distributed from the PCIe controller node
+- nvidia,num-lanes: number of lanes to use for this port
+
+Example:
+
+	pcie-controller {
+		compatible = "nvidia,tegra20-pcie";
+		reg = <0x80003000 0x00000800   /* PADS registers */
+		       0x80003800 0x00000200   /* AFI registers */
+		       0x81000000 0x01000000   /* configuration space */
+		       0x90000000 0x10000000>; /* extended configuration space */
+		interrupts = <0 98 0x04   /* controller interrupt */
+		              0 99 0x04>; /* MSI interrupt */
+		status = "disabled";
+
+		ranges = <0 0 0  0x80000000 0x00001000   /* root port 0 */
+			  0 1 0  0x81000000 0x00800000   /* port 0 config space */
+			  0 2 0  0x90000000 0x08000000   /* port 0 ext config space */
+			  0 3 0  0x82000000 0x00008000   /* port 0 downstream I/O */
+			  0 4 0  0xa0000000 0x08000000   /* port 0 non-prefetchable memory */
+			  0 5 0  0xb0000000 0x08000000   /* port 0 prefetchable memory */
+
+			  1 0 0  0x80001000 0x00001000   /* root port 1 */
+			  1 1 0  0x81800000 0x00800000   /* port 1 config space */
+			  1 2 0  0x98000000 0x08000000   /* port 1 ext config space */
+			  1 3 0  0x82008000 0x00008000   /* port 1 downstream I/O */
+			  1 4 0  0xa8000000 0x08000000   /* port 1 non-prefetchable memory */
+			  1 5 0  0xb8000000 0x08000000>; /* port 1 prefetchable memory */
+
+		#address-cells = <3>;
+		#size-cells = <1>;
+
+		pci@0 {
+			device_type = "pciex";
+			reg = <0 0 0 0x1000>;
+			status = "disabled";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x80000000 0 0  0 1 0  0 0x00800000   /* config space */
+				  0x90000000 0 0  0 2 0  0 0x08000000   /* ext config space */
+				  0x81000000 0 0  0 3 0  0 0x00008000   /* I/O */
+				  0x82000000 0 0  0 4 0  0 0x08000000   /* non-prefetchable memory */
+				  0xc2000000 0 0  0 5 0  0 0x08000000>; /* prefetchable memory */
+
+			nvidia,num-lanes = <2>;
+		};
+
+		pci@1 {
+			device_type = "pciex";
+			reg = <1 0 0 0x1000>;
+			status = "disabled";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x80000000 0 0  1 1 0  0 0x00800000   /* config space */
+				  0x90000000 0 0  1 2 0  0 0x08000000   /* ext config space */
+				  0x81000000 0 0  1 3 0  0 0x00008000   /* I/O */
+				  0x82000000 0 0  1 4 0  0 0x08000000   /* non-prefetchable memory */
+				  0xc2000000 0 0  1 5 0  0 0x08000000>; /* prefetchable memory */
+
+			nvidia,num-lanes = <2>;
+		};
+	};
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index a094c97..c886dff 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -199,6 +199,68 @@
 		#size-cells = <0>;
 	};
 
+	pcie-controller {
+		compatible = "nvidia,tegra20-pcie";
+		reg = <0x80003000 0x00000800   /* PADS registers */
+		       0x80003800 0x00000200   /* AFI registers */
+		       0x81000000 0x01000000   /* configuration space */
+		       0x90000000 0x10000000>; /* extended configuration space */
+		interrupts = <0 98 0x04   /* controller interrupt */
+		              0 99 0x04>; /* MSI interrupt */
+		status = "disabled";
+
+		ranges = <0 0 0  0x80000000 0x00001000   /* root port 0 */
+			  0 1 0  0x81000000 0x00800000   /* port 0 config space */
+			  0 2 0  0x90000000 0x08000000   /* port 0 ext config space */
+			  0 3 0  0x82000000 0x00010000   /* port 0 downstream I/O */
+			  0 4 0  0xa0000000 0x08000000   /* port 0 non-prefetchable memory */
+			  0 5 0  0xb0000000 0x08000000   /* port 0 prefetchable memory */
+
+			  1 0 0  0x80001000 0x00001000   /* root port 1 */
+			  1 1 0  0x81800000 0x00800000   /* port 1 config space */
+			  1 2 0  0x98000000 0x08000000   /* port 1 ext config space */
+			  1 3 0  0x82010000 0x00010000   /* port 1 downstream I/O */
+			  1 4 0  0xa8000000 0x08000000   /* port 1 non-prefetchable memory */
+			  1 5 0  0xb8000000 0x08000000>; /* port 1 prefetchable memory */
+
+		#address-cells = <3>;
+		#size-cells = <1>;
+
+		pci@0 {
+			device_type = "pciex";
+			reg = <0 0 0 0x1000>;
+			status = "disabled";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x80000000 0 0  0 1 0  0 0x00800000   /* config space */
+				  0x90000000 0 0  0 2 0  0 0x08000000   /* ext config space */
+				  0x81000000 0 0  0 3 0  0 0x00010000   /* I/O */
+				  0x82000000 0 0  0 4 0  0 0x08000000   /* non-prefetchable memory */
+				  0xc2000000 0 0  0 5 0  0 0x08000000>; /* prefetchable memory */
+
+			nvidia,num-lanes = <2>;
+		};
+
+		pci@1 {
+			device_type = "pciex";
+			reg = <1 0 0 0x1000>;
+			status = "disabled";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x80000000 0 0  1 1 0  0 0x00800000   /* config space */
+				  0x90000000 0 0  1 2 0  0 0x08000000   /* ext config space */
+				  0x81000000 0 0  1 3 0  0 0x00010000   /* I/O */
+				  0x82000000 0 0  1 4 0  0 0x08000000   /* non-prefetchable memory */
+				  0xc2000000 0 0  1 5 0  0 0x08000000>; /* prefetchable memory */
+
+			nvidia,num-lanes = <2>;
+		};
+	};
+
 	usb@c5000000 {
 		compatible = "nvidia,tegra20-ehci", "usb-ehci";
 		reg = <0xc5000000 0x4000>;
diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index a8a05c1..caa377a 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -40,6 +40,7 @@
 
 #include <mach/iomap.h>
 #include <mach/irqs.h>
+#include <mach/pci-tegra.h>
 
 #include "board.h"
 #include "board-harmony.h"
@@ -114,11 +115,7 @@ static void __init tegra_dt_init(void)
 #ifdef CONFIG_MACH_TRIMSLICE
 static void __init trimslice_init(void)
 {
-	int ret;
-
-	ret = tegra_pcie_init(true, true);
-	if (ret)
-		pr_err("tegra_pci_init() failed: %d\n", ret);
+	platform_device_register(&tegra_pcie_device);
 }
 #endif
 
diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index dab3479..2d00b1c 100644
--- a/arch/arm/mach-tegra/pcie.c
+++ b/arch/arm/mach-tegra/pcie.c
@@ -37,6 +37,10 @@
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/msi.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/regulator/consumer.h>
 
 #include <asm/sizes.h>
 #include <asm/mach/irq.h>
@@ -220,6 +224,9 @@ struct tegra_pcie {
 	unsigned int num_ports;
 
 	struct tegra_pcie_msi *msi;
+
+	struct regulator *pex_clk_supply;
+	struct regulator *vdd_supply;
 };
 
 struct tegra_pcie_port {
@@ -1016,6 +1023,178 @@ static int tegra_pcie_disable_msi(struct tegra_pcie *pcie)
 	return 0;
 }
 
+static int tegra_pcie_dt_init(struct platform_device *pdev)
+{
+	struct tegra_pcie *pcie = platform_get_drvdata(pdev);
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
+	struct tegra_pcie *pcie = platform_get_drvdata(pdev);
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
+struct resource *of_parse_reg(struct device_node *np, unsigned int *countp)
+{
+	unsigned int count = 0, i;
+	struct resource *reg, res;
+	int err;
+
+	while (of_address_to_resource(np, count, &res) == 0)
+		count++;
+
+	reg = kzalloc(sizeof(*reg) * count, GFP_KERNEL);
+	if (!reg)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < count; i++) {
+		err = of_address_to_resource(np, i, &reg[i]);
+		if (err < 0) {
+			kfree(reg);
+			return ERR_PTR(err);
+		}
+	}
+
+	if (countp)
+		*countp = count;
+
+	return reg;
+}
+
+static int tegra_pcie_port_parse_dt(struct tegra_pcie *pcie,
+				    struct device_node *node,
+				    struct tegra_pcie_rp *port)
+{
+	const __be32 *values;
+	u32 value;
+	int err;
+
+	values = of_get_property(node, "reg", NULL);
+	if (!values)
+		return -ENODEV;
+
+	port->index = be32_to_cpup(values);
+
+	port->resources = of_parse_reg(node, &port->num_resources);
+	if (!port->resources)
+		return -ENOMEM;
+
+	port->ranges = of_pci_parse_ranges(node, &port->num_ranges);
+	if (!port->ranges) {
+		err = -ENOMEM;
+		goto free;
+	}
+
+	err = of_property_read_u32(node, "nvidia,num-lanes", &value);
+	if (err < 0)
+		goto free;
+
+	port->num_lanes = value;
+
+	return 0;
+
+free:
+	kfree(port->ranges);
+	kfree(port->resources);
+	return err;
+}
+
+static struct tegra_pcie_pdata *tegra_pcie_parse_dt(struct tegra_pcie *pcie)
+{
+	struct tegra_pcie_pdata *pdata;
+	struct device_node *child;
+	unsigned int i = 0;
+	size_t size;
+	int err;
+
+	pdata = devm_kzalloc(pcie->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return NULL;
+
+	pdata->init = tegra_pcie_dt_init;
+	pdata->exit = tegra_pcie_dt_exit;
+
+	pcie->vdd_supply = devm_regulator_get(pcie->dev, "vdd");
+	if (IS_ERR_OR_NULL(pcie->vdd_supply))
+		return ERR_CAST(pcie->vdd_supply);
+
+	pcie->pex_clk_supply = devm_regulator_get(pcie->dev, "pex-clk");
+	if (IS_ERR_OR_NULL(pcie->pex_clk_supply))
+		return ERR_CAST(pcie->pex_clk_supply);
+
+	/* parse root port nodes */
+	for_each_child_of_node(pcie->dev->of_node, child) {
+		if (of_device_is_available(child))
+			pdata->num_ports++;
+	}
+
+	size = pdata->num_ports * sizeof(*pdata->ports);
+
+	pdata->ports = devm_kzalloc(pcie->dev, size, GFP_KERNEL);
+	if (!pdata->ports)
+		return ERR_PTR(-ENOMEM);
+
+	for_each_child_of_node(pcie->dev->of_node, child) {
+		struct tegra_pcie_rp *port = &pdata->ports[i];
+
+		if (!of_device_is_available(child))
+			continue;
+
+		err = tegra_pcie_port_parse_dt(pcie, child, port);
+		if (err < 0)
+			return ERR_PTR(err);
+
+		i++;
+	}
+
+	pdata->num_ports = i;
+
+	return pdata;
+}
+
 static unsigned long tegra_pcie_port_get_pex_ctrl(struct tegra_pcie_port *port)
 {
 	unsigned long ret = 0;
@@ -1193,6 +1372,14 @@ static int __devinit tegra_pcie_probe(struct platform_device *pdev)
 
 	pcie->dev = &pdev->dev;
 
+	if (IS_ENABLED(CONFIG_OF)) {
+		if (!pdata && pdev->dev.of_node) {
+			pdata = tegra_pcie_parse_dt(pcie);
+			if (IS_ERR(pdata))
+				return PTR_ERR(pdata);
+		}
+	}
+
 	if (!pdata)
 		return -ENODEV;
 
@@ -1280,10 +1467,18 @@ static int __devexit tegra_pcie_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id tegra_pcie_of_match[] = {
+	{ .compatible = "nvidia,tegra20-pcie", },
+	{ },
+};
+#endif
+
 static struct platform_driver tegra_pcie_driver = {
 	.driver = {
 		.name = "tegra-pcie",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(tegra_pcie_of_match),
 	},
 	.probe = tegra_pcie_probe,
 	.remove = __devexit_p(tegra_pcie_remove),
-- 
1.7.11.2

