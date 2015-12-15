Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:34491 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965477AbbLOWQK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Dec 2015 17:16:10 -0500
Received: by mail-io0-f181.google.com with SMTP id e126so35628677ioa.1
        for <linux-pci@vger.kernel.org>; Tue, 15 Dec 2015 14:16:09 -0800 (PST)
From: David Daney <ddaney.cavm@gmail.com>
To: Martin Mares <mj@ucw.cz>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	"Sean O. Stalley" <sean.stalley@intel.com>,
	David Daney <david.daney@cavium.com>
Subject: [PATCH v3] Add lspci support for Enhanced Allocation Capability.
Date: Tue, 15 Dec 2015 14:15:59 -0800
Message-Id: <1450217759-22063-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

The PCISIG recently added the Enhanced Allocation Capability.  Decode
it in lspci.
---
The specification is currently located here:

https://pcisig.com/sites/default/files/specification_documents/ECN_Enhanced_Allocation_23_Oct_2014_Final.pdf

Bjorn Helgaas recently merged Linux kernel support for EA, and Cavium
ThunderX processors have implemented it.  This patch gives us a pretty
view of the capability structure.

Changes from v1: Add and use more symbolic names.  Use FLAG() macro
where appropiate.  Read subordinate bus number from proper offset.

Changes from v2: Reword and reformat some messages.

Thanks,
David Daney


 lib/header.h |   8 +++
 ls-caps.c    | 156 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+)

diff --git a/lib/header.h b/lib/header.h
index f7cdee7..b8f7dc1 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -203,6 +203,7 @@
 #define  PCI_CAP_ID_MSIX	0x11	/* MSI-X */
 #define  PCI_CAP_ID_SATA	0x12	/* Serial-ATA HBA */
 #define  PCI_CAP_ID_AF		0x13	/* Advanced features of PCI devices integrated in PCIe root cplx */
+#define  PCI_CAP_ID_EA		0x14	/* Enhanced Allocation */
 #define PCI_CAP_LIST_NEXT	1	/* Next capability in the list */
 #define PCI_CAP_FLAGS		2	/* Capability defined flags (16 bits) */
 #define PCI_CAP_SIZEOF		4
@@ -906,6 +907,13 @@
 #define PCI_SATA_HBA_BARS	4
 #define PCI_SATA_HBA_REG0	8
 
+/* Enhanced Allocation (EA) */
+#define PCI_EA_CAP_TYPE1_SECONDARY	4
+#define PCI_EA_CAP_TYPE1_SUBORDINATE	5
+/* EA Entry header */
+#define PCI_EA_CAP_ENT_WRITABLE	0x40000000	/* Writable: 1 = RW, 0 = HwInit */
+#define PCI_EA_CAP_ENT_ENABLE	0x80000000	/* Enable for this entry */
+
 /*** Definitions of extended capabilities ***/
 
 /* Advanced Error Reporting */
diff --git a/ls-caps.c b/ls-caps.c
index c145ed6..0ccaf97 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -1254,6 +1254,159 @@ cap_sata_hba(struct device *d, int where, int cap)
     printf(" BAR??%d\n", bar);
 }
 
