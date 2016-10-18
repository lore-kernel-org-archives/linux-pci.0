Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48308 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751689AbcJRIZw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Oct 2016 04:25:52 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        linux-pci@vger.kernel.org,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: [PATCH resend] PCI: designware: fix register access before host init
Date: Tue, 18 Oct 2016 10:25:49 +0200
Message-Id: <20161018082549.10905-1-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The function used to determine if iATU unroll is available will read
a RC register. This is not possible and will result in a system hang
if the RC is still in reset, so it is only safe to call this function
after host_init() has been called.

Fixes: a0601a470537 (PCI: designware: Add iATU Unroll feature)
Reported-by: Gary Bisson <gary.bisson@boundarydevices.com>
Tested-by: Gary Bisson <gary.bisson@boundarydevices.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/host/pcie-designware.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 035f50c03281..74510508fafc 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -637,11 +637,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		}
 	}
 
-	pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
-
 	if (pp->ops->host_init)
 		pp->ops->host_init(pp);
 
+	pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
+
 	pp->root_bus_nr = pp->busn->start;
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		bus = pci_scan_root_bus_msi(pp->dev, pp->root_bus_nr,
-- 
2.9.3

