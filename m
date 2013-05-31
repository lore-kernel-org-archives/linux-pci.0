Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db8lp0188.outbound.messaging.microsoft.com ([213.199.154.188]:42373
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752300Ab3EaDSf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 May 2013 23:18:35 -0400
From: Shane Huang <shane.huang@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Tejun Heo <tj@kernel.org>, Jean Delvare <khali@linux-fr.org>,
	<linux-pci@vger.kernel.org>, <linux-ide@vger.kernel.org>,
	<linux-i2c@vger.kernel.org>, Shane Huang <shane.huang@amd.com>
Subject: [PATCH 1/3] pci_ids: put Hudson-2 device IDs together
Date: Fri, 31 May 2013 19:17:19 +0800
Message-ID: <1369999039-1983-1-git-send-email-shane.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

To put all AMD Hudson-2 device IDs together for better maintenance.

Signed-off-by: Shane Huang <shane.huang@amd.com>
---
 include/linux/pci_ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index c129162..e0b5623 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -556,7 +556,6 @@
 #define PCI_DEVICE_ID_AMD_8131_BRIDGE	0x7450
 #define PCI_DEVICE_ID_AMD_8131_APIC	0x7451
 #define PCI_DEVICE_ID_AMD_8132_BRIDGE	0x7458
-#define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS	0x780b
 #define PCI_DEVICE_ID_AMD_CS5535_IDE    0x208F
 #define PCI_DEVICE_ID_AMD_CS5536_ISA    0x2090
 #define PCI_DEVICE_ID_AMD_CS5536_FLASH  0x2091
@@ -570,6 +569,7 @@
 #define PCI_DEVICE_ID_AMD_LX_AES    0x2082
 #define PCI_DEVICE_ID_AMD_HUDSON2_IDE		0x780c
 #define PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE	0x7800
+#define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS		0x780b
 
 #define PCI_VENDOR_ID_TRIDENT		0x1023
 #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000
-- 
1.8.1.2


