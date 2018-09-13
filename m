Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v2 06/10] PCI: portdrv: Add runtime PM hooks for port service drivers
Date: Thu, 13 Sep 2018 17:33:18 +0300
Message-Id: <20180913143322.77953-7-mika.westerberg@linux.intel.com>
In-Reply-To: <20180913143322.77953-1-mika.westerberg@linux.intel.com>
References: <20180913143322.77953-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When PCIe port is runtime suspended/resumed some extra steps might be
needed to be executed from the port service driver side. For instance we
may need to disable PCIe hotplug interrupt to prevent it from triggering
immediately when PCIe link to the downstream component goes down.

To make the above possible add optional ->runtime_suspend() and
->runtime_resume() callbacks to struct pcie_port_service_driver and call
them for each port service in runtime suspend/resume callbacks of portdrv.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pcie/portdrv.h      |  4 ++++
 drivers/pci/pcie/portdrv_core.c | 20 ++++++++++++++++++++
 drivers/pci/pcie/portdrv_pci.c  | 10 ++++------
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index d59afa42fc14..72fa132060e5 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -52,6 +52,8 @@ struct pcie_port_service_driver {
 	int (*suspend) (struct pcie_device *dev);
 	int (*resume_noirq) (struct pcie_device *dev);
 	int (*resume) (struct pcie_device *dev);
+	int (*runtime_suspend) (struct pcie_device *dev);
+	int (*runtime_resume) (struct pcie_device *dev);
 
 	/* Device driver may resume normal operations */
 	void (*error_resume)(struct pci_dev *dev);
@@ -85,6 +87,8 @@ int pcie_port_device_register(struct pci_dev *dev);
 int pcie_port_device_suspend(struct device *dev);
 int pcie_port_device_resume_noirq(struct device *dev);
 int pcie_port_device_resume(struct device *dev);
+int pcie_port_device_runtime_suspend(struct device *dev);
+int pcie_port_device_runtime_resume(struct device *dev);
 #endif
 void pcie_port_device_remove(struct pci_dev *dev);
 int __must_check pcie_port_bus_register(void);
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 7c37d815229e..6542c48c7f59 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -395,6 +395,26 @@ int pcie_port_device_resume(struct device *dev)
 	size_t off = offsetof(struct pcie_port_service_driver, resume);
 	return device_for_each_child(dev, &off, pm_iter);
 }
+
+/**
+ * pcie_port_device_runtime_suspend - runtime suspend port services
+ * @dev: PCI Express port to handle
+ */
+int pcie_port_device_runtime_suspend(struct device *dev)
+{
+	size_t off = offsetof(struct pcie_port_service_driver, runtime_suspend);
+	return device_for_each_child(dev, &off, pm_iter);
+}
+
+/**
+ * pcie_port_device_runtime_resume - runtime resume port services
+ * @dev: PCI Express port to handle
+ */
+int pcie_port_device_runtime_resume(struct device *dev)
+{
+	size_t off = offsetof(struct pcie_port_service_driver, runtime_resume);
+	return device_for_each_child(dev, &off, pm_iter);
+}
 #endif /* PM */
 
 static int remove_iter(struct device *dev, void *data)
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 629d5fe4c9b5..42d72cab3b1d 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -45,12 +45,10 @@ __setup("pcie_ports=", pcie_port_setup);
 #ifdef CONFIG_PM
 static int pcie_port_runtime_suspend(struct device *dev)
 {
-	return to_pci_dev(dev)->bridge_d3 ? 0 : -EBUSY;
-}
+	if (!to_pci_dev(dev)->bridge_d3)
+		return -EBUSY;
 
-static int pcie_port_runtime_resume(struct device *dev)
-{
-	return 0;
+	return pcie_port_device_runtime_suspend(dev);
 }
 
 static int pcie_port_runtime_idle(struct device *dev)
@@ -73,7 +71,7 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
 	.restore_noirq	= pcie_port_device_resume_noirq,
 	.restore	= pcie_port_device_resume,
 	.runtime_suspend = pcie_port_runtime_suspend,
-	.runtime_resume	= pcie_port_runtime_resume,
+	.runtime_resume	= pcie_port_device_runtime_resume,
 	.runtime_idle	= pcie_port_runtime_idle,
 };
 
-- 
2.18.0
