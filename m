Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <bhelgaas@google.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>,
        <jcm@redhat.com>, <toshi.kani@hpe.com>, <tanxiaojun@huawei.com>,
        <wangzhou1@hisilicon.com>, Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH v2 1/2] PCI ACPI: Avoid panic when PCI IO resource's size is not page aligned
Date: Sat, 31 Mar 2018 15:12:22 +0800
Message-ID: <1522480343-37669-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Zhou reported a bug on Hisilicon arm64 D06 platform with 64KB page size:

 [    2.470908] kernel BUG at lib/ioremap.c:72!
 [    2.475079] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
 [    2.480551] Modules linked in:
 [    2.483594] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc7-00062-g0b41260-dirty #23
 [    2.491756] Hardware name: Huawei D06/D06, BIOS Hisilicon D06 UEFI Nemo 2.0 RC0 - B120 03/23/2018
 [    2.500614] pstate: 80c00009 (Nzcv daif +PAN +UAO)
 [    2.505395] pc : ioremap_page_range+0x268/0x36c
 [    2.509912] lr : pci_remap_iospace+0xe4/0x100
 [...]
 [    2.603733] Call trace:
 [    2.606168]  ioremap_page_range+0x268/0x36c
 [    2.610337]  pci_remap_iospace+0xe4/0x100
 [    2.614334]  acpi_pci_probe_root_resources+0x1d4/0x214
 [    2.619460]  pci_acpi_root_prepare_resources+0x18/0xa8
 [    2.624585]  acpi_pci_root_create+0x98/0x214
 [    2.628843]  pci_acpi_scan_root+0x124/0x20c
 [    2.633013]  acpi_pci_root_add+0x224/0x494
 [    2.637096]  acpi_bus_attach+0xf8/0x200
 [    2.640918]  acpi_bus_attach+0x98/0x200
 [    2.644740]  acpi_bus_attach+0x98/0x200
 [    2.648562]  acpi_bus_scan+0x48/0x9c
 [    2.652125]  acpi_scan_init+0x104/0x268
 [    2.655948]  acpi_init+0x308/0x374
 [    2.659337]  do_one_initcall+0x48/0x14c
 [    2.663160]  kernel_init_freeable+0x19c/0x250
 [    2.667504]  kernel_init+0x10/0x100
 [    2.670979]  ret_from_fork+0x10/0x18

The cause is the size of PCI IO resource is 32KB, which is 4K aligned but
not 64KB aligned, however, ioremap_page_range() request the range as page
aligned or it will trigger a BUG_ON() on ioremap_pte_range() it calls, as
ioremap_pte_range increase the addr by PAGE_SIZE, which makes addr != end
until trigger BUG_ON, if its incoming end is not page aligned. More detail
trace is as following:

 ioremap_page_range
 -> ioremap_p4d_range
    -> ioremap_p4d_range
       -> ioremap_pud_range
          -> ioremap_pmd_range
             -> ioremap_pte_range

This patch fix the bug by align the size of PCI IO resource to PAGE_SIZE.

Reported-by: Zhou Wang <wangzhou1@hisilicon.com>
Tested-by: Xiaojun Tan <tanxiaojun@huawei.com>
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
I mark this as v2 for I have post a RFC version:

 https://lkml.org/lkml/2018/3/30/8
 
v2:
 * Let the caller of ioremap_page_range() align the request by PAGE_SIZE - per Toshi

Thanks
Yisheng

 drivers/acpi/pci_root.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 6fc204a..b758ca3 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -746,7 +746,7 @@ static void acpi_pci_root_remap_iospace(struct resource_entry *entry)
 		goto err;
 
 	res->start = port;
-	res->end = port + length - 1;
+	res->end = PAGE_ALIGN(port + length) - 1;
 	entry->offset = port - pci_addr;
 
 	if (pci_remap_iospace(res, cpu_addr) < 0)
-- 
1.7.12.4

