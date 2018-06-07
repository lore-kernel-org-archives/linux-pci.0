Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Oza Pawandeep <poza@codeaurora.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH NEXT 4/6] PCI/AER: Clear device status error bits during ERR_FATAL and ERR_NONFATAL
Date: Thu,  7 Jun 2018 02:00:32 -0400
Message-Id: <1528351234-26914-4-git-send-email-poza@codeaurora.org>
In-Reply-To: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
References: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We are handling ERR_FATAL by resetting the Link in software,skipping the
driver pci_error_handlers callbacks, removing the devices from the PCI
subsystem, and re-enumerating, the device status has to be cleared,
which fixes BUG existed before.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 8cbc62b..0d9eaba 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -341,12 +341,8 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
  */
 static void aer_error_resume(struct pci_dev *dev)
 {
-	u16 reg16;
-
 	/* Clean up Root device status */
-	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
-	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, reg16);
-
+	pci_cleanup_aer_error_device_status(dev);
 	/* Clean AER Root Error Status */
 	pci_cleanup_aer_uncorrect_error_status(dev);
 }
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 6745e37..95e9828 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -47,6 +47,17 @@ int pci_disable_pcie_error_reporting(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_disable_pcie_error_reporting);
 
+int pci_cleanup_aer_error_device_status(struct pci_dev *dev)
+{
+	u16 reg16;
+
+	/* Clean up Root device status */
+	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
+	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, reg16);
+
+	return 0;
+}
+
 int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
 {
 	int pos;
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 3998ed7..e1e642c 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -252,6 +252,7 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 			dev->error_state = state;
 		pci_walk_bus(dev->subordinate, cb, &result_data);
 		if (cb == report_resume) {
+			pci_cleanup_aer_error_device_status(dev);
 			pci_cleanup_aer_uncorrect_error_status(dev);
 			dev->error_state = pci_channel_io_normal;
 		}
@@ -312,6 +313,7 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
 		 * do error recovery on all subordinates of the bridge instead
 		 * of the bridge and clear the error status of the bridge.
 		 */
+		pci_cleanup_aer_error_device_status(dev);
 		pci_cleanup_aer_uncorrect_error_status(dev);
 	}
 
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 514bffa..165a147 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -44,6 +44,7 @@ struct aer_capability_regs {
 /* PCIe port driver needs this function to enable AER */
 int pci_enable_pcie_error_reporting(struct pci_dev *dev);
 int pci_disable_pcie_error_reporting(struct pci_dev *dev);
+int pci_cleanup_aer_error_device_status(struct pci_dev *dev);
 int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);
 int pci_cleanup_aer_error_status_regs(struct pci_dev *dev);
 #else
@@ -55,6 +56,10 @@ static inline int pci_disable_pcie_error_reporting(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+static inline int pci_cleanup_aer_error_device_status(struct pci_dev *dev)
+{
+	return -EINVAL;
+}
 static inline int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
 {
 	return -EINVAL;
-- 
2.7.4
