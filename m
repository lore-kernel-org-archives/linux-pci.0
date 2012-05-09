Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17960 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758144Ab2EIPZv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 9 May 2012 11:25:51 -0400
Subject: [PATCH v2] pci: clean all funcs when hot-removing multifunc device
To: mst@redhat.com, linux-pci@vger.kernel.org, seabios@seabios.org,
	qemu-devel@nongnu.org, jbarnes@virtuousgeek.org,
	alex.williamson@redhat.com, kevin@koconnor.net
From: Amos Kong <akong@redhat.com>
Date: Wed, 09 May 2012 23:25:43 +0800
Message-ID: <20120509152543.11307.20072.stgit@t>
In-Reply-To: <1315976141-6684-1-git-send-email-akong@redhat.com>
References: <1315976141-6684-1-git-send-email-akong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=737720#c8
(dmesg and DSDT were attached in bz)

Boot up a Linux VM with 8 pci block devices which
are the 8 functions in one pci slot.
| # qemu-kvm ...
| -drive file=images/u0,if=none,id=drv0,format=qcow2,cache=none \
| -device virtio-blk-pci,drive=drv0,id=v0,multifunction=on,addr=0x03.0 \
| ....
| -drive file=images/u7,if=none,id=drv7,format=qcow2,cache=none \
| -device virtio-blk-pci,drive=drv7,id=v7,multifunction=on,addr=0x03.7 \

Check devices in guest.
| vm)# ls /dev/vd*
|    vda vdb vdc vde vdf vdg vdh
| vm)# lspci |grep block
| 00:03.0 SCSI storage controller: Red Hat, Inc Virtio block device
|    ...
| 00:03.7 SCSI storage controller: Red Hat, Inc Virtio block device
|

Func1~7 still exist in guest after hot-removing the whole slot
by qemu monitor cmd.
| vm)# lspci |grep block    (00:03.0 disappeared)
| 00:03.1 SCSI storage controller: Red Hat, Inc Virtio block device (rev ff)
|    ...
| 00:03.7 SCSI storage controller: Red Hat, Inc Virtio block device (rev ff)
| vm)# ls /dev/vd*          (vda disappeared)
|    vdb vdc vde vdf vdg vdh
| vm)# mkfs /dev/vdb
|    INFO: task mkfs.ext2:1784 blocked for more than 120 seconds.

We process pci slot as a whole device, in seabios only defines one
device for a slot in ACPI DSDT table, then there is only one entry
(for func#0) would be added into 'slot->funcs' list.
When we release the whole slot, only the entry in 'slot->funcs' will
be cleaned, so func#1~7 could not be cleaned from system.

| drivers/pci/hotplug/acpiphp_glue.c:
| static int disable_device(struct acpiphp_slot *slot) {
| 	list_for_each_entry(func, &slot->funcs, sibling) {
| 		pdev = pci_get_slot(slot->bridge->pci_bus,
| 		       PCI_DEVFN(slot->device, func->function));
| 		..clean code.. // those code is only executed 1 time(for func#0)
|                 __pci_remove_bus_device(pdev);
|                 pci_dev_put(pdev);

I try to add entries for all hotpluged device in enable_device(), but
it doesn't work, because 'slot->funcs' is used in many place which we
only need to process func#0. This patch just try to clean all funcs in
disable_device().

Hotpluging multifunc of guests(WinXp/Win7) is fine.

---
v1 thread: http://marc.info/?t=131597601700003&r=1&w=2

Changes from v1:
- rebase patch to latest linux.git
- remove unnecessary multiplefunction check
- rename 'i' to meaningful 'fn'
- fix coding style

Signed-off-by: Amos Kong <akong@redhat.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 806c44f..42f9bb9 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -887,6 +887,7 @@ static int disable_device(struct acpiphp_slot *slot)
 	struct acpiphp_func *func;
 	struct pci_dev *pdev;
 	struct pci_bus *bus = slot->bridge->pci_bus;
+	int fn;
 
 	/* The slot will be enabled when func 0 is added, so check
 	   func 0 before disable the slot. */
@@ -902,16 +903,17 @@ static int disable_device(struct acpiphp_slot *slot)
 			func->bridge = NULL;
 		}
 
-		pdev = pci_get_slot(slot->bridge->pci_bus,
-				    PCI_DEVFN(slot->device, func->function));
-		if (pdev) {
-			pci_stop_bus_device(pdev);
-			if (pdev->subordinate) {
-				disable_bridges(pdev->subordinate);
-				pci_disable_device(pdev);
+		for (fn = 0; fn < 8; fn++) {
+			pdev = pci_get_slot(bus, PCI_DEVFN(slot->device, fn));
+			if (pdev) {
+				pci_stop_bus_device(pdev);
+				if (pdev->subordinate) {
+					disable_bridges(pdev->subordinate);
+					pci_disable_device(pdev);
+				}
+				__pci_remove_bus_device(pdev);
+				pci_dev_put(pdev);
 			}
-			__pci_remove_bus_device(pdev);
-			pci_dev_put(pdev);
 		}
 	}
 

