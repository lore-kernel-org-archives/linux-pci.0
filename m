Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754203AbdGJPwj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Jul 2017 11:52:39 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 1/2] PCI: Implement pci_reset_function_locked
Date: Mon, 10 Jul 2017 16:52:29 +0100
Message-Id: <20170710155230.8622-2-marc.zyngier@arm.com>
In-Reply-To: <20170710155230.8622-1-marc.zyngier@arm.com>
References: <20170710155230.8622-1-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The implementation of PCI workarounds may require that the device
is reset from its probe function. This implies that the PCI device
lock is already held, and makes calling pci_reset_function impossible
(since it will itself try to take that lock).

This patch introduces pci_reset_function_locked, which is the equivalent
of pci_reset_function, except that it requires the PCI device lock to
be already held by the caller.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/pci.c   | 35 +++++++++++++++++++++++++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 563901cd9c06..a2c3e8b94f65 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4287,6 +4287,41 @@ int pci_reset_function(struct pci_dev *dev)
 EXPORT_SYMBOL_GPL(pci_reset_function);
 
 /**
+ * pci_reset_function_locked - quiesce and reset a PCI device function
+ * @dev: PCI device to reset
+ *
+ * Some devices allow an individual function to be reset without affecting
+ * other functions in the same device.  The PCI device must be responsive
+ * to PCI config space in order to use this function.
+ *
+ * This function does not just reset the PCI portion of a device, but
+ * clears all the state associated with the device.  This function differs
+ * from __pci_reset_function in that it saves and restores device state
+ * over the reset. it also differs from pci_reset_function in that it
+ * requires the PCI device lock to be held.
+ *
+ * Returns 0 if the device function was successfully reset or negative if the
+ * device doesn't support resetting a single function.
+ */
+int pci_reset_function_locked(struct pci_dev *dev)
+{
+	int rc;
+
+	rc = pci_dev_reset(dev, 1);
+	if (rc)
+		return rc;
+
+	pci_dev_save_and_disable(dev);
+
+	rc = __pci_dev_reset(dev, 0);
+
+	pci_dev_restore(dev);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(pci_reset_function_locked);
+
+/**
  * pci_try_reset_function - quiesce and reset a PCI device function
  * @dev: PCI device to reset
  *
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8039f9f0ca05..16be18678ca1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1049,6 +1049,7 @@ void pcie_flr(struct pci_dev *dev);
 int __pci_reset_function(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
+int pci_reset_function_locked(struct pci_dev *dev);
 int pci_try_reset_function(struct pci_dev *dev);
 int pci_probe_reset_slot(struct pci_slot *slot);
 int pci_reset_slot(struct pci_slot *slot);
-- 
2.11.0
