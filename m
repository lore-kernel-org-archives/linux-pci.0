Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:42782 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108Ab3GAPLi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2013 11:11:38 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 2 Jul 2013 00:59:51 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id EB9563578051
	for <linux-pci@vger.kernel.org>; Tue,  2 Jul 2013 01:11:33 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r61FBOUK6881620
	for <linux-pci@vger.kernel.org>; Tue, 2 Jul 2013 01:11:24 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r61FBXR9023900
	for <linux-pci@vger.kernel.org>; Tue, 2 Jul 2013 01:11:33 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: weiyang@linux.vnet.ibm.com, linuxram@us.ibm.com,
	shangw@linux.vnet.ibm.com
Subject: [PATCH 3/4] PCI: trivial cleanup in pbus_size_io()
Date: Mon,  1 Jul 2013 23:10:31 +0800
Message-Id: <1372691432-6440-4-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1372691432-6440-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1372691432-6440-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch did several cleanup in pbus_size_io():
1. change the type of size to resource_size_t
2. fix the warning in dev_printk() for the change of type

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Reviewed-by: Gavin Shan <shangw@linux.vnet.ibm.com>
Reviewed-by: Ram Pai <linuxram@us.ibm.com>
---
 drivers/pci/setup-bus.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 43dbe0a..bd0ce39d 100644
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

