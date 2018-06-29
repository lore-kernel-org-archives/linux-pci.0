Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:41993 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935356AbeF2K1z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jun 2018 06:27:55 -0400
Received: by mail-qk0-f193.google.com with SMTP id u62-v6so4616392qkf.9
        for <linux-pci@vger.kernel.org>; Fri, 29 Jun 2018 03:27:54 -0700 (PDT)
From: Hari Vyas <hari.vyas@broadcom.com>
To: bhelgaas@google.com, benh@kernel.crashing.org
Cc: linux-pci@vger.kernel.org, ray.jui@broadcom.com,
        Hari Vyas <hari.vyas@broadcom.com>
Subject: [PATCH v2 2/3] PCI: use new pci function to get device addition state
Date: Fri, 29 Jun 2018 15:57:40 +0530
Message-Id: <1530268061-17324-3-git-send-email-hari.vyas@broadcom.com>
In-Reply-To: <1530268061-17324-1-git-send-email-hari.vyas@broadcom.com>
References: <1530268061-17324-1-git-send-email-hari.vyas@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Due to one race condition happening while updating pci
device addition and master status bits in a particular
scenario, device addition state is moved to a independent
private flag variable.

This change uses newly proposed pci_dev_is_added() function
to retrieve device addition state.

Signed-off-by: Hari Vyas <hari.vyas@broadcom.com>
---
 arch/powerpc/kernel/pci-common.c          | 4 +++-
 arch/powerpc/platforms/powernv/pci-ioda.c | 3 ++-
 arch/powerpc/platforms/pseries/setup.c    | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index fe9733f..471aac3 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -42,6 +42,8 @@
 #include <asm/ppc-pci.h>
 #include <asm/eeh.h>
 
+#include "../../../drivers/pci/pci.h"
+
 /* hose_spinlock protects accesses to the the phb_bitmap. */
 static DEFINE_SPINLOCK(hose_spinlock);
 LIST_HEAD(hose_list);
@@ -1014,7 +1016,7 @@ void pcibios_setup_bus_devices(struct pci_bus *bus)
 		/* Cardbus can call us to add new devices to a bus, so ignore
 		 * those who are already fully discovered
 		 */
-		if (dev->is_added)
+		if (pci_dev_is_added(dev))
 			continue;
 
 		pcibios_setup_device(dev);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 5bd0eb6..70b2e1e 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -46,6 +46,7 @@
 
 #include "powernv.h"
 #include "pci.h"
+#include "../../../../drivers/pci/pci.h"
 
 #define PNV_IODA1_M64_NUM	16	/* Number of M64 BARs	*/
 #define PNV_IODA1_M64_SEGS	8	/* Segments per M64 BAR	*/
@@ -3138,7 +3139,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 	struct pci_dn *pdn;
 	int mul, total_vfs;
 
-	if (!pdev->is_physfn || pdev->is_added)
+	if (!pdev->is_physfn || pci_dev_is_added(pdev))
 		return;
 
 	pdn = pci_get_pdn(pdev);
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 139f0af..8a4868a 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -71,6 +71,7 @@
 #include <asm/security_features.h>
 
 #include "pseries.h"
+#include "../../../../drivers/pci/pci.h"
 
 int CMO_PrPSP = -1;
 int CMO_SecPSP = -1;
@@ -664,7 +665,7 @@ static void pseries_pci_fixup_iov_resources(struct pci_dev *pdev)
 	const int *indexes;
 	struct device_node *dn = pci_device_to_OF_node(pdev);
 
-	if (!pdev->is_physfn || pdev->is_added)
+	if (!pdev->is_physfn || pci_dev_is_added(pdev))
 		return;
 	/*Firmware must support open sriov otherwise dont configure*/
 	indexes = of_get_property(dn, "ibm,open-sriov-vf-bar-info", NULL);
-- 
1.9.1
