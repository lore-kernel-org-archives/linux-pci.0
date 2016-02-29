Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:60693 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828AbcB2M4M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 29 Feb 2016 07:56:12 -0500
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 4/6] PCI: Add runtime PM support for PCIe ports
Date: Mon, 29 Feb 2016 14:56:04 +0200
Message-Id: <1456750566-116248-5-git-send-email-mika.westerberg@linux.intel.com>
In-Reply-To: <1456750566-116248-1-git-send-email-mika.westerberg@linux.intel.com>
References: <1456750566-116248-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add back runtime PM support for PCIe ports that was removed in
commit fe9a743a2601 ("PCI/PM: Drop unused runtime PM support code for PCIe
ports").

First of all we cannot enable it automatically for all root ports since
there have been problems previously, so we enable it only based on per port
configuration (runtime_suspend_allowed). Furthermore we need to check that
the device, if wake capable, can do so from D3cold (which is the state it
goes after the root port is powered down). This follows what we did for
PCIe port system suspend already.

Runtime PM is still blocked and needs to be unblocked from userspace like
with other PCI devices.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pcie/portdrv_pci.c | 49 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index fe3349685141..eb0f425f51cc 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -85,6 +85,7 @@ enum pcie_port_type {
 
 struct pcie_port_config {
 	bool suspend_allowed;
+	bool runtime_suspend_allowed;
 };
 
 static const struct pcie_port_config pcie_port_configs[] = {
@@ -154,6 +155,11 @@ static bool pcie_port_suspend_allowed(struct pci_dev *pdev)
 	return pcie_port_can_suspend(pdev);
 }
 
+static bool pcie_port_runtime_suspend_allowed(struct pci_dev *pdev)
+{
+	return pcie_port_get_config(pdev)->runtime_suspend_allowed;
+}
+
 static int pcie_port_suspend_noirq(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -188,6 +194,34 @@ static int pcie_port_resume_noirq(struct device *dev)
 	return 0;
 }
 
+static int pcie_port_runtime_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	/*
+	 * All devices behind the port are assumed to be in D3cold so
+	 * update their state now.
+	 */
+	__pci_bus_set_current_state(pdev->subordinate, PCI_D3cold);
+	return 0;
+}
+
+static int pcie_port_runtime_resume(struct device *dev)
+{
+	return 0;
+}
+
+static int pcie_port_runtime_idle(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (pcie_port_can_suspend(pdev)) {
+		pm_schedule_suspend(dev, 10);
+		return 0;
+	}
+	return -EBUSY;
+}
+
 static const struct dev_pm_ops pcie_portdrv_pm_ops = {
 	.suspend	= pcie_port_device_suspend,
 	.resume		= pcie_port_device_resume,
@@ -197,12 +231,20 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
 	.restore	= pcie_port_device_resume,
 	.suspend_noirq	= pcie_port_suspend_noirq,
 	.resume_noirq	= pcie_port_resume_noirq,
+	.runtime_suspend = pcie_port_runtime_suspend,
+	.runtime_resume	= pcie_port_runtime_resume,
+	.runtime_idle	= pcie_port_runtime_idle,
 };
 
 #define PCIE_PORTDRV_PM_OPS	(&pcie_portdrv_pm_ops)
 
 #else /* !PM */
 
+static inline bool pcie_port_runtime_suspend_allowed(struct pci_dev *pdev)
+{
+	return false;
+}
+
 #define PCIE_PORTDRV_PM_OPS	NULL
 #endif /* !PM */
 
@@ -230,11 +272,18 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 		return status;
 
 	pci_save_state(dev);
+
+	if (pcie_port_runtime_suspend_allowed(dev))
+		pm_runtime_put_noidle(&dev->dev);
+
 	return 0;
 }
 
 static void pcie_portdrv_remove(struct pci_dev *dev)
 {
+	if (pcie_port_runtime_suspend_allowed(dev))
+		pm_runtime_get_noresume(&dev->dev);
+
 	pcie_port_device_remove(dev);
 }
 
-- 
2.7.0

