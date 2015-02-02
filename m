Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:45059 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588AbbBBVGa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Feb 2015 16:06:30 -0500
Received: by mail-ob0-f175.google.com with SMTP id va2so7183005obc.6
        for <linux-pci@vger.kernel.org>; Mon, 02 Feb 2015 13:06:29 -0800 (PST)
Date: Mon, 2 Feb 2015 15:06:26 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, boris.ostrovsky@oracle.com,
	yinghai@kernel.org, xen-devel@lists.xenproject.org,
	konrad.wilk@oracle.com, david.vrabel@citrix.com,
	alex.williamson@redhat.com, kvm@vger.kernel.org,
	Jan Beulich <JBeulich@suse.com>
Subject: Re: [PATCH v3] PCI: Add guard to avoid mapping a invalid msix base
 address
Message-ID: <20150202210626.GC5176@google.com>
References: <1422503683-19709-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422503683-19709-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Jan]

On Thu, Jan 29, 2015 at 11:54:43AM +0800, Yijing Wang wrote:
> Sometimes, a pci bridge device BAR was not assigned
> properly. After we call pci_bus_assign_resources(), the
> resource of the BAR would be reseted. So if we try to
> enable msix for this device, it will map a invalid
> resource as the msix base address, and a warning call trace
> will report.
> 
> pci_bus_assign_resources()
> 	__pci_bus_assign_resources()
> 		pbus_assign_resources_sorted()
> 			__assign_resources_sorted()
> 				assign_requested_resources_sorted()
> 					pci_assign_resource() -->fail
> 					reset_resource()	-->res->start/end/flags = 0
> 
> pcie_port_device_register()
> 	init_service_irqs()
> 		pcie_port_enable_msix()
> 			...
> 				msix_capability_init()
> 					msix_map_region()
> 						phys_addr = pci_resource_start(dev, bir) + table_offset;
> If BAR(index=bir) was not assign properly, pci_resource_start(dev, bir)
> here would return 0, so phys_addr is a invalid physical
> address of msix.
> 
> [   43.094087] ------------[ cut here ]------------
> [   43.097418] WARNING: CPU: 1 PID: 1800 at arch/arm64/mm/ioremap.c:58 __ioremap_caller+0xd4/0xe8()
> ...
> [   43.121694] CPU: 1 PID: 1800 Comm: insmod Tainted: G           O  3.16.0 #5
> [   43.127374] Call trace:
> [   43.128522] [<ffffffc0000891d4>] dump_backtrace+0x0/0x130
> [   43.132637] [<ffffffc000089314>] show_stack+0x10/0x1c
> [   43.136402] [<ffffffc0004db040>] dump_stack+0x74/0x94
> [   43.140166] [<ffffffc0000986f8>] warn_slowpath_common+0x8c/0xb4
> [   43.144804] [<ffffffc0000987e4>] warn_slowpath_null+0x14/0x20
> [   43.149266] [<ffffffc000095474>] __ioremap_caller+0xd0/0xe8
> [   43.153555] [<ffffffc000095498>] __ioremap+0xc/0x18
> [   43.157145] [<ffffffc0002cc62c>] pci_enable_msix+0x238/0x44c
> [   43.161521] [<ffffffc0002cc874>] pci_enable_msix_range+0x34/0x80
> [   43.166243] [<ffffffc0002c946c>] pcie_port_device_register+0x104/0x480
> [   43.171491] [<ffffffc0002c99f8>] pcie_portdrv_probe+0x38/0xa0
> [   43.175952] [<ffffffc0002bd6c8>] pci_device_probe+0x78/0xd4
> [   43.180238] [<ffffffc00030e68c>] really_probe+0x6c/0x22c
> [   43.184265] [<ffffffc00030e8a8>] __device_attach+0x5c/0x6c
> [   43.188466] [<ffffffc00030cb68>] bus_for_each_drv+0x50/0x94
> [   43.192755] [<ffffffc00030e5fc>] device_attach+0x9c/0xc0
> [   43.196780] [<ffffffc0002b4c54>] pci_bus_add_device+0x38/0x80
> [   43.201243] [<ffffffc0002b5064>] pci_bus_add_devices+0x4c/0xd4
> [   43.205791] [<ffffffc000093d70>] pci_common_init+0x274/0x378
> [   43.210170] [<ffffffbff18e4b8c>] $x+0xb8c/0xc88 [pcie]
> [   43.214024] [<ffffffc00031013c>] platform_drv_probe+0x20/0x58
> [   43.218483] [<ffffffc00030e6e4>] really_probe+0xc4/0x22c
> [   43.222510] [<ffffffc00030e958>] __driver_attach+0xa0/0xa8
> [   43.226708] [<ffffffc00030cab0>] bus_for_each_dev+0x54/0x98
> [   43.231000] [<ffffffc00030e234>] driver_attach+0x1c/0x28
> [   43.235024] [<ffffffc00030deb0>] bus_add_driver+0x14c/0x204
> [   43.239309] [<ffffffc00030f038>] driver_register+0x64/0x130
> [   43.243598] [<ffffffc000310110>] __platform_driver_register+0x5c/0x68
> [   43.248757] [<ffffffc0003101b4>] platform_driver_probe+0x28/0xac
> [   43.253485] [<ffffffbff18e4cb8>] pcie_init+0x30/0x3c [pcie]
> [   43.258293] [<ffffffc0000815dc>] do_one_initcall+0x88/0x19c
> [   43.262585] [<ffffffc0000f6b74>] load_module+0xc2c/0xf2c
> [   43.266609] [<ffffffc0000f6fd0>] SyS_finit_module+0x78/0x88
> [   43.270897] ---[ end trace ea5eb60837afb5aa ]---
> 
> Reported-by: Zhang Jukuo <zhangjukuo@huawei.com>
> Tested-by: Zhang Jukuo <zhangjukuo@huawei.com>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

