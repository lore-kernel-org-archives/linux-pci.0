Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:40864 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754962AbcETGn7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2016 02:43:59 -0400
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 20 May 2016 16:43:57 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5A2492BB005E
	for <linux-pci@vger.kernel.org>; Fri, 20 May 2016 16:43:50 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u4K6hYvx52297788
	for <linux-pci@vger.kernel.org>; Fri, 20 May 2016 16:43:42 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u4K6h4cO010518
	for <linux-pci@vger.kernel.org>; Fri, 20 May 2016 16:43:04 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, alistair@popple.id.au, aik@ozlabs.ru,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v10 10/18] powerpc/powernv: Make pnv_ioda_deconfigure_pe() visible
Date: Fri, 20 May 2016 16:41:34 +1000
Message-Id: <1463726502-14679-11-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pnv_ioda_deconfigure_pe() is visible only when CONFIG_PCI_IOV is
enabled. The function will be used to tear down PE's associated
mapping in PCI hotplug path that doesn't depend on CONFIG_PCI_IOV.

This makes pnv_ioda_deconfigure_pe() visible and not depend on
CONFIG_PCI_IOV.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index e97a5fa..ba7b3a0 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -712,7 +712,6 @@ static int pnv_ioda_set_peltv(struct pnv_phb *phb,
 	return 0;
 }
 
-#ifdef CONFIG_PCI_IOV
 static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 {
 	struct pci_dev *parent;
@@ -747,9 +746,11 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 		}
 		rid_end = pe->rid + (count << 8);
 	} else {
+#ifdef CONFIG_PCI_IOV
 		if (pe->flags & PNV_IODA_PE_VF)
 			parent = pe->parent_dev;
 		else
+#endif
 			parent = pe->pdev->bus->self;
 		bcomp = OpalPciBusAll;
 		dcomp = OPAL_COMPARE_RID_DEVICE_NUMBER;
@@ -787,11 +788,12 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 
 	pe->pbus = NULL;
 	pe->pdev = NULL;
+#ifdef CONFIG_PCI_IOV
 	pe->parent_dev = NULL;
+#endif
 
 	return 0;
 }
-#endif /* CONFIG_PCI_IOV */
 
 static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 {
-- 
2.1.0

