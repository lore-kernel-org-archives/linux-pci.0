Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:18564 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758585AbdDSAcd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2017 20:32:33 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v2] PCI: disable SERR for kdump kernel
Date: Tue, 18 Apr 2017 17:31:30 -0700
Message-Id: <20170419003130.5302-1-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Found one system with infiniband with SRIOV enabled, kdump kernel
SRIOV BAR probing trigger one pci fatal error.
That assert error pin, and host get reset by BMC.

We can just ignore that error to let kernel go on
and kdump to create vmcore.

-v2: add debug print out

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/probe.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

Index: linux-2.6/drivers/pci/probe.c
===================================================================
--- linux-2.6.orig/drivers/pci/probe.c
+++ linux-2.6/drivers/pci/probe.c
@@ -17,6 +17,8 @@
 #include <linux/acpi.h>
 #include <linux/irqdomain.h>
 #include <linux/pm_runtime.h>
+#include <linux/crash_dump.h>
+
 #include "pci.h"
 
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
@@ -1515,6 +1517,24 @@ static void pci_msi_setup_pci_dev(struct
 		pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
 }
 
+static void pci_disable_serr(struct pci_dev *dev)
+{
+	u16 pci_cmd, pci_bctl;
+
+	pci_read_config_word(dev, PCI_COMMAND, &pci_cmd);
+	pci_cmd &= ~PCI_COMMAND_SERR;
+	pci_write_config_word(dev, PCI_COMMAND, pci_cmd);
+	dev_printk(KERN_DEBUG, &dev->dev, "SERR cleared\n");
+
+	/* Program bridge control value */
+	if ((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
+		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &pci_bctl);
+		pci_bctl &= ~PCI_BRIDGE_CTL_SERR;
+		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, pci_bctl);
+		dev_printk(KERN_DEBUG, &dev->dev, "BRIDGE SERR cleared\n");
+	}
+}
+
 /**
  * pci_setup_device - fill in class and map information of a device
  * @dev: the device structure to fill
@@ -1572,6 +1592,9 @@ int pci_setup_device(struct pci_dev *dev
 	/* device class may be changed after fixup */
 	class = dev->class >> 8;
 
+	if (is_kdump_kernel())
+		pci_disable_serr(dev);
+
 	if (dev->non_compliant_bars) {
 		pci_read_config_word(dev, PCI_COMMAND, &cmd);
 		if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
