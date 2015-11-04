Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:51749 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965425AbbKDNN7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2015 08:13:59 -0500
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 4 Nov 2015 23:13:57 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	bhelgaas@google.com, grant.likely@linaro.org,
	robherring2@gmail.com, panto@antoniou-consulting.com,
	frowand.list@gmail.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 43/50] powerpc/powernv: Select OF_DYNAMIC
Date: Thu,  5 Nov 2015 00:12:43 +1100
Message-Id: <1446642770-4681-44-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The device tree will change dynamically in PowerNV PCI hotplug
driver. This enables CONFIG_OF_DYNAMIC to support that.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 604190c..e7b1ad7 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -18,6 +18,7 @@ config PPC_POWERNV
 	select CPU_FREQ_GOV_ONDEMAND
 	select CPU_FREQ_GOV_CONSERVATIVE
 	select PPC_DOORBELL
+	select OF_DYNAMIC
 	default y
 
 config OPAL_PRD
-- 
2.1.0

