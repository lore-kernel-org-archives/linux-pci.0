Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:44482 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeGKIEI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jul 2018 04:04:08 -0400
From: Colin King <colin.king@canonical.com>
To: Alan Douglas <adouglas@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: pcie-candence-ep: remove redundant variable mmc
Date: Wed, 11 Jul 2018 09:01:03 +0100
Message-Id: <20180711080103.4581-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Variable mmc is being assigned but is never used hence it is redundant
and can be removed.

Cleans up clang warning:
warning: variable 'mmc' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pci/controller/pcie-cadence-ep.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index e3fe4124e3af..63549e03eae8 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -238,7 +238,7 @@ static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
 	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
-	u16 flags, mmc, mme;
+	u16 flags, mme;
 
 	/* Validate that the MSI feature is actually enabled. */
 	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
@@ -249,7 +249,6 @@ static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
 	 * Get the Multiple Message Enable bitfield from the Message Control
 	 * register.
 	 */
-	mmc = (flags & PCI_MSI_FLAGS_QMASK) >> 1;
 	mme = (flags & PCI_MSI_FLAGS_QSIZE) >> 4;
 
 	return mme;
-- 
2.17.1
