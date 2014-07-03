Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:32267 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844AbaGCUqm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jul 2014 16:46:42 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Guo Chao <yan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v4 1/3] PCI: Fix bus align checking to support more than 8G
Date: Thu,  3 Jul 2014 13:46:17 -0700
Message-Id: <1404420379-20983-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use 128G instead.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/setup-bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/pci/setup-bus.c
===================================================================
--- linux-2.6.orig/drivers/pci/setup-bus.c
+++ linux-2.6/drivers/pci/setup-bus.c
@@ -925,7 +925,7 @@ static int pbus_size_mem(struct pci_bus
 {
 	struct pci_dev *dev;
 	resource_size_t min_align, align, size, size0, size1;
-	resource_size_t aligns[14];	/* Alignments from 1Mb to 8Gb */
+	resource_size_t aligns[18];	/* Alignments from 1Mb to 128Gb */
 	int order, max_order;
 	struct resource *b_res = find_free_bus_resource(bus,
 					mask | IORESOURCE_PREFETCH, type);
