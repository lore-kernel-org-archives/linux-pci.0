Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:15347 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753540AbaIVJvW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 05:51:22 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Phil Edworthy <phil.edworthy@renesas.com>
In-Reply-To: <1411379470-20639-1-git-send-email-phil.edworthy@renesas.com>
References: <1411379470-20639-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1411379470-20639-2-git-send-email-phil.edworthy@renesas.com>
Date: Mon, 22 Sep 2014 10:51:08 +0100
Subject: [PATCH 1/3] PCI: rcar-pcie: Add call to get domain nr
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

R-Car devices (r8a7790 and r8a7791) need to place the internal PCI and external
PCIe controllers on separate domains so that they can work at the same time.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/pci/host/pcie-rcar.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 4884ee5..db74371 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -128,6 +128,7 @@ struct rcar_pcie {
 	struct device		*dev;
 	void __iomem		*base;
 	struct resource		res[RCAR_PCI_MAX_RESOURCES];
+	int			domain;
 	struct resource		busn;
 	int			root_bus_nr;
 	struct clk		*clk;
@@ -393,13 +394,13 @@ static void rcar_pcie_enable(struct rcar_pcie *pcie)
 {
 	struct platform_device *pdev = to_platform_device(pcie->dev);
 
+#ifdef CONFIG_PCI_DOMAINS
+	rcar_pci.domain = pcie->domain;
+#endif
 	rcar_pci.nr_controllers = 1;
 	rcar_pci.private_data = (void **)&pcie;
 
 	pci_common_init_dev(&pdev->dev, &rcar_pci);
-#ifdef CONFIG_PCI_DOMAINS
-	rcar_pci.domain++;
-#endif
 }
 
 static int phy_wait_for_ack(struct rcar_pcie *pcie)
@@ -917,6 +918,8 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	pcie->dev = &pdev->dev;
 	platform_set_drvdata(pdev, pcie);
 
+	pcie->domain = of_pci_get_domain_nr(pdev->dev.of_node, true);
+
 	/* Get the bus range */
 	if (of_pci_parse_bus_range(pdev->dev.of_node, &pcie->busn)) {
 		dev_err(&pdev->dev, "failed to parse bus-range property\n");
-- 
2.1.0

