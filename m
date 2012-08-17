Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f202.google.com ([209.85.214.202]:34062 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755445Ab2HQXgc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 19:36:32 -0400
Received: by mail-ob0-f202.google.com with SMTP id wc20so3010724obb.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Aug 2012 16:36:32 -0700 (PDT)
Subject: [PATCH v2 09/16] PCI: Remove unused, commented-out, code
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pcmcia@lists.infradead.org, Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date: Fri, 17 Aug 2012 17:36:31 -0600
Message-ID: <20120817233631.10973.50100.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
References: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |   28 -----------------
 drivers/pci/proc.c                 |   19 ------------
 drivers/pci/remove.c               |   19 ------------
 drivers/pci/rom.c                  |   59 ------------------------------------
 4 files changed, 0 insertions(+), 125 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index b5d798e..7be4ca5 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -1461,34 +1461,6 @@ int __init acpiphp_get_num_slots(void)
 }
 
 
-#if 0
-/**
- * acpiphp_for_each_slot - call function for each slot
- * @fn: callback function
- * @data: context to be passed to callback function
- */
-static int acpiphp_for_each_slot(acpiphp_callback fn, void *data)
-{
-	struct list_head *node;
-	struct acpiphp_bridge *bridge;
-	struct acpiphp_slot *slot;
-	int retval = 0;
-
-	list_for_each (node, &bridge_list) {
-		bridge = (struct acpiphp_bridge *)node;
-		for (slot = bridge->slots; slot; slot = slot->next) {
-			retval = fn(slot, data);
-			if (!retval)
-				goto err_exit;
-		}
-	}
-
- err_exit:
-	return retval;
-}
-#endif
-
-
 /**
  * acpiphp_enable_slot - power on slot
  * @slot: ACPI PHP slot
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 27911b5..eb907a8f 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -434,25 +434,6 @@ int pci_proc_detach_device(struct pci_dev *dev)
 	return 0;
 }
 
-#if 0
-int pci_proc_attach_bus(struct pci_bus* bus)
-{
-	struct proc_dir_entry *de = bus->procdir;
-
-	if (!proc_initialized)
-		return -EACCES;
-
-	if (!de) {
-		char name[16];
-		sprintf(name, "%02x", bus->number);
-		de = bus->procdir = proc_mkdir(name, proc_bus_pci_dir);
-		if (!de)
-			return -ENOMEM;
-	}
-	return 0;
-}
-#endif  /*  0  */
-
 int pci_proc_detach_bus(struct pci_bus* bus)
 {
 	struct proc_dir_entry *de = bus->procdir;
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 3828104..44f479f 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -43,25 +43,6 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	pci_dev_put(dev);
 }
 
-/**
- * pci_remove_device_safe - remove an unused hotplug device
- * @dev: the device to remove
- *
- * Delete the device structure from the device lists and 
- * notify userspace (/sbin/hotplug), but only if the device
- * in question is not being used by a driver.
- * Returns 0 on success.
- */
-#if 0
-int pci_remove_device_safe(struct pci_dev *dev)
-{
-	if (pci_dev_driver(dev))
-		return -EBUSY;
-	pci_destroy_dev(dev);
-	return 0;
-}
-#endif  /*  0  */
-
 void pci_remove_bus(struct pci_bus *pci_bus)
 {
 	pci_proc_detach_bus(pci_bus);
diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index 48ebdb2..0b3037a 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -167,44 +167,6 @@ void __iomem *pci_map_rom(struct pci_dev *pdev, size_t *size)
 	return rom;
 }
 
-#if 0
-/**
- * pci_map_rom_copy - map a PCI ROM to kernel space, create a copy
- * @pdev: pointer to pci device struct
- * @size: pointer to receive size of pci window over ROM
- *
- * Return: kernel virtual pointer to image of ROM
- *
- * Map a PCI ROM into kernel space. If ROM is boot video ROM,
- * the shadow BIOS copy will be returned instead of the
- * actual ROM.
- */
-void __iomem *pci_map_rom_copy(struct pci_dev *pdev, size_t *size)
-{
-	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
-	void __iomem *rom;
-
-	rom = pci_map_rom(pdev, size);
-	if (!rom)
-		return NULL;
-
-	if (res->flags & (IORESOURCE_ROM_COPY | IORESOURCE_ROM_SHADOW |
-			  IORESOURCE_ROM_BIOS_COPY))
-		return rom;
-
-	res->start = (unsigned long)kmalloc(*size, GFP_KERNEL);
-	if (!res->start)
-		return rom;
-
-	res->end = res->start + *size;
-	memcpy_fromio((void*)(unsigned long)res->start, rom, *size);
-	pci_unmap_rom(pdev, rom);
-	res->flags |= IORESOURCE_ROM_COPY;
-
-	return (void __iomem *)(unsigned long)res->start;
-}
-#endif  /*  0  */
-
 /**
  * pci_unmap_rom - unmap the ROM from kernel space
  * @pdev: pointer to pci device struct
@@ -226,27 +188,6 @@ void pci_unmap_rom(struct pci_dev *pdev, void __iomem *rom)
 		pci_disable_rom(pdev);
 }
 
-#if 0
-/**
- * pci_remove_rom - disable the ROM and remove its sysfs attribute
- * @pdev: pointer to pci device struct
- *
- * Remove the rom file in sysfs and disable ROM decoding.
- */
-void pci_remove_rom(struct pci_dev *pdev)
-{
-	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
-
-	if (pci_resource_len(pdev, PCI_ROM_RESOURCE))
-		sysfs_remove_bin_file(&pdev->dev.kobj, pdev->rom_attr);
-	if (!(res->flags & (IORESOURCE_ROM_ENABLE |
-			    IORESOURCE_ROM_SHADOW |
-			    IORESOURCE_ROM_BIOS_COPY |
-			    IORESOURCE_ROM_COPY)))
-		pci_disable_rom(pdev);
-}
-#endif  /*  0  */
-
 /**
  * pci_cleanup_rom - free the ROM copy created by pci_map_rom_copy
  * @pdev: pointer to pci device struct

