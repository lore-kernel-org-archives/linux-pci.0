Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60474 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932100AbeGBWxF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jul 2018 18:53:05 -0400
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V5 1/3] PCI: pciehp: implement mask and unmask interrupt functions
Date: Mon,  2 Jul 2018 18:52:45 -0400
Message-Id: <1530571967-19099-2-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adding pciehp_mask_irq() and pciehp_unmask_irq() to be called from struct
pcie_device as mask_irq() and unmask_irq() callbacks.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/hotplug/pciehp.h      |  2 ++
 drivers/pci/hotplug/pciehp_core.c | 19 +++++++++++++++++++
 drivers/pci/hotplug/pciehp_hpc.c  | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h        |  2 ++
 4 files changed, 62 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 5f89206..c579d03 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -138,6 +138,8 @@ int pciehp_check_link_status(struct controller *ctrl);
 bool pciehp_check_link_active(struct controller *ctrl);
 void pciehp_release_ctrl(struct controller *ctrl);
 int pciehp_reset_slot(struct slot *slot, int probe);
+void pciehp_mask_irq(struct slot *slot);
+void pciehp_unmask_irq(struct slot *slot);
 
 int pciehp_set_raw_indicator_status(struct hotplug_slot *h_slot, u8 status);
 int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 44a6a63..ca2faa1 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -299,6 +299,22 @@ static int pciehp_resume(struct pcie_device *dev)
 }
 #endif /* PM */
 
+static void pciehp_mask_int(struct pcie_device *dev)
+{
+	struct controller *ctrl = get_service_data(dev);
+	struct slot *slot = ctrl->slot;
+
+	pciehp_mask_irq(slot);
+}
+
+static void pciehp_unmask_int(struct pcie_device *dev)
+{
+	struct controller *ctrl = get_service_data(dev);
+	struct slot *slot = ctrl->slot;
+
+	pciehp_unmask_irq(slot);
+}
+
 static struct pcie_port_service_driver hpdriver_portdrv = {
 	.name		= PCIE_MODULE_NAME,
 	.port_type	= PCIE_ANY_PORT,
@@ -311,6 +327,9 @@ static struct pcie_port_service_driver hpdriver_portdrv = {
 	.suspend	= pciehp_suspend,
 	.resume		= pciehp_resume,
 #endif	/* PM */
+
+	.mask_irq	= pciehp_mask_int,
+	.unmask_irq	= pciehp_unmask_int,
 };
 
 static int __init pcied_init(void)
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 8dae232..d44e2c6 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -757,6 +757,45 @@ int pciehp_reset_slot(struct slot *slot, int probe)
 	return rc;
 }
 
+void pciehp_mask_irq(struct slot *slot)
+{
+	struct controller *ctrl = slot->ctrl;
+	u16 ctrl_mask = 0;
+
+	if (!ATTN_BUTTN(ctrl))
+		ctrl_mask |= PCI_EXP_SLTCTL_PDCE;
+
+	ctrl_mask |= PCI_EXP_SLTCTL_DLLSCE;
+
+	pcie_write_cmd(ctrl, 0, ctrl_mask);
+	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
+		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, 0);
+	if (pciehp_poll_mode)
+		del_timer_sync(&ctrl->poll_timer);
+}
+
+void pciehp_unmask_irq(struct slot *slot)
+{
+	struct controller *ctrl = slot->ctrl;
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+	u16 stat_mask = 0, ctrl_mask = 0;
+
+	if (!ATTN_BUTTN(ctrl)) {
+		ctrl_mask |= PCI_EXP_SLTCTL_PDCE;
+		stat_mask |= PCI_EXP_SLTSTA_PDC;
+	}
+	ctrl_mask |= PCI_EXP_SLTCTL_DLLSCE;
+	stat_mask |= PCI_EXP_SLTSTA_DLLSC;
+
+	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, stat_mask);
+	pcie_write_cmd_nowait(ctrl, ctrl_mask, ctrl_mask);
+	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
+		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, ctrl_mask);
+	if (pciehp_poll_mode)
+		int_poll_timeout(&ctrl->poll_timer);
+}
+
+
 int pcie_init_notification(struct controller *ctrl)
 {
 	if (pciehp_request_irq(ctrl))
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 6ffc797..40bb6f2 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -51,6 +51,8 @@ struct pcie_port_service_driver {
 	void (*remove) (struct pcie_device *dev);
 	int (*suspend) (struct pcie_device *dev);
 	int (*resume) (struct pcie_device *dev);
+	void (*mask_irq)(struct pcie_device *dev);
+	void (*unmask_irq)(struct pcie_device *dev);
 
 	/* Device driver may resume normal operations */
 	void (*error_resume)(struct pci_dev *dev);
-- 
2.7.4
