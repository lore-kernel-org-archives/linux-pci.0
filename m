Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:3083 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732186AbeHBNbD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Aug 2018 09:31:03 -0400
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [RFC] PCI: add support for Immediate Readiness
Date: Thu,  2 Aug 2018 14:36:35 +0300
Message-Id: <20180802113635.7097-1-felipe.balbi@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCIe GEN4 defines a new bit on Status Register which tells us that, if
Set, a function is immediately ready after a Reset. This means that
all delays after a Conventional or Function Reset can be skipped.

This patch reads such bit and caches its value in a flag inside struct
pci_dev to be checked later if we should delay or can skip delays
after a reset.

Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
---
 drivers/pci/pci.c             | 9 ++++++++-
 include/linux/pci.h           | 1 +
 include/uapi/linux/pci_regs.h | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 316496e99da9..cf5239edd46a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -835,7 +835,7 @@ static void __pci_start_power_transition(struct pci_dev *dev, pci_power_t state)
 		 * because have already delayed for the bridge.
 		 */
 		if (dev->runtime_d3cold) {
-			if (dev->d3cold_delay)
+			if (dev->d3cold_delay && !dev->immediate)
 				msleep(dev->d3cold_delay);
 			/*
 			 * When powering on a bridge from D3cold, the
@@ -2442,6 +2442,7 @@ EXPORT_SYMBOL_GPL(pci_d3cold_disable);
 void pci_pm_init(struct pci_dev *dev)
 {
 	int pm;
+	u16 status;
 	u16 pmc;
 
 	pm_runtime_forbid(&dev->dev);
@@ -2504,6 +2505,9 @@ void pci_pm_init(struct pci_dev *dev)
 		/* Disable the PME# generation functionality */
 		pci_pme_active(dev, false);
 	}
+
+	pci_read_config_word(dev, PCI_STATUS, &status);
+	dev->immediate = status & PCI_STATUS_IMMEDIATE;
 }
 
 static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
@@ -4034,6 +4038,9 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 	int delay = 1;
 	u32 id;
 
+	if (dev->immediate)
+		return 0;
+
 	/*
 	 * After reset, the device should not silently discard config
 	 * requests, but it may still indicate that it needs more time by
diff --git a/include/linux/pci.h b/include/linux/pci.h
index abd5d5e17aee..d8f0a382b026 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -321,6 +321,7 @@ struct pci_dev {
 	pci_power_t	current_state;	/* Current operating state. In ACPI,
 					   this is D0-D3, D0 being fully
 					   functional, and D3 being off. */
+	unsigned int	immediate:1;	/* Supports Immediate Readiness */
 	u8		pm_cap;		/* PM capability offset */
 	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
 					   can be generated */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 4da87e2ef8a8..796d12910791 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -52,6 +52,7 @@
 #define  PCI_COMMAND_INTX_DISABLE 0x400 /* INTx Emulation Disable */
 
 #define PCI_STATUS		0x06	/* 16 bits */
+#define  PCI_STATUS_IMMEDIATE	0x01	/* Immediate Readiness */
 #define  PCI_STATUS_INTERRUPT	0x08	/* Interrupt status */
 #define  PCI_STATUS_CAP_LIST	0x10	/* Support Capability List */
 #define  PCI_STATUS_66MHZ	0x20	/* Support 66 MHz PCI 2.1 bus */
-- 
2.16.1
