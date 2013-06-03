Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:11025
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753713Ab3FCCVh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 2 Jun 2013 22:21:37 -0400
From: Shane Huang <shane.huang@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Tejun Heo <tj@kernel.org>, Jean Delvare <khali@linux-fr.org>,
	<linux-pci@vger.kernel.org>, <linux-ide@vger.kernel.org>,
	<linux-i2c@vger.kernel.org>, Shane Huang <shane.huang@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH RESEND 1/3] pci_ids: put Hudson-2 device IDs together
Date: Mon, 3 Jun 2013 18:22:28 +0800
Message-ID: <1370254948-2284-1-git-send-email-shane.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

To put all AMD Hudson-2 device IDs together for better maintenance.

Signed-off-by: Shane Huang <shane.huang@amd.com>
Reviewed-by: Tejun Heo <tj@kernel.org>
Acked-by: Jean Delvare <khali@linux-fr.org>
Cc: stable@vger.kernel.org
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


