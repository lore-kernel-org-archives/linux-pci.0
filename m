Return-Path: <SRS0=/7aD=K6=netronome.com=jakub.kicinski@kernel.org>
Return-Path: <SRS0=/7aD=K6=netronome.com=jakub.kicinski@kernel.org>
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	oss-drivers@netronome.com,
	Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH] PCI: remove ids for NFP32xx
Date: Tue, 14 Aug 2018 17:14:30 -0700
Message-Id: <20180815001430.27660-1-jakub.kicinski@netronome.com>
List-ID: <linux-pci.vger.kernel.org>

Defines for NFP32xx are no longer used anywhere, remove them.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 include/linux/pci_ids.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 381fc009551d..39f7f0b14572 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2538,8 +2538,6 @@
 #define PCI_VENDOR_ID_HUAWEI         	0x19e5
 
 #define PCI_VENDOR_ID_NETRONOME		0x19ee
-#define PCI_DEVICE_ID_NETRONOME_NFP3200	0x3200
-#define PCI_DEVICE_ID_NETRONOME_NFP3240	0x3240
 #define PCI_DEVICE_ID_NETRONOME_NFP4000	0x4000
 #define PCI_DEVICE_ID_NETRONOME_NFP5000	0x5000
 #define PCI_DEVICE_ID_NETRONOME_NFP6000	0x6000
-- 
2.17.1
