Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751972AbeA3S1Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jan 2018 13:27:16 -0500
Subject: [PATCH v2 14/14] PCI/DPC: Reformat DPC register definitions
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>
Date: Tue, 30 Jan 2018 12:27:14 -0600
Message-ID: <20180130182714.106875.95828.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180130182235.106875.70588.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180130182235.106875.70588.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Reformat DPC register definitions to follow the convention that register
field masks indicate the register width, e.g., a field of a 16-bit register
uses a mask of 4 hex digits, with leading zeros included as needed.
No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Keith Busch <keith.busch@intel.com>
---
 include/uapi/linux/pci_regs.h |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 970a0dc535c4..66d71461d2f0 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -966,28 +966,28 @@
 
 /* Downstream Port Containment */
 #define PCI_EXP_DPC_CAP			4	/* DPC Capability */
-#define PCI_EXP_DPC_IRQ			0x1f	/* DPC Interrupt Message Number */
-#define  PCI_EXP_DPC_CAP_RP_EXT		0x20	/* Root Port Extensions for DPC */
-#define  PCI_EXP_DPC_CAP_POISONED_TLP	0x40	/* Poisoned TLP Egress Blocking Supported */
-#define  PCI_EXP_DPC_CAP_SW_TRIGGER	0x80	/* Software Triggering Supported */
-#define  PCI_EXP_DPC_RP_PIO_LOG_SIZE	0xF00	/* RP PIO log size */
+#define PCI_EXP_DPC_IRQ			0x001F	/* Interrupt Message Number */
+#define  PCI_EXP_DPC_CAP_RP_EXT		0x0020	/* Root Port Extensions */
+#define  PCI_EXP_DPC_CAP_POISONED_TLP	0x0040	/* Poisoned TLP Egress Blocking Supported */
+#define  PCI_EXP_DPC_CAP_SW_TRIGGER	0x0080	/* Software Triggering Supported */
+#define  PCI_EXP_DPC_RP_PIO_LOG_SIZE	0x0F00	/* RP PIO Log Size */
 #define  PCI_EXP_DPC_CAP_DL_ACTIVE	0x1000	/* ERR_COR signal on DL_Active supported */
 
 #define PCI_EXP_DPC_CTL			6	/* DPC control */
-#define  PCI_EXP_DPC_CTL_EN_NONFATAL 	0x02	/* Enable trigger on ERR_NONFATAL message */
-#define  PCI_EXP_DPC_CTL_INT_EN 	0x08	/* DPC Interrupt Enable */
+#define  PCI_EXP_DPC_CTL_EN_NONFATAL 	0x0002	/* Enable trigger on ERR_NONFATAL message */
+#define  PCI_EXP_DPC_CTL_INT_EN 	0x0008	/* DPC Interrupt Enable */
 
 #define PCI_EXP_DPC_STATUS		8	/* DPC Status */
-#define  PCI_EXP_DPC_STATUS_TRIGGER	0x01	/* Trigger Status */
-#define  PCI_EXP_DPC_STATUS_TRIGGER_RSN	0x06	/* Trigger Reason */
-#define  PCI_EXP_DPC_STATUS_INTERRUPT	0x08	/* Interrupt Status */
-#define  PCI_EXP_DPC_RP_BUSY		0x10	/* Root Port Busy */
-#define  PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT 0x60 /* Trig Reason Extension */
+#define  PCI_EXP_DPC_STATUS_TRIGGER	    0x0001 /* Trigger Status */
+#define  PCI_EXP_DPC_STATUS_TRIGGER_RSN	    0x0006 /* Trigger Reason */
+#define  PCI_EXP_DPC_STATUS_INTERRUPT	    0x0008 /* Interrupt Status */
+#define  PCI_EXP_DPC_RP_BUSY		    0x0010 /* Root Port Busy */
+#define  PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT 0x0060 /* Trig Reason Extension */
 
 #define PCI_EXP_DPC_SOURCE_ID		10	/* DPC Source Identifier */
 
 #define PCI_EXP_DPC_RP_PIO_STATUS	 0x0C	/* RP PIO Status */
-#define PCI_EXP_DPC_RP_PIO_MASK		 0x10	/* RP PIO MASK */
+#define PCI_EXP_DPC_RP_PIO_MASK		 0x10	/* RP PIO Mask */
 #define PCI_EXP_DPC_RP_PIO_SEVERITY	 0x14	/* RP PIO Severity */
 #define PCI_EXP_DPC_RP_PIO_SYSERROR	 0x18	/* RP PIO SysError */
 #define PCI_EXP_DPC_RP_PIO_EXCEPTION	 0x1C	/* RP PIO Exception */
