Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753014AbcKQXaG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Nov 2016 18:30:06 -0500
Subject: [PATCH v3 1/5] PCI: Add Mellanox device IDs
From: Bjorn Helgaas <bhelgaas@google.com>
To: Noa Osherovich <noaos@mellanox.com>
Cc: linux-pci@vger.kernel.org, majd@mellanox.com,
        gwshan@linux.vnet.ibm.com
Date: Thu, 17 Nov 2016 17:30:02 -0600
Message-ID: <20161117233002.2003.38306.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161117232458.2003.88193.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161117232458.2003.88193.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Noa Osherovich <noaos@mellanox.com>

Add Mellanox device IDs for use by the mlx4 driver and INTx quirks.

[bhelgaas: sorted and adapted from
http://lkml.kernel.org/r/1478011644-12080-1-git-send-email-noaos@mellanox.com]
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci_ids.h |   27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index c58752f..f020ab4 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2256,12 +2256,29 @@
 #define PCI_DEVICE_ID_ZOLTRIX_2BD0	0x2bd0
 
 #define PCI_VENDOR_ID_MELLANOX		0x15b3
-#define PCI_DEVICE_ID_MELLANOX_TAVOR	0x5a44
+#define PCI_DEVICE_ID_MELLANOX_CONNECTX3	0x1003
+#define PCI_DEVICE_ID_MELLANOX_CONNECTX3_PRO	0x1007
+#define PCI_DEVICE_ID_MELLANOX_CONNECTIB	0x1011
+#define PCI_DEVICE_ID_MELLANOX_CONNECTX4	0x1013
+#define PCI_DEVICE_ID_MELLANOX_CONNECTX4_LX	0x1015
+#define PCI_DEVICE_ID_MELLANOX_TAVOR		0x5a44
 #define PCI_DEVICE_ID_MELLANOX_TAVOR_BRIDGE	0x5a46
-#define PCI_DEVICE_ID_MELLANOX_ARBEL_COMPAT 0x6278
-#define PCI_DEVICE_ID_MELLANOX_ARBEL	0x6282
-#define PCI_DEVICE_ID_MELLANOX_SINAI_OLD 0x5e8c
-#define PCI_DEVICE_ID_MELLANOX_SINAI	0x6274
+#define PCI_DEVICE_ID_MELLANOX_SINAI_OLD	0x5e8c
+#define PCI_DEVICE_ID_MELLANOX_SINAI		0x6274
+#define PCI_DEVICE_ID_MELLANOX_ARBEL_COMPAT	0x6278
+#define PCI_DEVICE_ID_MELLANOX_ARBEL		0x6282
+#define PCI_DEVICE_ID_MELLANOX_HERMON_SDR	0x6340
+#define PCI_DEVICE_ID_MELLANOX_HERMON_DDR	0x634a
+#define PCI_DEVICE_ID_MELLANOX_HERMON_QDR	0x6354
+#define PCI_DEVICE_ID_MELLANOX_HERMON_EN	0x6368
+#define PCI_DEVICE_ID_MELLANOX_CONNECTX_EN	0x6372
+#define PCI_DEVICE_ID_MELLANOX_HERMON_DDR_GEN2	0x6732
+#define PCI_DEVICE_ID_MELLANOX_HERMON_QDR_GEN2	0x673c
+#define PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_5_GEN2 0x6746
+#define PCI_DEVICE_ID_MELLANOX_HERMON_EN_GEN2	0x6750
+#define PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_T_GEN2 0x675a
+#define PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_GEN2	0x6764
+#define PCI_DEVICE_ID_MELLANOX_CONNECTX2	0x676e
 
 #define PCI_VENDOR_ID_DFI		0x15bd
 

