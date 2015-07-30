Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:47085 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbbG3EQu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jul 2015 00:16:50 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>,
	<stable@vger.kernel.org.#3.4+>
Subject: [PATCH] PCI/ASPM: Don't remove pcie_link_state until we stop the last device
Date: Thu, 30 Jul 2015 12:09:20 +0800
Message-ID: <1438229360-370-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now we stop the pci_bus->devices in reverse order, but in
pcie_aspm_exit_link_state(), we only would do something when
the device is the last one.

void pcie_aspm_exit_link_state(struct pci_dev *pdev)
{
	...
	if (!list_is_last(&pdev->bus_list, &parent->subordinate->devices))
		goto out;
	...
}

So if we have the following pcie tree, system may crash.

[b7-bd]--+-02.0-[bb-bd]--+-00.0-[bc-bd]----01.0-[bd]----00.0  PLX Technology, Inc. Device 0002
                         +-00.1  PLX Technology, Inc. Device 0002
                         +-00.2  PLX Technology, Inc. Device 0002
                         +-00.3  PLX Technology, Inc. Device 0002
                         \-00.4  PLX Technology, Inc. Device 0002

In this case, we would stop bb:00.4 before bb:00.0, so when we touch bb:00.4,
we would call pcie_aspm_exit_link_state(), and free the pcie_link_state.
So when we want to stop bd:00.0 and free related pcie_link_state,
it would try to access the parent pcie_link_state which has been freed.

Part crash call trace:
BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
CPU 16 Pid: 33262, comm: IVS_PowerOn
RIP: 0010:[<ffffffffa0d7c14f>]  [<ffffffffa0d7c14f>] pcie_config_aspm_link+0x3f/0x100
RSP: 0018:ffff8801bc577790  EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 000000000000e7e6
RDX: 000000000000e6e6 RSI: 00000000ffffc5ec RDI: 0000000000000246
RBP: ffff8801bc5777d0 R08: ffff88007b001000 R09: 00000000003fffff
...
Call Trace:
 [<ffffffff8124a542>] pcie_config_aspm_path+0x32/0x60
 [<ffffffffa0d7cc00>] pcie_aspm_exit_link_state+0x160/0x560
 [<ffffffffa0d7c0bc>] pci_stop_bus_device+0x8c/0xe0
 [<ffffffffa0d7c068>] pci_stop_bus_device+0x38/0xe0
 [<ffffffffa0d7c068>] pci_stop_bus_device+0x38/0xe0
 [<ffffffffa0d7c068>] pci_stop_bus_device+0x38/0xe0
 [<ffffffffa0d7c068>] pci_stop_bus_device+0x38/0xe0
 [<ffffffff8123eca1>] pci_stop_and_remove_bus_device+0x11/0x20
...

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
CC: stable@vger.kernel.org #3.4+
---
 drivers/pci/pcie/aspm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 317e355..c81f549 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -648,7 +648,8 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 	 * All PCIe functions are in one slot, remove one function will remove
 	 * the whole slot, so just wait until we are the last function left.
 	 */
-	if (!list_is_last(&pdev->bus_list, &parent->subordinate->devices))
+	if (!(pdev == list_first_entry(&parent->subordinate->devices,
+					struct pci_dev, bus_list)))
 		goto out;
 
 	link = parent->link_state;
-- 
1.7.1