I applied this to pci/msi for v3.20, thanks!  I reworked the changelog as
follows; let me know if it still doesn't make things clear:


commit 6a878e5085fe97bd1e222b7883a1b815fcbbe4ed
Author: Yijing Wang <wangyijing@huawei.com>
Date:   Wed Jan 28 09:52:17 2015 +0800

    PCI: Fail MSI-X mappings if there's no space assigned to MSI-X BAR
    
    Unlike MSI, which is configured via registers in the MSI capability in
    Configuration Space, MSI-X is configured via tables in Memory Space.
    These MSI-X tables are mapped by a device BAR, and if no Memory Space
    has been assigned to the BAR, MSI-X cannot be used.
    
    Fail MSI-X setup if no space has been assigned for the BAR.
    
    Previously, we ioremapped the MSI-X table even if the resource hadn't been
    assigned.  In this case, the resource address is undefined (and is often
    zero), which may lead to warnings or oopses in this path:
    
      pci_enable_msix
        msix_capability_init
          msix_map_region
            ioremap_nocache
    
    The PCI core sets resource flags to zero when it can't assign space for the
    resource (see reset_resource()).  There are also some cases where it sets
    the IORESOURCE_UNSET flag, e.g., pci_reassigndev_resource_alignment(),
    pci_assign_resource(), etc.  So we must check for both cases.
    
    [bhelgaas: changelog]
    Reported-by: Zhang Jukuo <zhangjukuo@huawei.com>
    Tested-by: Zhang Jukuo <zhangjukuo@huawei.com>
    Signed-off-by: Yijing Wang <wangyijing@huawei.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index c489ef2c1a39..34fc4189ebf0 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -298,12 +298,16 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 			map_irq.entry_nr = nvec;
 		} else if (type == PCI_CAP_ID_MSIX) {
 			int pos;
+			unsigned long flags;
 			u32 table_offset, bir;
 
 			pos = dev->msix_cap;
 			pci_read_config_dword(dev, pos + PCI_MSIX_TABLE,
 					      &table_offset);
 			bir = (u8)(table_offset & PCI_MSIX_TABLE_BIR);
+			flags = pci_resource_flags(dev, bir);
+			if (!flags || (flags & IORESOURCE_UNSET))
+				return -EINVAL;
 
 			map_irq.table_base = pci_resource_start(dev, bir);
 			map_irq.entry_nr = msidesc->msi_attrib.entry_nr;
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index fd60806d3fd0..c3e7dfcf9ff5 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -694,11 +694,16 @@ static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
 {
 	resource_size_t phys_addr;
 	u32 table_offset;
+	unsigned long flags;
 	u8 bir;
 
 	pci_read_config_dword(dev, dev->msix_cap + PCI_MSIX_TABLE,
 			      &table_offset);
 	bir = (u8)(table_offset & PCI_MSIX_TABLE_BIR);
+	flags = pci_resource_flags(dev, bir);
+	if (!flags || (flags & IORESOURCE_UNSET))
+		return NULL;
+
 	table_offset &= PCI_MSIX_TABLE_OFFSET;
 	phys_addr = pci_resource_start(dev, bir) + table_offset;
 
