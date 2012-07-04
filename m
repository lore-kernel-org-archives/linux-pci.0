Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:58672 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756016Ab2GDDQp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jul 2012 23:16:45 -0400
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 4FBBE3EE0AE
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 12:16:44 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 37B6845DE58
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 12:16:44 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 14C6145DD6C
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 12:16:44 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id F2BECE08004
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 12:16:43 +0900 (JST)
Received: from m005.s.css.fujitsu.com (m005.s.css.fujitsu.com [10.23.4.35])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 90DBCE08002
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 12:16:43 +0900 (JST)
Date: Wed, 4 Jul 2012 12:16:39 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH 2/2] pci: reserve extra bus resource for hotplug bridge
Message-Id: <20120704121639.d3949763.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120702134901.83708415.izumi.taku@jp.fujitsu.com>
References: <20120702134901.83708415.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Currently I/O ports and I/O memory resources are reserved for
hotplug bridges and we can tune their size by using hpiosize
and hpmemsize boot option. 

This patch extends feature so that we can reserve additional 
bus number resources for hotplug bridges and tune it by 
using "hpbussize" option.

Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
---
 Documentation/kernel-parameters.txt |    4 ++++
 drivers/pci/pci.c                   |    6 +++++-
 drivers/pci/probe.c                 |    4 ++++
 include/linux/pci.h                 |    1 +
 4 files changed, 14 insertions(+), 1 deletion(-)

Index: linux/drivers/pci/pci.c
===================================================================
--- linux.orig/drivers/pci/pci.c	2012-06-26 14:37:22.000000000 +0900
+++ linux/drivers/pci/pci.c	2012-07-04 10:00:50.708002757 +0900
@@ -74,9 +74,11 @@ unsigned long pci_cardbus_mem_size = DEF
 
 #define DEFAULT_HOTPLUG_IO_SIZE		(256)
 #define DEFAULT_HOTPLUG_MEM_SIZE	(2*1024*1024)
-/* pci=hpmemsize=nnM,hpiosize=nn can override this */
+#define DEFAULT_HOTPLUG_BUS_SIZE	(0)
+/* pci=hpmemsize=nnM,hpiosize=nn,hpbussize=n can override this */
 unsigned long pci_hotplug_io_size  = DEFAULT_HOTPLUG_IO_SIZE;
 unsigned long pci_hotplug_mem_size = DEFAULT_HOTPLUG_MEM_SIZE;
+unsigned int pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
 
 enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_TUNE_OFF;
 
@@ -4022,6 +4024,8 @@ static int __init pci_setup(char *str)
 				pci_hotplug_io_size = memparse(str + 9, &str);
 			} else if (!strncmp(str, "hpmemsize=", 10)) {
 				pci_hotplug_mem_size = memparse(str + 10, &str);
+			} else if (!strncmp(str, "hpbussize=", 10)) {
+				pci_hotplug_bus_size = memparse(str + 10, &str);
 			} else if (!strncmp(str, "pcie_bus_tune_off", 17)) {
 				pcie_bus_config = PCIE_BUS_TUNE_OFF;
 			} else if (!strncmp(str, "pcie_bus_safe", 13)) {
Index: linux/drivers/pci/probe.c
===================================================================
--- linux.orig/drivers/pci/probe.c	2012-06-26 14:37:22.000000000 +0900
+++ linux/drivers/pci/probe.c	2012-07-04 10:00:50.718002632 +0900
@@ -867,6 +867,10 @@ int __devinit pci_scan_bridge(struct pci
 		/*
 		 * Set the subordinate bus number to its real value.
 		 */
+		if (dev->is_hotplug_bridge) {
+			if (max + pci_hotplug_bus_size < child->busn_res.end)
+				max += pci_hotplug_bus_size;
+		}
 		pci_bus_update_busn_res_end(child, max);
 		pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
 	}
Index: linux/include/linux/pci.h
===================================================================
--- linux.orig/include/linux/pci.h	2012-07-04 09:59:43.321845252 +0900
+++ linux/include/linux/pci.h	2012-07-04 10:00:50.725002545 +0900
@@ -1573,6 +1573,7 @@ extern u8 pci_cache_line_size;
 
 extern unsigned long pci_hotplug_io_size;
 extern unsigned long pci_hotplug_mem_size;
+extern unsigned int pci_hotplug_bus_size;
 
 /* Architecture specific versions may override these (weak) */
 int pcibios_add_platform_entries(struct pci_dev *dev);
Index: linux/Documentation/kernel-parameters.txt
===================================================================
--- linux.orig/Documentation/kernel-parameters.txt	2012-07-04 10:00:34.401206673 +0900
+++ linux/Documentation/kernel-parameters.txt	2012-07-04 10:00:50.729002493 +0900
@@ -2174,6 +2174,10 @@ bytes respectively. Such letter suffixes
 		hpmemsize	The fixed amount of bus space which is
 				reserved for hotplug bridge's memory window.
 				The default value is 2 megabytes.
+		hpbussize	The fixed amount of bus space which is
+				reserved for hotplug bridge's additional bus
+				number resources.
+				The default value is 0.
 		resource_alignment=
 				Format:
 				[<order of align>@][<domain>:]<bus>:<slot>.<func>[; ...]

