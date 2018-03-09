Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932468AbeCITAB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Mar 2018 14:00:01 -0500
Subject: [PATCH v2 02/13] PCI/PM: Move pcie_clear_root_pme_status() to core
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>,
        Frederick Lawler <fred@fredlawl.com>
Date: Fri, 09 Mar 2018 13:00:00 -0600
Message-ID: <152062200018.77693.9632596426168244205.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Move pcie_clear_root_pme_status() from the port driver to the PCI core so
it will be available even when the port driver isn't present.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci.c              |    9 +++++++++
 drivers/pci/pci.h              |    1 +
 drivers/pci/pcie/portdrv.h     |    2 --
 drivers/pci/pcie/portdrv_pci.c |    9 ---------
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f6a4dd10d9b0..120e3393fc35 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1683,6 +1683,15 @@ int pci_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
 }
 EXPORT_SYMBOL_GPL(pci_set_pcie_reset_state);
 
+/**
+ * pcie_clear_root_pme_status - Clear root port PME interrupt status.
+ * @dev: PCIe root port or event collector.
+ */
+void pcie_clear_root_pme_status(struct pci_dev *dev)
+{
+	pcie_capability_set_dword(dev, PCI_EXP_RTSTA, PCI_EXP_RTSTA_PME);
+}
+
 /**
  * pci_check_pme_status - Check if given device has generated PME.
  * @dev: Device to check.
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fcd81911b127..813ca2c895d8 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -71,6 +71,7 @@ void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
 void pci_power_up(struct pci_dev *dev);
 void pci_disable_enabled_device(struct pci_dev *dev);
 int pci_finish_runtime_suspend(struct pci_dev *dev);
+void pcie_clear_root_pme_status(struct pci_dev *dev);
 int __pci_pme_wakeup(struct pci_dev *dev, void *ign);
 void pci_pme_restore(struct pci_dev *dev);
 bool pci_dev_keep_suspended(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index d4009e35702c..7086086e45d0 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -93,8 +93,6 @@ void pcie_port_bus_unregister(void);
 
 struct pci_dev;
 
-void pcie_clear_root_pme_status(struct pci_dev *dev);
-
 #ifdef CONFIG_HOTPLUG_PCI_PCIE
 extern bool pciehp_msi_disabled;
 
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 977bd3cca2e5..d6f10a97d400 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -49,15 +49,6 @@ __setup("pcie_ports=", pcie_port_setup);
 
 /* global data */
 
-/**
- * pcie_clear_root_pme_status - Clear root port PME interrupt status.
- * @dev: PCIe root port or event collector.
- */
-void pcie_clear_root_pme_status(struct pci_dev *dev)
-{
-	pcie_capability_set_dword(dev, PCI_EXP_RTSTA, PCI_EXP_RTSTA_PME);
-}
-
 static int pcie_portdrv_restore_config(struct pci_dev *dev)
 {
 	int retval;
