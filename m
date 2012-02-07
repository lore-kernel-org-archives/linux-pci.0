Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21193 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756124Ab2BGXbX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Feb 2012 18:31:23 -0500
Date: Tue, 7 Feb 2012 15:31:18 -0800
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	Takashi Iwai <tiwai@suse.de>, trenn@suse.de,
	linux-pci@vger.kernel.org, Michal Marek <MMarek@suse.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [RFC] xhci: Fix BIOS handoff failure on some Intel systems.
Message-ID: <20120207233118.GA6947@xanatos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120203152745.GA5321@xanatos>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On some systems with an Intel Panther Point xHCI host controller, the
BIOS disables the xHCI PCI device during boot, and switches the xHCI
ports over to EHCI.  This allows the BIOS to access USB devices without
having xHCI support.

The downside is that the xHCI BIOS handoff mechanism will fail because
memory mapped I/O is not enabled for the disabled PCI device.  Make the
xHCI quirk handler call pci_enable_device() to re-enable MMIO, and call
pci_disable_device() once it's done with the BIOS handoff.  This will
balance the ref counts in the PCI core.  When the xHCI PCI probe is
called, usb_hcd_pci_probe() will call pci_enable_device() again.

Also add some debugging to the xHCI quirk failure paths, so we can pin
point the problem when a user says their xHCI PCI quirk function fails.

Signed-off-by: Sarah Sharp <sarah.a.sharp@linux.intel.com>
---

Hi Oliver,

What about this approach instead?  This means the PCI quirk sequence
doesn't change, and the xHCI ports are still switched over before the
EHCI PCI probe starts.  With your original patch, the ports could be
switched over after the EHCI driver has already started to enumerate
devices.

Can you test and make sure this fixes the issue on your test systems?

Sarah Sharp

 drivers/usb/host/pci-quirks.c |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index ac53a66..ff31f69 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -786,13 +786,28 @@ static void __devinit quirk_usb_handoff_xhci(struct pci_dev *pdev)
 	u32 val;
 	int timeout;
 
-	if (!mmio_resource_enabled(pdev, 0))
+	/* Some BIOS manufacturers disable the Intel Panther Point xHCI PCI
+	 * device during boot and use the Panther Point EHCI host instead.
+	 * We attempt to re-enable it in order to have memory mapped I/O.
+	 */
+	if (pci_enable_device(pdev) < 0) {
+		dev_warn(&pdev->dev, "Can't enable PCI device, "
+				"xHCI BIOS handoff failed.\n");
 		return;
+	}
+	if (!mmio_resource_enabled(pdev, 0)) {
+		dev_warn(&pdev->dev, "PCI MMIO not enabled, "
+				"xHCI BIOS handoff failed.\n");
+		goto disable_pci;
+	}
 
 	base = ioremap_nocache(pci_resource_start(pdev, 0),
 				pci_resource_len(pdev, 0));
-	if (base == NULL)
-		return;
+	if (base == NULL) {
+		dev_warn(&pdev->dev, "PCI register memory map failed, "
+				"xHCI BIOS handoff failed.\n");
+		goto disable_pci;
+	}
 
 	/*
 	 * Find the Legacy Support Capability register -
@@ -863,6 +878,8 @@ hc_init:
 	}
 
 	iounmap(base);
+disable_pci:
+	pci_disable_device(pdev);
 }
 
 static void __devinit quirk_usb_early_handoff(struct pci_dev *pdev)
-- 
1.7.9

