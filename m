Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:37904 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759173Ab2FUJjd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2012 05:39:33 -0400
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id E5D123EE0BC
	for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 18:39:32 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id C783245DE5B
	for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 18:39:32 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id AE49245DE56
	for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 18:39:32 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9A0C51DB8050
	for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 18:39:32 +0900 (JST)
Received: from m0000.s.css.fujitsu.com (m0000.s.css.fujitsu.com [10.23.4.183])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 55EB01DB804D
	for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 18:39:32 +0900 (JST)
Date: Thu, 21 Jun 2012 18:39:44 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH 4/4] acpi, pci: add resoruce-assign code for devices under
 hot-added hostbridge
Message-Id: <20120621183944.a769aabe.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120621183430.2b84fb53.izumi.taku@jp.fujitsu.com>
References: <20120621183430.2b84fb53.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Devices under hot-added hostbridge have no chance to assign resources
and to configure them, so this patch adds such code for hot-added 
hostbridges at acpi_pci_root_start().

Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
---
 drivers/acpi/pci_root.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

Index: linux/drivers/acpi/pci_root.c
===================================================================
--- linux.orig/drivers/acpi/pci_root.c
+++ linux/drivers/acpi/pci_root.c
@@ -38,6 +38,7 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/apei.h>
+#include <linux/pci_hotplug.h>
 
 #define PREFIX "ACPI: "
 
@@ -644,6 +645,19 @@ end:
 static int acpi_pci_root_start(struct acpi_device *device)
 {
 	struct acpi_pci_root *root = acpi_driver_data(device);
+	struct pci_dev *pdev;
+
+	/*
+	 * Devices under hot-added hostbridge have no chance to assign
+	 * resources and to configure them, so do that here
+	 */
+	if (system_state != SYSTEM_BOOTING) {
+		pci_bus_size_bridges(root->bus);
+		pci_bus_assign_resources(root->bus);
+		list_for_each_entry(pdev, &root->bus->devices, bus_list)
+			pci_configure_slot(pdev);
+		pci_enable_bridges(root->bus);
+	}
 
 	pci_bus_add_devices(root->bus);
 	return 0;

