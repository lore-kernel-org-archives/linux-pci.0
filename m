Return-Path: <SRS0=iiy+=DB=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=iiy+=DB=huawei.com=liudongdong3@kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>, <rjw@sisk.pl>, <linux-pci@vger.kernel.org>
CC: <stable@vger.kernel.org>, <linuxarm@huawei.com>,
        Dongdong Liu
	<liudongdong3@huawei.com>
Subject: [PATCH V2 1/2] PCI/portdrv: Fix switch devctrl error report enable
Date: Tue, 5 Dec 2017 17:50:37 +0800
Message-ID: <1512467438-42850-2-git-send-email-liudongdong3@huawei.com>
In-Reply-To: <1512467438-42850-1-git-send-email-liudongdong3@huawei.com>
References: <1512467438-42850-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

Current code has a bug, switch upstream/downstream port error report
is disabled.
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-

We call aer_probe() for a root port, and it enables AER reporting for
the root port and any downstream devices:

aer_probe(root port)                        # only binds to root ports
  aer_enable_rootport
    set_downstream_devices_error_reporting(root, true)
      set_device_error_reporting(root, true)
        pci_enable_pcie_error_reporting
          pcie_capability_set_word(root, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS)
        pci_walk_bus(root->subordinate set_device_error_reporting, true)
          set_device_error_reporting(dev, true)
            pci_enable_pcie_error_reporting
              pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
PCI_EXP_AER_FLAGS)

We later call pcie_portdrv_probe() for every downstream bridge (it
matches PCI_CLASS_BRIDGE_PCI devices, then discards any non-PCIe
devices), and it *disables* AER reporting:

pcie_portdrv_probe(switch port)
  pcie_port_device_register
    get_port_device_capability
      pci_disable_pcie_error_reporting
        pcie_capability_clear_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS)

The result is that we first enable AER for the downstream switch
ports, then we disable it again.

It does not need to disable AER for upstream/downstream ports as
AER driver only binds to root ports.

Fixes: 2bd50dd800b5(PCI: PCIe: Disable PCIe port services during port
initialization)
Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
CC: stable@vger.kernel.org
---
 drivers/pci/pcie/portdrv_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index a592103..a0dff44 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -241,7 +241,9 @@ static int get_port_device_capability(struct pci_dev *dev)
 		 * Disable AER on this port in case it's been enabled by the
 		 * BIOS (the AER service driver will enable it when necessary).
 		 */
-		pci_disable_pcie_error_reporting(dev);
+		if ((pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
+		    (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM))
+			pci_disable_pcie_error_reporting(dev);
 	}
 	/* VC support */
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_VC))
-- 
1.9.1
