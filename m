Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:36100 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932899AbcLSIRu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2016 03:17:50 -0500
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: helgaas@google.com, krzk@kernel.org, linux-kernel@vger.kernel.org,
        jingoohan1@gmail.com, javier@osg.samsung.com, kgene@kernel.org,
        linux-samsung-soc@vger.kernel.org, cpgs@samsung.com,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 4/4] PCI: exynos: remove the duplicated codes
Date: Mon, 19 Dec 2016 17:17:40 +0900
Message-id: <20161219081740.5457-5-jh80.chung@samsung.com>
In-reply-to: <20161219081740.5457-1-jh80.chung@samsung.com>
References: <20161219081740.5457-1-jh80.chung@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Removed the duplicated codes.
It can use the more simply than now.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/pci/host/pci-exynos.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index d705bfe..33562cf 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -116,30 +116,24 @@ static void exynos_pcie_sideband_dbi_w_mode(struct exynos_pcie *ep, bool on)
 {
 	u32 val;
 
-	if (on) {
-		val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_SLV_AWMISC);
+	val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_SLV_AWMISC);
+	if (on)
 		val |= PCIE_ELBI_SLV_DBI_ENABLE;
-		exynos_pcie_writel(ep->elbi_base, val, PCIE_ELBI_SLV_AWMISC);
-	} else {
-		val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_SLV_AWMISC);
+	else
 		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
-		exynos_pcie_writel(ep->elbi_base, val, PCIE_ELBI_SLV_AWMISC);
-	}
+	exynos_pcie_writel(ep->elbi_base, val, PCIE_ELBI_SLV_AWMISC);
 }
 
 static void exynos_pcie_sideband_dbi_r_mode(struct exynos_pcie *ep, bool on)
 {
 	u32 val;
 
-	if (on) {
-		val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_SLV_ARMISC);
+	val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_SLV_ARMISC);
+	if (on)
 		val |= PCIE_ELBI_SLV_DBI_ENABLE;
-		exynos_pcie_writel(ep->elbi_base, val, PCIE_ELBI_SLV_ARMISC);
-	} else {
-		val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_SLV_ARMISC);
+	else
 		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
-		exynos_pcie_writel(ep->elbi_base, val, PCIE_ELBI_SLV_ARMISC);
-	}
+	exynos_pcie_writel(ep->elbi_base, val, PCIE_ELBI_SLV_ARMISC);
 }
 
 static void exynos_pcie_assert_core_reset(struct exynos_pcie *ep)
-- 
2.10.2

