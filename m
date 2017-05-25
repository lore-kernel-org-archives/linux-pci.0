Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35551 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760518AbdEYVfS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 May 2017 17:35:18 -0400
Received: by mail-wm0-f46.google.com with SMTP id b84so108027505wmh.0
        for <linux-pci@vger.kernel.org>; Thu, 25 May 2017 14:35:17 -0700 (PDT)
Date: Thu, 25 May 2017 22:32:25 +0100
From: Piotr Gregor <piotrgregor@rsyncme.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        GregKroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Neo Jia <cjia@nvidia.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Vlad Tsyrklevich <vlad@tsyrklevich.net>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Yongji Xie <xyjxie@linux.vnet.ibm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH] PCI: Move test of INTx masking to pci_setup_device
Message-ID: <20170525213222.GA27295@westernst>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The test for INTx masking via config space command performed
in pci_intx_mask_supported should be performed before PCI device
can be used. This is to avoid reading/writing of PCI_COMMAND_INTX_DISABLE
register which may collide with MSI/MSI-X interrupts.

This patch moves test performed in pci_intx_mask_supported
to __pci_intx_mask_supported and unexports the former.
The result of INTx masking test is saved in broken_intx_masking
field of struct pci_dev (which now has extended meaning: if true
then the test has failed or the feature is not supported).
The __pci_intx_mask_supported test is moved to pci_setup_device.
The result can be queried at any time later from the pci_dev
using same interface as before (though whith changed implementation)

static inline bool pci_intx_mask_supported(struct pci_dev *pdev)
{
        /*
         * INTx masking is supported if device passed INTx test
         * and it's INTx masking feature works properly.
         */
        return !pdev->broken_intx_masking;
}

so current users of pci_intx_mask_supported: uio and vfio, keep
their code unchanged.

Signed-off-by: Piotr Gregor <piotrgregor@rsyncme.org>
---
 drivers/pci/pci.c   | 45 ++++++++++++++++++++++++---------------------
 drivers/pci/probe.c |  3 +++
 include/linux/pci.h | 13 +++++++++++--
 3 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b01bd5b..8d5628e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3709,44 +3709,47 @@ void pci_intx(struct pci_dev *pdev, int enable)
 EXPORT_SYMBOL_GPL(pci_intx);
 
 /**
- * pci_intx_mask_supported - probe for INTx masking support
+ * pci_intx_mask_supported - probe for INTx masking support in pci_setup_device
  * @dev: the PCI device to operate on
  *
- * Check if the device dev support INTx masking via the config space
- * command word.
+ * Check if the device dev supports INTx masking via the config space
+ * command word. Executed when PCI device is setup. Result is saved
+ * in broken_intx_masking field of pci_dev and can be checked
+ * with pci_intx_mask_supported after PCI device has been setup
+ * (avoids testing of PCI_COMMAND_INTX_DISABLE register at runtime).
  */
-bool pci_intx_mask_supported(struct pci_dev *dev)
+bool __pci_intx_mask_supported(struct pci_dev *dev)
 {
-	bool mask_supported = false;
-	u16 orig, new;
+	u16 orig, toggle, new;
 
+	/*
+	 * If device doesn't support this feature though it could pass the test.
+	 */
 	if (dev->broken_intx_masking)
 		return false;
 
 	pci_cfg_access_lock(dev);
 
+	/*
+	 * Perform the test.
+	 */
 	pci_read_config_word(dev, PCI_COMMAND, &orig);
-	pci_write_config_word(dev, PCI_COMMAND,
-			      orig ^ PCI_COMMAND_INTX_DISABLE);
+	toggle = orig ^ PCI_COMMAND_INTX_DISABLE;
+	pci_write_config_word(dev, PCI_COMMAND, toggle);
 	pci_read_config_word(dev, PCI_COMMAND, &new);
 
 	/*
-	 * There's no way to protect against hardware bugs or detect them
-	 * reliably, but as long as we know what the value should be, let's
-	 * go ahead and check it.
+	 * Restore initial state.
 	 */
-	if ((new ^ orig) & ~PCI_COMMAND_INTX_DISABLE) {
-		dev_err(&dev->dev, "Command register changed from 0x%x to 0x%x: driver or hardware bug?\n",
-			orig, new);
-	} else if ((new ^ orig) & PCI_COMMAND_INTX_DISABLE) {
-		mask_supported = true;
-		pci_write_config_word(dev, PCI_COMMAND, orig);
-	}
+	pci_write_config_word(dev, PCI_COMMAND, orig);
 
 	pci_cfg_access_unlock(dev);
-	return mask_supported;
+
+	if (new == toggle)
+		return true;
+
+	return false;
 }
