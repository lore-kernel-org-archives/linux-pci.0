Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:53284 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935029Ab2JaI1L (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 31 Oct 2012 04:27:11 -0400
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 6F8CD3EE081
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 17:27:09 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 586EC45DEBC
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 17:27:09 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3F32E45DEB6
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 17:27:09 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 317C41DB803F
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 17:27:09 +0900 (JST)
Received: from m0000.s.css.fujitsu.com (m0000.s.css.fujitsu.com [10.23.4.183])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id E33151DB803C
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 17:27:08 +0900 (JST)
Received: from m0000.css.fujitsu.com (m0000 [127.0.0.1])
	by m0000.s.css.fujitsu.com (Postfix) with ESMTP id CDA841015BE
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 17:27:08 +0900 (JST)
Received: from DEUCALION (unknown [10.124.101.32])
	by m0000.s.css.fujitsu.com (Postfix) with SMTP id ADB2E101599
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 17:27:08 +0900 (JST)
Date: Wed, 31 Oct 2012 17:27:05 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v3,RESEND 8/8] ACPI, PCI: add resoruce-assign code for
 devices under hot-added hostbridge
Message-Id: <20121031172705.d8978e83.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20121030040237.GA10472@google.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
	<20120918152553.8c8390d8.izumi.taku@jp.fujitsu.com>
	<CAErSpo7hYHkFAgFy=q6ASV_15r-y_Cp=92nUdRAnBSGLi9ZMrA@mail.gmail.com>
	<20120928184627.0b039d14.izumi.taku@jp.fujitsu.com>
	<20121030040237.GA10472@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Devices under hot-added hostbridge have no chance to assign resources
and to configure them, so this patch adds such code for hot-added 
hostbridges at acpi_pci_root_start().

diff: updated according to Yinhai's comment
      disconnect dependency on CONFIG_HOTPLUG
      

Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
---
 drivers/acpi/pci_root.c |   13 +++++++++++++
 include/acpi/acpi_bus.h |    1 +
 2 files changed, 14 insertions(+)

Index: Bjorn-next-0925/drivers/acpi/pci_root.c
===================================================================
--- Bjorn-next-0925.orig/drivers/acpi/pci_root.c
+++ Bjorn-next-0925/drivers/acpi/pci_root.c
@@ -628,6 +628,9 @@ static int __devinit acpi_pci_root_add(s
 	if (device->wakeup.flags.run_wake)
 		device_set_run_wake(root->bus->bridge, true);
 
+	if (system_state != SYSTEM_BOOTING)
+		root->hot_added = true;
+
 	return 0;
 
 out_del_root:
@@ -644,6 +647,16 @@ static int acpi_pci_root_start(struct ac
 	struct acpi_pci_root *root = acpi_driver_data(device);
 	struct acpi_pci_driver *driver;
 
+	/*
+	 * Devices under hot-added hostbridge have no chance to assign
+	 * resources and to configure them, so do that here
+	 */
+	if (root->hot_added) {
+		pci_bus_size_bridges(root->bus);
+		pci_bus_assign_resources(root->bus);
+		pci_enable_bridges(root->bus);
+	}
+
 	mutex_lock(&acpi_pci_root_lock);
 	list_for_each_entry(driver, &acpi_pci_drivers, node)
 		if (driver->add)
Index: Bjorn-next-0925/include/acpi/acpi_bus.h
===================================================================
--- Bjorn-next-0925.orig/include/acpi/acpi_bus.h
+++ Bjorn-next-0925/include/acpi/acpi_bus.h
@@ -407,6 +407,7 @@ struct acpi_pci_root {
 	u32 osc_support_set;	/* _OSC state of support bits */
 	u32 osc_control_set;	/* _OSC state of control bits */
 	phys_addr_t mcfg_addr;
+	bool hot_added;
 };
 
 /* helper */

