Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:53924 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752782AbeC1Lus (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Mar 2018 07:50:48 -0400
From: Niklas Cassel <niklas.cassel@axis.com>
To: kishon@ti.com, cyrille.pitchen@free-electrons.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/12] PCI: endpoint: Setting 64-bit/prefetch bit is invalid when IO is set
Date: Wed, 28 Mar 2018 13:50:09 +0200
Message-Id: <20180328115018.31921-5-niklas.cassel@axis.com>
In-Reply-To: <20180328115018.31921-1-niklas.cassel@axis.com>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If flag PCI_BASE_ADDRESS_SPACE_IO is set, also having any
PCI_BASE_ADDRESS_MEM_* bit set is invalid.

This sanity check is done in pci_epc_set_bar(), so that we don't need
to do this sanity check in all epc->ops->set_bar() implementations.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 109d75f0b7d2..40eea20d21f9 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -309,10 +309,13 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
 {
 	int ret;
 	unsigned long irq_flags;
+	int flags = epf_bar->flags;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
 	    (epf_bar->barno == BAR_5 &&
-	     epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
+	     flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ||
+	    (flags & PCI_BASE_ADDRESS_SPACE_IO &&
+	     flags & PCI_BASE_ADDRESS_IO_MASK))
 		return -EINVAL;
 
 	if (!epc->ops->set_bar)
-- 
2.14.2
