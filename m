Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:6082 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758162AbcDHKg4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Apr 2016 06:36:56 -0400
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Qipeng Zha <qipeng.zha@intel.com>, Qi Zheng <qi.zheng@intel.com>,
	Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 4/4] PCI: Add runtime PM support for PCIe ports
Date: Fri,  8 Apr 2016 13:36:30 +0300
Message-Id: <1460111790-92836-5-git-send-email-mika.westerberg@linux.intel.com>
In-Reply-To: <1460111790-92836-1-git-send-email-mika.westerberg@linux.intel.com>
References: <1460111790-92836-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add back runtime PM support for PCIe ports that was removed in
commit fe9a743a2601 ("PCI/PM: Drop unused runtime PM support code for
PCIe ports").

First of all we cannot enable it automatically for all ports since there
has been problems previously as can be seen in [1]. In summary suspended
PCIe ports were not able to deal with hotplug reliably. One reason why this
might happen is the fact that when a PCIe port is powered down, config
space access to the devices behind the port is not possible. If the BIOS
hotplug SMI handler assumes the port is always in D0 it will not be able to
find the hotplugged devices. To be on the safe side only enable runtime PM
if the port does not claim to be hotplug capable.

Furthermore we need to check that the PCI core thinks the port can go to D3
in the first place. The PCI core sets 'bridge_d3' in that case. If both
conditions are met we enable and allow runtime PM for the PCIe port. Since
'bridge_d3' can be changed anytime we check this in driver ->runtime_idle()
and ->runtime_suspend() and only allow runtime suspend if the flag is still
set. The actual power transition to D3 and back is handled in the PCI core.

Idea to automatically unblock (allow) runtime PM for PCIe ports came from
Dave Airlie.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=53811

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pcie/portdrv_pci.c | 85 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 6c6bb03392ea..bbe86527788c 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -58,6 +58,10 @@ __setup("pcie_ports=", pcie_port_setup);
 
 /* global data */
 
+struct pcie_port_data {
+	bool runtime_pm_enabled;
+};
+
 /**
  * pcie_clear_root_pme_status - Clear root port PME interrupt status.
  * @dev: PCIe root port or event collector.
@@ -93,6 +97,58 @@ static int pcie_port_resume_noirq(struct device *dev)
 	return 0;
 }
 
+static int pcie_port_runtime_suspend(struct device *dev)
+{
+	return to_pci_dev(dev)->bridge_d3 ? 0 : -EBUSY;
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
+	/*
+	 * Rely the PCI core has set bridge_d3 whenever it thinks the port
+	 * should be good to go to D3. Everything else, including moving
+	 * the port to D3, is handled by the PCI core.
+	 */
+	if (pdev->bridge_d3) {
+		pm_schedule_suspend(dev, 10);
+		return 0;
+	}
+	return -EBUSY;
+}
+
+static bool pcie_port_runtime_pm_possible(struct pci_dev *pdev)
+{
+	/*
+	 * Only enable runtime PM if the PCI core agrees that this port can
+	 * even go to D3.
+	 */
+	if (!pdev->bridge_d3)
+		return false;
+
+	/*
+	 * Prevent runtime PM if the port is hotplug capable. Otherwise the
+	 * hotplug SMI code might not be able to enumerate devices behind
+	 * this port properly (the port is powered down preventing all
+	 * config space accesses to the subordinate devices).
+	 */
+	if (pcie_caps_reg(pdev) & PCI_EXP_FLAGS_SLOT) {
+		u32 sltcap;
+
+		pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &sltcap);
+		if (sltcap & (PCI_EXP_SLTCAP_HPC | PCI_EXP_SLTCAP_HPS))
+			return false;
+	}
+
+	return true;
+}
+
 static const struct dev_pm_ops pcie_portdrv_pm_ops = {
 	.suspend	= pcie_port_device_suspend,
 	.resume		= pcie_port_device_resume,
@@ -101,12 +157,20 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
 	.poweroff	= pcie_port_device_suspend,
 	.restore	= pcie_port_device_resume,
 	.resume_noirq	= pcie_port_resume_noirq,
+	.runtime_suspend = pcie_port_runtime_suspend,
+	.runtime_resume	= pcie_port_runtime_resume,
+	.runtime_idle	= pcie_port_runtime_idle,
 };
 
 #define PCIE_PORTDRV_PM_OPS	(&pcie_portdrv_pm_ops)
 
 #else /* !PM */
 
+static inline bool pcie_port_runtime_pm_possible(struct pci_dev *pdev)
+{
+	return false;
+}
+
 #define PCIE_PORTDRV_PM_OPS	NULL
 #endif /* !PM */
 
@@ -121,6 +185,7 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
 static int pcie_portdrv_probe(struct pci_dev *dev,
 					const struct pci_device_id *id)
 {
+	struct pcie_port_data *pdata;
 	int status;
 
 	if (!pci_is_pcie(dev) ||
@@ -134,11 +199,31 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 		return status;
 
 	pci_save_state(dev);
+
+	pdata = devm_kzalloc(&dev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	pci_set_drvdata(dev, pdata);
+	if (pcie_port_runtime_pm_possible(dev)) {
+		pm_runtime_put_noidle(&dev->dev);
+		pm_runtime_allow(&dev->dev);
+
+		pdata->runtime_pm_enabled = true;
+	}
+
 	return 0;
 }
 
 static void pcie_portdrv_remove(struct pci_dev *dev)
 {
+	const struct pcie_port_data *pdata = pci_get_drvdata(dev);
+
+	if (pdata->runtime_pm_enabled) {
+		pm_runtime_forbid(&dev->dev);
+		pm_runtime_get_noresume(&dev->dev);
+	}
+
 	pcie_port_device_remove(dev);
 }
 
-- 
2.8.0.rc3

