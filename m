Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55004 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbaBZK1Y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Feb 2014 05:27:24 -0500
From: Lucas Stach <l.stach@pengutronix.de>
To: Richard Zhu <r65037@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH v2 2/2] PCI: imx6: add support for MSI
Date: Wed, 26 Feb 2014 11:27:18 +0100
Message-Id: <1393410438-28205-2-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1393410438-28205-1-git-send-email-l.stach@pengutronix.de>
References: <1393410438-28205-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Juergen Beisert <jbe@pengutronix.de>

This patch adds support for Message Signaled Interrupt in the
imx6q-pcie driver. It is done in a similar way as for the Exynos
PCIe driver (commit f342d940ee0e3a2b5197fd4fbade1cb6bbc960b7),
which is also using the Synopsys designware PCIe IP core.

Signed-off-by: Harro Haan <hrhaan@gmail.com>
Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v2: fix typo MCI->MSI
---
 drivers/pci/host/pci-imx6.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index ee082509b0ba..344a72184307 100644
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
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		dw_pcie_msi_init(pp);
 }
 
 static void imx6_pcie_reset_phy(struct pcie_port *pp)
@@ -498,6 +513,20 @@ static int imx6_add_pcie_port(struct pcie_port *pp,
 		return -ENODEV;
 	}
 
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		pp->msi_irq = platform_get_irq(pdev, 3);
+		if (!pp->msi_irq) {
+			dev_err(&pdev->dev, "failed to get INTD/MSI\n");
+			return -ENODEV;
+		}
+
+		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
+					imx6_pcie_irqd_msi_handler,
+					IRQF_SHARED, "mx6-pcie-msi", pp);
+		if (ret)
+			dev_err(&pdev->dev, "failed to request INTD/MSI irq\n");
+	}
+
 	pp->root_bus_nr = -1;
 	pp->ops = &imx6_pcie_host_ops;
 
-- 
1.8.5.3

