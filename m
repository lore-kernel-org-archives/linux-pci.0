Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:57204 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956Ab3LFAT5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Dec 2013 19:19:57 -0500
Received: by mail-ob0-f170.google.com with SMTP id wp18so18704191obc.15
        for <linux-pci@vger.kernel.org>; Thu, 05 Dec 2013 16:19:56 -0800 (PST)
Subject: [PATCH 2/2] PCI: Stop clearing bridge Secondary Status when setting
 up I/O aperture
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Date: Thu, 05 Dec 2013 17:19:55 -0700
Message-ID: <20131206001954.27659.78163.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20131206001333.27659.59935.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20131206001333.27659.59935.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_setup_bridge_io() accessed PCI_IO_BASE and PCI_IO_LIMIT using dword
(32-bit) reads and writes, which also access the Secondary Status register.
Since the Secondary Status register is in the upper 16 bits of the dword,
and we preserved those upper 16 bits, this had the effect of clearing any
of the write-1-to-clear bits that happened to be set in the Secondary
Status register.

That's not what we want, so use word (16-bit) accesses to update only
PCI_IO_BASE and PCI_IO_LIMIT.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/setup-bus.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 80350299a6ea..2e344a5581ae 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -538,7 +538,8 @@ static void pci_setup_bridge_io(struct pci_bus *bus)
 	struct pci_bus_region region;
 	unsigned long io_mask;
 	u8 io_base_lo, io_limit_lo;
-	u32 l, io_upper16;
+	u16 l;
+	u32 io_upper16;
 
 	io_mask = PCI_IO_RANGE_MASK;
 	if (bridge->io_window_1k)
@@ -548,11 +549,10 @@ static void pci_setup_bridge_io(struct pci_bus *bus)
 	res = bus->resource[0];
 	pcibios_resource_to_bus(bridge, &region, res);
 	if (res->flags & IORESOURCE_IO) {
-		pci_read_config_dword(bridge, PCI_IO_BASE, &l);
-		l &= 0xffff0000;
+		pci_read_config_word(bridge, PCI_IO_BASE, &l);
 		io_base_lo = (region.start >> 8) & io_mask;
 		io_limit_lo = (region.end >> 8) & io_mask;
-		l |= ((u32) io_limit_lo << 8) | io_base_lo;
+		l = ((u16) io_limit_lo << 8) | io_base_lo;
 		/* Set up upper 16 bits of I/O base/limit. */
 		io_upper16 = (region.end & 0xffff0000) | (region.start >> 16);
 		dev_info(&bridge->dev, "  bridge window %pR\n", res);
@@ -564,7 +564,7 @@ static void pci_setup_bridge_io(struct pci_bus *bus)
 	/* Temporarily disable the I/O range before updating PCI_IO_BASE. */
 	pci_write_config_dword(bridge, PCI_IO_BASE_UPPER16, 0x0000ffff);
 	/* Update lower 16 bits of I/O base/limit. */
-	pci_write_config_dword(bridge, PCI_IO_BASE, l);
+	pci_write_config_word(bridge, PCI_IO_BASE, l);
 	/* Update upper 16 bits of I/O base/limit. */
 	pci_write_config_dword(bridge, PCI_IO_BASE_UPPER16, io_upper16);
 }

