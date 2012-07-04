Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:34397 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932567Ab2GDIIS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jul 2012 04:08:18 -0400
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id EFA0A3EE0BB
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:08:17 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id D82C045DEA6
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:08:17 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id B81AA45DEB9
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:08:17 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id A82251DB803B
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:08:17 +0900 (JST)
Received: from m003.s.css.fujitsu.com (m003.s.css.fujitsu.com [10.23.4.33])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 43AB31DB8047
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:08:17 +0900 (JST)
Date: Wed, 4 Jul 2012 17:08:11 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH 3/7] ACPI, PCI: Use normal list for struct acpi_pci_driver
Message-Id: <20120704170811.98ec88dc.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120704170345.07cd0ad7.izumi.taku@jp.fujitsu.com>
References: <20120704170345.07cd0ad7.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <jiang.liu@huawei.com>

    ACPI, PCI: Use normal list for struct acpi_pci_driver
    
    Use normal list for struct acpi_pci_driver to simplify code.
    
    Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
    Signed-off-by: Yinghai Lu <yinghai@kernel.org>

Index: linux/drivers/acpi/pci_root.c
===================================================================
--- linux.orig/drivers/acpi/pci_root.c	2012-07-04 09:54:52.061486507 +0900
+++ linux/drivers/acpi/pci_root.c	2012-07-04 09:55:45.697815965 +0900
@@ -72,8 +72,8 @@ static struct acpi_driver acpi_pci_root_
 };
 
 static LIST_HEAD(acpi_pci_roots);
+static LIST_HEAD(acpi_pci_drivers);
 
-static struct acpi_pci_driver *sub_driver;
 static DEFINE_MUTEX(osc_lock);
 
 int acpi_pci_register_driver(struct acpi_pci_driver *driver)
@@ -81,10 +81,7 @@ int acpi_pci_register_driver(struct acpi
 	int n = 0;
 	struct acpi_pci_root *root;
 
-	struct acpi_pci_driver **pptr = &sub_driver;
-	while (*pptr)
-		pptr = &(*pptr)->next;
-	*pptr = driver;
+	list_add_tail(&driver->node, &acpi_pci_drivers);
 
 	if (!driver->add)
 		return 0;
@@ -103,14 +100,7 @@ void acpi_pci_unregister_driver(struct a
 {
 	struct acpi_pci_root *root;
 
-	struct acpi_pci_driver **pptr = &sub_driver;
-	while (*pptr) {
-		if (*pptr == driver)
-			break;
-		pptr = &(*pptr)->next;
-	}
-	BUG_ON(!*pptr);
-	*pptr = (*pptr)->next;
+	list_del(&driver->node);
 
 	if (!driver->remove)
 		return;
Index: linux/include/linux/acpi.h
===================================================================
--- linux.orig/include/linux/acpi.h	2012-07-04 09:54:52.061486507 +0900
+++ linux/include/linux/acpi.h	2012-07-04 09:55:45.697815965 +0900
@@ -138,7 +138,7 @@ void acpi_penalize_isa_irq(int irq, int 
 void acpi_pci_irq_disable (struct pci_dev *dev);
 
 struct acpi_pci_driver {
-	struct acpi_pci_driver *next;
+	struct list_head node;
 	int (*add)(acpi_handle handle);
 	void (*remove)(acpi_handle handle);
 };

