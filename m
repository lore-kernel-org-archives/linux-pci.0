Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53418 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235Ab1KYG4D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 25 Nov 2011 01:56:03 -0500
From: Amos Kong <akong@redhat.com>
To: linux-pci@vger.kernel.org, kvm@vger.kernel.org
Cc: mst@redhat.com, jasowang@redhat.com, scott@spiteful.org,
	jbarnes@virtuousgeek.org, mtosatti@redhat.com,
	Amos Kong <akong@redhat.com>
Subject: [PATCH] PCI: Can continually add funcs after adding func0
Date: Fri, 25 Nov 2011 15:03:07 +0800
Message-Id: <1322204587-3636-1-git-send-email-akong@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Boot up a KVM guest, and hotplug multifunction
devices(func1,func2,func0,func3) to guest.

for i in 1 2 0 3;do
qemu-img create /tmp/resize$i.qcow2 1G -f qcow2
(qemu) drive_add 0x11.$i id=drv11$i,if=none,file=/tmp/resize$i.qcow2
(qemu) device_add virtio-blk-pci,id=dev11$i,drive=drv11$i,addr=0x11.$i,multifunction=on
done

In linux kernel, when func0 of the slot is hot-added, the whole
slot will be marked as 'enabled', then driver will ignore other new
hotadded funcs.
But in Win7 & WinXP, we can continaully add other funcs after adding
func0, all funcs will be added in guest.

drivers/pci/hotplug/acpiphp_glue.c:
static int acpiphp_check_bridge(struct acpiphp_bridge *bridge)
{
....
        for (slot = bridge->slots; slot; slot = slot->next) {
                if (slot->flags & SLOT_ENABLED) {
                        acpiphp_disable_slot()
                else
                        acpiphp_enable_slot()
....                              |
}                                 v
                            enable_device()
                                  |
                                  v
        //only don't enable slot if func0 is not added
	list_for_each_entry(func, &slot->funcs, sibling) {
               ...
        }
       slot->flags |= SLOT_ENABLED; //mark slot to 'enabled'

This patch just make pci driver can continaully add funcs after adding
func 0. Only mark slot to 'enabled' when all funcs are added.

For pci multifunction hotplug, we can add functions one by one(func 0 is
necessary), and all functions will be removed in one time.

Signed-off-by: Amos Kong <akong@redhat.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |   29 +++++++++++++----------------
 1 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 596172b..a1b0afc 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -789,20 +789,10 @@ static int __ref enable_device(struct acpiphp_slot *slot)
 	if (slot->flags & SLOT_ENABLED)
 		goto err_exit;
 
-	/* sanity check: dev should be NULL when hot-plugged in */
-	dev = pci_get_slot(bus, PCI_DEVFN(slot->device, 0));
-	if (dev) {
-		/* This case shouldn't happen */
-		err("pci_dev structure already exists.\n");
-		pci_dev_put(dev);
-		retval = -1;
-		goto err_exit;
-	}
-
 	num = pci_scan_slot(bus, PCI_DEVFN(slot->device, 0));
 	if (num == 0) {
-		err("No new device found\n");
-		retval = -1;
+		/* Maybe only part of funcs are added. */
+		dbg("No new device found\n");
 		goto err_exit;
 	}
 
@@ -837,11 +827,16 @@ static int __ref enable_device(struct acpiphp_slot *slot)
 
 	pci_bus_add_devices(bus);
 
+	slot->flags |= SLOT_ENABLED;
 	list_for_each_entry(func, &slot->funcs, sibling) {
 		dev = pci_get_slot(bus, PCI_DEVFN(slot->device,
 						  func->function));
-		if (!dev)
+		if (!dev) {
+			/* Do not set SLOT_ENABLED flag if some funcs
+			   are not added. */
+			slot->flags &= (~SLOT_ENABLED);
 			continue;
+		}
 
 		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE &&
 		    dev->hdr_type != PCI_HEADER_TYPE_CARDBUS) {
@@ -856,7 +851,6 @@ static int __ref enable_device(struct acpiphp_slot *slot)
 		pci_dev_put(dev);
 	}
 
-	slot->flags |= SLOT_ENABLED;
 
  err_exit:
 	return retval;
@@ -881,9 +875,12 @@ static int disable_device(struct acpiphp_slot *slot)
 {
 	struct acpiphp_func *func;
 	struct pci_dev *pdev;
+	struct pci_bus *bus = slot->bridge->pci_bus;
 
-	/* is this slot already disabled? */
-	if (!(slot->flags & SLOT_ENABLED))
+	/* The slot will be enabled when func 0 is added, so check
+	   func 0 before disable the slot. */
+	pdev = pci_get_slot(bus, PCI_DEVFN(slot->device, 0));
+	if (!pdev)
 		goto err_exit;
 
 	list_for_each_entry(func, &slot->funcs, sibling) {
-- 
1.7.7.3

