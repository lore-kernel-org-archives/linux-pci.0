Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:46691 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbbBWKV6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Feb 2015 05:21:58 -0500
From: Phong Tran <tranmanphong@gmail.com>
To: tinamdar@apm.com, bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH] PCI: xgene: Fix the map_bus callback prototype
Date: Mon, 23 Feb 2015 17:21:39 +0700
Message-Id: <1424686899-7869-1-git-send-email-tranmanphong@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The return value should be void __iomem *.
Tested by compile only.

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 drivers/pci/host/pci-xgene.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index aab5547..9c3bfd8 100644
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
2.1.0

