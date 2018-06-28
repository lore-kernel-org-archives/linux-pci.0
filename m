Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org
Subject: [PATCH V3 2/6] PCI: Hide pci_reset_bridge_secondary_bus() from drivers
Date: Thu, 28 Jun 2018 14:28:22 -0400
Message-Id: <1530210507-9287-2-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1530210507-9287-1-git-send-email-okaya@codeaurora.org>
References: <1530210507-9287-1-git-send-email-okaya@codeaurora.org>
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Markus Elfring <elfring@users.sourceforge.net>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Rename pci_reset_bridge_secondary_bus() to pci_bridge_secondary_bus_reset()
and move the declartation from linux/pci.h to drivers/pci.h to be used
internally in PCI directory only.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/hotplug/pciehp_hpc.c |  2 +-
 drivers/pci/pci.c                | 11 +++++------
 drivers/pci/pci.h                |  1 +
 drivers/pci/pcie/aer.c           |  2 +-
 drivers/pci/pcie/err.c           |  2 +-
 include/linux/pci.h              |  1 -
 6 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index bbaa211..8dae232 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -746,7 +746,7 @@ int pciehp_reset_slot(struct slot *slot, int probe)
 	if (pciehp_poll_mode)
 		del_timer_sync(&ctrl->poll_timer);
 
-	rc = pci_reset_bridge_secondary_bus(ctrl->pcie->port);
+	rc = pci_bridge_secondary_bus_reset(ctrl->pcie->port);
 
 	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, stat_mask);
 	pcie_write_cmd_nowait(ctrl, ctrl_mask, ctrl_mask);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 98d1490..236220c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4224,19 +4224,18 @@ void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
 }
 
 /**
- * pci_reset_bridge_secondary_bus - Reset the secondary bus on a PCI bridge.
+ * pci_bridge_secondary_bus_reset - Reset the secondary bus on a PCI bridge.
  * @dev: Bridge device
  *
  * Use the bridge control register to assert reset on the secondary bus.
  * Devices on the secondary bus are left in power-on state.
  */
-int pci_reset_bridge_secondary_bus(struct pci_dev *dev)
+int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
 {
 	pcibios_reset_secondary_bus(dev);
 
 	return pci_dev_wait(dev, "bus reset", PCIE_RESET_READY_POLL_MS);
 }
-EXPORT_SYMBOL_GPL(pci_reset_bridge_secondary_bus);
 
 static int pci_parent_bus_reset(struct pci_dev *dev, int probe)
 {
@@ -4253,7 +4252,7 @@ static int pci_parent_bus_reset(struct pci_dev *dev, int probe)
 	if (probe)
 		return 0;
 
-	return pci_reset_bridge_secondary_bus(dev->bus->self);
+	return pci_bridge_secondary_bus_reset(dev->bus->self);
 }
 
 static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, int probe)
@@ -4860,7 +4859,7 @@ static int pci_bus_reset(struct pci_bus *bus, int probe)
 
 	might_sleep();
 
-	ret = pci_reset_bridge_secondary_bus(bus->self);
+	ret = pci_bridge_secondary_bus_reset(bus->self);
 
 	pci_bus_unlock(bus);
 
@@ -4924,7 +4923,7 @@ int pci_try_reset_bus(struct pci_bus *bus)
 
 	if (pci_bus_trylock(bus)) {
 		might_sleep();
-		rc = pci_reset_bridge_secondary_bus(bus->self);
+		rc = pci_bridge_secondary_bus_reset(bus->self);
 		pci_bus_unlock(bus);
 	} else
 		rc = -EAGAIN;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c358e7a0..f784263 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -33,6 +33,7 @@ int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
 		  enum pci_mmap_api mmap_api);
 
 int pci_probe_reset_function(struct pci_dev *dev);
+int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 
 /**
  * struct pci_platform_pm_ops - Firmware PM callbacks
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f1d0f3e..74ea6ec 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1314,7 +1314,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
 	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
 
-	rc = pci_reset_bridge_secondary_bus(dev);
+	rc = pci_bridge_secondary_bus_reset(dev);
 	pci_printk(KERN_DEBUG, dev, "Root Port link has been reset\n");
 
 	/* Clear Root Error Status */
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 3a62a2e..a3a26f1 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -177,7 +177,7 @@ static pci_ers_result_t default_reset_link(struct pci_dev *dev)
 {
 	int rc;
 
-	rc = pci_reset_bridge_secondary_bus(dev);
+	rc = pci_bridge_secondary_bus_reset(dev);
 	pci_printk(KERN_DEBUG, dev, "downstream link has been reset\n");
 	return !rc ? PCI_ERS_RESULT_RECOVERED : PCI_ERS_RESULT_DISCONNECT;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 340029b..6b12ce2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1102,7 +1102,6 @@ int pci_reset_bus(struct pci_bus *bus);
 int pci_try_reset_bus(struct pci_bus *bus);
 void pci_reset_secondary_bus(struct pci_dev *dev);
 void pcibios_reset_secondary_bus(struct pci_dev *dev);
-int pci_reset_bridge_secondary_bus(struct pci_dev *dev);
 void pci_update_resource(struct pci_dev *dev, int resno);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
 int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resource_size_t add_size, resource_size_t align);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
