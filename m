Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48729 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068AbaJBBKW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Oct 2014 21:10:22 -0400
Message-ID: <1412210082.10667.2.camel@pasglop>
Subject: [PATCH v2 3/4] sound/radeon: Move 64-bit MSI quirk from arch to
 driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Deucher <alexdeucher@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Dave Airlie <airlied@linux.ie>,
	Brian King <brking@linux.vnet.ibm.com>,
	Takashi Iwai <tiwai@suse.de>, linux-pci@vger.kernel.org,
	Yijing Wang <wangyijing@huawei.com>,
	Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@ozlabs.org
Date: Thu, 02 Oct 2014 10:34:42 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


A number of radeon cards have a HW limitation causing them to be
unable to generate the full 64-bit of address bits for MSIs. This
breaks MSIs on some platforms such as POWER machines.

We used to have a powerpc specific quirk to address that on a
single card, but this doesn't scale very well, this is better
put under control of the drivers who know precisely what a given
HW revision can do.

This moves the setting of the quirk flag to the audio driver.

While recent ASICs have that problem fixed, they don't seem to
be listed in the PCI IDs of the current driver, so let's quirk all
the ATI HDMI for now. The consequences are nil on x86 anyway.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: <stable@vger.kernel.org>
---
 arch/powerpc/kernel/pci_64.c |  6 ------
 sound/pci/hda/hda_intel.c    | 10 ++++++++--
 sound/pci/hda/hda_priv.h     |  1 +
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 5330f6d..b15194e 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -266,9 +266,3 @@ int pcibus_to_node(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pcibus_to_node);
 #endif
-
-static void quirk_radeon_32bit_msi(struct pci_dev *dev)
-{
-	dev->no_64bit_msi = true;
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0xaa68, quirk_radeon_32bit_msi);
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index aa302fb..f91ba7f 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -296,7 +296,8 @@ enum {
 
 /* quirks for ATI/AMD HDMI */
 #define AZX_DCAPS_PRESET_ATI_HDMI \
-	(AZX_DCAPS_NO_TCSEL | AZX_DCAPS_SYNC_WRITE | AZX_DCAPS_POSFIX_LPIB)
+	(AZX_DCAPS_NO_TCSEL | AZX_DCAPS_SYNC_WRITE | AZX_DCAPS_POSFIX_LPIB|\
+	 AZX_DCAPS_NO_MSI64)
 
 /* quirks for Nvidia */
 #define AZX_DCAPS_PRESET_NVIDIA \
@@ -1505,9 +1506,14 @@ static int azx_first_init(struct azx *chip)
 		return -ENXIO;
 	}
 
-	if (chip->msi)
+	if (chip->msi) {
+		if (chip->driver_caps & AZX_DCAPS_NO_MSI64) {
+			dev_dbg(card->dev, "Disabling 64bit MSI\n");
+			pci->no_64bit_msi = true;
+		}
 		if (pci_enable_msi(pci) < 0)
 			chip->msi = 0;
+	}
 
 	if (azx_acquire_irq(chip, 0) < 0)
 		return -EBUSY;
diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
index 949cd43..5016014 100644
--- a/sound/pci/hda/hda_priv.h
+++ b/sound/pci/hda/hda_priv.h
@@ -171,6 +171,7 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 #define AZX_DCAPS_PM_RUNTIME	(1 << 26)	/* runtime PM support */
 #define AZX_DCAPS_I915_POWERWELL (1 << 27)	/* HSW i915 powerwell support */
 #define AZX_DCAPS_CORBRP_SELF_CLEAR (1 << 28)	/* CORBRP clears itself after reset */
+#define AZX_DCAPS_NO_MSI64      (1 << 29)	/* Stick to 32-bit MSIs */
 
 /* HD Audio class code */
 #define PCI_CLASS_MULTIMEDIA_HD_AUDIO	0x0403




