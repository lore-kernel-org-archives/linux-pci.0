Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36977 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbbFSWmc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jun 2015 18:42:32 -0400
Received: by igblr2 with SMTP id lr2so22559753igb.0
        for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2015 15:42:31 -0700 (PDT)
Subject: [PATCH 2/6] PCI: Fix generic NCR 53c810 class code quirk
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dexuan Cui <dexuan.cui@intel.com>, Matthew Wilcox <matthew@wil.cx>,
	x86@kernel.org, Felipe Balbi <balbi@ti.com>,
	Yu Zhao <yu.zhao@intel.com>, Huang Rui <ray.huang@amd.com>,
	Krzysztof =?utf-8?q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Jason Chang <jason.chang@amd.com>
Date: Fri, 19 Jun 2015 17:42:30 -0500
Message-ID: <20150619224230.14626.82853.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150619223325.14626.66402.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150619223325.14626.66402.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In the generic quirk fixup_rev1_53c810(), added by a5312e28c195 ("[PATCH]
PCI: NCR 53c810 quirk"), we assigned "class = PCI_CLASS_STORAGE_SCSI".  But
PCI_CLASS_STORAGE_SCSI is only the two-byte base class/sub-class and needs
to be shifted to make space for the low-order interface byte.

Furthermore, we had a similar quirk, pci_fixup_ncr53c810(), for arch/x86,
which assigned class correctly.  The arch code is linked before the PCI
core, so arch quirks run before generic quirks.  Therefore, on x86, the x86
arch quirk ran first, and the generic quirk did nothing because it saw that
dev->class was already set.  But on other arches, the generic quirk set the
wrong class code.

Fix the generic quirk to set the correct class code and remove the
now-unnecessary x86-specific quirk.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Matthew Wilcox <matthew@wil.cx>
---
 arch/x86/pci/fixup.c |   13 -------------
 drivers/pci/quirks.c |   14 +++++++++-----
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 9a2b710..e585655 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -62,19 +62,6 @@ static void pci_fixup_umc_ide(struct pci_dev *d)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_UMC, PCI_DEVICE_ID_UMC_UM8886BF, pci_fixup_umc_ide);
 
-static void pci_fixup_ncr53c810(struct pci_dev *d)
-{
-	/*
-	 * NCR 53C810 returns class code 0 (at least on some systems).
-	 * Fix class to be PCI_CLASS_STORAGE_SCSI
-	 */
-	if (!d->class) {
-		dev_warn(&d->dev, "Fixing NCR 53C810 class code\n");
-		d->class = PCI_CLASS_STORAGE_SCSI << 8;
-	}
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C810, pci_fixup_ncr53c810);
-
 static void pci_fixup_latency(struct pci_dev *d)
 {
 	/*
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 2dab425..64177a6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1997,14 +1997,18 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1508, quirk_disable_aspm_l0s);
 
 static void fixup_rev1_53c810(struct pci_dev *dev)
 {
-	/* rev 1 ncr53c810 chips don't set the class at all which means
+	u32 class = dev->class;
+
+	/*
+	 * rev 1 ncr53c810 chips don't set the class at all which means
 	 * they don't get their resources remapped. Fix that here.
 	 */
+	if (class)
+		return;
 
-	if (dev->class == PCI_CLASS_NOT_DEFINED) {
-		dev_info(&dev->dev, "NCR 53c810 rev 1 detected; setting PCI class\n");
-		dev->class = PCI_CLASS_STORAGE_SCSI;
-	}
+	dev->class = PCI_CLASS_STORAGE_SCSI << 8;
+	dev_info(&dev->dev, "NCR 53c810 rev 1 PCI class overridden (%#08x -> %#08x)\n",
+		 class, dev->class);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C810, fixup_rev1_53c810);
 

--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in
