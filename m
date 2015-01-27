Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:18418 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453AbbA0Iq6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jan 2015 03:46:58 -0500
From: Yijing Wang <wangyijing@huawei.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH] PCI: Add guard to avoid mapping a invalid msix base address
Date: Tue, 27 Jan 2015 16:44:13 +0800
Message-ID: <1422348253-13990-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Sometimes, a pci bridge device BAR was not assigned
properly. After we call pci_bus_assign_resources(), the
resource of the BAR would be reseted. So if we try to
enable msix for this device, it will map a invalid
resource as the msix base address, and a warning call trace
will report.

pci_bus_assign_resources()
	__pci_bus_assign_resources()
		pbus_assign_resources_sorted()
			__assign_resources_sorted()
				assign_requested_resources_sorted()
					pci_assign_resource() -->fail
					reset_resource()	-->res->start/end/flags = 0

pcie_port_device_register()
	init_service_irqs()
		pcie_port_enable_msix()
			...
				msix_capability_init()
					msix_map_region()
						phys_addr = pci_resource_start(dev, bir) + table_offset;
If BAR(index=bir) was not assign properly, pci_resource_start(dev, bir)
here would return 0, so phys_addr is a invalid physical
address of msix.

[   43.094087] ------------[ cut here ]------------
[   43.097418] WARNING: CPU: 1 PID: 1800 at arch/arm64/mm/ioremap.c:58 __ioremap_caller+0xd4/0xe8()
...
[   43.121694] CPU: 1 PID: 1800 Comm: insmod Tainted: G           O  3.16.0 #5
[   43.127374] Call trace:
[   43.128522] [<ffffffc0000891d4>] dump_backtrace+0x0/0x130
[   43.132637] [<ffffffc000089314>] show_stack+0x10/0x1c
[   43.136402] [<ffffffc0004db040>] dump_stack+0x74/0x94
[   43.140166] [<ffffffc0000986f8>] warn_slowpath_common+0x8c/0xb4
[   43.144804] [<ffffffc0000987e4>] warn_slowpath_null+0x14/0x20
[   43.149266] [<ffffffc000095474>] __ioremap_caller+0xd0/0xe8
[   43.153555] [<ffffffc000095498>] __ioremap+0xc/0x18
[   43.157145] [<ffffffc0002cc62c>] pci_enable_msix+0x238/0x44c
[   43.161521] [<ffffffc0002cc874>] pci_enable_msix_range+0x34/0x80
[   43.166243] [<ffffffc0002c946c>] pcie_port_device_register+0x104/0x480
[   43.171491] [<ffffffc0002c99f8>] pcie_portdrv_probe+0x38/0xa0
[   43.175952] [<ffffffc0002bd6c8>] pci_device_probe+0x78/0xd4
[   43.180238] [<ffffffc00030e68c>] really_probe+0x6c/0x22c
[   43.184265] [<ffffffc00030e8a8>] __device_attach+0x5c/0x6c
[   43.188466] [<ffffffc00030cb68>] bus_for_each_drv+0x50/0x94
[   43.192755] [<ffffffc00030e5fc>] device_attach+0x9c/0xc0
[   43.196780] [<ffffffc0002b4c54>] pci_bus_add_device+0x38/0x80
[   43.201243] [<ffffffc0002b5064>] pci_bus_add_devices+0x4c/0xd4
[   43.205791] [<ffffffc000093d70>] pci_common_init+0x274/0x378
[   43.210170] [<ffffffbff18e4b8c>] $x+0xb8c/0xc88 [pcie]
[   43.214024] [<ffffffc00031013c>] platform_drv_probe+0x20/0x58
[   43.218483] [<ffffffc00030e6e4>] really_probe+0xc4/0x22c
[   43.222510] [<ffffffc00030e958>] __driver_attach+0xa0/0xa8
[   43.226708] [<ffffffc00030cab0>] bus_for_each_dev+0x54/0x98
[   43.231000] [<ffffffc00030e234>] driver_attach+0x1c/0x28
[   43.235024] [<ffffffc00030deb0>] bus_add_driver+0x14c/0x204
[   43.239309] [<ffffffc00030f038>] driver_register+0x64/0x130
[   43.243598] [<ffffffc000310110>] __platform_driver_register+0x5c/0x68
[   43.248757] [<ffffffc0003101b4>] platform_driver_probe+0x28/0xac
[   43.253485] [<ffffffbff18e4cb8>] pv660_pcie_init+0x30/0x3c [pcie]
[   43.258293] [<ffffffc0000815dc>] do_one_initcall+0x88/0x19c
[   43.262585] [<ffffffc0000f6b74>] load_module+0xc2c/0xf2c
[   43.266609] [<ffffffc0000f6fd0>] SyS_finit_module+0x78/0x88
[   43.270897] ---[ end trace ea5eb60837afb5aa ]---

Reported-by: Zhang Jukuo<zhangjukuo@huawei.com>
Tested-by: Zhang Jukuo<zhangjukuo@huawei.com>
Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/msi.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index fd60806..cd401a2 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -699,6 +699,9 @@ static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
 	pci_read_config_dword(dev, dev->msix_cap + PCI_MSIX_TABLE,
 			      &table_offset);
 	bir = (u8)(table_offset & PCI_MSIX_TABLE_BIR);
+	if (!pci_resource_flags(dev, bir))
+		return NULL;
+
 	table_offset &= PCI_MSIX_TABLE_OFFSET;
 	phys_addr = pci_resource_start(dev, bir) + table_offset;
 
-- 
1.7.1

