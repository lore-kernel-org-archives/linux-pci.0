Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21141 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933750AbcIFWA0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Sep 2016 18:00:26 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
        Wei Zhang <wzhang@fb.com>, Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 3/4] pcie/aer: Cache capability position
Date: Tue,  6 Sep 2016 16:00:18 -0600
Message-Id: <1473199219-3369-4-git-send-email-keith.busch@intel.com>
In-Reply-To: <1473199219-3369-1-git-send-email-keith.busch@intel.com>
References: <1473199219-3369-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This saves the postition of the error reporting capability so that it
doesn't need to be rediscovered during error handling.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer/aerdrv.c      | 10 +++++-----
 drivers/pci/pcie/aer/aerdrv_core.c | 12 ++++++------
 drivers/pci/probe.c                |  2 ++
 include/linux/pci.h                |  1 +
 4 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 49805a4..df64adb 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -130,7 +130,7 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
 	pcie_capability_clear_word(pdev, PCI_EXP_RTCTL,
 				   SYSTEM_ERROR_INTR_ON_MESG_MASK);
 
-	aer_pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
+	aer_pos = pdev->aer_cap;
 	/* Clear error status */
 	pci_read_config_dword(pdev, aer_pos + PCI_ERR_ROOT_STATUS, &reg32);
 	pci_write_config_dword(pdev, aer_pos + PCI_ERR_ROOT_STATUS, reg32);
@@ -169,7 +169,7 @@ static void aer_disable_rootport(struct aer_rpc *rpc)
 	 */
 	set_downstream_devices_error_reporting(pdev, false);
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
+	pos = pdev->aer_cap;
 	/* Disable Root's interrupt in response to error messages */
 	pci_read_config_dword(pdev, pos + PCI_ERR_ROOT_COMMAND, &reg32);
 	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
@@ -196,7 +196,7 @@ irqreturn_t aer_irq(int irq, void *context)
 	unsigned long flags;
 	int pos;
 
-	pos = pci_find_ext_capability(pdev->port, PCI_EXT_CAP_ID_ERR);
+	pos = pdev->port->aer_cap;
 	/*
 	 * Must lock access to Root Error Status Reg, Root Error ID Reg,
 	 * and Root error producer/consumer index
@@ -339,7 +339,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	u32 reg32;
 	int pos;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	pos = dev->aer_cap;
 
 	/* Disable Root's interrupt in response to error messages */
 	pci_read_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, &reg32);
@@ -392,7 +392,7 @@ static void aer_error_resume(struct pci_dev *dev)
 	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, reg16);
 
 	/* Clean AER Root Error Status */
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	pos = dev->aer_cap;
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &mask);
 	if (dev->error_state == pci_channel_io_normal)
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 521e39c..47ac510 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -40,7 +40,7 @@ int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 	if (pcie_aer_get_firmware_first(dev))
 		return -EIO;
 
-	if (!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR))
+	if (!dev->aer_cap)
 		return -EIO;
 
 	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
@@ -62,7 +62,7 @@ int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
 	int pos;
 	u32 status;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	pos = dev->aer_cap;
 	if (!pos)
 		return -EIO;
 
@@ -83,7 +83,7 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 	if (!pci_is_pcie(dev))
 		return -ENODEV;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	pos = dev->aer_cap;
 	if (!pos)
 		return -EIO;
 
@@ -158,7 +158,7 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
 	if (!(reg16 & PCI_EXP_AER_FLAGS))
 		return false;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	pos = dev->aer_cap;
 	if (!pos)
 		return false;
 
@@ -555,7 +555,7 @@ static void handle_error_source(struct pcie_device *aerdev,
 		 * Correctable error does not need software intervention.
 		 * No need to go through error recovery process.
 		 */
-		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+		pos = dev->aer_cap;
 		if (pos)
 			pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS,
 					info->status);
@@ -647,7 +647,7 @@ static int get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 	info->status = 0;
 	info->tlp_header_valid = 0;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	pos = dev->aer_cap;
 
 	/* The device might not support AER */
 	if (!pos)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index e2e4244..7c3fcba 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1666,6 +1666,8 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	/* Enable ACS P2P upstream forwarding */
 	pci_enable_acs(dev);
 
+	/* Advanced Error Reporting */
+	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
 	pci_cleanup_aer_error_status_regs(dev);
 
 	/* Precision Time Measurement */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1b62f7a..ee289da 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -268,6 +268,7 @@ struct pci_dev {
 	unsigned int	class;		/* 3 bytes: (base,sub,prog-if) */
 	u8		revision;	/* PCI revision, low byte of class word */
 	u8		hdr_type;	/* PCI header type (`multi' flag masked out) */
+	u16		aer_cap;	/* AER capability offset */
 	u8		pcie_cap;	/* PCIe capability offset */
 	u8		msi_cap;	/* MSI capability offset */
 	u8		msix_cap;	/* MSI-X capability offset */
-- 
2.7.2

