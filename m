Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:34686 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbbEAGEh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 May 2015 02:04:37 -0400
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 1 May 2015 16:04:35 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3183C2BB005A
	for <linux-pci@vger.kernel.org>; Fri,  1 May 2015 16:04:32 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4164OCo52166792
	for <linux-pci@vger.kernel.org>; Fri, 1 May 2015 16:04:32 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4163vb2009600
	for <linux-pci@vger.kernel.org>; Fri, 1 May 2015 16:03:58 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org,
	bhelgaas@google.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v4 20/21] powerpc/powernv: Select OF_DYNAMIC
Date: Fri,  1 May 2015 16:03:07 +1000
Message-Id: <1430460188-31343-21-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The device tree nodes will be changed dynamically on PCI hotplug
events on PowerNV platform. The patch selects OF_DYNAMIC on the
platform to support PCI hotplug.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 4b044d8..9c62631 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -18,4 +18,5 @@ config PPC_POWERNV
 	select CPU_FREQ_GOV_ONDEMAND
 	select CPU_FREQ_GOV_CONSERVATIVE
 	select PPC_DOORBELL
+	select OF_DYNAMIC
 	default y
-- 
2.1.0

