Return-Path: <SRS0=BKQN=LS=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=BKQN=LS=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: <linux-pci@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	Sinan Kaya <okaya@kernel.org>,
	Oza Pawandeep <poza@codeaurora.org>,
	Matthew Wilcox <willy@infradead.org>,
	Lukas Winner <lukas@wunner.de>,
	Christoph Hellwig <hch@lst.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH] PCI/portdrv: Enable error reporting on managed ports
Date: Tue,  4 Sep 2018 12:33:09 -0600
Message-Id: <1536085989-2956-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

During probe, the port driver will disable error reporting and assumes
it will be enabled later by the AER driver's pci_walk_bus() sequence.
This may not be the case for host-bridge enabled root ports, who will
enable first error reporting on the bus during the root port probe, and
then disable error reporting on downstream devices during subsequent
probing of the bus.

A hotplugged port device may also fail to enable error reporting as the
AER driver has already run on the root bus.

Check for these conditions and enable error reporting during portdrv
probing.

Example case:
[  343.790573] pcieport 10000:00:00.0: pci_disable_pcie_error_reporting
[  343.809812] pcieport 10000:00:00.0: pci_enable_pcie_error_reporting
[  343.819506] pci 10000:01:00.0: pci_enable_pcie_error_reporting
[  343.828814] pci 10000:02:00.0: pci_enable_pcie_error_reporting
[  343.838089] pci 10000:02:01.0: pci_enable_pcie_error_reporting
[  343.847478] pci 10000:02:02.0: pci_enable_pcie_error_reporting
[  343.856659] pci 10000:02:03.0: pci_enable_pcie_error_reporting
[  343.865794] pci 10000:02:04.0: pci_enable_pcie_error_reporting
[  343.874875] pci 10000:02:05.0: pci_enable_pcie_error_reporting
[  343.883918] pci 10000:02:06.0: pci_enable_pcie_error_reporting
[  343.892922] pci 10000:02:07.0: pci_enable_pcie_error_reporting
[  343.918900] pcieport 10000:01:00.0: pci_disable_pcie_error_reporting
[  343.968426] pcieport 10000:02:00.0: pci_disable_pcie_error_reporting
[  344.028179] pcieport 10000:02:01.0: pci_disable_pcie_error_reporting
[  344.091269] pcieport 10000:02:02.0: pci_disable_pcie_error_reporting
[  344.156473] pcieport 10000:02:03.0: pci_disable_pcie_error_reporting
[  344.238042] pcieport 10000:02:04.0: pci_disable_pcie_error_reporting
[  344.321864] pcieport 10000:02:05.0: pci_disable_pcie_error_reporting
[  344.411601] pcieport 10000:02:06.0: pci_disable_pcie_error_reporting
[  344.505332] pcieport 10000:02:07.0: pci_disable_pcie_error_reporting
[  344.621824] nvme 10000:06:00.0: pci_enable_pcie_error_reporting

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/pcie/portdrv_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 7c37d81..fdd953a 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -343,6 +343,16 @@ int pcie_port_device_register(struct pci_dev *dev)
 	if (!nr_service)
 		goto error_cleanup_irqs;
 
+#ifdef CONFIG_PCIEAER
+	/*
+	 * Enable error reporting for this port in case AER probing has already
+	 * run on the root bus or this port device is hot-inserted
+	 */
+	if (dev->aer_cap && pci_aer_available() &&
+	    (pcie_ports_native || pci_find_host_bridge(dev->bus)->native_aer))
+		pci_enable_pcie_error_reporting(dev);
+#endif
+
 	return 0;
 
 error_cleanup_irqs:
-- 
1.8.3.1
