Return-Path: <mika.westerberg@linux.intel.com>
Return-Path: <mika.westerberg@linux.intel.com>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Valdis Kletnieks <valdis.kletnieks@vt.edu>,
	Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: pcie: Call pm_runtime_no_callbacks() after device is registered
Date: Mon, 23 May 2016 11:11:55 +0300
Message-Id: <1463991115-64820-1-git-send-email-mika.westerberg@linux.intel.com>
In-Reply-To: <14501.1463692755@turing-police.cc.vt.edu>
References: <14501.1463692755@turing-police.cc.vt.edu>
List-ID: <linux-pci.vger.kernel.org>

Commit 0195d2813547 ("PCI: Add runtime PM support for PCIe ports") added
call to pm_runtime_no_callbacks() for each port service device to prevent
them exposing unnecessary runtime PM sysfs files. However, that function
tries to acquire dev->power.lock which is not yet initialized.

This triggers following splat:

 BUG: spinlock bad magic on CPU#0, swapper/0/1
  lock: 0xffff8801be2aa8e8, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
 CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.6.0+ #820
  0000000000000000 ffff8801beb97be0 ffffffff812cf42d 0000000000000000
  ffff8801be2aa8e8 ffff8801beb97c00 ffffffff8109ee58 ffff8801be2aa8e8
  ffff8801be2aa8e8 ffff8801beb97c30 ffffffff8109efd9 ffff8801be2aa8e8
 Call Trace:
  [<ffffffff812cf42d>] dump_stack+0x4f/0x72
  [<ffffffff8109ee58>] spin_dump+0x78/0xc0
  [<ffffffff8109efd9>] do_raw_spin_lock+0xf9/0x150
  [<ffffffff81674e10>] _raw_spin_lock_irq+0x20/0x30
  [<ffffffff813d738e>] pm_runtime_no_callbacks+0x1e/0x40
  [<ffffffff81322cad>] pcie_port_device_register+0x1fd/0x4e0
  [<ffffffff813232f8>] pcie_portdrv_probe+0x38/0xa0
  [<ffffffff81314fb5>] local_pci_probe+0x45/0xa0
  [<ffffffff81315fe0>] ? pci_match_device+0xe0/0x110
  [<ffffffff813163ab>] pci_device_probe+0xdb/0x130
  [<ffffffff813ccefc>] driver_probe_device+0x22c/0x440
  [<ffffffff813cd1e1>] __driver_attach+0xd1/0xf0
  [<ffffffff813cd110>] ? driver_probe_device+0x440/0x440
  [<ffffffff813caab4>] bus_for_each_dev+0x64/0xa0
  [<ffffffff813cc60e>] driver_attach+0x1e/0x20
  [<ffffffff813cc0cb>] bus_add_driver+0x1eb/0x280
  [<ffffffff81d36cdc>] ? pcie_port_setup+0x7c/0x7c
  [<ffffffff813cdb90>] driver_register+0x60/0xe0
  [<ffffffff813148e0>] __pci_register_driver+0x60/0x70
  [<ffffffff81d36d3f>] pcie_portdrv_init+0x63/0x75
  [<ffffffff810003db>] do_one_initcall+0xab/0x1c0
  [<ffffffff81cff083>] kernel_init_freeable+0x153/0x1d9
  [<ffffffff8166dfce>] kernel_init+0xe/0x100
  [<ffffffff81675612>] ret_from_fork+0x22/0x40
  [<ffffffff8166dfc0>] ? rest_init+0x90/0x90

Fix this by calling pm_runtime_no_callbacks() after device_register() just
like other buses, like I2C is doing already.

Reported-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Tested-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pcie/portdrv_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 65b1a624826b..97927dfbbf5f 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -344,7 +344,6 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
 		     get_descriptor_id(pci_pcie_type(pdev), service));
 	device->parent = &pdev->dev;
 	device_enable_async_suspend(device);
-	pm_runtime_no_callbacks(device);
 
 	retval = device_register(device);
 	if (retval) {
@@ -352,6 +351,8 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
 		return retval;
 	}
 
+	pm_runtime_no_callbacks(device);
+
 	return 0;
 }
 
-- 
2.8.1
