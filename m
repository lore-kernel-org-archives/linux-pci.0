Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <tony@atomide.com>
CC: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<bcousson@baylibre.com>, <linux@arm.linux.org.uk>, <kishon@ti.com>,
	<nsekhar@ti.com>
Subject: [PATCH 1/2] pci: host: pci-dra7xx: Add support to make gpio drive PERST# line
Date: Tue, 28 Jul 2015 19:09:09 +0530
Message-ID: <1438090750-11604-2-git-send-email-kishon@ti.com>
In-Reply-To: <1438090750-11604-1-git-send-email-kishon@ti.com>
References: <1438090750-11604-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PERST# line in am57x-evm is connected to a gpio line and PERST#
should be driven high to indicate the clocks are stable (As per
Figure 2-10: Power Up of the PCIe CEM spec 3.0).

Add support in pci-dra7xx driver to make gpio drive PERST#
line here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/pci/ti-pci.txt |    3 +++
 drivers/pci/host/pci-dra7xx.c                    |   24 ++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
index 3d21791..60e2516 100644
--- a/Documentation/devicetree/bindings/pci/ti-pci.txt
+++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
@@ -23,6 +23,9 @@ PCIe Designware Controller
    interrupt-map-mask,
    interrupt-map : as specified in ../designware-pcie.txt
 
+Optional Property:
+ - gpios : Should be added if a gpio line is required to drive PERST# line
+
 Example:
 axi {
 	compatible = "simple-bus";
diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 7acc833..d3d0faf 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -17,6 +17,7 @@
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_gpio.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -336,6 +337,9 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	char name[10];
+	int gpio_sel;
+	enum of_gpio_flags flags;
+	unsigned long gpio_flags;
 
 	dra7xx = devm_kzalloc(dev, sizeof(*dra7xx), GFP_KERNEL);
 	if (!dra7xx)
@@ -398,6 +402,22 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 		goto err_get_sync;
 	}
 
+	gpio_sel = of_get_gpio_flags(dev->of_node, 0, &flags);
+	if (gpio_is_valid(gpio_sel)) {
+		gpio_flags = (flags & OF_GPIO_ACTIVE_LOW) ?
+				GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH;
+		ret = devm_gpio_request_one(dev, gpio_sel, gpio_flags,
+					    "pcie_reset");
+		if (ret) {
+			dev_err(&pdev->dev, "gpio%d request failed, ret %d\n",
+				gpio_sel, ret);
+			goto err_gpio;
+		}
+	} else if (gpio_sel == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
+		goto err_gpio;
+	}
+
 	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD);
 	reg &= ~LTSSM_EN;
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
@@ -406,11 +426,11 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 
 	ret = dra7xx_add_pcie_port(dra7xx, pdev);
 	if (ret < 0)
-		goto err_add_port;
+		goto err_gpio;
 
 	return 0;
 
-err_add_port:
+err_gpio:
 	pm_runtime_put(dev);
 
 err_get_sync:
-- 
1.7.9.5

