Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:25225 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753090AbaIVJvV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 05:51:21 -0400
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
Message-ID: <1411379470-20639-3-git-send-email-phil.edworthy@renesas.com>
Date: Mon, 22 Sep 2014 10:51:09 +0100
Subject: [PATCH 2/3] PCI: rcar-internal-pci: Add call to get domain nr
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

R-Car devices (r8a7790 and r8a7791) need to place the internal PCI and external
PCIe controllers on separate domains so that they can work at the same time.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/pci/host/pci-rcar-gen2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index 3ef854f..17681ea 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -99,6 +99,7 @@ struct rcar_pci_priv {
 	struct resource io_res;
 	struct resource mem_res;
 	struct resource *cfg_res;
+	int domain;
 	unsigned busnr;
 	int irq;
 	unsigned long window_size;
@@ -373,6 +374,8 @@ static int rcar_pci_probe(struct platform_device *pdev)
 
 	priv->window_size = SZ_1G;
 
+	priv->domain = of_pci_get_domain_nr(pdev->dev.of_node, true);
+
 	if (pdev->dev.of_node) {
 		struct resource busnr;
 		int ret;
@@ -397,6 +400,9 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	hw.map_irq = rcar_pci_map_irq;
 	hw.ops = &rcar_pci_ops;
 	hw.setup = rcar_pci_setup;
+#ifdef CONFIG_PCI_DOMAINS
+	hw.domain = priv->domain;
+#endif
 	pci_common_init_dev(&pdev->dev, &hw);
 	return 0;
 }
-- 
2.1.0

