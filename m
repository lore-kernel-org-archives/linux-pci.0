Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:40058 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932166Ab2GDIHO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jul 2012 04:07:14 -0400
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 2CD263EE0BB
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:07:13 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id D2AD245DEAD
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:07:12 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id BBC6C45DE7E
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:07:12 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id AC3E61DB803E
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:07:12 +0900 (JST)
Received: from m0001.s.css.fujitsu.com (m0001.s.css.fujitsu.com [10.23.4.186])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 69253E18001
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:07:12 +0900 (JST)
Date: Wed, 4 Jul 2012 17:07:07 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH 2/7] PCI: Correctly clean up pci root buses in function
 pci_remove_bus()
Message-Id: <20120704170707.9303dc62.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120704170345.07cd0ad7.izumi.taku@jp.fujitsu.com>
References: <20120704170345.07cd0ad7.izumi.taku@jp.fujitsu.com>
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

Index: linux/drivers/pci/remove.c
===================================================================
--- linux.orig/drivers/pci/remove.c	2012-07-04 09:54:52.126485695 +0900
+++ linux/drivers/pci/remove.c	2012-07-04 09:55:33.695965952 +0900
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
 

