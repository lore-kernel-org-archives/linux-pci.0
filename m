Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:54114 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753514AbeDTSVT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Apr 2018 14:21:19 -0400
From: "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To: Frederick Lawler <fred@fredlawl.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@mellanox.com" <jgg@mellanox.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] IB/hfi1: Replace custom hfi1 macros with PCIe
 macros
Date: Fri, 20 Apr 2018 18:21:17 +0000
Message-ID: <14063C7AD467DE4B82DEDB5C278E8663B2E28205@fmsmsx107.amr.corp.intel.com>
References: <20180417002825.2737-1-fred@fredlawl.com>
 <20180417002825.2737-3-fred@fredlawl.com>
In-Reply-To: <20180417002825.2737-3-fred@fredlawl.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>-----Original Message-----
>From: linux-rdma-owner@vger.kernel.org [mailto:linux-rdma-
>owner@vger.kernel.org] On Behalf Of Frederick Lawler
>Sent: Monday, April 16, 2018 8:28 PM
>To: bhelgaas@google.com; Marciniszyn, Mike <mike.marciniszyn@intel.com>;
>Dalessandro, Dennis <dennis.dalessandro@intel.com>;
>dledford@redhat.com; jgg@mellanox.com
>Cc: linux-pci@vger.kernel.org; linux-rdma@vger.kernel.org; Frederick Lawler
><fred@fredlawl.com>
>Subject: [PATCH v3 2/2] IB/hfi1: Replace custom hfi1 macros with PCIe macros
>
>IB/hfi1 contains custom macros for PCIe link configuration. Remove the
>custom macros in favor of the PCIe link macros. No functional change
>intended.
>
>Signed-off-by: Frederick Lawler <fred@fredlawl.com>

This looks good.

Thanks!

Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>


>--
>V3: Use PCI_EXP_LNKCTL2_TLS* macros
>V2: s/LINK/LNK
>---
> drivers/infiniband/hw/hfi1/pcie.c | 24 ++++++++----------------
> 1 file changed, 8 insertions(+), 16 deletions(-)
>
>diff --git a/drivers/infiniband/hw/hfi1/pcie.c
>b/drivers/infiniband/hw/hfi1/pcie.c
>index 83d66e862207..fe2a6d602856 100644
>--- a/drivers/infiniband/hw/hfi1/pcie.c
>+++ b/drivers/infiniband/hw/hfi1/pcie.c
>@@ -56,11 +56,6 @@
> #include "chip_registers.h"
> #include "aspm.h"
>
>-/* link speed vector for Gen3 speed - not in Linux headers */
>-#define GEN1_SPEED_VECTOR 0x1
>-#define GEN2_SPEED_VECTOR 0x2
>-#define GEN3_SPEED_VECTOR 0x3
>-
> /*
>  * This file contains PCIe utility routines.
>  */
>@@ -265,7 +260,7 @@ static u32 extract_speed(u16 linkstat)
> 	case PCI_EXP_LNKSTA_CLS_5_0GB:
> 		speed = 5000; /* Gen 2, 5GHz */
> 		break;
>-	case GEN3_SPEED_VECTOR:
>+	case PCI_EXP_LNKSTA_CLS_8_0GB:
> 		speed = 8000; /* Gen 3, 8GHz */
> 		break;
> 	}
>@@ -320,7 +315,7 @@ int pcie_speeds(struct hfi1_devdata *dd)
> 		return ret;
> 	}
>
>-	if ((linkcap & PCI_EXP_LNKCAP_SLS) != GEN3_SPEED_VECTOR) {
>+	if ((linkcap & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_8_0GB)
>{
> 		dd_dev_info(dd,
> 			    "This HFI is not Gen3 capable, max speed 0x%x,
>need 0x3\n",
> 			    linkcap & PCI_EXP_LNKCAP_SLS);
>@@ -697,9 +692,6 @@ const struct pci_error_handlers hfi1_pci_err_handler =
>{
> /* gasket block secondary bus reset delay */
> #define SBR_DELAY_US 200000	/* 200ms */
>
>-/* mask for PCIe capability register lnkctl2 target link speed */
>-#define LNKCTL2_TARGET_LINK_SPEED_MASK 0xf
>-
> static uint pcie_target = 3;
> module_param(pcie_target, uint, S_IRUGO);
> MODULE_PARM_DESC(pcie_target, "PCIe target speed (0 skip, 1-3 Gen1-3)");
>@@ -1048,13 +1040,13 @@ int do_pcie_gen3_transition(struct hfi1_devdata
>*dd)
> 		return 0;
>
> 	if (pcie_target == 1) {			/* target Gen1 */
>-		target_vector = GEN1_SPEED_VECTOR;
>+		target_vector = PCI_EXP_LNKCTL2_TLS_2_5GB;
> 		target_speed = 2500;
> 	} else if (pcie_target == 2) {		/* target Gen2 */
>-		target_vector = GEN2_SPEED_VECTOR;
>+		target_vector = PCI_EXP_LNKCTL2_TLS_5_0GB;
> 		target_speed = 5000;
> 	} else if (pcie_target == 3) {		/* target Gen3 */
>-		target_vector = GEN3_SPEED_VECTOR;
>+		target_vector = PCI_EXP_LNKCTL2_TLS_8_0GB;
> 		target_speed = 8000;
> 	} else {
> 		/* off or invalid target - skip */
>@@ -1293,8 +1285,8 @@ int do_pcie_gen3_transition(struct hfi1_devdata
>*dd)
> 	dd_dev_info(dd, "%s: ..old link control2: 0x%x\n", __func__,
> 		    (u32)lnkctl2);
> 	/* only write to parent if target is not as high as ours */
>-	if ((lnkctl2 & LNKCTL2_TARGET_LINK_SPEED_MASK) < target_vector) {
>-		lnkctl2 &= ~LNKCTL2_TARGET_LINK_SPEED_MASK;
>+	if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) < target_vector) {
>+		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
> 		lnkctl2 |= target_vector;
> 		dd_dev_info(dd, "%s: ..new link control2: 0x%x\n", __func__,
> 			    (u32)lnkctl2);
>@@ -1319,7 +1311,7 @@ int do_pcie_gen3_transition(struct hfi1_devdata
>*dd)
>
> 	dd_dev_info(dd, "%s: ..old link control2: 0x%x\n", __func__,
> 		    (u32)lnkctl2);
>-	lnkctl2 &= ~LNKCTL2_TARGET_LINK_SPEED_MASK;
>+	lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
> 	lnkctl2 |= target_vector;
> 	dd_dev_info(dd, "%s: ..new link control2: 0x%x\n", __func__,
> 		    (u32)lnkctl2);
>--
>2.17.0
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
