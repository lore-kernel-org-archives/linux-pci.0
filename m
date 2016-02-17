Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:45978 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964994AbcBQDp6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Feb 2016 22:45:58 -0500
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 17 Feb 2016 13:45:55 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	dja@axtens.net, bhelgaas@google.com, robherring2@gmail.com,
	grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v8 06/45] powerpc/powernv: Reorder fields in struct pnv_phb
Date: Wed, 17 Feb 2016 14:43:49 +1100
Message-Id: <1455680668-23298-7-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This moves those fields in struct pnv_phb that are related to PE
allocation around. No logical change.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 78f035e..f2a1452 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -140,15 +140,14 @@ struct pnv_phb {
 		unsigned int		io_segsize;
 		unsigned int		io_pci_base;
 
-		/* PE allocation bitmap */
-		unsigned long		*pe_alloc;
-		/* PE allocation mutex */
+		/* PE allocation */
 		struct mutex		pe_alloc_mutex;
+		unsigned long		*pe_alloc;
+		struct pnv_ioda_pe	*pe_array;
 
 		/* M32 & IO segment maps */
 		unsigned int		*m32_segmap;
 		unsigned int		*io_segmap;
-		struct pnv_ioda_pe	*pe_array;
 
 		/* IRQ chip */
 		int			irq_chip_init;
-- 
2.1.0

