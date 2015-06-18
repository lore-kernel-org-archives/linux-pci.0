Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
	patches@apm.com, Duc Dang <dhdang@apm.com>
Subject: [PATCH 1/1] PCI: xgene: Allow config access to Root Port even when link is down
Date: Thu, 18 Jun 2015 11:45:39 -0700
Message-Id: <1434653139-14461-1-git-send-email-dhdang@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Even if a Root Port's link is down, we should still be able to access the
Port's configuration space.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Duc Dang <dhdang@apm.com>
Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
---
 drivers/pci/host/pci-xgene.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 7e3cf28..2e66c87 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -139,7 +139,7 @@ static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
 {
 	struct xgene_pcie_port *port = bus->sysdata;
 
-	if ((pci_is_root_bus(bus) && devfn != 0) || !port->link_up ||
+	if ((pci_is_root_bus(bus) && devfn != 0) ||
 	    xgene_pcie_hide_rc_bars(bus, offset))
 		return NULL;
 
-- 
1.9.1

