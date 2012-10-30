Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:50027 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343Ab2J3GYM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Oct 2012 02:24:12 -0400
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 2EF593EE0C3
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:24:10 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 1379845DE50
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:24:10 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id F16F045DD78
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:24:09 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id E22381DB803E
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:24:09 +0900 (JST)
Received: from m0000.s.css.fujitsu.com (m0000.s.css.fujitsu.com [10.23.4.183])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 9C0231DB802C
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:24:09 +0900 (JST)
Date: Tue, 30 Oct 2012 15:24:06 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>, linux-pci@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 1/5] ACPI: Pass segment/bus to _PRT add/del so they don't
 depend on pci_bus
Message-Id: <20121030152406.3c27d022.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20121030062124.BE34D2E0805@m003.s.css.fujitsu.com>
References: <20121030062124.BE34D2E0805@m003.s.css.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Author: Bjorn Helgaas <bhelgaas@google.com>

ACPI: Pass segment/bus to _PRT add/del so they don't depend on pci_bus
    
This effectively reverts 859a3f86ca8 ("ACPI: simplify
acpi_pci_irq_add_prt() API") and d9efae3688a ("ACPI: simplify
acpi_pci_irq_del_prt() API").
    
The reason is to disentangle these routines from the struct pci_bus.
We want to be able to add the _PRT before the struct pci_bus
exists, and delete the _PRT after we've removed the pci_bus.
    
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
---
 drivers/acpi/pci_bind.c     |   10 +++++-----
 drivers/acpi/pci_irq.c      |   17 ++++++++---------
 drivers/acpi/pci_root.c     |    3 ++-
 include/acpi/acpi_drivers.h |    4 ++--
 4 files changed, 17 insertions(+), 17 deletions(-)

Index: Bjorn-next-0925/drivers/acpi/pci_bind.c
===================================================================
--- Bjorn-next-0925.orig/drivers/acpi/pci_bind.c
+++ Bjorn-next-0925/drivers/acpi/pci_bind.c
@@ -49,7 +49,7 @@ static int acpi_pci_unbind(struct acpi_d
 	if (!dev->subordinate)
 		goto out;
 
-	acpi_pci_irq_del_prt(dev->subordinate);
+	acpi_pci_irq_del_prt(pci_domain_nr(dev->bus), dev->subordinate->number);
 
 	device->ops.bind = NULL;
 	device->ops.unbind = NULL;
@@ -63,7 +63,7 @@ static int acpi_pci_bind(struct acpi_dev
 {
 	acpi_status status;
 	acpi_handle handle;
-	struct pci_bus *bus;
+	unsigned char bus;
 	struct pci_dev *dev;
 
 	dev = acpi_get_pci_dev(device->handle);
@@ -100,11 +100,11 @@ static int acpi_pci_bind(struct acpi_dev
 		goto out;
 
 	if (dev->subordinate)
-		bus = dev->subordinate;
+		bus = dev->subordinate->number;
 	else
-		bus = dev->bus;
+		bus = dev->bus->number;
 
-	acpi_pci_irq_add_prt(device->handle, bus);
+	acpi_pci_irq_add_prt(device->handle, pci_domain_nr(dev->bus), bus);
 
 out:
 	pci_dev_put(dev);
Index: Bjorn-next-0925/drivers/acpi/pci_irq.c
===================================================================
--- Bjorn-next-0925.orig/drivers/acpi/pci_irq.c
+++ Bjorn-next-0925/drivers/acpi/pci_irq.c
@@ -184,7 +184,7 @@ static void do_prt_fixups(struct acpi_pr
 	}
 }
 
-static int acpi_pci_irq_add_entry(acpi_handle handle, struct pci_bus *bus,
+static int acpi_pci_irq_add_entry(acpi_handle handle, int segment, int bus,
 				  struct acpi_pci_routing_table *prt)
 {
 	struct acpi_prt_entry *entry;
@@ -198,8 +198,8 @@ static int acpi_pci_irq_add_entry(acpi_h
 	 * 1=INTA, 2=INTB.  We use the PCI encoding throughout, so convert
 	 * it here.
 	 */
-	entry->id.segment = pci_domain_nr(bus);
-	entry->id.bus = bus->number;
+	entry->id.segment = segment;
+	entry->id.bus = bus;
 	entry->id.device = (prt->address >> 16) & 0xFFFF;
 	entry->pin = prt->pin + 1;
 
@@ -244,7 +244,7 @@ static int acpi_pci_irq_add_entry(acpi_h
 	return 0;
 }
 
-int acpi_pci_irq_add_prt(acpi_handle handle, struct pci_bus *bus)
+int acpi_pci_irq_add_prt(acpi_handle handle, int segment, int bus)
 {
 	acpi_status status;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -273,7 +273,7 @@ int acpi_pci_irq_add_prt(acpi_handle han
 
 	entry = buffer.pointer;
 	while (entry && (entry->length > 0)) {
-		acpi_pci_irq_add_entry(handle, bus, entry);
+		acpi_pci_irq_add_entry(handle, segment, bus, entry);
 		entry = (struct acpi_pci_routing_table *)
 		    ((unsigned long)entry + entry->length);
 	}
@@ -282,17 +282,16 @@ int acpi_pci_irq_add_prt(acpi_handle han
 	return 0;
 }
 
-void acpi_pci_irq_del_prt(struct pci_bus *bus)
+void acpi_pci_irq_del_prt(int segment, int bus)
 {
 	struct acpi_prt_entry *entry, *tmp;
 
 	printk(KERN_DEBUG
 	       "ACPI: Delete PCI Interrupt Routing Table for %04x:%02x\n",
-	       pci_domain_nr(bus), bus->number);
+	       segment, bus);
 	spin_lock(&acpi_prt_lock);
 	list_for_each_entry_safe(entry, tmp, &acpi_prt_list, list) {
-		if (pci_domain_nr(bus) == entry->id.segment
-			&& bus->number == entry->id.bus) {
+		if (segment == entry->id.segment && bus == entry->id.bus) {
 			list_del(&entry->list);
 			kfree(entry);
 		}
Index: Bjorn-next-0925/drivers/acpi/pci_root.c
===================================================================
--- Bjorn-next-0925.orig/drivers/acpi/pci_root.c
+++ Bjorn-next-0925/drivers/acpi/pci_root.c
@@ -554,7 +554,8 @@ static int __devinit acpi_pci_root_add(s
 	 */
 	status = acpi_get_handle(device->handle, METHOD_NAME__PRT, &handle);
 	if (ACPI_SUCCESS(status))
-		result = acpi_pci_irq_add_prt(device->handle, root->bus);
+		result = acpi_pci_irq_add_prt(device->handle, root->segment,
+					      root->secondary.start);
 
 	/*
 	 * Scan and bind all _ADR-Based Devices
Index: Bjorn-next-0925/include/acpi/acpi_drivers.h
===================================================================
--- Bjorn-next-0925.orig/include/acpi/acpi_drivers.h
+++ Bjorn-next-0925/include/acpi/acpi_drivers.h
@@ -92,8 +92,8 @@ int acpi_pci_link_free_irq(acpi_handle h
 
 /* ACPI PCI Interrupt Routing (pci_irq.c) */
 
-int acpi_pci_irq_add_prt(acpi_handle handle, struct pci_bus *bus);
-void acpi_pci_irq_del_prt(struct pci_bus *bus);
+int acpi_pci_irq_add_prt(acpi_handle handle, int segment, int bus);
+void acpi_pci_irq_del_prt(int segment, int bus);
 
 /* ACPI PCI Device Binding (pci_bind.c) */
 