+static const char *cap_ea_property(int p, int is_secondary)
+{
+  switch (p) {
+  case 0x00:
+    return "memory space, non-prefetchable";
+  case 0x01:
+    return "memory space, prefetchable";
+  case 0x02:
+    return "I/O space";
+  case 0x03:
+    return "VF memory space, prefetchable";
+  case 0x04:
+    return "VF memory space, non-prefetchable";
+  case 0x05:
+    return "allocation behind bridge, non-prefetchable memory";
+  case 0x06:
+    return "allocation behind bridge, prefetchable memory";
+  case 0x07:
+    return "allocation behind bridge, I/O space";
+  case 0xfd:
+    return "memory space resource unavailable for use";
+  case 0xfe:
+    return "I/O space resource unavailable for use";
+  case 0xff:
+    if (is_secondary)
+      return "entry unavailable for use, PrimaryProperties should be used";
+    else
+      return "entry unavailable for use";
+  default:
+    return NULL;
+  }
+}
+
+static void cap_ea(struct device *d, int where, int cap)
+{
+  int entry;
+  int entry_base = where + 4;
+  int num_entries = BITS(cap, 0, 6);
+  u8 htype = get_conf_byte(d, PCI_HEADER_TYPE) & 0x7f;
+
+  printf("Enhanced Allocation (EA): NumEntries=%u", num_entries);
+  if (htype == PCI_HEADER_TYPE_BRIDGE) {
+    byte fixed_sub, fixed_sec;
+
+    entry_base += 4;
+    if (!config_fetch(d, where + 4, 2)) {
+      printf("\n");
+      return;
+    }
+    fixed_sec = get_conf_byte(d, where + PCI_EA_CAP_TYPE1_SECONDARY);
+    fixed_sub = get_conf_byte(d, where + PCI_EA_CAP_TYPE1_SUBORDINATE);
+    printf(", secondary=%d, subordinate=%d", fixed_sec, fixed_sub);
+  }
+  printf("\n");
+  if (verbose < 2)
+    return;
+
+  for (entry = 0; entry < num_entries; entry++) {
+    int max_offset_high_pos, has_base_high, has_max_offset_high;
+    u32 entry_header;
+    u32 base, max_offset;
+    int es, bei, pp, sp;
+    const char *prop_text;
+
+    if (!config_fetch(d, entry_base, 4))
+      return;
+    entry_header = get_conf_long(d, entry_base);
+    es = BITS(entry_header, 0, 3);
+    bei = BITS(entry_header, 4, 4);
+    pp = BITS(entry_header, 8, 8);
+    sp = BITS(entry_header, 16, 8);
+    if (!config_fetch(d, entry_base + 4, es * 4))
+      return;
+    printf("\t\tEntry %u: Enable%c Writable%c EntrySize=%u\n", entry,
+	   FLAG(entry_header, PCI_EA_CAP_ENT_ENABLE),
+	   FLAG(entry_header, PCI_EA_CAP_ENT_WRITABLE), es);
+    printf("\t\t\t BAR Equivalent Indicator: ");
+    switch (bei) {
+    case 0:
+    case 1:
+    case 2:
+    case 3:
+    case 4:
+    case 5:
+      printf("BAR %u", bei);
+      break;
+    case 6:
+      printf("resource behind function");
+      break;
+    case 7:
+      printf("not indicated");
+      break;
+    case 8:
+      printf("expansion ROM");
+      break;
+    case 9:
+    case 10:
+    case 11:
+    case 12:
+    case 13:
+    case 14:
+      printf("VF-BAR %u", bei - 9);
+      break;
+    default:
+      printf("reserved");
+      break;
+    }
+    printf("\n");
+
+    prop_text = cap_ea_property(pp, 0);
+    printf("\t\t\t PrimaryProperties: ");
+    if (prop_text)
+      printf("%s\n", prop_text);
+    else
+      printf("[%02x]\n", pp);
+
+    prop_text = cap_ea_property(sp, 1);
+    printf("\t\t\t SecondaryProperties: ");
+    if (prop_text)
+      printf("%s\n", prop_text);
+    else
+      printf("[%02x]\n", sp);
+
+    base = get_conf_long(d, entry_base + 4);
+    has_base_high = ((base & 2) != 0);
+    base &= ~3;
+
+    max_offset = get_conf_long(d, entry_base + 8);
+    has_max_offset_high = ((max_offset & 2) != 0);
+    max_offset |= 3;
+    max_offset_high_pos = entry_base + 12;
+
+    printf("\t\t\t Base: ");
+    if (has_base_high) {
+      u32 base_high = get_conf_long(d, entry_base + 12);
+
+      printf("%x", base_high);
+      max_offset_high_pos += 4;
+    }
+    printf("%08x\n", base);
+
+    printf("\t\t\t MaxOffset: ");
+    if (has_max_offset_high) {
+      u32 max_offset_high = get_conf_long(d, max_offset_high_pos);
+
+      printf("%x", max_offset_high);
+    }
+    printf("%08x\n", max_offset);
+
+    entry_base += 4 + 4 * es;
+  }
+}
+
 void
 show_caps(struct device *d, int where)
 {
@@ -1348,6 +1501,9 @@ show_caps(struct device *d, int where)
 	    case PCI_CAP_ID_AF:
 	      cap_af(d, where);
 	      break;
+	    case PCI_CAP_ID_EA:
+	      cap_ea(d, where, cap);
+	      break;
 	    default:
 	      printf("#%02x [%04x]\n", id, cap);
 	    }
-- 
1.8.3.1

