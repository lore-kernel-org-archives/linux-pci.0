Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
To: kishon@ti.com, cyrille.pitchen@free-electrons.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/12] PCI: endpoint: Make sure that BAR_5 does not have 64-bit flag set when clearing
Date: Wed, 28 Mar 2018 13:50:15 +0200
Message-Id: <20180328115018.31921-11-niklas.cassel@axis.com>
In-Reply-To: <20180328115018.31921-1-niklas.cassel@axis.com>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since a 64-bit BAR consists of a BAR pair, and since there is no
BAR after BAR_5, BAR_5 cannot be 64-bits wide.

This sanity check is done in pci_epc_clear_bar(), so that we don't need
to do this sanity check in all epc->ops->clear_bar() implementations.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
Kishon made a review comment that he wanted this:
https://marc.info/?l=linux-kernel&m=152161168226203

Personally, I don't think that this check is needed,
since pci_epc_set_bar() already does this check,
and no one should modify the flags after pci_epc_set_bar()
has been called.

If everyone agrees, then this patch could be dropped.

 drivers/pci/endpoint/pci-epc-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index eccc942043cb..b0ee42739c3c 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -285,7 +285,9 @@ void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no,
 {
 	unsigned long flags;
 
-	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
+	    (epf_bar->barno == BAR_5 &&
+	     epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
 		return;
 
 	if (!epc->ops->clear_bar)
-- 
2.14.2
