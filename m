Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ea0-f202.google.com ([209.85.215.202]:34065 "EHLO
	mail-ea0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446Ab2LEVCa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Dec 2012 16:02:30 -0500
Received: by mail-ea0-f202.google.com with SMTP id j12so395109eaa.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Dec 2012 13:02:29 -0800 (PST)
Subject: [PATCH 01/12] PCI: Add and use standard PCI-X Capability register
	names
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Matthew Wilcox <willy@linux.intel.com>
Date: Wed, 05 Dec 2012 13:57:24 -0700
Message-ID: <20121205205724.13851.50508.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add and use #defines for PCI-X Capability registers and fields.
Note that the PCI-X Capability has a different layout for
type 0 (endpoint) and type 1 (bridge) devices.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Matthew Wilcox <willy@linux.intel.com>
---
 drivers/pci/probe.c           |   15 +++++++++------
 include/uapi/linux/pci_regs.h |   15 ++++++++++++++-
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ec909af..81d0667 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -579,14 +579,16 @@ static void pci_set_bus_speed(struct pci_bus *bus)
 	if (pos) {
 		u16 status;
 		enum pci_bus_speed max;
-		pci_read_config_word(bridge, pos + 2, &status);
 
-		if (status & 0x8000) {
+		pci_read_config_word(bridge, pos + PCI_X_BRIDGE_SSTATUS,
+				     &status);
+
+		if (status & PCI_X_SSTATUS_533MHZ) {
 			max = PCI_SPEED_133MHz_PCIX_533;
-		} else if (status & 0x4000) {
+		} else if (status & PCI_X_SSTATUS_266MHZ) {
 			max = PCI_SPEED_133MHz_PCIX_266;
-		} else if (status & 0x0002) {
-			if (((status >> 12) & 0x3) == 2) {
+		} else if (status & PCI_X_SSTATUS_133MHZ) {
+			if ((status & PCI_X_SSTATUS_VERS) == PCI_X_SSTATUS_V2) {
 				max = PCI_SPEED_133MHz_PCIX_ECC;
 			} else {
 				max = PCI_SPEED_133MHz_PCIX;
@@ -596,7 +598,8 @@ static void pci_set_bus_speed(struct pci_bus *bus)
 		}
 
 		bus->max_bus_speed = max;
-		bus->cur_bus_speed = pcix_bus_speed[(status >> 6) & 0xf];
+		bus->cur_bus_speed = pcix_bus_speed[
+			(status & PCI_X_SSTATUS_FREQ) >> 6];
 
 		return;
 	}
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 20ae747..4cca834 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -349,7 +349,7 @@
 #define  PCI_AF_STATUS_TP	0x01
 #define PCI_CAP_AF_SIZEOF	6	/* size of AF registers */
 
-/* PCI-X registers */
+/* PCI-X registers (Type 0 (non-bridge) devices) */
 
 #define PCI_X_CMD		2	/* Modes & Features */
 #define  PCI_X_CMD_DPERR_E	0x0001	/* Data Parity Error Recovery Enable */
@@ -389,6 +389,19 @@
 #define PCI_CAP_PCIX_SIZEOF_V1	24	/* size for Version 1 */
 #define PCI_CAP_PCIX_SIZEOF_V2	PCI_CAP_PCIX_SIZEOF_V1	/* Same for v2 */
 
+/* PCI-X registers (Type 1 (bridge) devices) */
+
+#define PCI_X_BRIDGE_SSTATUS	2	/* Secondary Status */
+#define  PCI_X_SSTATUS_64BIT	0x0001	/* Secondary AD interface is 64 bits */
+#define  PCI_X_SSTATUS_133MHZ	0x0002	/* 133 MHz capable */
+#define  PCI_X_SSTATUS_FREQ	0x03c0	/* Secondary Bus Mode and Frequency */
+#define  PCI_X_SSTATUS_VERS	0x3000	/* PCI-X Capability Version */
+#define  PCI_X_SSTATUS_V1	0x1000	/* Mode 2, not Mode 1 */
+#define  PCI_X_SSTATUS_V2	0x2000	/* Mode 1 or Modes 1 and 2 */
+#define  PCI_X_SSTATUS_266MHZ	0x4000	/* 266 MHz capable */
+#define  PCI_X_SSTATUS_533MHZ	0x8000	/* 533 MHz capable */
+#define PCI_X_BRIDGE_STATUS	4	/* Bridge Status */
+
 /* PCI Bridge Subsystem ID registers */
 
 #define PCI_SSVID_VENDOR_ID     4	/* PCI-Bridge subsystem vendor id register */

