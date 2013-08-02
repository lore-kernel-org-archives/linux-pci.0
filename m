Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:58444 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758247Ab3HBJdr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Aug 2013 05:33:47 -0400
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 2 Aug 2013 14:58:16 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id E6770E0053
	for <linux-pci@vger.kernel.org>; Fri,  2 Aug 2013 15:03:51 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r729Xcs747644820
	for <linux-pci@vger.kernel.org>; Fri, 2 Aug 2013 15:03:38 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r729Xdti020153
	for <linux-pci@vger.kernel.org>; Fri, 2 Aug 2013 19:33:40 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: linuxram@us.ibm.com, shangw@linux.vnet.ibm.com,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH 3/4] PCI: trivial cleanup in pbus_size_io()
Date: Fri,  2 Aug 2013 17:31:05 +0800
Message-Id: <1375435866-16332-4-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1375435866-16332-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1375435866-16332-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch did several cleanup in pbus_size_io():
1. change the type of size to resource_size_t
2. fix the warning in dev_printk() for the change of type

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/setup-bus.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 939ca1b..d4f1ad9 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -747,7 +747,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 {
 	struct pci_dev *dev;
 	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO);
-	unsigned long size = 0, size0 = 0, size1 = 0;
+	resource_size_t size = 0, size0 = 0, size1 = 0;
 	resource_size_t children_add_size = 0;
 	resource_size_t min_align, io_align, align;
 
@@ -807,8 +807,9 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 		add_to_list(realloc_head, bus->self, b_res, size1-size0,
 			    min_align);
 		dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window "
-				 "%pR to %pR add_size %lx\n", b_res,
-				 &bus->busn_res, size1-size0);
+				 "%pR to %pR add_size %llx\n", b_res,
+				 &bus->busn_res,
+				 (unsigned long long)size1-size0);
 	}
 }
 
-- 
1.7.5.4

