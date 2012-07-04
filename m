Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:43070 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933382Ab2GDIGs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jul 2012 04:06:48 -0400
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 6AC1D3EE0C1
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:06:46 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 4783E45DEB7
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:06:46 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 22D8145DEB4
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:06:46 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 0C03D1DB8040
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:06:46 +0900 (JST)
Received: from m001.s.css.fujitsu.com (m001.s.css.fujitsu.com [10.23.4.39])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id B9DAB1DB803C
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:06:45 +0900 (JST)
Date: Wed, 4 Jul 2012 17:06:37 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH 1/7] x86, PCI: Fix non acpi path pci_sysdata leaking with
 release_fn
Message-Id: <20120704170637.e1fd77f5.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120704170345.07cd0ad7.izumi.taku@jp.fujitsu.com>
References: <20120704170345.07cd0ad7.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Yinghai Lu <yinghai@kernel.org>

    x86, PCI: Fix non acpi path pci_sysdata leaking with release_fn
    
    Non acpi path, or root is not probed from acpi, during root bus removal
    will get warning about leaking from pci_scan_bus_on_node.
    
    Fix it with setting pci_host_bridge release function.
    
    Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 arch/x86/pci/common.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

Index: linux/arch/x86/pci/common.c
===================================================================
--- linux.orig/arch/x86/pci/common.c	2012-07-04 09:54:52.159485283 +0900
+++ linux/arch/x86/pci/common.c	2012-07-04 09:54:59.788389907 +0900
@@ -634,17 +634,19 @@ int pci_ext_cfg_avail(struct pci_dev *de
 		return 0;
 }
 
+static void release_pci_sysdata(struct pci_host_bridge *bridge)
+{
+	struct pci_sysdata *sd = bridge->release_data;
+
+	kfree(sd);
+}
+
 struct pci_bus * __devinit pci_scan_bus_on_node(int busno, struct pci_ops *ops, int node)
 {
 	LIST_HEAD(resources);
 	struct pci_bus *bus = NULL;
 	struct pci_sysdata *sd;
 
-	/*
-	 * Allocate per-root-bus (not per bus) arch-specific data.
-	 * TODO: leak; this memory is never freed.
-	 * It's arguable whether it's worth the trouble to care.
-	 */
 	sd = kzalloc(sizeof(*sd), GFP_KERNEL);
 	if (!sd) {
 		printk(KERN_ERR "PCI: OOM, skipping PCI bus %02x\n", busno);
@@ -654,7 +656,10 @@ struct pci_bus * __devinit pci_scan_bus_
 	x86_pci_root_bus_resources(busno, &resources);
 	printk(KERN_DEBUG "PCI: Probing PCI hardware (bus %02x)\n", busno);
 	bus = pci_scan_root_bus(NULL, busno, ops, sd, &resources);
-	if (!bus) {
+	if (bus)
+		pci_set_host_bridge_release(to_pci_host_bridge(bus->bridge),
+					release_pci_sysdata, sd);
+	else {
 		pci_free_resource_list(&resources);
 		kfree(sd);
 	}

