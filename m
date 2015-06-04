Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:46540 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbbFDGnl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2015 02:43:41 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 4 Jun 2015 16:43:40 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
	panto@antoniou-consulting.com, robherring2@gmail.com,
	grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 27/42] powerpc/powernv: Simplify pnv_eeh_reset()
Date: Thu,  4 Jun 2015 16:41:56 +1000
Message-Id: <1433400131-18429-28-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch simplifies pnv_eeh_reset() by dropping unnecessary nested
if statement. No logic changed by the patch.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Split from PATCH[v4 09/21]
  * Fixed "quoted string split across lines" from checkpatch.pl
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 65 +++++++++++++---------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 4feb533..4669122 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1084,7 +1084,9 @@ void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
 static int pnv_eeh_reset(struct eeh_pe *pe, int option)
 {
 	struct pci_controller *hose = pe->phb;
+	struct pnv_phb *phb = hose->private_data;
 	struct pci_bus *bus;
+	int64_t rc;
 	int ret;
 
 	/*
@@ -1101,44 +1103,39 @@ static int pnv_eeh_reset(struct eeh_pe *pe, int option)
 	 * reset. The side effect is that EEH core has to clear the frozen
 	 * state explicitly after BAR restore.
 	 */
-	if (pe->type & EEH_PE_PHB) {
-		ret = pnv_eeh_phb_reset(hose, option);
-	} else {
-		struct pnv_phb *phb;
-		s64 rc;
+	if (pe->type & EEH_PE_PHB)
+		return pnv_eeh_phb_reset(hose, option);
 
-		/*
-		 * The frozen PE might be caused by PAPR error injection
-		 * registers, which are expected to be cleared after hitting
-		 * frozen PE as stated in the hardware spec. Unfortunately,
-		 * that's not true on P7IOC. So we have to clear it manually
-		 * to avoid recursive EEH errors during recovery.
-		 */
-		phb = hose->private_data;
-		if (phb->model == PNV_PHB_MODEL_P7IOC &&
-		    (option == EEH_RESET_HOT ||
-		    option == EEH_RESET_FUNDAMENTAL)) {
-			rc = opal_pci_reset(phb->opal_id,
-					    OPAL_RESET_PHB_ERROR,
-					    OPAL_ASSERT_RESET);
-			if (rc != OPAL_SUCCESS) {
-				pr_warn("%s: Failure %lld clearing "
-					"error injection registers\n",
-					__func__, rc);
-				return -EIO;
-			}
+	/*
+	 * The frozen PE might be caused by PAPR error injection
+	 * registers, which are expected to be cleared after hitting
+	 * frozen PE as stated in the hardware spec. Unfortunately,
+	 * that's not true on P7IOC. So we have to clear it manually
+	 * to avoid recursive EEH errors during recovery.
+	 */
+	phb = hose->private_data;
+	if (phb->model == PNV_PHB_MODEL_P7IOC &&
+	    (option == EEH_RESET_HOT ||
+	    option == EEH_RESET_FUNDAMENTAL)) {
+		rc = opal_pci_reset(phb->opal_id,
+				    OPAL_RESET_PHB_ERROR,
+				    OPAL_ASSERT_RESET);
+		if (rc != OPAL_SUCCESS) {
+			pr_warn("%s: Error %lld clearing errinjct registers\n",
+				__func__, rc);
+			return -EIO;
 		}
-
-		bus = eeh_pe_bus_get(pe);
-		if (pe->type & EEH_PE_VF)
-			ret = pnv_eeh_vf_pe_reset(pe, option);
-		else if (pci_is_root_bus(bus) ||
-			pci_is_root_bus(bus->parent))
-			ret = pnv_eeh_root_reset(hose, option);
-		else
-			ret = pnv_eeh_bridge_reset(bus->self, option);
 	}
 
+	bus = eeh_pe_bus_get(pe);
+	if (pe->type & EEH_PE_VF)
+		ret = pnv_eeh_vf_pe_reset(pe, option);
+	else if (pci_is_root_bus(bus) ||
+		pci_is_root_bus(bus->parent))
+		ret = pnv_eeh_root_reset(hose, option);
+	else
+		ret = pnv_eeh_bridge_reset(bus->self, option);
+
 	return ret;
 }
 
-- 
2.1.0

