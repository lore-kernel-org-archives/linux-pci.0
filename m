Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1675 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932747AbcI0UMq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Sep 2016 16:12:46 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Lukas Wunner <lukas@wunner.de>,
        Wei Zhang <wzhang@fb.com>, Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 4/5] pcie/aer: Cache capability position
Date: Tue, 27 Sep 2016 16:23:34 -0400
Message-Id: <1475007815-28354-5-git-send-email-keith.busch@intel.com>
In-Reply-To: <1475007815-28354-1-git-send-email-keith.busch@intel.com>
References: <1475007815-28354-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This saves the position of the error reporting capability so that it
doesn't need to be rediscovered during error handling.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pcie/aer/aerdrv.c      | 10 +++++-----
 drivers/pci/pcie/aer/aerdrv_core.c | 18 ++++++++++++------
 drivers/pci/probe.c                |  3 ++-
 include/linux/pci.h                |  5 +++++
 4 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 48d21e0..24c6722 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -134,7 +134,7 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
 	pcie_capability_clear_word(pdev, PCI_EXP_RTCTL,
 				   SYSTEM_ERROR_INTR_ON_MESG_MASK);
 
-	aer_pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
+	aer_pos = pdev->aer_cap;
 	/* Clear error status */
 	pci_read_config_dword(pdev, aer_pos + PCI_ERR_ROOT_STATUS, &reg32);
 	pci_write_config_dword(pdev, aer_pos + PCI_ERR_ROOT_STATUS, reg32);
@@ -173,7 +173,7 @@ static void aer_disable_rootport(struct aer_rpc *rpc)
 	 */
 	set_downstream_devices_error_reporting(pdev, false);
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
+	pos = pdev->aer_cap;
 	/* Disable Root's interrupt in response to error messages */
 	pci_read_config_dword(pdev, pos + PCI_ERR_ROOT_COMMAND, &reg32);
 	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
@@ -200,7 +200,7 @@ irqreturn_t aer_irq(int irq, void *context)
 	unsigned long flags;
 	int pos;
 
-	pos = pci_find_ext_capability(pdev->port, PCI_EXT_CAP_ID_ERR);
+	pos = pdev->port->aer_cap;
 	/*
 	 * Must lock access to Root Error Status Reg, Root Error ID Reg,
 	 * and Root error producer/consumer index
@@ -343,7 +343,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	u32 reg32;
 	int pos;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	pos = dev->aer_cap;
 
 	/* Disable Root's interrupt in response to error messages */
 	pci_read_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, &reg32);
@@ -396,7 +396,7 @@ static void aer_error_resume(struct pci_dev *dev)
 	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, reg16);
 
 	/* Clean AER Root Error Status */
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	pos = dev->aer_cap;
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &mask);
 	if (dev->error_state == pci_channel_io_normal)
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 521e39c..d9175ef 100644
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
 
@@ -102,6 +102,12 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 	return 0;
 }
 
+int pci_aer_init(struct pci_dev *dev)
+{
+	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	return pci_cleanup_aer_error_status_regs(dev);
+}
+
 /**
  * add_error_device - list device to be handled
  * @e_info: pointer to error info
@@ -158,7 +164,7 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
 	if (!(reg16 & PCI_EXP_AER_FLAGS))
 		return false;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	pos = dev->aer_cap;
 	if (!pos)
 		return false;
 
@@ -555,7 +561,7 @@ static void handle_error_source(struct pcie_device *aerdev,
 		 * Correctable error does not need software intervention.
 		 * No need to go through error recovery process.
 		 */
-		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+		pos = dev->aer_cap;
 		if (pos)
 			pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS,
 					info->status);
@@ -647,7 +653,7 @@ static int get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 	info->status = 0;
 	info->tlp_header_valid = 0;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	pos = dev->aer_cap;
 
 	/* The device might not support AER */
 	if (!pos)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 93f280d..1575724 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1666,7 +1666,8 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	/* Enable ACS P2P upstream forwarding */
 	pci_enable_acs(dev);
 
-	pci_cleanup_aer_error_status_regs(dev);
+	/* Advanced Error Reporting */
+	pci_aer_init(dev);
 }
 
 /*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7a320ca..306e5c6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -268,6 +268,9 @@ struct pci_dev {
 	unsigned int	class;		/* 3 bytes: (base,sub,prog-if) */
 	u8		revision;	/* PCI revision, low byte of class word */
 	u8		hdr_type;	/* PCI header type (`multi' flag masked out) */
+#ifdef CONFIG_PCIEAER
+	u16		aer_cap;	/* AER capability offset */
+#endif
 	u8		pcie_cap;	/* PCIe capability offset */
 	u8		msi_cap;	/* MSI capability offset */
 	u8		msix_cap;	/* MSI-X capability offset */
@@ -1390,9 +1393,11 @@ static inline bool pcie_aspm_support_enabled(void) { return false; }
 #ifdef CONFIG_PCIEAER
 void pci_no_aer(void);
 bool pci_aer_available(void);
+int pci_aer_init(struct pci_dev *dev);
 #else
 static inline void pci_no_aer(void) { }
 static inline bool pci_aer_available(void) { return false; }
+static inline int pci_aer_init(struct pci_dev *d) { return -ENODEV; }
 #endif
 
 #ifdef CONFIG_PCIE_ECRC
-- 
2.7.2

