Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59013 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbaC1QxI (ORCPT
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
Subject: [PATCH 5/8] PCI: imx6: drop old irq mapping
Date: Fri, 28 Mar 2014 17:52:56 +0100
Message-Id: <1396025579-14344-6-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We don't need this anymore. The irqs are now
properly mapped through the DT.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/host/pci-imx6.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 71730bbcd9a2..259a73687526 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -483,12 +483,6 @@ static int imx6_add_pcie_port(struct pcie_port *pp,
 {
 	int ret;
 
-	pp->irq = platform_get_irq(pdev, 0);
-	if (!pp->irq) {
-		dev_err(&pdev->dev, "failed to get irq\n");
-		return -ENODEV;
-	}
-
 	pp->root_bus_nr = -1;
 	pp->ops = &imx6_pcie_host_ops;
 
-- 
1.9.0

