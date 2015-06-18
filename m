Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
	patches@apm.com, Duc Dang <dhdang@apm.com>
Subject: [PATCH 1/1] pci: xgene: Fix compilation warning
Date: Thu, 18 Jun 2015 15:10:58 -0700
Message-Id: <1434665458-28354-1-git-send-email-dhdang@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

commit 979595bcb8da ("PCI: xgene: Allow config access to Root Port even
when link is down") removes the port->link_up check, which makes 'port'
become unused variable. This patch remove struct xgene_pcie_port *port
declaration to avoid compilation warning.

Signed-off-by: Duc Dang <dhdang@apm.com>
Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
---
 drivers/pci/host/pci-xgene.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 3684126..105fd83 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -137,8 +137,6 @@ static bool xgene_pcie_hide_rc_bars(struct pci_bus *bus, int offset)
 static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
 			      int offset)
 {
-	struct xgene_pcie_port *port = bus->sysdata;
-
 	if ((pci_is_root_bus(bus) && devfn != 0) ||
 	    xgene_pcie_hide_rc_bars(bus, offset))
 		return NULL;
-- 
1.9.1

