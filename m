Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51259 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758241Ab2ETC7h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 19 May 2012 22:59:37 -0400
From: kongjianjun@gmail.com
To: liuj97@gmail.com, linux-pci@vger.kernel.org, qemu-devel@nongnu.org,
	jbarnes@virtuousgeek.org, kaneshige.kenji@jp.fujitsu.com,
	bhelgaas@google.com
Cc: Amos Kong <kongjianjun@gmail.com>
Subject: [PATCH v5] pci: clean all funcs when hot-removing multifunc device
Date: Sun, 20 May 2012 10:59:21 +0800
Message-Id: <1337482761-6265-1-git-send-email-kongjianjun@gmail.com>
In-Reply-To: <CAErSpo6bVG+-+E8JBcNv19+KHoQmswMTPrH-OsmRZmjAMT5e5g@mail.gmail.com>
References: <CAErSpo6bVG+-+E8JBcNv19+KHoQmswMTPrH-OsmRZmjAMT5e5g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Amos Kong <kongjianjun@gmail.com>

Hotplug CallTrace:
int acpiphp_enable_slot(struct acpiphp_slot *slot)
    \_enable_device(slot);
       \_pci_bus_add_devices(bus);
            # un-added new devs(all funcs in slot) will be added
            list_for_each_entry(dev, &bus->devices, bus_list) {
                if (dev->is_added)
                        continue;
                pci_bus_add_device(dev);
                device_add(&dev->dev);
                dev->is_added = 1;

'dev->is_added' is used to trace if pci dev is added to bus, all funcs in
same slot would be added to bus in enable_device(slot). So we need to clean
all funcs of same slot in disable_device(slot).

But hot-remove exists bug: https://bugzilla.kernel.org/show_bug.cgi?id=43219
(dmesg and DSDT were attached in bz), detail:

. Boot up a Linux VM with 8 pci block devices which are the 8
functions in one pci slot.
| # qemu-kvm ...
| -drive file=images/u0,if=none,id=drv0,format=qcow2,cache=none \
| -device virtio-blk-pci,drive=drv0,id=v0,multifunction=on,addr=0x03.0 \
| ....
| -drive file=images/u7,if=none,id=drv7,format=qcow2,cache=none \
| -device virtio-blk-pci,drive=drv7,id=v7,multifunction=on,addr=0x03.7 \

. Check devices in guest.
| vm)# ls /dev/vd*
|    vda vdb vdc vde vdf vdg vdh
| vm)# lspci |grep block
| 00:03.0 SCSI storage controller: Red Hat, Inc Virtio block device
|    ...
| 00:03.7 SCSI storage controller: Red Hat, Inc Virtio block device
|

. Func1~7 still exist in guest after hot-removing the whole slot
by qemu monitor cmd.
| vm)# lspci |grep block    (00:03.0 disappeared)
| 00:03.1 SCSI storage controller: Red Hat, Inc Virtio block device (rev ff)
|    ...
| 00:03.7 SCSI storage controller: Red Hat, Inc Virtio block device (rev ff)
| vm)# ls /dev/vd*          (vda disappeared)
|    vdb vdc vde vdf vdg vdh
| vm)# mkfs /dev/vdb
|    INFO: task mkfs.ext2:1784 blocked for more than 120 seconds.

We process pci slot as a whole device in pciphp spec, seabios only
defines one device for a slot in ACPI DSDT table.
In acpiphp_glue.c:register_slot(), only one entry is added (for func#0)
into 'slot->funcs' list. When we release the whole slot, only
the entry in 'slot->funcs' will be cleaned, so func#1~7 could
not be cleaned from system.

| drivers/pci/hotplug/acpiphp_glue.c:
| static int disable_device(struct acpiphp_slot *slot) {
| 	list_for_each_entry(func, &slot->funcs, sibling) {
| 		pdev = pci_get_slot(slot->bridge->pci_bus,
| 		       PCI_DEVFN(slot->device, func->function));
| 		..clean code.. // those code is only executed 1 time(for func#0)
|                 __pci_remove_bus_device(pdev);
|                 pci_dev_put(pdev);

Hotpluging multifunc of guests(WinXp/Win7) is fine.

Changes from v1:
- rebase patch to latest linux.git
- remove unnecessary multiplefunction check
- rename 'i' to meaningful 'fn'
- fix coding style

Changes from v2:
- update detail reason(calltrace) to commitlog
- remove hardcode 8, find funcs in pci devlist

Changes from v3:
- use pci_bus_sem lock when walking bus->devices list

Changes from V4:
- check null point of pdev

Signed-off-by: Amos Kong <kongjianjun@gmail.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 806c44f..ba46724 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -893,6 +893,7 @@ static int disable_device(struct acpiphp_slot *slot)
 	pdev = pci_get_slot(bus, PCI_DEVFN(slot->device, 0));
 	if (!pdev)
 		goto err_exit;
+	pci_dev_put(pdev);
 
 	list_for_each_entry(func, &slot->funcs, sibling) {
 		if (func->bridge) {
@@ -902,9 +903,20 @@ static int disable_device(struct acpiphp_slot *slot)
 			func->bridge = NULL;
 		}
 
-		pdev = pci_get_slot(slot->bridge->pci_bus,
-				    PCI_DEVFN(slot->device, func->function));
-		if (pdev) {
+		while (1) {
+			/* pci_bus_sem is used to protect bus->devices list,
+			   it may cause invalid memory access if threads
+			   modify bus->devices list concurrently. */
+			down_read(&pci_bus_sem);
+			list_for_each_entry(pdev, &bus->devices, bus_list)
+				if (PCI_SLOT(pdev->devfn) == slot->device) {
+					pci_dev_get(pdev);
+					break;
+				}
+			up_read(&pci_bus_sem);
+
+			if (!pdev || PCI_SLOT(pdev->devfn) != slot->device)
+				break;
 			pci_stop_bus_device(pdev);
 			if (pdev->subordinate) {
 				disable_bridges(pdev->subordinate);
-- 
1.7.9.5

