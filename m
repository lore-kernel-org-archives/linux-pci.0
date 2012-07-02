Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:41124 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900Ab2GBEtS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jul 2012 00:49:18 -0400
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 0AA523EE0BB
	for <linux-pci@vger.kernel.org>; Mon,  2 Jul 2012 13:49:17 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id E0ACF45DE56
	for <linux-pci@vger.kernel.org>; Mon,  2 Jul 2012 13:49:16 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id BB72445DE55
	for <linux-pci@vger.kernel.org>; Mon,  2 Jul 2012 13:49:16 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id A5A451DB804B
	for <linux-pci@vger.kernel.org>; Mon,  2 Jul 2012 13:49:16 +0900 (JST)
Received: from m0000.s.css.fujitsu.com (m0000.s.css.fujitsu.com [10.23.4.183])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 583351DB804A
	for <linux-pci@vger.kernel.org>; Mon,  2 Jul 2012 13:49:16 +0900 (JST)
Date: Mon, 2 Jul 2012 13:49:01 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH] pci: reserve extra bus number resource for hotplug bridge
Message-Id: <20120702134901.83708415.izumi.taku@jp.fujitsu.com>
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

This patch also adds missing document for "hpiosize" and
"hpmemsize" option.

Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
---
 Documentation/kernel-parameters.txt |   10 ++++++++++
 drivers/pci/pci.c                   |    6 +++++-
 drivers/pci/probe.c                 |    4 ++++
 include/linux/pci.h                 |    1 +
 4 files changed, 20 insertions(+), 1 deletion(-)

Index: linux/drivers/pci/pci.c
===================================================================
--- linux.orig/drivers/pci/pci.c
+++ linux/drivers/pci/pci.c
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
 
@@ -3826,6 +3828,8 @@ static int __init pci_setup(char *str)
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
--- linux.orig/drivers/pci/probe.c
+++ linux/drivers/pci/probe.c
@@ -865,6 +865,10 @@ int __devinit pci_scan_bridge(struct pci
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
--- linux.orig/include/linux/pci.h
+++ linux/include/linux/pci.h
@@ -1517,6 +1517,7 @@ extern u8 pci_cache_line_size;
 
 extern unsigned long pci_hotplug_io_size;
 extern unsigned long pci_hotplug_mem_size;
+extern unsigned int pci_hotplug_bus_size;
 
 /* Architecture specific versions may override these (weak) */
 int pcibios_add_platform_entries(struct pci_dev *dev);
Index: linux/Documentation/kernel-parameters.txt
===================================================================
--- linux.orig/Documentation/kernel-parameters.txt
+++ linux/Documentation/kernel-parameters.txt
@@ -2138,6 +2138,16 @@ bytes respectively. Such letter suffixes
 		cbmemsize=nn[KMG]	The fixed amount of bus space which is
 				reserved for the CardBus bridge's memory
 				window. The default value is 64 megabytes.
+		hpiosize	The fixed amount of bus space which is
+				reserved for hotplug bridge's IO window.
+				The default value is 256 bytes.
+		hpmemsize	The fixed amount of bus space which is
+				reserved for hotplug bridge's memory window.
+				The default value is 2 megabytes.
+		hpbussize	The fixed amount of bus space which is
+				reserved for hotplug bridge's additional bus
+				number resources.
+				The default value is 0.
 		resource_alignment=
 				Format:
 				[<order of align>@][<domain>:]<bus>:<slot>.<func>[; ...]

