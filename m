Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbeHFA6M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 5 Aug 2018 20:58:12 -0400
From: Sinan Kaya <okaya@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH v7 1/1] PCI: pciehp: Ignore link events when there is a fatal error pending
Date: Sun,  5 Aug 2018 15:51:36 -0700
Message-Id: <20180805225136.5800-2-okaya@kernel.org>
In-Reply-To: <20180805225136.5800-1-okaya@kernel.org>
References: <20180805225136.5800-1-okaya@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

AER/DPC reset is known as warm-resets. HP link recovery is known as
cold-reset via power-off and power-on command to the PCI slot.

In the middle of a warm-reset operation (AER/DPC), we are:

1. turning off the slow power. Slot power needs to be kept on in order
for recovery to succeed.

2. performing a cold reset causing Fatal Error recovery to fail.

If link goes down due to a DPC event, it should be recovered by DPC
status trigger. Injecting a cold reset in the middle can cause a HW
lockup as it is an undefined behavior.

Similarly, If link goes down due to an AER secondary bus reset issue,
it should be recovered by HW. Injecting a cold reset in the middle of a
secondary bus reset can cause a HW lockup as it is an undefined behavior.

1. HP ISR observes link down interrupt.
2. HP ISR checks that there is a fatal error pending, it doesn't touch
the link.
3. HP ISR waits until link recovery happens.
4. HP ISR calls the read vendor id function.
5. If all fails, try the cold-reset approach.

If fatal error is pending and a fatal error service such as DPC or AER
is running, it is the responsibility of the fatal error service to
recover the link.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 19 ++++++++++
 drivers/pci/pci.h                 |  2 ++
 drivers/pci/pcie/err.c            | 60 +++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index da7c72372ffc..ba8dd51a3f0f 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -222,9 +222,28 @@ void pciehp_handle_disable_request(struct slot *slot)
 void pciehp_handle_presence_or_link_change(struct slot *slot, u32 events)
 {
 	struct controller *ctrl = slot->ctrl;
+	struct pci_dev *pdev = ctrl->pcie->port;
 	bool link_active;
 	u8 present;
 
+	/* If a fatal error is pending, wait for AER or DPC to handle it. */
+	if (pcie_fatal_error_pending(pdev, PCI_ERR_UNC_SURPDN)) {
+		bool recovered;
+
+		recovered = pcie_wait_fatal_error_clear(pdev,
+						PCI_ERR_UNC_SURPDN);
+
+		/* If the fatal error is gone and the link is up, return */
+		if (recovered && pcie_wait_for_link(pdev, true)) {
+			ctrl_info(ctrl, "Slot(%s): Ignoring Link event due to successful fatal error recovery\n",
+				  slot_name(slot));
+			return;
+		}
+
+		ctrl_info(ctrl, "Slot(%s): Fatal error recovery failed for Link event, tryig hotplug reset\n",
+			  slot_name(slot));
+	}
+
 	/*
 	 * If the slot is on and presence or link has changed, turn it off.
 	 * Even if it's occupied again, we cannot assume the card is the same.
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c358e7a07f3f..2ebb05338368 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -356,6 +356,8 @@ void pci_enable_acs(struct pci_dev *dev);
 /* PCI error reporting and recovery */
 void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service);
 void pcie_do_nonfatal_recovery(struct pci_dev *dev);
+bool pcie_fatal_error_pending(struct pci_dev *pdev, u32 usrmask);
+bool pcie_wait_fatal_error_clear(struct pci_dev *pdev, u32 usrmask);
 
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 #ifdef CONFIG_PCIEASPM
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index f7ce0cb0b0b7..8ea012dbf063 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/aer.h>
+#include <linux/delay.h>
 #include "portdrv.h"
 #include "../pci.h"
 
@@ -386,3 +387,62 @@ void pcie_do_nonfatal_recovery(struct pci_dev *dev)
 	/* TODO: Should kernel panic here? */
 	pci_info(dev, "AER: Device recovery failed\n");
 }
+
+bool pcie_fatal_error_pending(struct pci_dev *pdev, u32 usrmask)
+{
+	u16 err_status = 0;
+	u32 status, mask, severity;
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
+	rc = pci_read_config_dword(pdev, pdev->aer_cap + PCI_ERR_UNCOR_SEVER,
+				   &severity);
+	if (rc)
+		return false;
+
+	status &= mask;
+	status &= ~usrmask;
+	status &= severity;
+
+	return !!status;
+}
+
+bool pcie_wait_fatal_error_clear(struct pci_dev *pdev, u32 usrmask)
+{
+	int timeout = 1000;
+	bool ret;
+
+	for (;;) {
+		ret = pcie_fatal_error_pending(pdev, usrmask);
+		if (ret == false)
+			return true;
+		if (timeout <= 0)
+			break;
+		msleep(20);
+		timeout -= 20;
+	}
+
+	return false;
+}
-- 
2.17.1
