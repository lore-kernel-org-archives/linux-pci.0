Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45506 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307Ab2BCLU0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2012 06:20:26 -0500
From: Oliver Neukum <oneukum@suse.de>
To: linux-usb@vger.kernel.org
Subject: [PATCH] USB:xhci: fix port switching on PantherPoint
Date: Fri, 3 Feb 2012 12:22:43 +0100
Cc: gregkh@linuxfoundation.org,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>, trenn@suse.de,
	linux-pci@vger.kernel.org, Michal Marek <MMarek@suse.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201202031222.43649.oneukum@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>From be9bdcf88b2974cfe95c1afea327b46135b65391 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oliver@neukum.org>
Date: Fri, 3 Feb 2012 12:01:12 +0100
Subject: [PATCH] USB:xhci: fix port switching on PantherPoint

The quirks of XHCI were called to early so that the
PCI device hadn't been enabled and the quirk handler bailed out.
The fix is to call it later.

Signed-off-by: Oliver Neukum <oneukum@suse.de>
---
 drivers/usb/host/pci-quirks.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index caf8742..b49e3d0 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -873,7 +873,12 @@ static void __devinit quirk_usb_early_handoff(struct pci_dev *pdev)
 		quirk_usb_handoff_ohci(pdev);
 	else if (pdev->class == PCI_CLASS_SERIAL_USB_EHCI)
 		quirk_usb_disable_ehci(pdev);
-	else if (pdev->class == PCI_CLASS_SERIAL_USB_XHCI)
-		quirk_usb_handoff_xhci(pdev);
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, quirk_usb_early_handoff);
+
+static void __devinit quirk_xhci_early_handoff(struct pci_dev *pdev)
+{
+	 if (pdev->class == PCI_CLASS_SERIAL_USB_XHCI)
+                quirk_usb_handoff_xhci(pdev);
+}
+DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, quirk_xhci_early_handoff);
-- 
1.7.1

