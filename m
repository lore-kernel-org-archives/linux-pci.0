Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:36158 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932375Ab2FUJg5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2012 05:36:57 -0400
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 171A73EE081
	for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 18:36:57 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id F21BB45DE54
	for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 18:36:56 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id D8A2045DE51
	for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 18:36:56 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id C98501DB803B
	for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 18:36:56 +0900 (JST)
Received: from m003.s.css.fujitsu.com (m003.s.css.fujitsu.com [10.23.4.33])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 80E72E18004
	for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 18:36:56 +0900 (JST)
Date: Thu, 21 Jun 2012 18:37:06 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH 1/4] acpi, pci: introduce list for acpi_pci_root drivers
Message-Id: <20120621183706.b5e4417d.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120621183430.2b84fb53.izumi.taku@jp.fujitsu.com>
References: <20120621183430.2b84fb53.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use struct list_head for pci root sub drivers manipulation. This has
no functional change.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
---
 drivers/acpi/pci_root.c |   17 +++--------------
 include/linux/acpi.h    |    2 +-
 2 files changed, 4 insertions(+), 15 deletions(-)

Index: linux/drivers/acpi/pci_root.c
===================================================================
--- linux.orig/drivers/acpi/pci_root.c
+++ linux/drivers/acpi/pci_root.c
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
+	list_add(&driver->list, &acpi_pci_drivers);
 
 	if (!driver->add)
 		return 0;
@@ -93,7 +90,6 @@ int acpi_pci_register_driver(struct acpi
 		driver->add(root->device->handle);
 		n++;
 	}
-
 	return n;
 }
 
@@ -103,14 +99,7 @@ void acpi_pci_unregister_driver(struct a
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
+	list_del(&driver->list);
 
 	if (!driver->remove)
 		return;
Index: linux/include/linux/acpi.h
===================================================================
--- linux.orig/include/linux/acpi.h
+++ linux/include/linux/acpi.h
@@ -138,7 +138,7 @@ void acpi_penalize_isa_irq(int irq, int 
 void acpi_pci_irq_disable (struct pci_dev *dev);
 
 struct acpi_pci_driver {
-	struct acpi_pci_driver *next;
+	struct list_head list;
 	int (*add)(acpi_handle handle);
 	void (*remove)(acpi_handle handle);
 };

