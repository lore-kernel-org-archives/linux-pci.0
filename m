Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:35803 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755902AbcLUHxP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Dec 2016 02:53:15 -0500
From: John Crispin <john@phrozen.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <john@phrozen.org>
Subject: [PATCH] pci: add kernel config option for disabling common PCI quirks
Date: Wed, 21 Dec 2016 08:53:04 +0100
Message-Id: <1482306784-29224-1-git-send-email-john@phrozen.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Gabor Juhos <juhosg@openwrt.org>

These quirks do not effect small small plastic routers. These routers tend
to have very little flash space. This patch adds a new option that allows
us to build a kernel without including the common quirks, thus saving us
valuable flash space.

When building an image for a MIPS/Ralink router with this option enabled
it will reduce the size of an uncompressed uImage by 12KB.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
Hi Bjorn,

This patch has been lingering inside the OpenWrt for some years. I am not
sure if this is the best way to remove the quirks from the build. Let me
know if you prefer a different way of solving this.

	John

 drivers/pci/Kconfig  |   10 ++++++++++
 drivers/pci/quirks.c |    6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 6555eb7..967bcd5 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -71,6 +71,16 @@ config XEN_PCIDEV_FRONTEND
           The PCI device frontend driver allows the kernel to import arbitrary
           PCI devices from a PCI backend to support PCI driver domains.
 
+config PCI_DISABLE_COMMON_QUIRKS
+	bool "PCI disable common quirks"
+	depends on PCI
+        default n
+	help
+	  Say Y here if you do not wish to include the common quirks inside
+	  your kernel This is usefull for devices with scarce memory.
+
+	  If you don't know what to do here, say N.
+
 config HT_IRQ
 	bool "Interrupts on hypertransport devices"
 	default y
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index c232729..afe181e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -41,6 +41,7 @@ static void quirk_mmio_always_on(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_ANY_ID, PCI_ANY_ID,
 				PCI_CLASS_BRIDGE_HOST, 8, quirk_mmio_always_on);
 
+#ifndef CONFIG_PCI_DISABLE_COMMON_QUIRKS
 /* The Mellanox Tavor device gives false positive parity errors
  * Mark this device with a broken_parity_status, to allow
  * PCI scanning code to "skip" this now blacklisted device.
@@ -3015,6 +3016,7 @@ static void quirk_intel_mc_errata(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65f9, quirk_intel_mc_errata);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65fa, quirk_intel_mc_errata);
 
+#endif /* !CONFIG_PCI_DISABLE_COMMON_QUIRKS */
 
 /*
  * Ivytown NTB BAR sizes are misreported by the hardware due to an erratum.  To
@@ -3071,6 +3073,8 @@ static void fixup_debug_report(struct pci_dev *dev, ktime_t calltime,
 	}
 }
 
+#ifndef CONFIG_PCI_DISABLE_COMMON_QUIRKS
+
 /*
  * Some BIOS implementations leave the Intel GPU interrupts enabled,
  * even though no one is handling them (f.e. i915 driver is never loaded).
@@ -3105,6 +3109,8 @@ static void disable_igfx_irq(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x010a, disable_igfx_irq);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0152, disable_igfx_irq);
 
+#endif /* !CONFIG_PCI_DISABLE_COMMON_QUIRKS */
+
 /*
  * PCI devices which are on Intel chips can skip the 10ms delay
  * before entering D3 mode.
-- 
1.7.10.4

