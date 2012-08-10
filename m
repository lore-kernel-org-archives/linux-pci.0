Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:51458 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849Ab2HJGMd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Aug 2012 02:12:33 -0400
Date: Fri, 10 Aug 2012 15:12:27 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com,
	yinghai@kernel.org, jiang.liu@huawei.com
Subject: [PATCH 2/7][RESEND] PCI: Correctly clean up pci root buses in
 function pci_remove_bus()
Message-Id: <20120810151227.cc02c783.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120810150955.e4ab3c7f.izumi.taku@jp.fujitsu.com>
References: <20120810150955.e4ab3c7f.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <jiang.liu@huawei.com>

    Correctly clean up pci root buses in function pci_remove_bus()
    
    The function pci_create_root_bus() allocates the pci bus structure,
    registers the bus device and creates the legacy files for a pci root
    bus, but returns without setting the is_added flag. The is_added flag
    for a pci root bus will be set by function pci_scan_child_bus().
    If a pci root bus is destroyed before calling pci_scan_child_bus(),
    the is_added flag will not be set.  So teach function pci_remove_bus()
    to detect such a case and correctly clean up pci root buses.
    
    Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
    Signed-off-by: Yinghai Lu <yinghai@kernel.org>
    Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
---
 drivers/pci/remove.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: Bjorn-next-0808/drivers/pci/remove.c
===================================================================
--- Bjorn-next-0808.orig/drivers/pci/remove.c
+++ Bjorn-next-0808/drivers/pci/remove.c
@@ -70,11 +70,10 @@ void pci_remove_bus(struct pci_bus *pci_
 	list_del(&pci_bus->node);
 	pci_bus_release_busn_res(pci_bus);
 	up_write(&pci_bus_sem);
-	if (!pci_bus->is_added)
-		return;
-
-	pci_remove_legacy_files(pci_bus);
-	device_unregister(&pci_bus->dev);
+	if (pci_bus->is_added || pci_is_root_bus(pci_bus)) {
+		pci_remove_legacy_files(pci_bus);
+		device_unregister(&pci_bus->dev);
+	}
 }
 EXPORT_SYMBOL(pci_remove_bus);
 

