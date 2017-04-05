Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <hch@infradead.org>, <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH v6 14/23] PCI: dwc: dra7xx: Workaround for errata id i870
Date: Wed, 5 Apr 2017 14:22:34 +0530
Message-ID: <20170405085243.18123-15-kishon@ti.com>
In-Reply-To: <20170405085243.18123-1-kishon@ti.com>
References: <20170405085243.18123-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

According to errata i870, access to the PCIe slave port that are not 32-bit
aligned will result in incorrect mapping to TLP Address and Byte enable
fields.

Accessing non 32-bit aligned data causes incorrect data in the target
buffer if memcpy is used. Implement the workaround for this errata here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/dwc/pci-dra7xx.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 35c18534469c..8decf46cf525 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -26,6 +26,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/resource.h>
 #include <linux/types.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #include "pcie-designware.h"
 
@@ -528,6 +530,48 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
 	{},
 };
 
+/*
+ * dra7xx_pcie_ep_unaligned_memaccess: workaround for AM572x/AM571x Errata i870
+ * @dra7xx: the dra7xx device where the workaround should be applied
+ *
+ * Access to the PCIe slave port that are not 32-bit aligned will result
+ * in incorrect mapping to TLP Address and Byte enable fields. Therefore,
+ * byte and half-word accesses are not possible to byte offset 0x1, 0x2, or
+ * 0x3.
+ *
+ * To avoid this issue set PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE to 1.
+ */
+static int dra7xx_pcie_ep_unaligned_memaccess(struct device *dev)
+{
+	int ret;
+	struct device_node *np = dev->of_node;
+	struct of_phandle_args args;
+	struct regmap *regmap;
+
+	regmap = syscon_regmap_lookup_by_phandle(np,
+						 "ti,syscon-unaligned-access");
+	if (IS_ERR(regmap)) {
+		dev_dbg(dev, "can't get ti,syscon-unaligned-access\n");
+		return -EINVAL;
+	}
+
+	ret = of_parse_phandle_with_fixed_args(np, "ti,syscon-unaligned-access",
+					       2, 0, &args);
+	if (ret) {
+		dev_err(dev, "failed to parse ti,syscon-unaligned-access\n");
+		return ret;
+	}
+
+	ret = regmap_update_bits(regmap, args.args[0], args.args[1],
+				 args.args[1]);
+	if (ret)
+		dev_err(dev, "failed to enable unaligned access\n");
+
+	of_node_put(args.np);
+
+	return ret;
+}
+
 static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 {
 	u32 reg;
@@ -644,6 +688,11 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	case DW_PCIE_EP_TYPE:
 		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
 				   DEVICE_TYPE_EP);
+
+		ret = dra7xx_pcie_ep_unaligned_memaccess(dev);
+		if (ret)
+			goto err_gpio;
+
 		ret = dra7xx_add_pcie_ep(dra7xx, pdev);
 		if (ret < 0)
 			goto err_gpio;
-- 
2.11.0
