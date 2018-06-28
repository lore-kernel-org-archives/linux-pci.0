Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org
Subject: [PATCH V4 1/7] PCI: handle error return from
 pci_reset_bridge_secondary_bus()
Date: Thu, 28 Jun 2018 15:30:59 -0400
Message-Id: <1530214274-21139-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, Oza Pawandeep <poza@codeaurora.org>,
 Kees Cook <keescook@chromium.org>, Frederick Lawler <fred@fredlawl.com>,
 linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
 Sinan Kaya <okaya@codeaurora.org>, Lukas Wunner <lukas@wunner.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

commit 01fd61c0b9bd ("PCI: Add a return type for
pci_reset_bridge_secondary_bus()") added a return value to the function to
return if a device is accessible following a reset. Callers are not
checking the value.

Pass error code up high in the stack if device is not accessible.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/hotplug/pciehp_hpc.c |  5 +++--
 drivers/pci/pci.c                | 12 ++++++------
 drivers/pci/pcie/aer.c           |  5 +++--
 drivers/pci/pcie/err.c           |  6 ++++--
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 718b607..bbaa211 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -728,6 +728,7 @@ int pciehp_reset_slot(struct slot *slot, int probe)
 	struct controller *ctrl = slot->ctrl;
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 stat_mask = 0, ctrl_mask = 0;
+	int rc;
 
 	if (probe)
 		return 0;
@@ -745,7 +746,7 @@ int pciehp_reset_slot(struct slot *slot, int probe)
 	if (pciehp_poll_mode)
 		del_timer_sync(&ctrl->poll_timer);
 
-	pci_reset_bridge_secondary_bus(ctrl->pcie->port);
+	rc = pci_reset_bridge_secondary_bus(ctrl->pcie->port);
 
 	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, stat_mask);
 	pcie_write_cmd_nowait(ctrl, ctrl_mask, ctrl_mask);
@@ -753,7 +754,7 @@ int pciehp_reset_slot(struct slot *slot, int probe)
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, ctrl_mask);
 	if (pciehp_poll_mode)
 		int_poll_timeout(&ctrl->poll_timer);
-	return 0;
+	return rc;
 }
 
 int pcie_init_notification(struct controller *ctrl)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 97acba7..98d1490 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4253,9 +4253,7 @@ static int pci_parent_bus_reset(struct pci_dev *dev, int probe)
 	if (probe)
 		return 0;
 
-	pci_reset_bridge_secondary_bus(dev->bus->self);
-
-	return 0;
+	return pci_reset_bridge_secondary_bus(dev->bus->self);
 }
 
 static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, int probe)
@@ -4850,6 +4848,8 @@ EXPORT_SYMBOL_GPL(pci_try_reset_slot);
 
 static int pci_bus_reset(struct pci_bus *bus, int probe)
 {
+	int ret;
+
 	if (!bus->self || !pci_bus_resetable(bus))
 		return -ENOTTY;
 
@@ -4860,11 +4860,11 @@ static int pci_bus_reset(struct pci_bus *bus, int probe)
 
 	might_sleep();
 
-	pci_reset_bridge_secondary_bus(bus->self);
+	ret = pci_reset_bridge_secondary_bus(bus->self);
 
 	pci_bus_unlock(bus);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -4924,7 +4924,7 @@ int pci_try_reset_bus(struct pci_bus *bus)
 
 	if (pci_bus_trylock(bus)) {
 		might_sleep();
-		pci_reset_bridge_secondary_bus(bus->self);
+		rc = pci_reset_bridge_secondary_bus(bus->self);
 		pci_bus_unlock(bus);
 	} else
 		rc = -EAGAIN;
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e8838..f1d0f3e 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1305,6 +1305,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 {
 	u32 reg32;
 	int pos;
+	int rc;
 
 	pos = dev->aer_cap;
 
@@ -1313,7 +1314,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
 	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
 
-	pci_reset_bridge_secondary_bus(dev);
+	rc = pci_reset_bridge_secondary_bus(dev);
 	pci_printk(KERN_DEBUG, dev, "Root Port link has been reset\n");
 
 	/* Clear Root Error Status */
@@ -1325,7 +1326,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
 	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
 
-	return PCI_ERS_RESULT_RECOVERED;
+	return !rc ? PCI_ERS_RESULT_RECOVERED : PCI_ERS_RESULT_DISCONNECT;
 }
 
 /**
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index f7ce0cb..3a62a2e 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -175,9 +175,11 @@ static int report_resume(struct pci_dev *dev, void *data)
  */
 static pci_ers_result_t default_reset_link(struct pci_dev *dev)
 {
-	pci_reset_bridge_secondary_bus(dev);
+	int rc;
+
+	rc = pci_reset_bridge_secondary_bus(dev);
 	pci_printk(KERN_DEBUG, dev, "downstream link has been reset\n");
-	return PCI_ERS_RESULT_RECOVERED;
+	return !rc ? PCI_ERS_RESULT_RECOVERED : PCI_ERS_RESULT_DISCONNECT;
 }
 
 static pci_ers_result_t reset_link(struct pci_dev *dev, u32 service)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
