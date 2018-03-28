Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:53906 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbeC1Lur (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Mar 2018 07:50:47 -0400
From: Niklas Cassel <niklas.cassel@axis.com>
To: kishon@ti.com, cyrille.pitchen@free-electrons.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/12] PCI: endpoint: Setting BAR_5 to 64-bits wide is invalid
Date: Wed, 28 Mar 2018 13:50:08 +0200
Message-Id: <20180328115018.31921-4-niklas.cassel@axis.com>
In-Reply-To: <20180328115018.31921-1-niklas.cassel@axis.com>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since a 64-bit BAR consists of a BAR pair, and since there is no
BAR after BAR_5, BAR_5 cannot be 64-bits wide.

This sanity check is done in pci_epc_set_bar(), so that we don't need
to do this sanity check in all epc->ops->set_bar() implementations.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 784e33d6f229..109d75f0b7d2 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -310,7 +310,9 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
 	int ret;
 	unsigned long irq_flags;
 
-	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
+	    (epf_bar->barno == BAR_5 &&
+	     epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
 		return -EINVAL;
 
 	if (!epc->ops->set_bar)
-- 
2.14.2
