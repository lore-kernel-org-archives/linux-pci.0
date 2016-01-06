Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	<linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kishon@ti.com>, <nsekhar@ti.com>
Subject: [PATCH 2/2] pci: host: pci-dra7xx: Enable x2 mode support
Date: Wed, 6 Jan 2016 16:19:53 +0530
Message-ID: <1452077393-25880-3-git-send-email-kishon@ti.com>
In-Reply-To: <1452077393-25880-1-git-send-email-kishon@ti.com>
References: <1452077393-25880-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Perform syscon configurations to get x2 mode to working in DRA74x and
DRA72x. Also add a new compatible string to dfferentiate
DRA72x and DRA74x, since b1c0 mask is different for both these platforms.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/pci/ti-pci.txt |    8 ++-
 drivers/pci/host/pci-dra7xx.c                    |   81 +++++++++++++++++++++-
 2 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
index 60e2516..0b10e84 100644
--- a/Documentation/devicetree/bindings/pci/ti-pci.txt
+++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
@@ -1,7 +1,9 @@
 TI PCI Controllers
 
 PCIe Designware Controller
- - compatible: Should be "ti,dra7-pcie""
+ - compatible: "ti,dra7-pcie" is deprecated
+	       Should be "ti,dra746-pcie" for DRA74x
+	       Should be "ti,dra726-pcie" for DRA72x
  - reg : Two register ranges as listed in the reg-names property
  - reg-names : The first entry must be "ti-conf" for the TI specific registers
 	       The second entry must be "rc-dbics" for the designware pcie
@@ -14,6 +16,10 @@ PCIe Designware Controller
 	       where <X> is the instance number of the pcie from the HW spec.
  - interrupts : Two interrupt entries must be specified. The first one is for
 		main interrupt line and the second for MSI interrupt line.
+ - syscon-lane-conf : phandle/offset pair. Phandle to the system control module and the
+   register offset to specify 1 lane or 2 lane.
+ - syscon-lane-sel : phandle/offset pair. Phandle to the system control module and the
+   register offset to specify lane selection.
  - #address-cells,
    #size-cells,
    #interrupt-cells,
diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 05bbeee..dac216f 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -22,9 +22,11 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/of_platform.h>
 #include <linux/resource.h>
 #include <linux/types.h>
-#include <linux/platform_data/pci-dra7xx.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #include <linux/platform_data/pci-dra7xx.h>
 
@@ -67,14 +69,22 @@
 #define	LINK_UP						BIT(16)
 #define	DRA7XX_CPU_TO_BUS_ADDR				0x0FFFFFFF
 
+#define PCIE_1LANE_2LANE_SELECTION			BIT(13)
+#define PCIE_B1C0_MODE_SEL				BIT(2)
+
 struct dra7xx_pcie {
 	void __iomem		*base;
+	u32			*b1c0_mask;
 	struct phy		**phy;
 	int			lanes;
 	struct device		*dev;
 	struct pcie_port	pp;
 };
 
+struct dra7xx_pcie_data {
+	u32	b1co_mode_sel_mask;
+};
+
 #define to_dra7xx_pcie(x)	container_of((x), struct dra7xx_pcie, pp)
 
 static inline u32 dra7xx_pcie_readl(struct dra7xx_pcie *pcie, u32 offset)
@@ -358,6 +368,57 @@ static int dra7xx_pcie_reset(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id of_dra7xx_pcie_match[];
+
+static int dra7xx_pcie_configure_two_lane(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct regmap *pcie_syscon;
+	unsigned int pcie_reg;
+	struct dra7xx_pcie_data *data;
+	const struct of_device_id *match;
+
+	match = of_match_device(of_dra7xx_pcie_match, dev);
+	if (!match)
+		return -EINVAL;
+
+	data = (struct dra7xx_pcie_data *)match->data;
+	if (!data) {
+		dev_err(dev, "no b1c0 mask data\n");
+		return -EINVAL;
+	}
+
+	pcie_syscon = syscon_regmap_lookup_by_phandle(np, "syscon-lane-conf");
+	if (IS_ERR(pcie_syscon)) {
+		dev_err(dev, "unable to get syscon-lane-conf\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32_index(np, "syscon-lane-conf", 1, &pcie_reg)) {
+		dev_err(dev, "couldn't get lane configuration reg offset\n");
+		return -EINVAL;
+	}
+
+	regmap_update_bits(pcie_syscon, pcie_reg, PCIE_1LANE_2LANE_SELECTION,
+			   PCIE_1LANE_2LANE_SELECTION);
+
+	pcie_syscon = syscon_regmap_lookup_by_phandle(np, "syscon-lane-sel");
+	if (IS_ERR(pcie_syscon)) {
+		dev_err(dev, "unable to get syscon-lane-sel\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32_index(np, "syscon-lane-sel", 1, &pcie_reg)) {
+		dev_err(dev, "couldn't get lane selection reg offset\n");
+		return -EINVAL;
+	}
+
+	regmap_update_bits(pcie_syscon, pcie_reg, data->b1co_mode_sel_mask,
+			   PCIE_B1C0_MODE_SEL);
+
+	return 0;
+}
+
 static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 {
 	u32 reg;
@@ -428,6 +489,12 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (lanes == 2) {
+		ret = dra7xx_pcie_configure_two_lane(dev);
+		if (ret < 0)
+			goto err_phy;
+	}
+
 	dra7xx->base = base;
 	dra7xx->phy = phy;
 	dra7xx->dev = dev;
@@ -581,8 +648,18 @@ static const struct dev_pm_ops dra7xx_pcie_pm_ops = {
 				      dra7xx_pcie_resume_noirq)
 };
 
+static const struct dra7xx_pcie_data dra746_pcie_data = {
+	.b1co_mode_sel_mask = BIT(2),
+};
+
+static const struct dra7xx_pcie_data dra726_pcie_data = {
+	.b1co_mode_sel_mask = GENMASK(3, 2),
+};
+
 static const struct of_device_id of_dra7xx_pcie_match[] = {
-	{ .compatible = "ti,dra7-pcie", },
+	{ .compatible = "ti,dra7-pcie", .data = &dra746_pcie_data },
+	{ .compatible = "ti,dra746-pcie", .data = &dra746_pcie_data },
+	{ .compatible = "ti,dra726-pcie", .data = &dra726_pcie_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, of_dra7xx_pcie_match);
-- 
1.7.9.5

