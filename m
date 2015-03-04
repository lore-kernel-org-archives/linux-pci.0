Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43962 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752966AbbCDWY5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 4 Mar 2015 17:24:57 -0500
From: Mark Salter <msalter@redhat.com>
To: Tanmay Inamdar <tinamdar@apm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Salter <msalter@redhat.com>
Subject: [PATCH] PCI: xgene: fix breakage from generic config usage
Date: Wed,  4 Mar 2015 17:24:24 -0500
Message-Id: <1425507864-22055-1-git-send-email-msalter@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 350f8be5bb402 ("PCI: xgene: Convert to use generic config
accessors") breaks PCI on the X-Gene platform. It creates two
problems with the xgene_pcie_map_bus() function. First, it returns
an int but should return a void __iomem *, but that's just a
compile-time warning. The breakage is caused by the offset not
being added to the base of the config map. So all config reads
and writes operate on the first four bytes of config space. This
patch fixes both issues.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 drivers/pci/host/pci-xgene.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 52bb25c..b87f80b 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -129,17 +129,21 @@ static bool xgene_pcie_hide_rc_bars(struct pci_bus *bus, int offset)
 	return false;
 }
 
-static int xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
-			      int offset)
+static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
+					int offset)
 {
 	struct xgene_pcie_port *port = bus->sysdata;
+	void __iomem *base;
 
 	if ((pci_is_root_bus(bus) && devfn != 0) || !port->link_up ||
 	    xgene_pcie_hide_rc_bars(bus, offset))
 		return NULL;
 
 	xgene_pcie_set_rtdid_reg(bus, devfn);
-	return xgene_pcie_get_cfg_base(bus);
+	base = xgene_pcie_get_cfg_base(bus);
+	if (base)
+		base += offset;
+	return base;
 }
 
 static struct pci_ops xgene_pcie_ops = {
-- 
1.8.3.1

