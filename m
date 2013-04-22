Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:33283 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636Ab3DVXLD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 19:11:03 -0400
Received: by mail-ie0-f169.google.com with SMTP id ar20so13179iec.28
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 16:11:02 -0700 (PDT)
Subject: [PATCH v4 07/22] PCI: Clean up MSI/MSI-X capability #defines
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 17:11:00 -0600
Message-ID: <20130422231100.32621.52374.stgit@bhelgaas-glaptop>
In-Reply-To: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This doesn't change any existing symbols, but it puts them in logical
order and uses explicit masks instead of shifts, like the rest of the
file.

It also adds new symbols for PCI_MSIX_TABLE_BIR,
PCI_MSIX_TABLE_OFFSET, PCI_MSIX_PBA_BIR, and PCI_MSIX_PBA_OFFSET to
replace the mis-named PCI_MSIX_FLAGS_BIRMASK (the BAR index fields
are part of the Table and PBA registers, not the flags register).

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/uapi/linux/pci_regs.h |   30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index ebfadc5..864e324 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -292,12 +292,12 @@
 
 /* Message Signalled Interrupts registers */
 
-#define PCI_MSI_FLAGS		2	/* Various flags */
-#define  PCI_MSI_FLAGS_64BIT	0x80	/* 64-bit addresses allowed */
-#define  PCI_MSI_FLAGS_QSIZE	0x70	/* Message queue size configured */
-#define  PCI_MSI_FLAGS_QMASK	0x0e	/* Maximum queue size available */
-#define  PCI_MSI_FLAGS_ENABLE	0x01	/* MSI feature enabled */
-#define  PCI_MSI_FLAGS_MASKBIT	0x100	/* 64-bit mask bits allowed */
+#define PCI_MSI_FLAGS		2	/* Message Control */
+#define  PCI_MSI_FLAGS_ENABLE	0x0001	/* MSI feature enabled */
+#define  PCI_MSI_FLAGS_QMASK	0x000e	/* Maximum queue size available */
+#define  PCI_MSI_FLAGS_QSIZE	0x0070	/* Message queue size configured */
+#define  PCI_MSI_FLAGS_64BIT	0x0080	/* 64-bit addresses allowed */
+#define  PCI_MSI_FLAGS_MASKBIT	0x0100	/* Per-vector masking capable */
 #define PCI_MSI_RFU		3	/* Rest of capability flags */
 #define PCI_MSI_ADDRESS_LO	4	/* Lower 32 bits */
 #define PCI_MSI_ADDRESS_HI	8	/* Upper 32 bits (if PCI_MSI_FLAGS_64BIT set) */
@@ -309,13 +309,17 @@
 #define PCI_MSI_PENDING_64	20	/* Pending intrs for 64-bit devices */
 
 /* MSI-X registers */
-#define PCI_MSIX_FLAGS		2
-#define  PCI_MSIX_FLAGS_QSIZE	0x7FF
-#define  PCI_MSIX_FLAGS_ENABLE	(1 << 15)
-#define  PCI_MSIX_FLAGS_MASKALL	(1 << 14)
-#define PCI_MSIX_TABLE		4
-#define PCI_MSIX_PBA		8
-#define  PCI_MSIX_FLAGS_BIRMASK	(7 << 0)
+#define PCI_MSIX_FLAGS		2	/* Message Control */
+#define  PCI_MSIX_FLAGS_QSIZE	0x07FF	/* Table size */
+#define  PCI_MSIX_FLAGS_MASKALL	0x4000	/* Mask all vectors for this function */
+#define  PCI_MSIX_FLAGS_ENABLE	0x8000	/* MSI-X enable */
+#define PCI_MSIX_TABLE		4	/* Table offset */
+#define  PCI_MSIX_TABLE_BIR	0x00000007 /* BAR index */
+#define  PCI_MSIX_TABLE_OFFSET	0xfffffff8 /* Offset into specified BAR */
+#define PCI_MSIX_PBA		8	/* Pending Bit Array offset */
+#define  PCI_MSIX_PBA_BIR	0x00000007 /* BAR index */
+#define  PCI_MSIX_PBA_OFFSET	0xfffffff8 /* Offset into specified BAR */
+#define  PCI_MSIX_FLAGS_BIRMASK	(7 << 0)   /* deprecated */
 #define PCI_CAP_MSIX_SIZEOF	12	/* size of MSIX registers */
 
 /* MSI-X entry's format */

