Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:35565 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964787AbbLWAd4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Dec 2015 19:33:56 -0500
Received: by mail-io0-f179.google.com with SMTP id q126so202380609iof.2
        for <linux-pci@vger.kernel.org>; Tue, 22 Dec 2015 16:33:56 -0800 (PST)
From: David Daney <ddaney.cavm@gmail.com>
To: linux-pci@vger.kernel.org, Martin Mares <mj@ucw.cz>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Sean O. Stalley" <sean.stalley@intel.com>,
	David Daney <david.daney@cavium.com>
Subject: [PATCH v4] Add lspci support for Enhanced Allocation Capability.
Date: Tue, 22 Dec 2015 16:33:51 -0800
Message-Id: <1450830831-3965-1-git-send-email-ddaney.cavm@gmail.com>
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

Changes from v3: Add tests/cap-ea-1, rebased.

Thanks,
David Daney


 lib/header.h   |   8 ++
 ls-caps.c      | 156 +++++++++++++++++++++++++++
 tests/cap-ea-1 | 324 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 488 insertions(+)
 create mode 100644 tests/cap-ea-1

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
index 639f931..7ff6c67 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -1255,6 +1255,159 @@ cap_sata_hba(struct device *d, int where, int cap)
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
@@ -1349,6 +1502,9 @@ show_caps(struct device *d, int where)
 	    case PCI_CAP_ID_AF:
 	      cap_af(d, where);
 	      break;
+	    case PCI_CAP_ID_EA:
+	      cap_ea(d, where, cap);
+	      break;
 	    default:
 	      printf("#%02x [%04x]\n", id, cap);
 	    }
