Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47444 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752201AbcBOImZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 15 Feb 2016 03:42:25 -0500
From: Hannes Reinecke <hare@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	linux-pci@vger.kernel.org, Babu Moger <babu.moger@oracle.com>,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>
Subject: [PATCHv3 1/4] pci: Update VPD definitions
Date: Mon, 15 Feb 2016 09:41:59 +0100
Message-Id: <1455525722-122040-2-git-send-email-hare@suse.de>
In-Reply-To: <1455525722-122040-1-git-send-email-hare@suse.de>
References: <1455525722-122040-1-git-send-email-hare@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The 'end' tag is actually 0x0f, it's the representation as a
small resource data type tag that's 0x78 (ie shifted by 3).
This patch also adds helper functions to extract the resource
data type tags for both large and small resource data types.

Cc: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 include/linux/pci.h | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 27df4a6..49ad85c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1834,12 +1834,13 @@ bool pci_acs_path_enabled(struct pci_dev *start,
 #define PCI_VPD_LRDT_RW_DATA		PCI_VPD_LRDT_ID(PCI_VPD_LTIN_RW_DATA)
 
 /* Small Resource Data Type Tag Item Names */
-#define PCI_VPD_STIN_END		0x78	/* End */
+#define PCI_VPD_STIN_END		0x0f	/* End */
 
-#define PCI_VPD_SRDT_END		PCI_VPD_STIN_END
+#define PCI_VPD_SRDT_END		(PCI_VPD_STIN_END << 3)
 
 #define PCI_VPD_SRDT_TIN_MASK		0x78
 #define PCI_VPD_SRDT_LEN_MASK		0x07
+#define PCI_VPD_LRDT_TIN_MASK		0x7f
 
 #define PCI_VPD_LRDT_TAG_SIZE		3
 #define PCI_VPD_SRDT_TAG_SIZE		1
@@ -1863,6 +1864,17 @@ static inline u16 pci_vpd_lrdt_size(const u8 *lrdt)
 }
 
 /**
+ * pci_vpd_lrdt_tag - Extracts the Large Resource Data Type Tag Item
+ * @lrdt: Pointer to the beginning of the Large Resource Data Type tag
+ *
+ * Returns the extracted Large Resource Data Type Tag item.
+ */
+static inline u16 pci_vpd_lrdt_tag(const u8 *lrdt)
+{
+    return (u16)(lrdt[0] & PCI_VPD_LRDT_TIN_MASK);
+}
+
+/**
  * pci_vpd_srdt_size - Extracts the Small Resource Data Type length
  * @lrdt: Pointer to the beginning of the Small Resource Data Type tag
  *
@@ -1874,6 +1886,17 @@ static inline u8 pci_vpd_srdt_size(const u8 *srdt)
 }
 
 /**
+ * pci_vpd_srdt_tag - Extracts the Small Resource Data Type Tag Item
+ * @lrdt: Pointer to the beginning of the Small Resource Data Type tag
+ *
+ * Returns the extracted Small Resource Data Type Tag Item.
+ */
+static inline u8 pci_vpd_srdt_tag(const u8 *srdt)
+{
+	return ((*srdt) & PCI_VPD_SRDT_TIN_MASK) >> 3;
+}
+
+/**
  * pci_vpd_info_field_size - Extracts the information field length
  * @lrdt: Pointer to the beginning of an information field header
  *
-- 
1.8.5.6

