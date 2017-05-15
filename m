Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36156 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757046AbdEORXi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2017 13:23:38 -0400
Received: by mail-wm0-f54.google.com with SMTP id u65so88659322wmu.1
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2017 10:23:37 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2] pci: ftpci100: Add clock handling
Date: Mon, 15 May 2017 19:23:24 +0200
Message-Id: <20170515172324.1833-1-linus.walleij@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds some optional clock handling to the Faraday FTPCI100.
We just get and prepare+enable the clocks right now, if they exist.
We can add more elaborate clock handling later.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pci/host/pci-ftpci100.c | 56 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/host/pci-ftpci100.c
index d26501c4145a..ebab33e99a0d 100644
--- a/drivers/pci/host/pci-ftpci100.c
+++ b/drivers/pci/host/pci-ftpci100.c
@@ -25,6 +25,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/bitops.h>
 #include <linux/irq.h>
+#include <linux/clk.h>
 
 /*
  * Special configuration registers directly in the first few words
@@ -37,6 +38,7 @@
 #define PCI_CONFIG	0x28 /* PCI configuration command register */
 #define PCI_DATA	0x2C
 
+#define FARADAY_PCI_STATUS_CMD		0x04 /* Status and command */
 #define FARADAY_PCI_PMC			0x40 /* Power management control */
 #define FARADAY_PCI_PMCSR		0x44 /* Power management status */
 #define FARADAY_PCI_CTRL1		0x48 /* Control register 1 */
@@ -45,6 +47,8 @@
 #define FARADAY_PCI_MEM2_BASE_SIZE	0x54 /* Memory base and size #2 */
 #define FARADAY_PCI_MEM3_BASE_SIZE	0x58 /* Memory base and size #3 */
 
+#define PCI_STATUS_66MHZ_CAPABLE	BIT(21)
+
 /* Bits 31..28 gives INTD..INTA status */
 #define PCI_CTRL2_INTSTS_SHIFT		28
 #define PCI_CTRL2_INTMASK_CMDERR	BIT(27)
@@ -117,6 +121,7 @@ struct faraday_pci {
 	void __iomem *base;
 	struct irq_domain *irqdomain;
 	struct pci_bus *bus;
+	struct clk *bus_clk;
 };
 
 static int faraday_res_to_memcfg(resource_size_t mem_base,
@@ -428,6 +433,7 @@ static int faraday_pci_probe(struct platform_device *pdev)
 	struct resource *mem;
 	struct resource *io;
 	struct pci_host_bridge *host;
+	struct clk *clk;
 	int ret;
 	u32 val;
 	LIST_HEAD(res);
@@ -444,6 +450,28 @@ static int faraday_pci_probe(struct platform_device *pdev)
 	host->sysdata = p;
 	p->dev = dev;
 
+	/* Retrieve and enable optional clocks */
+	clk = devm_clk_get(dev, "PCLK");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "no PCLK available\n");
+	} else {
+		ret = clk_prepare_enable(clk);
+		if (ret) {
+			dev_err(dev, "could not prepare PCLK\n");
+			return ret;
+		}
+	}
+	p->bus_clk = devm_clk_get(dev, "PCICLK");
+	if (IS_ERR(p->bus_clk)) {
+		dev_err(dev, "no PCICLK available\n");
+	} else {
+		ret = clk_prepare_enable(p->bus_clk);
+		if (ret) {
+			dev_err(dev, "could not prepare PCICLK\n");
+			return ret;
+		}
+	}
+
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	p->base = devm_ioremap_resource(dev, regs);
 	if (IS_ERR(p->base))
@@ -515,6 +543,34 @@ static int faraday_pci_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* Check bus clock if we can gear up to 66 MHz */
+	if (!IS_ERR(p->bus_clk)) {
+		unsigned long rate;
+		u32 val;
+
+		faraday_pci_read_config(p->bus, 0,
+					FARADAY_PCI_STATUS_CMD, 4, &val);
+		rate = clk_get_rate(p->bus_clk);
+
+		if ((rate == 33000000) && (val & PCI_STATUS_66MHZ_CAPABLE)) {
+			dev_info(dev, "33MHz bus is 66MHz capable\n");
+			p->bus->max_bus_speed = PCI_SPEED_66MHz;
+			ret = clk_set_rate(p->bus_clk, 66000000);
+			if (ret)
+				dev_err(dev, "failed to set bus clock\n");
+		} else {
+			dev_info(dev, "33MHz only bus\n");
+			p->bus->max_bus_speed = PCI_SPEED_33MHz;
+		}
+
+		/* Bumping the clock may fail so read back the rate */
+		rate = clk_get_rate(p->bus_clk);
+		if (rate == 33000000)
+			p->bus->cur_bus_speed = PCI_SPEED_33MHz;
+		if (rate == 66000000)
+			p->bus->cur_bus_speed = PCI_SPEED_66MHz;
+	}
+
 	ret = faraday_pci_parse_map_dma_ranges(p, dev->of_node);
 	if (ret)
 		return ret;
-- 
2.9.3
