Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:24761 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965526AbcIXXWP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Sep 2016 19:22:15 -0400
From: Adit Ranadive <aditr@vmware.com>
To: <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <pv-drivers@vmware.com>
CC: Adit Ranadive <aditr@vmware.com>, <netdev@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <jhansen@vmware.com>,
        <asarwade@vmware.com>, <georgezhang@vmware.com>,
        <bryantan@vmware.com>
Subject: [PATCH v5 01/16] vmxnet3: Move PCI Id to pci_ids.h
Date: Sat, 24 Sep 2016 16:21:25 -0700
Message-ID: <0ed494851c6a1de2152f68be6a1735af6579d3ae.1474759181.git.aditr@vmware.com>
In-Reply-To: <cover.1474759181.git.aditr@vmware.com>
References: <cover.1474759181.git.aditr@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The VMXNet3 PCI Id will be shared with our paravirtual RDMA driver.
Moved it to the shared location in pci_ids.h.

Suggested-by: Leon Romanovsky <leon@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Adit Ranadive <aditr@vmware.com>
---
 drivers/net/vmxnet3/vmxnet3_int.h | 3 +--
 include/linux/pci_ids.h           | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_int.h b/drivers/net/vmxnet3/vmxnet3_int.h
index 74fc030..2bd6bf8 100644
--- a/drivers/net/vmxnet3/vmxnet3_int.h
+++ b/drivers/net/vmxnet3/vmxnet3_int.h
@@ -119,9 +119,8 @@ enum {
 };
 
 /*
- * PCI vendor and device IDs.
+ * Maximum devices supported.
  */
-#define PCI_DEVICE_ID_VMWARE_VMXNET3    0x07B0
 #define MAX_ETHERNET_CARDS		10
 #define MAX_PCI_PASSTHRU_DEVICE		6
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index c58752f..98bb455 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2251,6 +2251,7 @@
 #define PCI_DEVICE_ID_RASTEL_2PORT	0x2000
 
 #define PCI_VENDOR_ID_VMWARE		0x15ad
+#define PCI_DEVICE_ID_VMWARE_VMXNET3	0x07b0
 
 #define PCI_VENDOR_ID_ZOLTRIX		0x15b0
 #define PCI_DEVICE_ID_ZOLTRIX_2BD0	0x2bd0
-- 
2.7.4

