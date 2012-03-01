Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:23013 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932287Ab2CATZD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Mar 2012 14:25:03 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [RFC PATCH 2/3] usb, PCI: remove disable/enable device with non-xhci quirk
Date: Thu,  1 Mar 2012 11:24:02 -0800
Message-Id: <1330629843-6027-2-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330629843-6027-1-git-send-email-yinghai@kernel.org>
References: <1330629843-6027-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

| commit cab928ee1f221c9cc48d6615070fefe2e444384a
|    USB: Fix handoff when BIOS disables host PCI device.

mention only need to do disable/enable for xhci controller.

So just remove that for non-xhci controller and restore old behavior for them.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/usb/host/pci-quirks.c |   18 ------------------
 1 file changed, 18 deletions(-)

Index: linux-2.6/drivers/usb/host/pci-quirks.c
===================================================================
--- linux-2.6.orig/drivers/usb/host/pci-quirks.c
+++ linux-2.6/drivers/usb/host/pci-quirks.c
@@ -889,13 +889,7 @@ static void __devinit quirk_usb_early_ha
 	if (pdev->vendor == 0x184e)	/* vendor Netlogic */
 		return;
 
-	if (pci_enable_device(pdev) < 0) {
-		dev_warn(&pdev->dev, "Can't enable PCI device, "
-				"BIOS handoff failed.\n");
-		return;
-	}
 	quirk_usb_handoff_uhci(pdev);
-	pci_disable_device(pdev);
 }
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_SERIAL_USB_UHCI, 0, quirk_usb_early_handoff_uhci);
@@ -908,13 +902,7 @@ static void __devinit quirk_usb_early_ha
 	if (pdev->vendor == 0x184e)	/* vendor Netlogic */
 		return;
 
-	if (pci_enable_device(pdev) < 0) {
-		dev_warn(&pdev->dev, "Can't enable PCI device, "
-				"BIOS handoff failed.\n");
-		return;
-	}
 	quirk_usb_handoff_ohci(pdev);
-	pci_disable_device(pdev);
 }
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_SERIAL_USB_OHCI, 0, quirk_usb_early_handoff_ohci);
@@ -924,13 +912,7 @@ static void __devinit quirk_usb_early_ha
 	if (pdev->vendor == 0x184e)	/* vendor Netlogic */
 		return;
 
-	if (pci_enable_device(pdev) < 0) {
-		dev_warn(&pdev->dev, "Can't enable PCI device, "
-				"BIOS handoff failed.\n");
-		return;
-	}
 	quirk_usb_handoff_ehci(pdev);
-	pci_disable_device(pdev);
 }
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_SERIAL_USB_EHCI, 0, quirk_usb_early_handoff_ehci);
