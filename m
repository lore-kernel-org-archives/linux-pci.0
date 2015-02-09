Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:60391 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759368AbbBIUMg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Feb 2015 15:12:36 -0500
Received: by mail-qa0-f41.google.com with SMTP id x12so5821158qac.0
        for <linux-pci@vger.kernel.org>; Mon, 09 Feb 2015 12:12:35 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: robh@kernel.org, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] PCI: xgene: Fix xgene_pcie_map_bus() return type
Date: Mon,  9 Feb 2015 18:12:11 -0200
Message-Id: <1423512731-9625-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

Commit 350f8be5bb402a1 ("PCI: xgene: Convert to use generic config accessors")
introduced the following build warnings:

drivers/pci/host/pci-xgene.c:137:3: warning: return makes integer from pointer without a cast
drivers/pci/host/pci-xgene.c:140:2: warning: return makes integer from pointer without a cast
drivers/pci/host/pci-xgene.c:144:2: warning: initialization from incompatible pointer type
drivers/pci/host/pci-xgene.c:144:2: warning: (near initialization for 'xgene_pcie_ops.map_bus')

The .map_bus function should return 'void __iomem *' instead of 'int'.

Reported-by: Olof's autobuilder <build@lixom.net>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/pci/host/pci-xgene.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index aab5547..22addb6 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -127,7 +127,7 @@ static bool xgene_pcie_hide_rc_bars(struct pci_bus *bus, int offset)
 	return false;
 }
 
-static int xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
+static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
 			      int offset)
 {
 	struct xgene_pcie_port *port = bus->sysdata;
-- 
1.9.1

