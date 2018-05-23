Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: ryan@finnie.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, stable@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2] PCI/portdrv: do not disable device on reboot/shutdown
Date: Tue, 22 May 2018 22:44:46 -0400
Message-Id: <1527043490-17268-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

'Commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during
shutdown")' has been added to kernel to shutdown pending PCIe port
service interrupts during reboot so that a newly started kexec kernel
wouldn't observe pending interrupts.

pcie_port_device_remove() is disabling the root port and switches by
calling pci_disable_device() after all PCIe service drivers are shutdown.

pci_disable_device() has a much wider impact then port service itself and
it prevents all inbound transactions to reach to the system and impacts
the entire PCI traffic behind the bridge.

Issue is that pcie_port_device_remove() doesn't maintain any coordination
with the rest of the PCI device drivers in the system before clearing the
bus master bit.

This has been found to cause crashes on HP DL360 Gen9 machines during
reboot. Besides, kexec is already clearing the bus master bit in
pci_device_shutdown() after all PCI drivers are removed.

Just remove the extra clear in shutdown path by seperating the remove and
shutdown APIs in the PORTDRV.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=199779
Fixes: cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during shutdown")
Cc: stable@vger.kernel.org
Reported-by: Ryan Finnie <ryan@finnie.org>
---
 drivers/pci/pcie/portdrv.h      |  2 +-
 drivers/pci/pcie/portdrv_core.c |  5 +++--
 drivers/pci/pcie/portdrv_pci.c  | 16 +++++++++++++---
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index d0c6783..f6e88fe 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -86,7 +86,7 @@ int pcie_port_device_register(struct pci_dev *dev);
 int pcie_port_device_suspend(struct device *dev);
 int pcie_port_device_resume(struct device *dev);
 #endif
-void pcie_port_device_remove(struct pci_dev *dev);
+void pcie_port_device_remove(struct pci_dev *dev, bool disable);
 int __must_check pcie_port_bus_register(void);
 void pcie_port_bus_unregister(void);
 
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index c9c0663..f35341e 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -405,11 +405,12 @@ static int remove_iter(struct device *dev, void *data)
  * Remove PCI Express port service devices associated with given port and
  * disable MSI-X or MSI for the port.
  */
-void pcie_port_device_remove(struct pci_dev *dev)
+void pcie_port_device_remove(struct pci_dev *dev, bool disable)
 {
 	device_for_each_child(&dev->dev, NULL, remove_iter);
 	pci_free_irq_vectors(dev);
-	pci_disable_device(dev);
+	if (disable)
+		pci_disable_device(dev);
 }
 
 /**
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 973f1b8..29afaf3 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -137,7 +137,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	return 0;
 }
 
-static void pcie_portdrv_remove(struct pci_dev *dev)
+static void __pcie_portdrv_remove(struct pci_dev *dev, bool disable)
 {
 	if (pci_bridge_d3_possible(dev)) {
 		pm_runtime_forbid(&dev->dev);
@@ -145,7 +145,17 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
 		pm_runtime_dont_use_autosuspend(&dev->dev);
 	}
 
-	pcie_port_device_remove(dev);
+	pcie_port_device_remove(dev, disable);
+}
+
+static void pcie_portdrv_remove(struct pci_dev *dev)
+{
+	return __pcie_portdrv_remove(dev, true);
+}
+
+static void pcie_portdrv_shutdown(struct pci_dev *dev)
+{
+	return __pcie_portdrv_remove(dev, false);
 }
 
 static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
@@ -218,7 +228,7 @@ static struct pci_driver pcie_portdriver = {
 
 	.probe		= pcie_portdrv_probe,
 	.remove		= pcie_portdrv_remove,
-	.shutdown	= pcie_portdrv_remove,
+	.shutdown	= pcie_portdrv_shutdown,
 
 	.err_handler	= &pcie_portdrv_err_handler,
 
-- 
2.7.4