diff --git a/tests/cap-ea-1 b/tests/cap-ea-1
new file mode 100644
index 0000000..df88ba9
--- /dev/null
+++ b/tests/cap-ea-1
@@ -0,0 +1,324 @@
+0002:01:00.0 Ethernet controller: Cavium, Inc. THUNDERX Network Interface Controller (rev 08)
+	Subsystem: Cavium, Inc. Device a11e
+	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
+	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
+	Latency: 0
+	Region 0: [virtual] Memory at 843000000000 (32-bit, non-prefetchable) [size=1G]
+	Region 4: [virtual] Memory at 843060000000 (32-bit, non-prefetchable) [size=1M]
+	Capabilities: [40] Express (v2) Endpoint, MSI 00
+		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
+			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset- SlotPowerLimit 0.000W
+		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
+			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
+			MaxPayload 128 bytes, MaxReadReq 128 bytes
+		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
+		LnkCap:	Port #0, Speed unknown, Width x0, ASPM not supported, Exit Latency L0s <64ns, L1 <1us
+			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
+		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
+			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
+		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
+		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported
+		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
+		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
+			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
+			 Compliance De-emphasis: -6dB
+		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
+			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
+	Capabilities: [80] MSI-X: Enable+ Count=10 Masked-
+		Vector table: BAR=4 offset=00000000
+		PBA: BAR=4 offset=000f0000
+	Capabilities: [98] Enhanced Allocation (EA): NumEntries=4
+		Entry 0: Enable+ Writable- EntrySize=4
+			 BAR Equivalent Indicator: BAR 0
+			 PrimaryProperties: memory space, non-prefetchable
+			 SecondaryProperties: entry unavailable for use, PrimaryProperties should be used
+			 Base: 843000000000
+			 MaxOffset: 03fffffff
+		Entry 1: Enable+ Writable- EntrySize=4
+			 BAR Equivalent Indicator: BAR 4
+			 PrimaryProperties: memory space, non-prefetchable
+			 SecondaryProperties: entry unavailable for use, PrimaryProperties should be used
+			 Base: 843060000000
+			 MaxOffset: 0000fffff
+		Entry 2: Enable+ Writable- EntrySize=4
+			 BAR Equivalent Indicator: VF-BAR 0
+			 PrimaryProperties: VF memory space, non-prefetchable
+			 SecondaryProperties: entry unavailable for use, PrimaryProperties should be used
+			 Base: 8430a0000000
+			 MaxOffset: 0001fffff
+		Entry 3: Enable+ Writable- EntrySize=4
+			 BAR Equivalent Indicator: VF-BAR 4
+			 PrimaryProperties: VF memory space, non-prefetchable
+			 SecondaryProperties: entry unavailable for use, PrimaryProperties should be used
+			 Base: 8430e0000000
+			 MaxOffset: 0001fffff
+	Capabilities: [100 v1] Alternative Routing-ID Interpretation (ARI)
+		ARICap:	MFVC- ACS-, Next Function: 0
+		ARICtl:	MFVC- ACS-, Function Group: 0
+	Capabilities: [108 v1] Vendor Specific Information: ID=00a0 Rev=1 Len=040 <?>
+	Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
+		IOVCap:	Migration-, Interrupt Message Number: 000
+		IOVCtl:	Enable+ Migration- Interrupt- MSE+ ARIHierarchy+
+		IOVSta:	Migration-
+		Initial VFs: 128, Total VFs: 128, Number of VFs: 128, Function Dependency Link: 00
+		VF offset: 1, stride: 1, Device ID: a034
+		Supported Page Size: 00000553, System Page Size: 00000100
+		VF Migration: offset: 00000000, BIR: 0
+	Kernel driver in use: thunder-nic
+00: 7d 17 1e a0 06 00 10 00 08 00 00 02 00 00 00 00
+10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+20: 00 00 00 00 00 00 00 00 00 00 00 00 7d 17 1e a1
+30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
+40: 10 80 02 00 00 00 00 00 00 00 00 00 00 00 00 00
+50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+80: 11 98 09 80 04 00 00 00 04 00 0f 00 00 00 00 00
+90: 00 00 00 00 00 00 00 00 14 00 04 00 04 00 ff 80
+a0: 02 00 00 00 fe ff ff 3f 30 84 00 00 00 00 00 00
+b0: 44 00 ff 80 02 00 00 60 fe ff 0f 00 30 84 00 00
+c0: 00 00 00 00 94 04 ff 80 02 00 00 a0 fe ff 1f 00
+d0: 30 84 00 00 00 00 00 00 d4 04 ff 80 02 00 00 e0
+e0: fe ff 1f 00 30 84 00 00 00 00 00 00 00 00 00 00
+f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+100: 0e 00 81 10 00 00 00 00 0b 00 01 18 a0 00 01 04
+110: 00 00 00 00 00 00 00 00 00 00 00 00 30 84 00 00
+120: 00 00 00 00 00 00 00 00 00 00 00 60 30 84 00 00
+130: 00 00 00 a0 30 84 00 00 00 00 00 00 00 00 00 00
+140: 00 00 00 e0 30 84 00 00 00 00 00 00 00 00 00 00
+150: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+160: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+170: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+180: 10 00 01 00 02 00 00 00 19 00 00 00 80 00 80 00
+190: 80 00 00 00 01 00 01 00 00 00 34 a0 53 05 00 00
+1a0: 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+1b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+1c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+1d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+1e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+1f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+210: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+250: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+260: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+270: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+290: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+2a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+2b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+2c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+2d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+2e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+2f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+310: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+320: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+330: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+340: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+350: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+370: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+390: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+3a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+3b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+3c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+3d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+3e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+3f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+410: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+420: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+430: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+450: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+460: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+510: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+520: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+620: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+630: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+640: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+650: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+660: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+670: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+690: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+710: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+720: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+730: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+740: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+750: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+760: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+770: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+790: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+7a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+7b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+7c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+7d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+7e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+7f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+810: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+820: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+830: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+840: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+850: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+890: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+910: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+920: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+930: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+940: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+950: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+960: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+970: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+990: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+aa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ab0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ac0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ad0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ae0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+af0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ba0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+bb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+bc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+bd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+be0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+bf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ca0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+cb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+cc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+cd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ce0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+cf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+da0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+db0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+dc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+dd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+de0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+df0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ea0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+eb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ec0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ed0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ee0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ef0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+fa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+fb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+fc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+fd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+fe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+
-- 
1.8.3.1

