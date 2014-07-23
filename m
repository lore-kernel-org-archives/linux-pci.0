Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42404 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289AbaGWRxE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jul 2014 13:53:04 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Richard Zhu <r65037@freescale.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>, Marek Vasut <marex@denx.de>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	kernel@pengutronix.de
Subject: [PATCH 2/4] PCI: designware: get rid of pci_scan_root_bus
Date: Wed, 23 Jul 2014 19:52:39 +0200
Message-Id: <1406137961-14684-3-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1406137961-14684-1-git-send-email-l.stach@pengutronix.de>
References: <1406137961-14684-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use pci_create_root_bus() similar to other pci
host controller drivers.

The main problem with pci_scan_root_bus() is that
not only it will create the root bus, but also try
to activate all devices on the bus. This triggers
PCI device drivers probe, which try to use the device
but fail as resource allocation isn't done at that
point in time.

To work around this we made sure that the host
controller driver is probed early and finishes resource
allocation before any other device drivers are registered.
Switching to pci_create_root_bus() allows us to get rid
of this special handling.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/host/pcie-designware.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index b13a830c8b0f..b869e202367c 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -801,14 +801,13 @@ static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 	struct pci_bus *bus;
 	struct pcie_port *pp = sys_to_pcie(sys);
 
-	if (pp) {
-		pp->root_bus_nr = sys->busnr;
-		bus = pci_scan_root_bus(pp->dev, sys->busnr, &dw_pcie_ops,
-					sys, &sys->resources);
-	} else {
-		bus = NULL;
-		BUG();
-	}
+	pp->root_bus_nr = sys->busnr;
+	bus = pci_create_root_bus(pp->dev, sys->busnr,
+				  &dw_pcie_ops, sys, &sys->resources);
+	if (!bus)
+		return NULL;
+
+	pci_scan_child_bus(bus);
 
 	return bus;
 }
-- 
2.0.1

