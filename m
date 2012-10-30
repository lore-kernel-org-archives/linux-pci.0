Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:50101 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742Ab2J3GZs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Oct 2012 02:25:48 -0400
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 988E83EE0C0
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:25:47 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 7E0DC45DE56
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:25:47 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5772145DE5D
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:25:47 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 44A5B1DB804F
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:25:47 +0900 (JST)
Received: from m003.s.css.fujitsu.com (m003.s.css.fujitsu.com [10.23.4.33])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id F1BCDE38003
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:25:46 +0900 (JST)
Date: Tue, 30 Oct 2012 15:25:39 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 3/5] PCI,ACPI: Remove _PRT info when removing a host bridge
Message-Id: <20121030152539.dad71d2b.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20121030062124.BE34D2E0805@m003.s.css.fujitsu.com>
References: <20121030062124.BE34D2E0805@m003.s.css.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Author: Bjorn Helgaas <bhelgaas@google.com>

PCI/ACPI: Remove _PRT info when removing a host bridge
    
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
---
 drivers/acpi/pci_root.c |    2 ++
 1 file changed, 2 insertions(+)

Index: Bjorn-next-0925/drivers/acpi/pci_root.c
===================================================================
--- Bjorn-next-0925.orig/drivers/acpi/pci_root.c
+++ Bjorn-next-0925/drivers/acpi/pci_root.c
@@ -671,6 +671,8 @@ static int acpi_pci_root_remove(struct a
 	device_set_run_wake(root->bus->bridge, false);
 	pci_acpi_remove_bus_pm_notifier(device);
 
+	acpi_pci_irq_del_prt(root->segment, root->secondary.start);
+
 	list_del(&root->node);
 	mutex_unlock(&acpi_pci_root_lock);
 	kfree(root);

