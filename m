Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:56849 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932729Ab3LDRbL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 4 Dec 2013 12:31:11 -0500
From: Andrew Lunn <andrew@lunn.ch>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	bhelgaas@google.com
Cc: Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH] PCI: MVEBU: Remove duplicate clock get
Date: Wed,  4 Dec 2013 18:30:41 +0100
Message-Id: <1386178241-10453-1-git-send-email-andrew@lunn.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Probably due to a merge conflict resolution gone bad, the pci clock is
got twice. Remove the second redundent of_clk_get_by_name().

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/pci/host/pci-mvebu.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index c269e430c760..96352be58cc9 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -949,14 +949,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 
 		mvebu_pcie_set_local_dev_nr(port, 1);
 
-		port->clk = of_clk_get_by_name(child, NULL);
-		if (IS_ERR(port->clk)) {
-			dev_err(&pdev->dev, "PCIe%d.%d: cannot get clock\n",
-			       port->port, port->lane);
-			iounmap(port->base);
-			continue;
-		}
-
 		port->dn = child;
 		spin_lock_init(&port->conf_lock);
 		mvebu_sw_pci_bridge_init(port);
-- 
1.8.5

