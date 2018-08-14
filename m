Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Hanjie Lin <hanjie.lin@amlogic.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 2/2] PCI: meson: add the Amlogic Meson PCIe phy driver
Date: Tue, 14 Aug 2018 02:12:14 -0400
Message-ID: <1534227134-151584-3-git-send-email-hanjie.lin@amlogic.com>
In-Reply-To: <1534227134-151584-1-git-send-email-hanjie.lin@amlogic.com>
References: <1534227134-151584-1-git-send-email-hanjie.lin@amlogic.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 linux-pci@vger.kernel.org, shawn.lin@rock-chips.com,
 linux-kernel@vger.kernel.org, Yue Wang <yue.wang@amlogic.com>, Kevin
 Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Yue Wang <yue.wang@amlogic.com>

The Meson-PCIE-PHY controller supports the 5-Gbps data rate
of the PCI Express Gen 2 specification and is backwardcompatible
with the 2.5-Gbps Gen 1.1 specification with only
inferred idle detection supported on AMLOGIC SoCs.

Signed-off-by: Yue Wang <yue.wang@amlogic.com>
Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
---
 drivers/phy/amlogic/Kconfig              |   8 ++
 drivers/phy/amlogic/Makefile             |   1 +
 drivers/phy/amlogic/phy-meson-axg-pcie.c | 160 +++++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+)
 create mode 100644 drivers/phy/amlogic/phy-meson-axg-pcie.c

diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
index 23fe1cd..3ab07f9 100644
--- a/drivers/phy/amlogic/Kconfig
+++ b/drivers/phy/amlogic/Kconfig
@@ -36,3 +36,11 @@ config PHY_MESON_GXL_USB3
 	  Enable this to support the Meson USB3 PHY and OTG detection
 	  IP block found in Meson GXL and GXM SoCs.
 	  If unsure, say N.
+
+config PHY_MESON_AXG_PCIE
+	bool "Meson AXG PCIe PHY driver"
+	depends on OF && (ARCH_MESON || COMPILE_TEST)
+	select GENERIC_PHY
+	help
+	  Enable PCIe PHY support for Meson AXG SoC series.
+	  This driver provides PHY interface for Meson PCIe controller.
\ No newline at end of file
diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
index 4fd8848..5ab8578 100644
--- a/drivers/phy/amlogic/Makefile
+++ b/drivers/phy/amlogic/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_PHY_MESON8B_USB2)		+= phy-meson8b-usb2.o
 obj-$(CONFIG_PHY_MESON_GXL_USB2)	+= phy-meson-gxl-usb2.o
 obj-$(CONFIG_PHY_MESON_GXL_USB3)	+= phy-meson-gxl-usb3.o
