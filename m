Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:42628 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754422AbcETGms (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2016 02:42:48 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 20 May 2016 16:42:46 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7DC292CE8054
	for <linux-pci@vger.kernel.org>; Fri, 20 May 2016 16:42:43 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u4K6gZBH63570088
	for <linux-pci@vger.kernel.org>; Fri, 20 May 2016 16:42:43 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u4K6g9FO031444
	for <linux-pci@vger.kernel.org>; Fri, 20 May 2016 16:42:11 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, alistair@popple.id.au, aik@ozlabs.ru,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v10 03/18] powerpc/powernv: Remove PCI_RESET_DELAY_US
Date: Fri, 20 May 2016 16:41:27 +1000
Message-Id: <1463726502-14679-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The macro defined in arch/powerpc/platforms/powernv/pci.c isn't
used by anyone. Just remove it.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 1d92bd9..b1ee631 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -36,9 +36,6 @@
 #include "powernv.h"
 #include "pci.h"
 
-/* Delay in usec */
-#define PCI_RESET_DELAY_US	3000000
-
 #ifdef CONFIG_PCI_MSI
 int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 {
-- 
2.1.0

