Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754386AbdGJPwl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Jul 2017 11:52:41 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 2/2] usb: host: pci_quirks: Force hard reset of Renesas uPD72020x USB controller
Date: Mon, 10 Jul 2017 16:52:30 +0100
Message-Id: <20170710155230.8622-3-marc.zyngier@arm.com>
In-Reply-To: <20170710155230.8622-1-marc.zyngier@arm.com>
References: <20170710155230.8622-1-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Renesas uPD72020x XHCI controller seems to suffer from a
really annoying bug, where it may retain some of its DMA programming
across a XHCI reset, and despite the driver correctly programming new
DMA addresses. This is visible if the device has been using 64bit DMA
addresses, and is then switched to using 32bit DMA addresses. The top
32bits of the address (now zero) are ignored are replaced by the 32bit
from the *previous* programming. Sticking with 64bit DMA always works,
but doesn't seem very appropriate.

A PCI reset of the device restores the normal functionnality, which
is done at probe time. Unfortunately, this has to be done before
any quirk has been discovered, hence the intrusive nature of the fix.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/usb/host/pci-quirks.c | 20 ++++++++++++++++++++
 drivers/usb/host/pci-quirks.h |  1 +
 drivers/usb/host/xhci-pci.c   |  7 +++++++
 3 files changed, 28 insertions(+)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index a9a1e4c40480..5bed002c7dd3 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -1096,3 +1096,23 @@ static void quirk_usb_early_handoff(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
 			PCI_CLASS_SERIAL_USB, 8, quirk_usb_early_handoff);
+
+bool usb_xhci_needs_pci_reset(struct pci_dev *pdev)
+{
+	/*
+	 * Our dear uPD72020{1,2} friend only partially resets when
+	 * asked to via the XHCI interface, and may end-up doing DMA
+	 * at the wrong addresses, as it keeps the top 32bit of some
+	 * addresses from its previous programming under obscure
+	 * circumstances.
+	 * Give it a good wack at probe time. Unfortunately, this
+	 * needs to happen before we've had a chance to discover any
+	 * quirk, or the system will be in a rather bad state.
+	 */
+	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
+	    (pdev->device == 0x0014 || pdev->device == 0x0015))
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(usb_xhci_needs_pci_reset);
diff --git a/drivers/usb/host/pci-quirks.h b/drivers/usb/host/pci-quirks.h
index 0222195bd5b0..dcbe4b097b33 100644
--- a/drivers/usb/host/pci-quirks.h
+++ b/drivers/usb/host/pci-quirks.h
@@ -14,6 +14,7 @@ void usb_amd_quirk_pll_enable(void);
 void usb_enable_intel_xhci_ports(struct pci_dev *xhci_pdev);
 void usb_disable_xhci_ports(struct pci_dev *xhci_pdev);
 void sb800_prefetch(struct device *dev, int on);
+bool usb_xhci_needs_pci_reset(struct pci_dev *pdev);
 #else
 struct pci_dev;
 static inline void usb_amd_quirk_pll_disable(void) {}
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 1bcf971141c0..3831705c2817 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -267,6 +267,13 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	driver = (struct hc_driver *)id->driver_data;
 
+	/* For some HW implementation, a XHCI reset is just not enough... */
+	if (usb_xhci_needs_pci_reset(dev)) {
+		dev_info(&dev->dev, "Resetting\n");
+		if (pci_reset_function_locked(dev))
+			dev_warn(&dev->dev, "Reset failed");
+	}
+
 	/* Prevent runtime suspending between USB-2 and USB-3 initialization */
 	pm_runtime_get_noresume(&dev->dev);
 
-- 
2.11.0
