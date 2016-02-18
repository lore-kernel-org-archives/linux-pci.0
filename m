Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jordan Hargrave <Jordan_Hargrave@dell.com>
To: jordan_hargrave@dell.com, bhelgaas@google.com
Cc: alexander.duyck@gmail.com, linux-pci@vger.kernel.org,
	babu.moger@oracle.com, hare@suse.de, linux-kernel@vger.kernel.org,
	jharg93@gmail.com, Jordan Hargrave <Jordan_Hargrave@dell.com>
Subject: [PATCH 2/2] Create sysfs entries for PCI VPDI and VPDR tags
Date: Thu, 18 Feb 2016 14:31:04 -0600
Message-Id: <1455827464-11398-1-git-send-email-Jordan_Hargrave@dell.com>
To: Jordan_Hargrave@dell.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The VPD-R is a readonly area of the PCI Vital Product Data region.
There are some standard keywords for serial number, manufacturer,
and vendor-specific values.  Dell Servers use a vendor-specific
tag to store number of ports and port mapping of partitioned NICs.

info = VPD-Info string
PN = Part Number
SN = Serial Number
MN = Manufacturer ID
Vx = Vendor-specific (x=0..9 A..Z)

This creates a sysfs subdirectory in the pci device: vpdattr with
'info', 'EC', 'SN', 'V0', etc. files containing the tag values.

Added pci.h patch

Signed-off-by: Jordan Hargrave <Jordan_Hargrave@dell.com>
---
 include/linux/pci.h     |   3 +
 1 files changed, 3 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8135a2f..c1313b1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -372,6 +372,9 @@ struct pci_dev {
 	const struct attribute_group **msi_irq_groups;
 #endif
 	struct pci_vpd *vpd;
+	int vpdr_len;
+	u8 *vpdr_data;
+	char *vpdi_data;
 #ifdef CONFIG_PCI_ATS
 	union {
 		struct pci_sriov *sriov;	/* SR-IOV capability related */
-- 
2.5.0
