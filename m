Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59017 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567AbaC1QxI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Mar 2014 12:53:08 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	Sean Cross <xobs@kosagi.com>, Marek Vasut <marex@denx.de>,
	Richard Zhu <r65037@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Tim Harvey <tharvey@gateworks.com>, kernel@pengutronix.de
Subject: [PATCH 8/8] PCI: imx6: add support for MSI
Date: Fri, 28 Mar 2014 17:52:59 +0100
Message-Id: <1396025579-14344-9-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds support for Message Signaled Interrupts in the
imx6-pcie driver.

Signed-off-by: Harro Haan <hrhaan@gmail.com>
Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/host/pci-imx6.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 4c20fc4795e5..41008b7804f9 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -25,6 +25,7 @@
 #include <linux/resource.h>
 #include <linux/signal.h>
 #include <linux/types.h>
+#include <linux/interrupt.h>
 
 #include "pcie-designware.h"
 
@@ -314,6 +315,13 @@ static int imx6_pcie_wait_for_link(struct pcie_port *pp)
 	return 0;
 }
 
+static irqreturn_t imx6_pcie_msi_handler(int irq, void *arg)
+{
+	struct pcie_port *pp = arg;
+
+	return dw_handle_msi_irq(pp);
+}
+
 static int imx6_pcie_start_link(struct pcie_port *pp)
 {
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
@@ -388,6 +396,9 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 	dw_pcie_setup_rc(pp);
 
 	imx6_pcie_start_link(pp);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		dw_pcie_msi_init(pp);
 }
 
 static void imx6_pcie_reset_phy(struct pcie_port *pp)
@@ -477,6 +488,22 @@ static int imx6_add_pcie_port(struct pcie_port *pp,
 {
 	int ret;
 
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
+		if (pp->msi_irq <= 0) {
+			dev_err(&pdev->dev, "failed to get MSI irq\n");
+			return -ENODEV;
+		}
+
+		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
+		                       imx6_pcie_msi_handler,
+		                       IRQF_SHARED, "mx6-pcie-msi", pp);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to request MSI irq\n");
+			return -ENODEV;
+		}
+	}
+
 	pp->root_bus_nr = -1;
 	pp->ops = &imx6_pcie_host_ops;
 
-- 
1.9.0

