Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:49949 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752013AbcKGMBZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2016 07:01:25 -0500
From: Simon Horman <horms+renesas@verge.net.au>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC] PCI: rcar: Restrict pci_fixup_irqs to the same PCI domain
Date: Mon,  7 Nov 2016 13:00:48 +0100
Message-Id: <1478520048-25430-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Phil Edworthy <phil.edworthy@renesas.com>

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---

Phil, this is from the 3.3.2 BSP.
Is it appropriate for mainline?
---
 drivers/pci/host/pcie-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 62700d1896f4..06e7a75094c7 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -472,7 +472,7 @@ static int rcar_pcie_enable(struct rcar_pcie *pcie)
 		return -ENODEV;
 	}
 
-	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
+	pci_fixup_irqs_local(bus, pci_common_swizzle, of_irq_parse_and_map_pci);
 
 	pci_bus_size_bridges(bus);
 	pci_bus_assign_resources(bus);
-- 
2.7.0.rc3.207.g0ac5344

