Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 82-68-191-81.dsl.posilan.com ([82.68.191.81]:51291 "EHLO
	rainbowdash.ducie.codethink.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753671AbaA1KHD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jan 2014 05:07:03 -0500
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-kernel@lists.codethink.co.uk
Cc: linux-sh@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	linux-pci@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 3/3] PCI: rcar: fix bridge logic configuration accesses
Date: Tue, 28 Jan 2014 10:06:56 +0000
Message-Id: <1390903616-8073-4-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390903616-8073-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1390903616-8073-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The bridge logic at slot 0 only supports reads up to 0x40 and the
rest of the PCI configuration space for this slot is marked as
reserved in the manual.

Trying a read from offset 0x100 is producing an error from the
bridge. With error interrupts enabled, the following is printed:

pci-rcar-gen2 ee0d0000.pci: error irq: status 00000014

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org
---
 drivers/pci/host/pci-rcar-gen2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index 01ba069..42f0105 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -119,6 +119,10 @@ static void __iomem *rcar_pci_cfg_base(struct pci_bus *bus, unsigned int devfn,
 	if (slot > 2)
 		return NULL;
 
+	/* bridge logic only has registers to 0x40 */
+	if (slot == 0x0 && where >= 0x40)
+		return NULL;
+
 	val = slot ? RCAR_AHBPCI_WIN1_DEVICE | RCAR_AHBPCI_WIN_CTR_CFG :
 		     RCAR_AHBPCI_WIN1_HOST | RCAR_AHBPCI_WIN_CTR_CFG;
 
-- 
1.8.5.2

