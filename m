Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33560 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759757AbbIVXt1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2015 19:49:27 -0400
From: David Daney <ddaney.cavm@gmail.com>
To: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>
Cc: David Daney <david.daney@cavium.com>
Subject: [PATCH v3 5/6] PCI: generic: Pass proper starting bus number to pci_scan_root_bus().
Date: Tue, 22 Sep 2015 16:49:16 -0700
Message-Id: <1442965757-12925-6-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1442965757-12925-1-git-send-email-ddaney.cavm@gmail.com>
References: <1442965757-12925-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

If the bus is being configured with a bus-range that does not start at
zero, pass that starting bus number to pci_scan_root_bus().  Passing
the incorrect value of zero causes attempted config accesses outside
of the supported range, which cascades to an OOPs spew and eventual
kernel panic.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
No change from v1 or v2.

 drivers/pci/host/pci-host-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index 0a9c453..e364232 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -259,7 +259,7 @@ static int gen_pci_probe(struct platform_device *pdev)
 	if (!pci_has_flag(PCI_PROBE_ONLY))
 		pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
 
-	bus = pci_scan_root_bus(dev, 0,
+	bus = pci_scan_root_bus(dev, pci->cfg.bus_range->start,
 				&pci->cfg.ops.ops, pci, &pci->resources);
 	if (!bus) {
 		dev_err(dev, "Scanning rootbus failed");
-- 
1.9.1

