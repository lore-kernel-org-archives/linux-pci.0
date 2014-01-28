Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 82-68-191-81.dsl.posilan.com ([82.68.191.81]:51235 "EHLO
	rainbowdash.ducie.codethink.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754471AbaA1Jr6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jan 2014 04:47:58 -0500
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-kernel@lists.codethink.co.uk
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: [PATCH 3/3] PCI: rcar: fix bridge logic abort
Date: Tue, 28 Jan 2014 09:47:48 +0000
Message-Id: <1390902468-7753-4-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390902468-7753-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1390902468-7753-1-git-send-email-ben.dooks@codethink.co.uk>
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
 drivers/pci/host/pci-rcar-gen2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index 01ba069..17ad857 100644
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
 
@@ -134,6 +138,8 @@ static int rcar_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 	if (!reg)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
+	dev_info(&bus->dev, "fn %08x, read %08x, size %d\n", devfn, where, size);
+
 	switch (size) {
 	case 1:
 		*val = ioread8(reg);
@@ -157,6 +163,8 @@ static int rcar_pci_write_config(struct pci_bus *bus, unsigned int devfn,
 	if (!reg)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
+	dev_info(&bus->dev, "devfn %08x: write %08x to %08x, size %d\n", devfn, val, where, size);
+
 	switch (size) {
 	case 1:
 		iowrite8(val, reg);
-- 
1.8.5.2

