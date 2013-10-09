Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52996 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753855Ab3JIOdJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 9 Oct 2013 10:33:09 -0400
Date: Wed, 9 Oct 2013 16:33:04 +0200
From: Jean Delvare <jdelvare@suse.de>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] PCI/portdrv: Set master earlier
Message-ID: <20131009163304.62b439a9@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since kernel 3.12-rc3, I get the following warning messages at boot:
pcieport 0000:00:07.0: driver skip pci_set_master, fix it!
pcieport 0000:00:01.0: driver skip pci_set_master, fix it!

These are:
00:01.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 1 (rev 13)
00:07.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 7 (rev 13)

Calling pci_set_master() immediately after pci_enable_device() makes
the warning messages go away.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
Please note that I am far from certain that this is the correct fix.
Another approach would be to disable the device if
get_port_device_capability() returns no capabilities. I suppose the
device would then be re-enabled later if really needed. What's the best
approach?

 drivers/pci/pcie/portdrv_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.12-rc4.orig/drivers/pci/pcie/portdrv_core.c	2013-09-24 00:41:09.000000000 +0200
+++ linux-3.12-rc4/drivers/pci/pcie/portdrv_core.c	2013-10-09 15:43:54.205943783 +0200
@@ -366,13 +366,13 @@ int pcie_port_device_register(struct pci
 	status = pci_enable_device(dev);
 	if (status)
 		return status;
+	pci_set_master(dev);
 
 	/* Get and check PCI Express port services */
 	capabilities = get_port_device_capability(dev);
 	if (!capabilities)
 		return 0;
 
-	pci_set_master(dev);
 	/*
 	 * Initialize service irqs. Don't use service devices that
 	 * require interrupts if there is no way to generate them.


-- 
Jean Delvare
Suse L3 Support
