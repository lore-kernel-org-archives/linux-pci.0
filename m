Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:32471 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249AbaGCUrC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jul 2014 16:47:02 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Guo Chao <yan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v4 3/3] PCI: Avoid size overflow for bridge 32bit resource
Date: Thu,  3 Jul 2014 13:46:19 -0700
Message-Id: <1404420379-20983-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1404420379-20983-1-git-send-email-yinghai@kernel.org>
References: <1404420379-20983-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When mmio64_mask is not used, overall size should not bigger than 2G
for single bridge.
Get out early, so we could have chance to have some child resources get
assigned instead of failing all of them, as bridge resource assigned
is too small when overflow happens.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/setup-bus.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: linux-2.6/drivers/pci/setup-bus.c
===================================================================
--- linux-2.6.orig/drivers/pci/setup-bus.c
+++ linux-2.6/drivers/pci/setup-bus.c
@@ -957,6 +957,16 @@ static int pbus_size_mem(struct pci_bus
 					  (r->flags & mask) != type3))
 				continue;
 			r_size = resource_size(r);
+
+			/* reject oversize early */
+			if (!mem64_mask &&
+			    ((unsigned long long)size + r_size > (1ULL<<31))) {
+				dev_warn(&dev->dev, "disabling BAR %d: %pR size %#llx overflow bridge's)\n",
+					i, r, (unsigned long long)size);
+				r->flags = 0;
+				continue;
+			}
+
 #ifdef CONFIG_PCI_IOV
 			/* put SRIOV requested res to the optional list */
 			if (realloc_head && i >= PCI_IOV_RESOURCES &&