-EXPORT_SYMBOL_GPL(pci_intx_mask_supported);
 
 static bool pci_check_and_set_intx_mask(struct pci_dev *dev, bool mask)
 {
@@ -3798,7 +3801,7 @@ static bool pci_check_and_set_intx_mask(struct pci_dev *dev, bool mask)
  * @dev: the PCI device to operate on
  *
  * Check if the device dev has its INTx line asserted, mask it and
- * return true in that case. False is returned if not interrupt was
+ * return true in that case. False is returned if no interrupt was
  * pending.
  */
 bool pci_check_and_mask_intx(struct pci_dev *dev)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 19c8950..b343b14 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1399,6 +1399,9 @@ int pci_setup_device(struct pci_dev *dev)
 		}
 	}
 
+	if (!dev->broken_intx_masking && !__pci_intx_mask_supported(dev))
+		dev->broken_intx_masking = 1;
+
 	switch (dev->hdr_type) {		    /* header type */
 	case PCI_HEADER_TYPE_NORMAL:		    /* standard header */
 		if (class == PCI_CLASS_BRIDGE_PCI)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 33c2b0b..58c6fe3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -366,7 +366,7 @@ struct pci_dev {
 	unsigned int	is_thunderbolt:1; /* Thunderbolt controller */
 	unsigned int    __aer_firmware_first_valid:1;
 	unsigned int	__aer_firmware_first:1;
-	unsigned int	broken_intx_masking:1;
+	unsigned int	broken_intx_masking:1; /* INTx masking can't be used */
 	unsigned int	io_window_1k:1;	/* Intel P2P bridge 1K I/O windows */
 	unsigned int	irq_managed:1;
 	unsigned int	has_secondary_link:1;
@@ -1003,6 +1003,15 @@ int __must_check pci_reenable_device(struct pci_dev *);
 int __must_check pcim_enable_device(struct pci_dev *pdev);
 void pcim_pin_device(struct pci_dev *pdev);
 
+static inline bool pci_intx_mask_supported(struct pci_dev *pdev)
+{
+	/*
+	 * INTx masking is supported if device passed INTx test and it's INTx
+	 * masking feature works properly.
+	 */
+	return !pdev->broken_intx_masking;
+}
+
 static inline int pci_is_enabled(struct pci_dev *pdev)
 {
 	return (atomic_read(&pdev->enable_cnt) > 0);
@@ -1026,7 +1035,7 @@ int __must_check pci_set_mwi(struct pci_dev *dev);
 int pci_try_set_mwi(struct pci_dev *dev);
 void pci_clear_mwi(struct pci_dev *dev);
 void pci_intx(struct pci_dev *dev, int enable);
-bool pci_intx_mask_supported(struct pci_dev *dev);
+bool __pci_intx_mask_supported(struct pci_dev *dev);
 bool pci_check_and_mask_intx(struct pci_dev *dev);
 bool pci_check_and_unmask_intx(struct pci_dev *dev);
 int pci_wait_for_pending(struct pci_dev *dev, int pos, u16 mask);
-- 
2.1.4
