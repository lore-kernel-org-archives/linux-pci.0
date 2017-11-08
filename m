Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:44455 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbdKHJ2X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2017 04:28:23 -0500
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 3/3] PCI: rcar: Add the suspend/resume for pcie-rcar driver
Date: Wed,  8 Nov 2017 10:28:06 +0100
Message-Id: <20171108092806.10335-3-marek.vasut+renesas@gmail.com>
In-Reply-To: <20171108092806.10335-1-marek.vasut+renesas@gmail.com>
References: <20171108092806.10335-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>

This adds the suspend/resume supports for pcie-rcar. The resume handler
reprogram the hardware based on the software state kept in specific
device structures. Also it doesn't need to save any registers.

Signed-off-by: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/pci/host/pcie-rcar.c | 86 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 78 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 2b28292de93a..7a9e30185c79 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -471,6 +471,36 @@ static void rcar_pcie_force_speedup(struct rcar_pcie *pcie)
 		 (macsr & LINK_SPEED) == LINK_SPEED_5_0GTS ? "5" : "2.5");
 }
 
+static int rcar_pcie_hw_enable(struct rcar_pcie *pcie)
+{
+	struct resource_entry *win;
+	LIST_HEAD(res);
+	int i = 0;
+
+	/* Try setting 5 GT/s link speed */
+	rcar_pcie_force_speedup(pcie);
+
+	/* Setup PCI resources */
+	resource_list_for_each_entry(win, &pcie->resources) {
+		struct resource *res = win->res;
+
+		if (!res->flags)
+			continue;
+
+		switch (resource_type(res)) {
+		case IORESOURCE_IO:
+		case IORESOURCE_MEM:
+			rcar_pcie_setup_window(i, pcie, res);
+			i++;
+			break;
+		default:
+			continue;
+		}
+	}
+
+	return 0;
+}
+
 static int rcar_pcie_enable(struct rcar_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -872,11 +902,25 @@ static const struct irq_domain_ops msi_domain_ops = {
 	.map = rcar_msi_map,
 };
 
+static void rcar_pcie_hw_enable_msi(struct rcar_pcie *pcie)
+{
+	struct rcar_msi *msi = &pcie->msi;
+	unsigned long base;
+
+	/* setup MSI data target */
+	base = virt_to_phys((void *)msi->pages);
+
+	rcar_pci_write_reg(pcie, base | MSIFE, PCIEMSIALR);
+	rcar_pci_write_reg(pcie, 0, PCIEMSIAUR);
+
+	/* enable all MSI interrupts */
+	rcar_pci_write_reg(pcie, 0xffffffff, PCIEMSIIER);
+}
+
 static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct rcar_msi *msi = &pcie->msi;
-	unsigned long base;
 	int err, i;
 
 	mutex_init(&msi->lock);
@@ -915,13 +959,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 
 	/* setup MSI data target */
 	msi->pages = __get_free_pages(GFP_KERNEL, 0);
-	base = virt_to_phys((void *)msi->pages);
-
-	rcar_pci_write_reg(pcie, base | MSIFE, PCIEMSIALR);
-	rcar_pci_write_reg(pcie, 0, PCIEMSIAUR);
-
-	/* enable all MSI interrupts */
-	rcar_pci_write_reg(pcie, 0xffffffff, PCIEMSIIER);
+	rcar_pcie_hw_enable_msi(pcie);
 
 	return 0;
 
@@ -1202,6 +1240,37 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
+static int rcar_pcie_resume(struct device *dev)
+{
+	struct rcar_pcie *pcie = dev_get_drvdata(dev);
+	unsigned int data;
+	int err;
+	int (*hw_init_fn)(struct rcar_pcie *);
+
+	err = rcar_pcie_parse_map_dma_ranges(pcie, dev->of_node);
+	if (err)
+		return 0;
+
+	/* Failure to get a link might just be that no cards are inserted */
+	hw_init_fn = of_device_get_match_data(dev);
+	err = hw_init_fn(pcie);
+	if (err) {
+		dev_info(dev, "PCIe link down\n");
+		return 0;
+	}
+
+	data = rcar_pci_read_reg(pcie, MACSR);
+	dev_info(dev, "PCIe x%d: link up\n", (data >> 20) & 0x3f);
+
+	/* Enable MSI */
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		rcar_pcie_hw_enable_msi(pcie);
+
+	rcar_pcie_hw_enable(pcie);
+
+	return 0;
+}
+
 static int rcar_pcie_resume_noirq(struct device *dev)
 {
 	struct rcar_pcie *pcie = dev_get_drvdata(dev);
@@ -1218,6 +1287,7 @@ static int rcar_pcie_resume_noirq(struct device *dev)
 }
 
 static const struct dev_pm_ops rcar_pcie_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(NULL, rcar_pcie_resume)
 	.resume_noirq = rcar_pcie_resume_noirq,
 };
 
-- 
2.11.0
