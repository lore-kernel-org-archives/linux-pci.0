Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44374 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933991AbaKMTho (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Nov 2014 14:37:44 -0500
From: Lucas Stach <l.stach@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCI: tegra: remove bogus bridge setup fixup
Date: Thu, 13 Nov 2014 20:37:37 +0100
Message-Id: <1415907457-3147-3-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1415907457-3147-1-git-send-email-l.stach@pengutronix.de>
References: <1415907457-3147-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The bridge setup is already done by generic code
while scanning the buses. Do not duplicate (or potentially
alter) this setup as a fixup.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/host/pci-tegra.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index d5a14f22ebb8..0ef22505cead 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -624,19 +624,6 @@ static void tegra_pcie_port_free(struct tegra_pcie_port *port)
 	devm_kfree(pcie->dev, port);
 }
 
-static void tegra_pcie_fixup_bridge(struct pci_dev *dev)
-{
-	u16 reg;
-
-	if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE) {
-		pci_read_config_word(dev, PCI_COMMAND, &reg);
-		reg |= (PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
-			PCI_COMMAND_MASTER | PCI_COMMAND_SERR);
-		pci_write_config_word(dev, PCI_COMMAND, reg);
-	}
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, tegra_pcie_fixup_bridge);
-
 /* Tegra PCIE root complex wrongly reports device class */
 static void tegra_pcie_fixup_class(struct pci_dev *dev)
 {
-- 
2.1.1

