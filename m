Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn3nam01on0080.outbound.protection.outlook.com ([104.47.33.80]:55283
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751402AbdAaUrS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Jan 2017 15:47:18 -0500
From: Jayachandran C <jnair@caviumnetworks.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jayachandran C <jnair@caviumnetworks.com>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH] PCI/ASPM: Skip parent link state check for PCI-to-PCIe bridges
Date: Tue, 31 Jan 2017 20:45:01 +0000
Message-ID: <1485895501-1780-1-git-send-email-jnair@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 51ebfc92b72b4f7dac1ab45683bf56741e454b8c ("PCI: Enumerate
switches below PCI-to-PCIe bridges") sets the has_secondary_link
value for device type PCI_EXP_TYPE_PCIE_BRIDGE. With this change
the function alloc_pcie_link_state() can be called with devices
of this type as well.

On Cavium ThunderX2, this causes a crash given below:
[    2.794915] pci_bus 0000:00: root bus resource [bus 00-ff]
[    2.801569] Unable to handle kernel NULL pointer dereference at virtual address 00000090
[    2.809749] pgd = ffff0000094d0000
[    2.813178] [00000090] *pgd=0000008ffbfe0003, *pud=0000008ffbfe0003, *pmd=0000008ffbfd0003, *pte=0
[    2.823556] Internal error: Oops: 96000005 [#1] SMP
[    2.828479] Modules linked in:
[    2.831558] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.10.0-rc6+ #56
[    2.838063] Hardware name: www.cavium.com Cavium CN99XX/CN99XX, BIOS 13:17:48 Jan 19 2017
[    2.846326] task: ffff808f46630e00 task.stack: ffff808f4031c000
[    2.852309] PC is at pcie_aspm_init_link_state+0x1cc/0x868
[    2.857848] LR is at pcie_aspm_init_link_state+0x180/0x868
[    2.863387] pc : [<ffff0000084fbf8c>] lr : [<ffff0000084fbf40>] pstate: 20400049
<...>
[    3.618537] [<ffff0000084fbf8c>] pcie_aspm_init_link_state+0x1cc/0x868
[    3.625133] [<ffff0000084e2ab4>] pci_scan_slot+0x10c/0x150
[    3.630672] [<ffff0000084e3c84>] pci_scan_child_bus+0x3c/0x1b0
[    3.636563] [<ffff0000084e38e4>] pci_scan_bridge+0x26c/0x5d0
[    3.642278] [<ffff0000084e3d04>] pci_scan_child_bus+0xbc/0x1b0
[    3.648169] [<ffff0000084e38e4>] pci_scan_bridge+0x26c/0x5d0
[    3.653884] [<ffff0000084e3d04>] pci_scan_child_bus+0xbc/0x1b0
[    3.659776] [<ffff00000853f720>] acpi_pci_root_create+0x18c/0x1f8
[    3.665934] [<ffff0000080972c4>] pci_acpi_scan_root+0x134/0x220
[    3.671912] [<ffff00000853f2b8>] acpi_pci_root_add+0x388/0x458
[    3.677804] [<ffff000008539d7c>] acpi_bus_attach+0xf4/0x1c4
[    3.683431] [<ffff000008539ddc>] acpi_bus_attach+0x154/0x1c4
[    3.689145] [<ffff000008539ddc>] acpi_bus_attach+0x154/0x1c4
[    3.694860] [<ffff000008539fc8>] acpi_bus_scan+0x80/0xac
[    3.700226] [<ffff000008dbd5ac>] acpi_scan_init+0xe8/0x248
[    3.705765] [<ffff000008dbd264>] acpi_init+0x2d4/0x344
[    3.710955] [<ffff00000808395c>] do_one_initcall+0x5c/0x168
[    3.716584] [<ffff000008d80dd0>] kernel_init_freeable+0x1ac/0x268
[    3.722742] [<ffff00000898d748>] kernel_init+0x18/0x110
[    3.728017] [<ffff0000080836b0>] ret_from_fork+0x10/0x20
[    3.733380] Code: 540001a0 f9400ac2 f9400842 f9401c42 (f9404842)

This is caused by dereference of pdev->bus->parent->self on a device
of type PCI_EXP_TYPE_PCIE_BRIDGE. Fix this by skipping the parent
link state check for device type PCI_EXP_TYPE_PCIE_BRIDGE as well.

Fixes: 51ebfc92b72b ("PCI: Enumerate switches below PCI-to-PCIe bridges")
Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
---
 drivers/pci/pcie/aspm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 17ac1dc..f631eeb 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -536,7 +536,8 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 	INIT_LIST_HEAD(&link->children);
 	INIT_LIST_HEAD(&link->link);
 	link->pdev = pdev;
-	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) {
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT &&
+	    pci_pcie_type(pdev) != PCI_EXP_TYPE_PCIE_BRIDGE) {
 		struct pcie_link_state *parent;
 		parent = pdev->bus->parent->self->link_state;
 		if (!parent) {
-- 
2.7.4

