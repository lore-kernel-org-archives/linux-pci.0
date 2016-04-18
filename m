Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:47743 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbcDRK5i (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2016 06:57:38 -0400
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Mon, 18 Apr 2016 20:57:36 +1000
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	corbet@lwn.net, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	gwshan@linux.vnet.ibm.com, Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC v6 02/10] PCI: Do not Use IORESOURCE_STARTALIGN to identify bridge resources
Date: Mon, 18 Apr 2016 18:55:58 +0800
Message-Id: <1460976961-29328-2-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1460976961-29328-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1460976961-29328-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now we use the IORESOURCE_STARTALIGN to identify bridge resources
in __assign_resources_sorted(). That's quite fragile. We can't
make sure that the PCI devices' resources will not use
IORESOURCE_STARTALIGN any more.

In this patch, we try to use a more robust way to identify
bridge resources.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/pci/setup-bus.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7796d0a..45fc484 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -391,6 +391,7 @@ static void __assign_resources_sorted(struct list_head *head,
 	struct pci_dev_resource *dev_res, *tmp_res, *dev_res2;
 	unsigned long fail_type;
 	resource_size_t add_align, align;
+	int index;
 
 	/* Check if optional add_size is there */
 	if (!realloc_head || list_empty(realloc_head))
@@ -411,11 +412,13 @@ static void __assign_resources_sorted(struct list_head *head,
 
 		/*
 		 * There are two kinds of additional resources in the list:
-		 * 1. bridge resource  -- IORESOURCE_STARTALIGN
-		 * 2. SR-IOV resource   -- IORESOURCE_SIZEALIGN
+		 * 1. bridge resource
+		 * 2. SR-IOV resource
 		 * Here just fix the additional alignment for bridge
 		 */
-		if (!(dev_res->res->flags & IORESOURCE_STARTALIGN))
+		index = dev_res->res - dev_res->dev->resource;
+		if (index < PCI_BRIDGE_RESOURCES ||
+			index > PCI_BRIDGE_RESOURCE_END)
 			continue;
 
 		add_align = get_res_add_align(realloc_head, dev_res->res);
-- 
1.7.9.5