+obj-$(CONFIG_PHY_MESON_AXG_PCIE)	+= phy-meson-axg-pcie.o
diff --git a/drivers/phy/amlogic/phy-meson-axg-pcie.c b/drivers/phy/amlogic/phy-meson-axg-pcie.c
new file mode 100644
index 0000000..8bc5c49
--- /dev/null
+++ b/drivers/phy/amlogic/phy-meson-axg-pcie.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Amlogic MESON SoC series PCIe PHY driver
+ *
+ * Phy provider for PCIe controller on MESON SoC series
+ *
+ * Copyright (c) 2018 Amlogic, inc.
+ * Yue Wang <yue.wang@amlogic.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/phy/phy.h>
+#include <linux/reset.h>
+
+struct meson_pcie_phy_data {
+	const struct phy_ops	*ops;
+};
+
+struct meson_pcie_reset {
+	struct reset_control	*port_a;
+	struct reset_control	*port_b;
+	struct reset_control	*phy;
+	struct reset_control	*apb;
+};
+
+struct meson_pcie_phy {
+	const struct meson_pcie_phy_data	*data;
+	struct meson_pcie_reset	reset;
+	void __iomem	*phy_base;
+};
+
+static int meson_pcie_phy_init(struct phy *phy)
+{
+	struct meson_pcie_phy *mphy = phy_get_drvdata(phy);
+	struct meson_pcie_reset *mrst = &mphy->reset;
+
+	writel(0x1c, mphy->phy_base);
+	reset_control_assert(mrst->port_a);
+	reset_control_assert(mrst->port_b);
+	reset_control_assert(mrst->phy);
+	reset_control_assert(mrst->apb);
+	udelay(400);
+	reset_control_deassert(mrst->port_a);
+	reset_control_deassert(mrst->port_b);
+	reset_control_deassert(mrst->phy);
+	reset_control_deassert(mrst->apb);
+	udelay(500);
+
+	return 0;
+}
+
+static const struct phy_ops meson_phy_ops = {
+	.init		= meson_pcie_phy_init,
+	.owner		= THIS_MODULE,
+};
+
+static const struct meson_pcie_phy_data meson_pcie_phy_data = {
+	.ops		= &meson_phy_ops,
+};
+
+static const struct of_device_id meson_pcie_phy_match[] = {
+	{
+		.compatible = "amlogic,axg-pcie-phy",
+		.data = &meson_pcie_phy_data,
+	},
+	{},
+};
+
+static int meson_pcie_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct meson_pcie_phy *mphy;
+	struct meson_pcie_reset *mrst;
+	struct phy *generic_phy;
+	struct phy_provider *phy_provider;
+	struct resource *res;
+	const struct meson_pcie_phy_data *data;
+
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -ENODEV;
+
+	mphy = devm_kzalloc(dev, sizeof(*mphy), GFP_KERNEL);
+	if (!mphy)
+		return -ENOMEM;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mphy->phy_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(mphy->phy_base))
+		return PTR_ERR(mphy->phy_base);
+
+	mrst = &mphy->reset;
+
+	mrst->port_a = devm_reset_control_get_shared(dev, "port_a");
+	if (IS_ERR(mrst->port_a)) {
+		if (PTR_ERR(mrst->port_a) != -EPROBE_DEFER)
+			dev_err(dev, "couldn't get port a reset %ld\n",
+				PTR_ERR(mrst->port_a));
+
+		return PTR_ERR(mrst->port_a);
+	}
+
+	mrst->port_b = devm_reset_control_get_shared(dev, "port_b");
+	if (IS_ERR(mrst->port_b)) {
+		if (PTR_ERR(mrst->port_b) != -EPROBE_DEFER)
+			dev_err(dev, "couldn't get port b reset %ld\n",
+				PTR_ERR(mrst->port_b));
+
+		return PTR_ERR(mrst->port_b);
+	}
+
+	mrst->phy = devm_reset_control_get_shared(dev, "phy");
+	if (IS_ERR(mrst->phy)) {
+		if (PTR_ERR(mrst->phy) != -EPROBE_DEFER)
+			dev_err(dev, "couldn't get phy reset\n");
+
+		return PTR_ERR(mrst->phy);
+	}
+
+	mrst->apb = devm_reset_control_get_shared(dev, "apb");
+	if (IS_ERR(mrst->apb)) {
+		if (PTR_ERR(mrst->apb) != -EPROBE_DEFER)
+			dev_err(dev, "couldn't get apb reset\n");
+
+		return PTR_ERR(mrst->apb);
+	}
+
+	reset_control_deassert(mrst->port_a);
+	reset_control_deassert(mrst->port_b);
+	reset_control_deassert(mrst->phy);
+	reset_control_deassert(mrst->apb);
+
+	mphy->data = data;
+
+	generic_phy = devm_phy_create(dev, dev->of_node, mphy->data->ops);
+	if (IS_ERR(generic_phy)) {
+		if (PTR_ERR(generic_phy) != -EPROBE_DEFER)
+			dev_err(dev, "failed to create PHY\n");
+
+		return PTR_ERR(generic_phy);
+	}
+
+	phy_set_drvdata(generic_phy, mphy);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static struct platform_driver meson_pcie_phy_driver = {
+	.probe	= meson_pcie_phy_probe,
+	.driver = {
+		.of_match_table	= meson_pcie_phy_match,
+		.name		= "meson-pcie-phy",
+	}
+};
+
+builtin_platform_driver(meson_pcie_phy_driver);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
