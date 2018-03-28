Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:53974 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752932AbeC1LvD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Mar 2018 07:51:03 -0400
From: Niklas Cassel <niklas.cassel@axis.com>
To: kishon@ti.com, cyrille.pitchen@free-electrons.com,
        Alan Douglas <adouglas@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/12] PCI: cadence: Set PCI_BASE_ADDRESS_MEM_TYPE_64 if a 64-bit BAR was set-up
Date: Wed, 28 Mar 2018 13:50:12 +0200
Message-Id: <20180328115018.31921-8-niklas.cassel@axis.com>
In-Reply-To: <20180328115018.31921-1-niklas.cassel@axis.com>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

cdns_pcie_ep_set_bar() does some round-up of the BAR size, which means
that a 64-bit BAR can be set-up, even when the flag
PCI_BASE_ADDRESS_MEM_TYPE_64 isn't set.

If a 64-bit BAR was set-up, set the flag PCI_BASE_ADDRESS_MEM_TYPE_64,
so that the calling function can know what BAR width that was actually
set-up.

I'm not sure why cdns_pcie_ep_set_bar() doesn't obey the flag
PCI_BASE_ADDRESS_MEM_TYPE_64, but I leave this for the MAINTAINER to
fix, since there might be a reason why this flag is ignored.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/cadence/pcie-cadence-ep.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/cadence/pcie-cadence-ep.c b/drivers/pci/cadence/pcie-cadence-ep.c
index cef36cd6b710..2905e098678c 100644
--- a/drivers/pci/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/cadence/pcie-cadence-ep.c
@@ -106,6 +106,9 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn,
 		if (is_64bits && (bar & 1))
 			return -EINVAL;
 
+		if (is_64bits && !(flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
+			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
+
 		if (is_64bits && is_prefetch)
 			ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS;
 		else if (is_prefetch)
-- 
2.14.2
