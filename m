Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:46818 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965110AbcBQDp6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Feb 2016 22:45:58 -0500
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 17 Feb 2016 13:45:56 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	dja@axtens.net, bhelgaas@google.com, robherring2@gmail.com,
	grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v8 12/45] powerpc/powernv: Rename M64 related functions
Date: Wed, 17 Feb 2016 14:43:55 +1100
Message-Id: <1455680668-23298-13-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This renames those functions picking PE number based on consumed
M64 segments, mapping M64 segments to PEs as those functions are
going to be shared by IODA1/IODA2 in next patch. No logical changes
introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index fc0374a..1dc663a 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -219,7 +219,7 @@ fail:
 	return -EIO;
 }
 
-static void pnv_ioda2_reserve_dev_m64_pe(struct pci_dev *pdev,
+static void pnv_ioda_reserve_dev_m64_pe(struct pci_dev *pdev,
 					 unsigned long *pe_bitmap)
 {
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
@@ -246,22 +246,22 @@ static void pnv_ioda2_reserve_dev_m64_pe(struct pci_dev *pdev,
 	}
 }
 
-static void pnv_ioda2_reserve_m64_pe(struct pci_bus *bus,
-				     unsigned long *pe_bitmap,
-				     bool all)
+static void pnv_ioda_reserve_m64_pe(struct pci_bus *bus,
+				    unsigned long *pe_bitmap,
+				    bool all)
 {
 	struct pci_dev *pdev;
 
 	list_for_each_entry(pdev, &bus->devices, bus_list) {
-		pnv_ioda2_reserve_dev_m64_pe(pdev, pe_bitmap);
+		pnv_ioda_reserve_dev_m64_pe(pdev, pe_bitmap);
 
 		if (all && pdev->subordinate)
-			pnv_ioda2_reserve_m64_pe(pdev->subordinate,
-						 pe_bitmap, all);
+			pnv_ioda_reserve_m64_pe(pdev->subordinate,
+						pe_bitmap, all);
 	}
 }
 
-static int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
+static int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct pnv_phb *phb = hose->private_data;
@@ -283,7 +283,7 @@ static int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
 	}
 
 	/* Figure out reserved PE numbers by the PE */
-	pnv_ioda2_reserve_m64_pe(bus, pe_alloc, all);
+	pnv_ioda_reserve_m64_pe(bus, pe_alloc, all);
 
 	/*
 	 * the current bus might not own M64 window and that's all
@@ -365,8 +365,8 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
 	/* Use last M64 BAR to cover M64 window */
 	phb->ioda.m64_bar_idx = 15;
 	phb->init_m64 = pnv_ioda2_init_m64;
-	phb->reserve_m64_pe = pnv_ioda2_reserve_m64_pe;
-	phb->pick_m64_pe = pnv_ioda2_pick_m64_pe;
+	phb->reserve_m64_pe = pnv_ioda_reserve_m64_pe;
+	phb->pick_m64_pe = pnv_ioda_pick_m64_pe;
 }
 
 static void pnv_ioda_freeze_pe(struct pnv_phb *phb, int pe_no)
-- 
2.1.0

