Return-Path: <SRS0=iiy+=DB=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=iiy+=DB=huawei.com=liudongdong3@kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>, <rjw@sisk.pl>, <linux-pci@vger.kernel.org>
CC: <stable@vger.kernel.org>, <linuxarm@huawei.com>,
        Dongdong Liu
	<liudongdong3@huawei.com>
Subject: [PATCH V2 2/2] PCI/AER: Fix AER device configuration
Date: Tue, 5 Dec 2017 17:50:38 +0800
Message-ID: <1512467438-42850-3-git-send-email-liudongdong3@huawei.com>
In-Reply-To: <1512467438-42850-1-git-send-email-liudongdong3@huawei.com>
References: <1512467438-42850-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

AER driver only binds to root ports. It binds to one device and it also
configures other downstream devices.  That opens the door to concurrency
issues and makes it really hard to ensure that hotplug works correctly.
The aer_probe() path should only touch the device it is binding, it
should not use pci_walk_bus().  If we need to configure another device,
that should be done in the enumeration path for *that device*.
We can use  _HPX to set PCI_EXP_DEVCTL to enable error report and ensure
that hotplug works correctly.  For more_HPX details information,
we can see ACPI 6.1 section 6.2.9 _HPX (Hot Plug Parameter Extensions).

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 drivers/pci/pcie/aer/aerdrv.c | 49 ++++---------------------------------------
 1 file changed, 4 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 6ff5f5b..cd63025 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -58,41 +58,6 @@ bool pci_aer_available(void)
 	return !pcie_aer_disable && pci_msi_enabled();
 }
 
-static int set_device_error_reporting(struct pci_dev *dev, void *data)
-{
-	bool enable = *((bool *)data);
-	int type = pci_pcie_type(dev);
-
-	if ((type == PCI_EXP_TYPE_ROOT_PORT) ||
-	    (type == PCI_EXP_TYPE_UPSTREAM) ||
-	    (type == PCI_EXP_TYPE_DOWNSTREAM)) {
-		if (enable)
-			pci_enable_pcie_error_reporting(dev);
-		else
-			pci_disable_pcie_error_reporting(dev);
-	}
-
-	if (enable)
-		pcie_set_ecrc_checking(dev);
-
-	return 0;
-}
-
-/**
- * set_downstream_devices_error_reporting - enable/disable the error reporting  bits on the root port and its downstream ports.
- * @dev: pointer to root port's pci_dev data structure
- * @enable: true = enable error reporting, false = disable error reporting.
- */
-static void set_downstream_devices_error_reporting(struct pci_dev *dev,
-						   bool enable)
-{
-	set_device_error_reporting(dev, &enable);
-
-	if (!dev->subordinate)
-		return;
-	pci_walk_bus(dev->subordinate, set_device_error_reporting, &enable);
-}
-
 /**
  * aer_enable_rootport - enable Root Port's interrupts when receiving messages
  * @rpc: pointer to a Root Port data structure
@@ -123,11 +88,8 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
 	pci_read_config_dword(pdev, aer_pos + PCI_ERR_UNCOR_STATUS, &reg32);
 	pci_write_config_dword(pdev, aer_pos + PCI_ERR_UNCOR_STATUS, reg32);
 
-	/*
-	 * Enable error reporting for the root port device and downstream port
-	 * devices.
-	 */
-	set_downstream_devices_error_reporting(pdev, true);
+	/* Enable error reporting for the root port device */
+	pci_enable_pcie_error_reporting(pdev);
 
 	/* Enable Root Port's interrupt in response to error messages */
 	pci_read_config_dword(pdev, aer_pos + PCI_ERR_ROOT_COMMAND, &reg32);
@@ -147,11 +109,8 @@ static void aer_disable_rootport(struct aer_rpc *rpc)
 	u32 reg32;
 	int pos;
 
-	/*
-	 * Disable error reporting for the root port device and downstream port
-	 * devices.
-	 */
-	set_downstream_devices_error_reporting(pdev, false);
+	/* Disable error reporting for the root port device */
+	pci_disable_pcie_error_reporting(pdev);
 
 	pos = pdev->aer_cap;
 	/* Disable Root's interrupt in response to error messages */
-- 
1.9.1
