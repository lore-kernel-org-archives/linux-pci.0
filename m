Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41660 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932845AbcBBRMZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 2 Feb 2016 12:12:25 -0500
Date: Tue, 2 Feb 2016 11:12:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Vineet.Gupta1@synopsys.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	CARLOS.PALMINHA@synopsys.com, Alexey.Brodkin@synopsys.com,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org, arnd@arndb.de
Subject: Re: [PATCH v7 2/2] add new platform driver for PCI RC
Message-ID: <20160202171221.GC11085@localhost>
References: <cover.1454349430.git.jpinto@synopsys.com>
 <10b29adcdb0a31eb8f8071b271da267e44ad8a04.1454349430.git.jpinto@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <10b29adcdb0a31eb8f8071b271da267e44ad8a04.1454349430.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 01, 2016 at 06:07:45PM +0000, Joao Pinto wrote:
> This patch adds a new driver that will be the reference platform driver
> for all PCI RC IP Protoyping Kits based on ARC SDP.
> This patch is composed by:
> 
> -MAINTAINERS file was updated to include the new driver
> -Documentation/devicetree/bindings/pci was updated to include the new
> driver documentation
> -New driver called pcie-synopsys
> 
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>

I applied the following changes.  Mostly whitespace/comment cleanup, but
also removed some include files that I don't think you need and added a
message when the link fails to come up.  Please test and make sure this
still works.

Bjorn


diff --git a/drivers/pci/host/pcie-synopsys.c b/drivers/pci/host/pcie-synopsys.c
index 9702e79..757ba30 100644
--- a/drivers/pci/host/pcie-synopsys.c
+++ b/drivers/pci/host/pcie-synopsys.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2015-2016 Synopsys, Inc. (www.synopsys.com)
  *
- * Authors: Manjunath Bettegowda <manjumb@synopsys.com>,
+ * Authors: Manjunath Bettegowda <manjumb@synopsys.com>
  *	    Jie Deng <jiedeng@synopsys.com>
  *	    Joao Pinto <jpinto@synopsys.com>
  *
@@ -12,17 +12,13 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/resource.h>
-#include <linux/signal.h>
 #include <linux/types.h>
 
 #include "pcie-designware.h"
@@ -38,8 +34,8 @@ struct synopsys_pcie {
 					    */
 };
 
-#define PCI_EQUAL_CONTROL_PHY 0x00000707
-#define PCIE_PHY_DEBUG_R1_LINK_UP 0x00000010
+#define PCI_EQUAL_CONTROL_PHY		0x00000707
+#define PCIE_PHY_DEBUG_R1_LINK_UP	0x00000010
 
 /* PCIe Port Logic registers (memory-mapped) */
 #define PLR_OFFSET 0x700
@@ -56,8 +52,6 @@ static irqreturn_t synopsys_pcie_msi_irq_handler(int irq, void *arg)
 {
 	struct pcie_port *pp = arg;
 
-	dw_handle_msi_irq(pp);
-
 	return dw_handle_msi_irq(pp);
 }
 
@@ -74,9 +68,9 @@ static int synopsys_pcie_deassert_core_reset(struct pcie_port *pp)
 
 static void synopsys_pcie_establish_link(struct pcie_port *pp)
 {
-	int retries = 0;
+	int retries;
 
-	/* check if the link is up or not */
+	/* wait for link to come up */
 	for (retries = 0; retries < 10; retries++) {
 		if (dw_pcie_link_up(pp)) {
 			dev_info(pp->dev, "Link up\n");
@@ -84,6 +78,8 @@ static void synopsys_pcie_establish_link(struct pcie_port *pp)
 		}
 		mdelay(100);
 	}
+
+	dev_err(pp->dev, "Link fail\n");
 }
 
 /*
@@ -142,21 +138,18 @@ static int synopsys_add_pcie_port(struct pcie_port *pp,
 	int ret;
 
 	pp->irq = platform_get_irq(pdev, 1);
-
 	if (pp->irq < 0)
 		return pp->irq;
 
 	ret = devm_request_irq(&pdev->dev, pp->irq, synopsys_pcie_irq_handler,
 				IRQF_SHARED, "synopsys-pcie", pp);
-
 	if (ret) {
-		dev_err(&pdev->dev, "failed to request irq\n");
+		dev_err(&pdev->dev, "failed to request IRQ %d\n", pp->irq);
 		return ret;
 	}
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		pp->msi_irq = platform_get_irq(pdev, 0);
-
 		if (pp->msi_irq < 0)
 			return pp->msi_irq;
 
@@ -164,7 +157,8 @@ static int synopsys_add_pcie_port(struct pcie_port *pp,
 					synopsys_pcie_msi_irq_handler,
 					IRQF_SHARED, "synopsys-pcie-msi", pp);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to request msi irq\n");
+			dev_err(&pdev->dev, "failed to request MSI IRQ %d\n",
+				pp->msi_irq);
 			return ret;
 		}
 	}
@@ -194,18 +188,18 @@ static int synopsys_add_pcie_port(struct pcie_port *pp,
 
 /**
  * synopsys_pcie_probe()
- * This function gets called as part of pcie registration. if the id matches
+ * This function gets called as part of PCIe registration. If the ID matches
  * the platform driver framework will call this function.
  *
  * @pdev: Pointer to the platform_device structure
  *
- * Returns zero on success; Negative errorno on failure
+ * Returns zero on success; Negative errno on failure
  */
 static int synopsys_pcie_probe(struct platform_device *pdev)
 {
 	struct synopsys_pcie *synopsys_pcie;
 	struct pcie_port *pp;
-	struct resource *res;  /* Resource from DT */
+	struct resource *res;
 	int ret;
 
 	synopsys_pcie = devm_kzalloc(&pdev->dev, sizeof(*synopsys_pcie),
@@ -217,7 +211,6 @@ static int synopsys_pcie_probe(struct platform_device *pdev)
 	pp->dev = &pdev->dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
 	if (!res)
 		return -ENODEV;
 
