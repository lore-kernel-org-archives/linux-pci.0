Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731739AbeG2Bco (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Jul 2018 21:32:44 -0400
From: Sinan Kaya <okaya@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Lukas Wunner <lukas@wunner.de>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v6 1/1] PCI: pciehp: Ignore link events when there is a fatal error pending
Date: Sat, 28 Jul 2018 02:13:24 -0700
Message-Id: <20180728091324.154795-2-okaya@kernel.org>
In-Reply-To: <20180728091324.154795-1-okaya@kernel.org>
References: <20180728091324.154795-1-okaya@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We need to figure out how to gracefully return inside hotplug driver
if link down happened and there is an error pending. Fatal error needs
to be serviced by AER/DPC drivers. Hotplug driver is observing link
events while AER/DPC drivers are performing link recovery today and
are causing confusion for the hotplug statemachine.

1. check if there is a fatal error pending in the device_status register
of the PCI Express capability on the root port.
2. bail out from hotplug routine if this is the case.
3. otherwise, existing behavior.

If fatal error is pending and a fatal error service such as DPC or AER
is running, it is the responsibility of the fatal error service to
recover the link.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/pci/hotplug/pciehp_hpc.c | 13 ++++++++----
 drivers/pci/pci.h                |  1 +
 drivers/pci/pcie/err.c           | 35 ++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 718b6073afad..776566ab7583 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -612,10 +612,15 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	 * and cause the wrong event to queue.
 	 */
 	if (events & PCI_EXP_SLTSTA_DLLSC) {
-		ctrl_info(ctrl, "Slot(%s): Link %s\n", slot_name(slot),
-			  link ? "Up" : "Down");
-		pciehp_queue_interrupt_event(slot, link ? INT_LINK_UP :
-					     INT_LINK_DOWN);
+		if (pci_fatal_error_pending(pdev, PCI_ERR_UNC_SURPDN))
+			ctrl_info(ctrl, "Slot(%s): Ignoring Link %s event due to detected Fatal Error\n",
+				  slot_name(slot), link ? "Up" : "Down");
+		else {
+			ctrl_info(ctrl, "Slot(%s): Link %s\n", slot_name(slot),
+				  link ? "Up" : "Down");
+			pciehp_queue_interrupt_event(slot, link ? INT_LINK_UP :
+						     INT_LINK_DOWN);
+		}
 	} else if (events & PCI_EXP_SLTSTA_PDC) {
 		present = !!(status & PCI_EXP_SLTSTA_PDS);
 		ctrl_info(ctrl, "Slot(%s): Card %spresent\n", slot_name(slot),
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 882f1f9596df..7494b2c0c5ff 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -360,6 +360,7 @@ void pci_enable_acs(struct pci_dev *dev);
 /* PCI error reporting and recovery */
 void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service);
 void pcie_do_nonfatal_recovery(struct pci_dev *dev);
+bool pci_fatal_error_pending(struct pci_dev *pdev, u32 usr_mask);
 
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 #ifdef CONFIG_PCIEASPM
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index f7ce0cb0b0b7..316b2d2750b9 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -386,3 +386,38 @@ void pcie_do_nonfatal_recovery(struct pci_dev *dev)
 	/* TODO: Should kernel panic here? */
 	pci_info(dev, "AER: Device recovery failed\n");
 }
+
+bool pci_fatal_error_pending(struct pci_dev *pdev, u32 usr_mask)
+{
+	u16 err_status = 0;
+	u32 status, mask;
+	int rc;
+
+	if (!pci_is_pcie(pdev))
+		return false;
+
+	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVSTA, &err_status);
+	if (rc)
+		return false;
+
+	if (!(err_status & PCI_EXP_DEVSTA_FED))
+		return false;
+
+	if (!pdev->aer_cap)
+		return false;
+
+	rc = pci_read_config_dword(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS,
+				   &status);
+	if (rc)
+		return false;
+
+	rc = pci_read_config_dword(pdev, pdev->aer_cap + PCI_ERR_UNCOR_MASK,
+				   &mask);
+	if (rc)
+		return false;
+
+	status &= mask;
+	status &= ~usr_mask;
+
+	return !!status;
+}
-- 
2.17.1
