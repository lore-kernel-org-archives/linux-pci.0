Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:47103 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956Ab3LFATu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Dec 2013 19:19:50 -0500
Received: by mail-oa0-f51.google.com with SMTP id i7so19250755oag.38
        for <linux-pci@vger.kernel.org>; Thu, 05 Dec 2013 16:19:49 -0800 (PST)
Subject: [PATCH 1/2] PCI: Prevent bus conflicts while checking for bridge
 apertures
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Date: Thu, 05 Dec 2013 17:19:47 -0700
Message-ID: <20131206001947.27659.14981.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20131206001333.27659.59935.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20131206001333.27659.59935.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_bridge_check_ranges() determines whether the bridge supports an I/O
aperture and a prefetchable memory aperture.

Previously, if the I/O aperture was unsupported, disabled, or configured at
[io 0x0000-0x0fff], we wrote 0xf0 to PCI_IO_BASE and PCI_IO_LIMIT, which,
if the bridge supports it, enables the I/O aperture at [io 0xf000-0xffff].
The enabled aperture may conflict with other devices in the system.

Similarly, we wrote 0xfff0 to PCI_PREF_MEMORY_BASE and
PCI_PREF_MEMORY_LIMIT, which enables the prefetchable memory aperture at
[mem 0xfff00000-0xffffffff], and that may also conflict with other devices.

All we need to know is whether the base and limit registers are writable,
so we can use values that leave the apertures disabled, e.g., PCI_IO_BASE =
0xf0, PCI_IO_LIMIT = 0xe0, PCI_PREF_MEMORY_BASE = 0xfff0,
PCI_PREF_MEMORY_LIMIT = 0xffe0.

Writing non-zero values to both the base and limit registers means we
detect whether either or both are writable, as we did before.

Reported-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Based-on-patch-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/setup-bus.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 219a4106480a..80350299a6ea 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -665,21 +665,23 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
 
 	pci_read_config_word(bridge, PCI_IO_BASE, &io);
 	if (!io) {
-		pci_write_config_word(bridge, PCI_IO_BASE, 0xf0f0);
+		pci_write_config_word(bridge, PCI_IO_BASE, 0xe0f0);
 		pci_read_config_word(bridge, PCI_IO_BASE, &io);
 		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
 	}
 	if (io)
 		b_res[0].flags |= IORESOURCE_IO;
+
 	/*  DECchip 21050 pass 2 errata: the bridge may miss an address
 	    disconnect boundary by one PCI data phase.
 	    Workaround: do not use prefetching on this device. */
 	if (bridge->vendor == PCI_VENDOR_ID_DEC && bridge->device == 0x0001)
 		return;
+
 	pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
 	if (!pmem) {
 		pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE,
-					       0xfff0fff0);
+					       0xffe0fff0);
 		pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
 		pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, 0x0);
 	}

