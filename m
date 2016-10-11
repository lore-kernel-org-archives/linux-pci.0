Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kishon@ti.com>, <nsekhar@ti.com>
Subject: [PATCH 2/4] PCI: dra7xx: simplify the probe code
Date: Tue, 11 Oct 2016 18:28:33 +0530
Message-ID: <1476190715-16884-3-git-send-email-kishon@ti.com>
In-Reply-To: <1476190715-16884-1-git-send-email-kishon@ti.com>
References: <1476190715-16884-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No functional change. Use the new devm_gpiod_get_optional() to
simplify the probe code.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/pci/host/pci-dra7xx.c |   21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 45eb833..4ccba6d 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -325,9 +325,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	void __iomem *base;
 	struct resource *res;
 	char name[10];
-	int gpio_sel;
-	enum of_gpio_flags flags;
-	unsigned long gpio_flags;
+	struct gpio_desc *reset;
 
 	dra7xx_pcie = devm_kzalloc(dev, sizeof(*dra7xx_pcie), GFP_KERNEL);
 	if (!dra7xx_pcie)
@@ -393,19 +391,10 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 		goto err_get_sync;
 	}
 
-	gpio_sel = of_get_gpio_flags(dev->of_node, 0, &flags);
-	if (gpio_is_valid(gpio_sel)) {
-		gpio_flags = (flags & OF_GPIO_ACTIVE_LOW) ?
-				GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH;
-		ret = devm_gpio_request_one(dev, gpio_sel, gpio_flags,
-					    "pcie_reset");
-		if (ret) {
-			dev_err(dev, "gpio%d request failed, ret %d\n",
-				gpio_sel, ret);
-			goto err_gpio;
-		}
-	} else if (gpio_sel == -EPROBE_DEFER) {
-		ret = -EPROBE_DEFER;
+	reset = devm_gpiod_get_optional(dev, NULL, GPIOD_OUT_HIGH);
+	if (IS_ERR(reset)) {
+		ret = PTR_ERR(reset);
+		dev_err(&pdev->dev, "gpio request failed, ret %d\n", ret);
 		goto err_gpio;
 	}
 
-- 
1.7.9.5
