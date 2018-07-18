Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728912AbeGRUYP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Jul 2018 16:24:15 -0400
Subject: [PATCH v3 5/7] PCI/AER: Clear device status bits during ERR_FATAL
 and ERR_NONFATAL
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@kernel.org>,
        Timur Tabi <timur@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 18 Jul 2018 14:44:51 -0500
Message-ID: <153194309124.191586.12413426053649369470.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <153194245964.191586.14782253252654776509.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153194245964.191586.14782253252654776509.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Oza Pawandeep <poza@codeaurora.org>

Clear the device status bits while handling both ERR_FATAL and ERR_NONFATAL
cases.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
[bhelgaas: rename to pci_aer_clear_device_status(), declare internal to PCI
core instead of exposing it everywhere]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h      |    1 +
 drivers/pci/pcie/aer.c |   15 +++++++++------
 drivers/pci/pcie/err.c |    2 ++
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12fd2ac95843..fc4978df7caf 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -454,6 +454,7 @@ static inline int devm_of_pci_get_host_bridge_resources(struct device *dev,
 
 #ifdef CONFIG_PCIEAER
 void pci_aer_clear_fatal_status(struct pci_dev *dev);
+void pci_aer_clear_device_status(struct pci_dev *dev);
 #endif
 
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index b8972fe85043..dc67f52b002f 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -357,6 +357,14 @@ int pci_disable_pcie_error_reporting(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_disable_pcie_error_reporting);
 
+void pci_aer_clear_device_status(struct pci_dev *dev)
+{
+	u16 sta;
+
+	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
+	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
+}
+
 int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
 {
 	int pos;
@@ -1356,12 +1364,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
  */
 static void aer_error_resume(struct pci_dev *dev)
 {
-	u16 reg16;
-
-	/* Clean up Root device status */
-	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
-	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, reg16);
-
+	pci_aer_clear_device_status(dev);
 	pci_cleanup_aer_uncorrect_error_status(dev);
 }
 
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 638eda5c1d79..fdbcc555860d 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -252,6 +252,7 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 			dev->error_state = state;
 		pci_walk_bus(dev->subordinate, cb, &result_data);
 		if (cb == report_resume) {
+			pci_aer_clear_device_status(dev);
 			pci_cleanup_aer_uncorrect_error_status(dev);
 			dev->error_state = pci_channel_io_normal;
 		}
@@ -312,6 +313,7 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
 		 * of the bridge and clear the error status of the bridge.
 		 */
 		pci_aer_clear_fatal_status(dev);
+		pci_aer_clear_device_status(dev);
 	}
 
 	if (result == PCI_ERS_RESULT_RECOVERED) {
