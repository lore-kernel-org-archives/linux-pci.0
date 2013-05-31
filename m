Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:4497
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752300Ab3EaDUK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 May 2013 23:20:10 -0400
From: Shane Huang <shane.huang@amd.com>
To: Tejun Heo <tj@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Jean Delvare <khali@linux-fr.org>, <linux-pci@vger.kernel.org>,
	<linux-ide@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
	Shane Huang <shane.huang@amd.com>
Subject: [PATCH 2/3] ahci: add AMD CZ SATA device ID
Date: Fri, 31 May 2013 19:20:09 +0800
Message-ID: <1369999209-2029-1-git-send-email-shane.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

To add AMD CZ SATA controller device ID of IDE mode.

Signed-off-by: Shane Huang <shane.huang@amd.com>
---
 drivers/ata/ahci.c      | 1 +
 drivers/pci/quirks.c    | 2 ++
 include/linux/pci_ids.h | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 751f1ea..548f1c3 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -310,6 +310,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 
 	/* AMD */
 	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
+	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
 	/* AMD is using RAID class only for ahci controllers */
 	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7d68aee..5aced49 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1022,6 +1022,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP700_SATA, quirk
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP700_SATA, quirk_amd_ide_mode);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE, quirk_amd_ide_mode);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE, quirk_amd_ide_mode);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CZ_SATA_IDE, quirk_amd_ide_mode);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CZ_SATA_IDE, quirk_amd_ide_mode);
 
 /*
  *	Serverworks CSB5 IDE does not fully support native mode
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index e0b5623..22449c1 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -570,6 +570,7 @@
 #define PCI_DEVICE_ID_AMD_HUDSON2_IDE		0x780c
 #define PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE	0x7800
 #define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS		0x780b
+#define PCI_DEVICE_ID_AMD_CZ_SATA_IDE	0x7900
 
 #define PCI_VENDOR_ID_TRIDENT		0x1023
 #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000
-- 
1.8.1.2


