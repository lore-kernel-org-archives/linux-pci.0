Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35821 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbbGXFaF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jul 2015 01:30:05 -0400
From: Kevin Hao <haokexin@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH 3/4] PCI: exynos: Mark the msi cascade handler IRQF_NO_THREAD
Date: Fri, 24 Jul 2015 13:29:35 +0800
Message-Id: <1437715776-2243-4-git-send-email-haokexin@gmail.com>
In-Reply-To: <1437715776-2243-1-git-send-email-haokexin@gmail.com>
References: <1437715776-2243-1-git-send-email-haokexin@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The cascade handler must run in hard interrupt context, otherwise
it will cause dead lock if we force threading of all the interrupt
handlers via kernel command parameter "threadirqs".

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/pci/host/pci-exynos.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index f9f468d9a819..7b6be7791d33 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -523,7 +523,8 @@ static int __init exynos_add_pcie_port(struct pcie_port *pp,
 
 		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
 					exynos_pcie_msi_irq_handler,
-					IRQF_SHARED, "exynos-pcie", pp);
+					IRQF_SHARED | IRQF_NO_THREAD,
+					"exynos-pcie", pp);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request msi irq\n");
 			return ret;
-- 
2.1.0

