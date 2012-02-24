Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 07/11] PCI: Use class for quirk for legacy ATA NO_D3
Date: Thu, 23 Feb 2012 23:46:55 -0800
Message-Id: <1330069619-14446-8-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330069619-14446-1-git-send-email-yinghai@kernel.org>
References: <1330069619-14446-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/quirks.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f41e00d..a860812 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1166,17 +1166,20 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, qui
 
 static void __devinit quirk_no_ata_d3(struct pci_dev *pdev)
 {
-	/* Quirk the legacy ATA devices only. The AHCI ones are ok */
-	if ((pdev->class >> 8) == PCI_CLASS_STORAGE_IDE)
-		pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
+	pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
 }
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, PCI_ANY_ID, quirk_no_ata_d3);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, PCI_ANY_ID, quirk_no_ata_d3);
+/* Quirk the legacy ATA devices only. The AHCI ones are ok */
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_SERVERWORKS, PCI_ANY_ID,
+				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
+				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
 /* ALi loses some register settings that we cannot then restore */
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID, quirk_no_ata_d3);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID,
+				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
 /* VIA comes back fine but we need to keep it alive or ACPI GTM failures
    occur when mode detecting */
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_no_ata_d3);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
+				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
 
 /* This was originally an Alpha specific thing, but it really fits here.
  * The i82375 PCI/EISA bridge appears as non-classified. Fix that.
-- 
1.7.7

