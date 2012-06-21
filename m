Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:42787 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759159Ab2FUJhw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2012 05:37:52 -0400
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 7365A3EE0AE
	for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 18:37:51 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 55E2945DEB6
	for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 18:37:51 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 33AFE45DEA6
	for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 18:37:51 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 20771E08002
	for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 18:37:51 +0900 (JST)
Received: from m003.s.css.fujitsu.com (m003.s.css.fujitsu.com [10.23.4.33])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id C97F11DB803E
	for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 18:37:50 +0900 (JST)
Date: Thu, 21 Jun 2012 18:38:03 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH 2/4] acpi, pci: introduce acpi_root_sem for list
 manipulation
Message-Id: <20120621183803.8b9bd8c0.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120621183430.2b84fb53.izumi.taku@jp.fujitsu.com>
References: <20120621183430.2b84fb53.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently acpi_pci_root list and acpi_pci_drivers list are manipulated
without holding any lock. This patch introduce acpi_pci_lock to
manipulate those lists.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
---
 drivers/acpi/pci_root.c |   33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

Index: linux/drivers/acpi/pci_root.c
===================================================================
--- linux.orig/drivers/acpi/pci_root.c
+++ linux/drivers/acpi/pci_root.c
@@ -73,6 +73,7 @@ static struct acpi_driver acpi_pci_root_
 
 static LIST_HEAD(acpi_pci_roots);
 static LIST_HEAD(acpi_pci_drivers);
+DECLARE_RWSEM(acpi_pci_sem);
 
 static DEFINE_MUTEX(osc_lock);
 
@@ -81,15 +82,19 @@ int acpi_pci_register_driver(struct acpi
 	int n = 0;
 	struct acpi_pci_root *root;
 
+	down_write(&acpi_pci_sem);
 	list_add(&driver->list, &acpi_pci_drivers);
+	up_write(&acpi_pci_sem);
 
 	if (!driver->add)
 		return 0;
 
+	down_read(&acpi_pci_sem);
 	list_for_each_entry(root, &acpi_pci_roots, node) {
 		driver->add(root->device->handle);
 		n++;
 	}
+	up_read(&acpi_pci_sem);
 	return n;
 }
 
@@ -99,13 +104,17 @@ void acpi_pci_unregister_driver(struct a
 {
 	struct acpi_pci_root *root;
 
+	down_write(&acpi_pci_sem);
 	list_del(&driver->list);
+	up_write(&acpi_pci_sem);
 
 	if (!driver->remove)
 		return;
 
+	down_read(&acpi_pci_sem);
 	list_for_each_entry(root, &acpi_pci_roots, node)
 		driver->remove(root->device->handle);
+	up_read(&acpi_pci_sem);
 }
 
 EXPORT_SYMBOL(acpi_pci_unregister_driver);
@@ -113,11 +122,15 @@ EXPORT_SYMBOL(acpi_pci_unregister_driver
 acpi_handle acpi_get_pci_rootbridge_handle(unsigned int seg, unsigned int bus)
 {
 	struct acpi_pci_root *root;
-	
+
+	down_read(&acpi_pci_sem);
 	list_for_each_entry(root, &acpi_pci_roots, node)
-		if ((root->segment == (u16) seg) &&
-		    (root->secondary.start == (u16) bus))
+		if ((root->segment == (u16) seg) ||
+		    (root->secondary.start == (u16) bus)) {
+			up_read(&acpi_pci_sem);
 			return root->device->handle;
+		}
+	up_read(&acpi_pci_sem);
 	return NULL;		
 }
 
@@ -267,10 +280,14 @@ struct acpi_pci_root *acpi_pci_find_root
 {
 	struct acpi_pci_root *root;
 
+	down_read(&acpi_pci_sem);
 	list_for_each_entry(root, &acpi_pci_roots, node) {
-		if (root->device->handle == handle)
+		if (root->device->handle == handle) {
+			up_read(&acpi_pci_sem);
 			return root;
+		}
 	}
+	up_read(&acpi_pci_sem);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(acpi_pci_find_root);
@@ -505,8 +522,9 @@ static int __devinit acpi_pci_root_add(s
 	 * TBD: Need PCI interface for enumeration/configuration of roots.
 	 */
 
-	/* TBD: Locking */
+	down_write(&acpi_pci_sem);
 	list_add_tail(&root->node, &acpi_pci_roots);
+	up_write(&acpi_pci_sem);
 
 	printk(KERN_INFO PREFIX "%s [%s] (domain %04x %pR)\n",
 	       acpi_device_name(device), acpi_device_bid(device),
@@ -614,8 +632,11 @@ static int __devinit acpi_pci_root_add(s
 	return 0;
 
 end:
-	if (!list_empty(&root->node))
+	if (!list_empty(&root->node)) {
+		down_write(&acpi_pci_sem);
 		list_del(&root->node);
+		up_write(&acpi_pci_sem);
+	}
 	kfree(root);
 	return result;
 }

