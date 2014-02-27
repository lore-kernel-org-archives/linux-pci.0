Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55889 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676AbaB0QmH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Feb 2014 11:42:07 -0500
From: Lucas Stach <l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	Richard Zhu <r65037@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de
Subject: [PATCH v3 3/3] PCI: imx6: add support for MSI
Date: Thu, 27 Feb 2014 17:41:45 +0100
Message-Id: <1393519305-15128-3-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1393519305-15128-1-git-send-email-l.stach@pengutronix.de>
References: <1393519305-15128-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds support for Message Signaled Interrupt in the
imx6q-pcie driver. It is done in a similar way as for the Exynos
PCIe driver (commit f342d940ee0e3a2b5197fd4fbade1cb6bbc960b7),
which is also using the Synopsys designware PCIe IP core.

Signed-off-by: Harro Haan <hrhaan@gmail.com>
Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/host/pci-imx6.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index ee082509b0ba..50f76581bcfb 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -25,6 +25,7 @@
 #include <linux/resource.h>
 #include <linux/signal.h>
 #include <linux/types.h>
+#include <linux/interrupt.h>
 
 #include "pcie-designware.h"
 
@@ -329,6 +330,17 @@ static int imx6_pcie_wait_for_link(struct pcie_port *pp)
 	return 0;
 }
 
+/* legacy IRQD/MSI interrupt */
+static irqreturn_t imx6_pcie_irqd_msi_handler(int irq, void *arg)
+{
+	struct pcie_port *pp = arg;
+
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		dw_handle_msi_irq(pp);
+
+	return IRQ_HANDLED;
+}
+
 static int imx6_pcie_start_link(struct pcie_port *pp)
 {
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
@@ -403,6 +415,9 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 	dw_pcie_setup_rc(pp);
 
 	imx6_pcie_start_link(pp);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI) && (pp->msi_irq >= 0))
+		dw_pcie_msi_init(pp);
 }
 
 static void imx6_pcie_reset_phy(struct pcie_port *pp)
@@ -498,6 +513,21 @@ static int imx6_add_pcie_port(struct pcie_port *pp,
 		return -ENODEV;
 	}
 
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		pp->msi_irq = platform_get_irq_byname(pdev, "intd/msi");
+		if (pp->msi_irq < 0) {
+			dev_info(&pdev->dev, "failed to get INTD/MSI, PCIe will not support MSI\n");
+		} else {
+			ret = devm_request_irq(&pdev->dev, pp->msi_irq,
+			                       imx6_pcie_irqd_msi_handler,
+			                       IRQF_SHARED, "mx6-pcie-msi", pp);
+			if (ret) {
+				dev_err(&pdev->dev, "failed to request INTD/MSI irq\n");
+				return -ENODEV;
+			}
+		}
+	}
+
 	pp->root_bus_nr = -1;
 	pp->ops = &imx6_pcie_host_ops;
 
-- 
1.8.5.3

