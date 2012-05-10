Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57225 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751773Ab2EJPod (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 10 May 2012 11:44:33 -0400
Subject: [PATCH v3] pci: clean all funcs when hot-removing multifunc device
To: mst@redhat.com, linux-pci@vger.kernel.org, seabios@seabios.org,
	qemu-devel@nongnu.org, jbarnes@virtuousgeek.org,
	alex.williamson@redhat.com, kevin@koconnor.net
From: Amos Kong <akong@redhat.com>
Date: Thu, 10 May 2012 23:44:23 +0800
Message-ID: <20120510154423.11306.85353.stgit@t>
In-Reply-To: <1315976141-6684-1-git-send-email-akong@redhat.com>
References: <1315976141-6684-1-git-send-email-akong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

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

---
v1 thread: http://marc.info/?t=131597601700003&r=1&w=2

Changes from v1:
- rebase patch to latest linux.git
- remove unnecessary multiplefunction check
- rename 'i' to meaningful 'fn'
- fix coding style

Changes from v2:
- update detail reason(calltrace) to commitlog
- remove hardcode 8, find funcs in pci devlist

Signed-off-by: Amos Kong <akong@redhat.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 806c44f..a7442d9 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -885,7 +885,7 @@ static void disable_bridges(struct pci_bus *bus)
 static int disable_device(struct acpiphp_slot *slot)
 {
 	struct acpiphp_func *func;
-	struct pci_dev *pdev;
+	struct pci_dev *pdev, *tmp;
 	struct pci_bus *bus = slot->bridge->pci_bus;
 
 	/* The slot will be enabled when func 0 is added, so check
@@ -902,9 +902,10 @@ static int disable_device(struct acpiphp_slot *slot)
 			func->bridge = NULL;
 		}
 
-		pdev = pci_get_slot(slot->bridge->pci_bus,
-				    PCI_DEVFN(slot->device, func->function));
-		if (pdev) {
+		list_for_each_entry_safe(pdev, tmp, &bus->devices, bus_list) {
+			if (PCI_SLOT(pdev->devfn) != slot->device)
+				continue;
+
 			pci_stop_bus_device(pdev);
 			if (pdev->subordinate) {
 				disable_bridges(pdev->subordinate);

