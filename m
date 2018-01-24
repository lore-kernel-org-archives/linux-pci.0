Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.hostfission.com ([139.99.139.48]:55918 "EHLO
        mail1.hostfission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752314AbeAXILp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jan 2018 03:11:45 -0500
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
        by mail1.hostfission.com (Postfix) with ESMTP id B36D943BA8
        for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2018 19:02:33 +1100 (AEDT)
To: linux-pci@vger.kernel.org
Subject: [PATCH] Restore PCI bridge configuration space on bridge reset
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 24 Jan 2018 19:02:33 +1100
From: geoff@hostfission.com
Message-ID: <0986ad77b71f3b8e0a17f79e238d1ebc@hostfission.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

According to PCI-to-PCI Bridge Architecture Specification 3.2.5.17

> The bridge’s secondary bus interface and any buffers between
> the two interfaces (primary and secondary) must be initialized
> back to their default state whenever this bit is set.

Failure to observe this causes inability to access devices on the 
secondary bus
on the AMD Threadripper platform after device reset when the device is 
being
used for PCI passthrough with KVM.

The following patch corrects this by saving the pci state and restoring 
it after
the bus has been reset.

--Signed-off-by: Geoffrey McRae<geoff@hostfission.com>

--- ./drivers/pci/pci.c.orig	2018-01-24 18:30:23.913953332 +1100
+++ ./drivers/pci/pci.c	2018-01-24 18:46:31.752819451 +1100
@@ -1112,12 +1112,12 @@ int pci_save_state(struct pci_dev *dev)
  EXPORT_SYMBOL(pci_save_state);

  static void pci_restore_config_dword(struct pci_dev *pdev, int offset,
-				     u32 saved_val, int retry)
+				     u32 saved_val, int retry, int force)
  {
  	u32 val;

  	pci_read_config_dword(pdev, offset, &val);
-	if (val == saved_val)
+	if (!force && val == saved_val)
  		return;

  	for (;;) {
@@ -1136,33 +1136,29 @@ static void pci_restore_config_dword(str
  }

  static void pci_restore_config_space_range(struct pci_dev *pdev,
-					   int start, int end, int retry)
+					   int start, int end, int retry, int force)
  {
  	int index;

  	for (index = end; index >= start; index--)
  		pci_restore_config_dword(pdev, 4 * index,
  					 pdev->saved_config_space[index],
-					 retry);
+					 retry, force);
  }

-static void pci_restore_config_space(struct pci_dev *pdev)
+static void pci_restore_config_space(struct pci_dev *pdev, int force)
  {
  	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
-		pci_restore_config_space_range(pdev, 10, 15, 0);
+		pci_restore_config_space_range(pdev, 10, 15, 0, force);
  		/* Restore BARs before the command register. */
-		pci_restore_config_space_range(pdev, 4, 9, 10);
-		pci_restore_config_space_range(pdev, 0, 3, 0);
+		pci_restore_config_space_range(pdev, 4, 9, 10, force);
+		pci_restore_config_space_range(pdev, 0, 3, 0, force);
  	} else {
-		pci_restore_config_space_range(pdev, 0, 15, 0);
+		pci_restore_config_space_range(pdev, 0, 15, 0, force);
  	}
  }

-/**
- * pci_restore_state - Restore the saved state of a PCI device
- * @dev: - PCI device that we're dealing with
- */
-void pci_restore_state(struct pci_dev *dev)
+static void _pci_restore_state(struct pci_dev *dev, int force)
  {
  	if (!dev->state_saved)
  		return;
@@ -1176,7 +1172,7 @@ void pci_restore_state(struct pci_dev *d

  	pci_cleanup_aer_error_status_regs(dev);

-	pci_restore_config_space(dev);
+	pci_restore_config_space(dev, force);

  	pci_restore_pcix_state(dev);
  	pci_restore_msi_state(dev);
@@ -1187,6 +1183,15 @@ void pci_restore_state(struct pci_dev *d

  	dev->state_saved = false;
  }
+
+/**
+ * pci_restore_state - Restore the saved state of a PCI device
+ * @dev: - PCI device that we're dealing with
+ */
+void pci_restore_state(struct pci_dev *dev)
+{
+	_pci_restore_state(dev, 0);
+}
  EXPORT_SYMBOL(pci_restore_state);

  struct pci_saved_state {
@@ -4083,6 +4088,8 @@ void pci_reset_secondary_bus(struct pci_
  {
  	u16 ctrl;

+  pci_save_state(dev);
+
  	pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &ctrl);
  	ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
  	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
@@ -4092,10 +4099,23 @@ void pci_reset_secondary_bus(struct pci_
  	 */
  	msleep(2);

+	pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &ctrl);
  	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
  	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);

  	/*
+	 * According to PCI-to-PCI Bridge Architecture Specification 3.2.5.17
+	 *
+	 * "The bridge’s secondary bus interface and any buffers between
+	 * the two interfaces (primary and secondary) must be initialized
+	 * back to their default state whenever this bit is set."
+	 *
+	 * Failure to observe this causes inability to access devices on the
+	 * secondary bus on the AMD Threadripper platform.
+	 */
+	_pci_restore_state(dev, 1);
+
+	/*
  	 * Trhfa for conventional PCI is 2^25 clock cycles.
  	 * Assuming a minimum 33MHz clock this results in a 1s
  	 * delay before we can consider subordinate devices to
