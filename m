Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jarod Wilson <jarod@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [Update][PATCH] PCIe / hotplug: Drop pointless ACPI-based "slot detection" check
Date: Tue, 19 May 2015 15:27:58 +0200
Message-ID: <1573807.HQlNd2BFYP@vostro.rjw.lan>
In-Reply-To: <6257210.QKy3yrBgEf@vostro.rjw.lan>
References: <1431632038-39917-1-git-send-email-jarod@redhat.com> <2168334.DgvA03CWPi@vostro.rjw.lan> <6257210.QKy3yrBgEf@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Jarod Wilson reports that the expresscard hotplug setup doesn't work
on HP ZBook G2.  The problem turns out to be the ACPI-based "slot
detection" code called from pciehp_probe() which tries to use some
questionable heuristics based on what ACPI objects are present for
the PCIe port device at hand to figure out whether or not to register
a hotplug slot for that port.

That code is used if there is at least one PCIe port having an ACPI
device configuration object related to hotplug (such as _EJ0 or _RMV)
and the Thunderbolt port on the affected machine has _RMV.  Of course,
Thunderbolt and PCIe native hotplug need not be mutually exclusive
(as they aren't on the machine in question), so that rule is simply
incorrect.

Moreover, the ACPI-based "slot detection" check does not add any
value if pciehp_probe() is called at all and the service type of the
device object it has been called for is PCIE_PORT_SERVICE_HP, because
PCIe hotplug services are only registered if the _OSC handshake in
acpi_pci_root_add() allows the kernel to control the PCIe native
hotplug feature.  No more checks need to be carried out to decide
whether or not to register a native PCIe hotlug slot in that case.

For the above reasons, make pciehp_probe() check if it has been
called for the right service type and drop the pointless ACPI-based
"slot detection" check from it.  Also remove the entire code whose
only user is that check (the entire pciehp_acpi.c file goes away
as a result) and drop function headers related to it from the
internal PCIeHP header file.

Link: http://marc.info/?t=143163219300002&r=1&w=2
Link: https://bugzilla.kernel.org/show_bug.cgi?id=98581
Reported-by: Jarod Wilson <jarod@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Changes in Makefile were missing from the previous version.

Bjorn, that's -stable material I think.  It should be applicable at least
since commit 5ba113f7c4fb (PCI: acpiphp: Handle PCIe ports without native
hotplug capability) that was shipped in 3.10.

Thanks!

---
 drivers/pci/hotplug/Makefile      |    3 
 drivers/pci/hotplug/pciehp.h      |   17 ----
 drivers/pci/hotplug/pciehp_acpi.c |  137 --------------------------------------
 drivers/pci/hotplug/pciehp_core.c |   10 --
 4 files changed, 3 insertions(+), 164 deletions(-)

Index: linux-pm/drivers/pci/hotplug/pciehp_core.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/pciehp_core.c
+++ linux-pm/drivers/pci/hotplug/pciehp_core.c
@@ -248,12 +248,9 @@ static int pciehp_probe(struct pcie_devi
 	struct slot *slot;
 	u8 occupied, poweron;
 
-	if (pciehp_force)
-		dev_info(&dev->device,
-			 "Bypassing BIOS check for pciehp use on %s\n",
-			 pci_name(dev->port));
-	else if (pciehp_acpi_slot_detection_check(dev->port))
-		goto err_out_none;
+	/* If this is not a "hotplug" service, we have no business here. */
+	if (dev->service != PCIE_PORT_SERVICE_HP)
+		return -ENODEV;
 
 	if (!dev->port->subordinate) {
 		/* Can happen if we run out of bus numbers during probe */
@@ -366,7 +363,6 @@ static int __init pcied_init(void)
 {
 	int retval = 0;
 
-	pciehp_firmware_init();
 	retval = pcie_port_service_register(&hpdriver_portdrv);
 	dbg("pcie_port_service_register = %d\n", retval);
 	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
Index: linux-pm/drivers/pci/hotplug/pciehp_acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/pciehp_acpi.c
+++ /dev/null
@@ -1,137 +0,0 @@
-/*
- * ACPI related functions for PCI Express Hot Plug driver.
- *
- * Copyright (C) 2008 Kenji Kaneshige
- * Copyright (C) 2008 Fujitsu Limited.
- *
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or (at
- * your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
- * NON INFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#include <linux/acpi.h>
-#include <linux/pci.h>
-#include <linux/pci_hotplug.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include "pciehp.h"
-
-#define PCIEHP_DETECT_PCIE	(0)
-#define PCIEHP_DETECT_ACPI	(1)
-#define PCIEHP_DETECT_AUTO	(2)
-#define PCIEHP_DETECT_DEFAULT	PCIEHP_DETECT_AUTO
-
-struct dummy_slot {
-	u32 number;
-	struct list_head list;
-};
-
-static int slot_detection_mode;
-static char *pciehp_detect_mode;
-module_param(pciehp_detect_mode, charp, 0444);
-MODULE_PARM_DESC(pciehp_detect_mode,
-	 "Slot detection mode: pcie, acpi, auto\n"
-	 "  pcie          - Use PCIe based slot detection\n"
-	 "  acpi          - Use ACPI for slot detection\n"
-	 "  auto(default) - Auto select mode. Use acpi option if duplicate\n"
-	 "                  slot ids are found. Otherwise, use pcie option\n");
-
-int pciehp_acpi_slot_detection_check(struct pci_dev *dev)
-{
-	if (slot_detection_mode != PCIEHP_DETECT_ACPI)
-		return 0;
-	if (acpi_pci_detect_ejectable(ACPI_HANDLE(&dev->dev)))
-		return 0;
-	return -ENODEV;
-}
-
-static int __init parse_detect_mode(void)
-{
-	if (!pciehp_detect_mode)
-		return PCIEHP_DETECT_DEFAULT;
-	if (!strcmp(pciehp_detect_mode, "pcie"))
-		return PCIEHP_DETECT_PCIE;
-	if (!strcmp(pciehp_detect_mode, "acpi"))
-		return PCIEHP_DETECT_ACPI;
-	if (!strcmp(pciehp_detect_mode, "auto"))
-		return PCIEHP_DETECT_AUTO;
-	warn("bad specifier '%s' for pciehp_detect_mode. Use default\n",
-	     pciehp_detect_mode);
-	return PCIEHP_DETECT_DEFAULT;
-}
-
-static int __initdata dup_slot_id;
-static int __initdata acpi_slot_detected;
-static struct list_head __initdata dummy_slots = LIST_HEAD_INIT(dummy_slots);
-
-/* Dummy driver for duplicate name detection */
-static int __init dummy_probe(struct pcie_device *dev)
-{
-	u32 slot_cap;
-	acpi_handle handle;
-	struct dummy_slot *slot, *tmp;
-	struct pci_dev *pdev = dev->port;
-
-	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap);
-	slot = kzalloc(sizeof(*slot), GFP_KERNEL);
-	if (!slot)
-		return -ENOMEM;
-	slot->number = (slot_cap & PCI_EXP_SLTCAP_PSN) >> 19;
-	list_for_each_entry(tmp, &dummy_slots, list) {
-		if (tmp->number == slot->number)
-			dup_slot_id++;
-	}
-	list_add_tail(&slot->list, &dummy_slots);
-	handle = ACPI_HANDLE(&pdev->dev);
-	if (!acpi_slot_detected && acpi_pci_detect_ejectable(handle))
-		acpi_slot_detected = 1;
-	return -ENODEV;         /* dummy driver always returns error */
-}
-
-static struct pcie_port_service_driver __initdata dummy_driver = {
-	.name		= "pciehp_dummy",
-	.port_type	= PCIE_ANY_PORT,
-	.service	= PCIE_PORT_SERVICE_HP,
-	.probe		= dummy_probe,
-};
-
-static int __init select_detection_mode(void)
-{
-	struct dummy_slot *slot, *tmp;
-
-	if (pcie_port_service_register(&dummy_driver))
-		return PCIEHP_DETECT_ACPI;
-	pcie_port_service_unregister(&dummy_driver);
-	list_for_each_entry_safe(slot, tmp, &dummy_slots, list) {
-		list_del(&slot->list);
-		kfree(slot);
-	}
-	if (acpi_slot_detected && dup_slot_id)
-		return PCIEHP_DETECT_ACPI;
-	return PCIEHP_DETECT_PCIE;
-}
-
-void __init pciehp_acpi_slot_detection_init(void)
-{
-	slot_detection_mode = parse_detect_mode();
-	if (slot_detection_mode != PCIEHP_DETECT_AUTO)
-		goto out;
-	slot_detection_mode = select_detection_mode();
-out:
-	if (slot_detection_mode == PCIEHP_DETECT_ACPI)
-		info("Using ACPI for slot detection.\n");
-}
Index: linux-pm/drivers/pci/hotplug/pciehp.h
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/pciehp.h
+++ linux-pm/drivers/pci/hotplug/pciehp.h
@@ -167,21 +167,4 @@ static inline const char *slot_name(stru
 	return hotplug_slot_name(slot->hotplug_slot);
 }
 
-#ifdef CONFIG_ACPI
-#include <linux/pci-acpi.h>
-
-void __init pciehp_acpi_slot_detection_init(void);
-int pciehp_acpi_slot_detection_check(struct pci_dev *dev);
-
-static inline void pciehp_firmware_init(void)
-{
-	pciehp_acpi_slot_detection_init();
-}
-#else
-#define pciehp_firmware_init()				do {} while (0)
-static inline int pciehp_acpi_slot_detection_check(struct pci_dev *dev)
-{
-	return 0;
-}
-#endif				/* CONFIG_ACPI */
 #endif				/* _PCIEHP_H */
Index: linux-pm/drivers/pci/hotplug/Makefile
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/Makefile
+++ linux-pm/drivers/pci/hotplug/Makefile
@@ -61,9 +61,6 @@ pciehp-objs		:=	pciehp_core.o	\
 				pciehp_ctrl.o	\
 				pciehp_pci.o	\
 				pciehp_hpc.o
-ifdef CONFIG_ACPI
-pciehp-objs		+=	pciehp_acpi.o
-endif
 
 shpchp-objs		:=	shpchp_core.o	\
 				shpchp_ctrl.o	\

