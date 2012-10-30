Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:50064 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740Ab2J3GY4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Oct 2012 02:24:56 -0400
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 7B5CA3EE0C3
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:24:55 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 61A0445DE5A
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:24:55 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 47B5A45DE58
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:24:55 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 3647C1DB8053
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:24:55 +0900 (JST)
Received: from m003.s.css.fujitsu.com (m003.s.css.fujitsu.com [10.23.4.33])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id E6FF11DB8049
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:24:54 +0900 (JST)
Date: Tue, 30 Oct 2012 15:24:50 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 2/5] PCI,ACPI: Add _PRT interrupt routing info before
 enumerating devices
Message-Id: <20121030152450.92d4c106.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20121030062124.BE34D2E0805@m003.s.css.fujitsu.com>
References: <20121030062124.BE34D2E0805@m003.s.css.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Author: Bjorn Helgaas <bhelgaas@google.com>

PCI/ACPI: Add _PRT interrupt routing info before enumerating devices
    
We used to add the _PRT after enumerating devices behind a new host
bridge.  This moves the _PRT addition *before* the enumeration, since
it no longer depends on the struct pci_bus existing.  This is one
step towards consolidating the .add/.start methods.
    
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
[insert acpi_pci_irq_del_prt() on hostbridge addition failure]
Signed-off-by: Taku Izumi <izumim.taku@jp.fujitsu.com>
---
 drivers/acpi/pci_root.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

Index: Bjorn-next-0925/drivers/acpi/pci_root.c
===================================================================
--- Bjorn-next-0925.orig/drivers/acpi/pci_root.c
+++ Bjorn-next-0925/drivers/acpi/pci_root.c
@@ -467,6 +467,7 @@ static int __devinit acpi_pci_root_add(s
 		result = -ENODEV;
 		goto end;
 	}
+	root->segment = segment & 0xFFFF;
 
 	/* Check _CRS first, then _BBN.  If no _BBN, default to zero. */
 	root->secondary.flags = IORESOURCE_BUS;
@@ -494,9 +495,18 @@ static int __devinit acpi_pci_root_add(s
 		}
 	}
 
+	/*
+	 * PCI Routing Table
+	 * -----------------
+	 * Evaluate and parse _PRT, if exists.
+	 */
+	status = acpi_get_handle(device->handle, METHOD_NAME__PRT, &handle);
+	if (ACPI_SUCCESS(status))
+		result = acpi_pci_irq_add_prt(device->handle, root->segment,
+					      root->secondary.start);
+
 	INIT_LIST_HEAD(&root->node);
 	root->device = device;
-	root->segment = segment & 0xFFFF;
 	strcpy(acpi_device_name(device), ACPI_PCI_ROOT_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
 	device->driver_data = root;
@@ -548,16 +558,6 @@ static int __devinit acpi_pci_root_add(s
 		goto out_del_root;
 
 	/*
-	 * PCI Routing Table
-	 * -----------------
-	 * Evaluate and parse _PRT, if exists.
-	 */
-	status = acpi_get_handle(device->handle, METHOD_NAME__PRT, &handle);
-	if (ACPI_SUCCESS(status))
-		result = acpi_pci_irq_add_prt(device->handle, root->segment,
-					      root->secondary.start);
-
-	/*
 	 * Scan and bind all _ADR-Based Devices
 	 */
 	list_for_each_entry(child, &device->children, node)
@@ -635,6 +635,8 @@ out_del_root:
 	mutex_lock(&acpi_pci_root_lock);
 	list_del(&root->node);
 	mutex_unlock(&acpi_pci_root_lock);
+
+	acpi_pci_irq_del_prt(root->segment, root->secondary.start);
 end:
 	kfree(root);
 	return result;

