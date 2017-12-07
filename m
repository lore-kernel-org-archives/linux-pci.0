Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58817 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750862AbdLGIAX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Dec 2017 03:00:23 -0500
From: Bandan Das <bsd@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH] x86/pci: Add a break condition when enabling BAR
Date: Thu, 07 Dec 2017 03:00:21 -0500
Message-ID: <jpga7yvotm2.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On an old flaky system with AMD Opteron 6320, boot hangs
with the following trace since commit fa564ad9:

[   28.181012] Hardware name: HP ProLiant DL385p Gen8, BIOS A28 09/03/2014
[   28.184022] RIP: 0010:lock_acquire+0xd5/0x1e0
[   28.185010] RSP: 0018:ffffb7ad818c39a8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff11
[   28.187010] RAX: ffffa074fb39b140 RBX: 0000000000000246 RCX: 0000000000000000
[   28.189014] RDX: ffffffffb20a55a9 RSI: 0000000000040009 RDI: 0000000000000246
[   28.191012] RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000000
[   28.193020] R10: 0000000000000001 R11: 00000000dac664b5 R12: 0000000000000000
[   28.196013] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
[   28.197011] FS:  0000000000000000(0000) GS:ffffa074fbd00000(0000) knlGS:0000000000000000
[   28.201014] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   28.201014] CR2: 0000000000000000 CR3: 00000003b6e10000 CR4: 00000000000406e0
[   28.205008] Call Trace:
[   28.205013]  ? request_resource_conflict+0x19/0x40
[   28.207013]  _raw_write_lock+0x2e/0x40
[   28.209008]  ? request_resource_conflict+0x19/0x40
[   28.209010]  request_resource_conflict+0x19/0x40
[   28.212013]  pci_amd_enable_64bit_bar+0x103/0x1a0
[   28.213025]  pci_fixup_device+0xd4/0x210
[   28.213025]  pci_setup_device+0x193/0x570
[   28.215010]  ? get_device+0x13/0x20
[   28.217008]  pci_scan_single_device+0x98/0xd0
[   28.217011]  pci_scan_slot+0x90/0x130
[   28.219010]  pci_scanild_bus_extend+0x3a/0x270
[   28.321008]  acpi_pci_root_create+0x1a9/0x210
[   28.321014]  ? pci_acpi_scan_root+0x135/0x1b0
[   28.324013]  pci_acpi_scan_root+0x15f/0x1b0
[   28.325008]  acpi_pci_root_add+0x283/0x560
[   28.325014]  ? acpi_match_device_ids+0xc/0x20
[   28.327013]  acpi_bus_attach+0xf9/0x1c0
[   28.329008]  acpi_bus_attach+0x82/0x1c0
[   28.329044]  acpi_bus_attach+0x82/0x1c0
[   28.331010]  acpi_bus_scan+0x47/0xa0
[   28.333008]  acpi_scan_init+0x12d/0x28d
[   28.333013]  ? bus_register+0x208/0x280
[   28.333013]  acpi_init+0x30f/0x36f
[   28.335010]  ? acpi_sleep_proc_init+0x24/0x24
[   28.337013]  do_one_initcall+0x4d/0x19c
[   28.337013]  ? do_early_param+0x29/0x86
[   28.340013]  kernel_init_freeable+0x209/0x2a4
[   28.341008]  ? set_debug_rodata+0x11/0x11
[   28.341011]  ? rest_init+0xc0/0xc0
[   28.343013]  kernel_init+0xa/0x104
[   28.345008]  ret_from_fork+0x24/0x30
[   28.345010] Code: 24 08 49 c1 e9 09 49 83 f1 01 41 83 e1 01 e8 73
e4 ff ff 65 48 8b 04 25 c0 d4 00 00 48 89 df c7 80 fc 0c 00 00 00 00
00 00 57 9d <0f> 1f 44 00 00 48 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f
c3 65

Since request_resource() will unconditionally return a conflict for invalid
regions, there will be no way to break out of the loop when enabling 64bit BAR.
Add checks and exit the loop in these cases without attempting to enable
BAR.

Signed-off-by: Bandan Das <bsd@redhat.com>
---
 arch/x86/pci/fixup.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 1e996df..8933a1b 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -696,8 +696,13 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 	res->end = 0xfd00000000ull - 1;
 
 	/* Just grab the free area behind system memory for this */
-	while ((conflict = request_resource_conflict(&iomem_resource, res)))
+	while ((conflict = request_resource_conflict(&iomem_resource, res))) {
+		if ((res->start > res->end) ||
+		    (res->start < iomem_resource.start) ||
+		    (res->end > iomem_resource.end))
+			break;
 		res->start = conflict->end + 1;
+	}
 
 	dev_info(&dev->dev, "adding root bus resource %pR\n", res);
 
-- 
2.9.4
