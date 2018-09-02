Return-Path: <SRS0=2elN=LQ=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=2elN=LQ=intel.com=jonathan.derrick@kernel.org>
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
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH] PCI/AER: Fix an AER enabling/disabling race
Date: Sat,  1 Sep 2018 19:06:52 -0600
Message-Id: <1535850412-3085-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

There is a sequence with non-ACPI root ports where the AER driver can
enable error reporting on the tree before port drivers have bound to
ports on the tree. The port driver assumes the AER driver will set up
error reporting afterwards, so instead add a check if error reporting
was set up first.

Example:
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
 drivers/pci/pcie/aer.c          | 1 +
 drivers/pci/pcie/portdrv_core.c | 5 ++++-
 include/linux/pci.h             | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 83180ed..a4e36b6 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1333,6 +1333,7 @@ static int set_device_error_reporting(struct pci_dev *dev, void *data)
 	if (enable)
 		pcie_set_ecrc_checking(dev);
 
+	dev->aer_configured = 1;
 	return 0;
 }
 
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 7c37d81..f5de554 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -224,8 +224,11 @@ static int get_port_device_capability(struct pci_dev *dev)
 		/*
 		 * Disable AER on this port in case it's been enabled by the
 		 * BIOS (the AER service driver will enable it when necessary).
+		 * Don't disable it if the AER service driver has already
+		 * enabled it from the root port bus walking
 		 */
-		pci_disable_pcie_error_reporting(dev);
+		if (!dev->aer_configured)
+			pci_disable_pcie_error_reporting(dev);
 	}
 #endif
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e72ca8d..c071622 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -402,6 +402,7 @@ struct pci_dev {
 	unsigned int	has_secondary_link:1;
 	unsigned int	non_compliant_bars:1;	/* Broken BARs; ignore them */
 	unsigned int	is_probed:1;		/* Device probing in progress */
+	unsigned int	aer_configured:1;	/* AER configured for device */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
-- 
1.8.3.1
