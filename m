Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:12708 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbbCYFNU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Mar 2015 01:13:20 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NLR00BVL566YD80@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 25 Mar 2015 14:13:18 +0900 (KST)
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Liviu.Dudau@arm.com,
	cpgs@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] pci: pci-exynos: fixed the sentence error
Date: Wed, 25 Mar 2015 14:13:12 +0900
Message-id: <1427260392-4186-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is the sentence error.
Changed the semicolon instead of comma.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/pci/host/pci-exynos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index d202b37..c139237 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -396,7 +396,7 @@ static void exynos_pcie_enable_irq_pulse(struct pcie_port *pp)
 
 	/* enable INTX interrupt */
 	val = IRQ_INTA_ASSERT | IRQ_INTB_ASSERT |
-		IRQ_INTC_ASSERT | IRQ_INTD_ASSERT,
+		IRQ_INTC_ASSERT | IRQ_INTD_ASSERT;
 	exynos_elb_writel(exynos_pcie, val, PCIE_IRQ_EN_PULSE);
 }
 
-- 
1.9.1

