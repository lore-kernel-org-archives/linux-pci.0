Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0071.outbound.protection.outlook.com ([207.46.100.71]:60562
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753332AbcCBKPJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 2 Mar 2016 05:15:09 -0500
From: Ley Foon Tan <lftan@altera.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	Ley Foon Tan <lftan.linux@gmail.com>,
	Ley Foon Tan <lftan@altera.com>
Subject: [PATCH] PCI: altera: fix altera_pcie_link_is_up()
Date: Wed, 2 Mar 2016 17:43:07 +0800
Message-ID: <1456911787-3576-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The original code return true if RP_LTSSM register return non-zero
value. This fix to return true only RP_LTSSM register is in L0 state
(link up).

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 drivers/pci/host/pcie-altera.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index 99da549..dbac6fb 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -40,6 +40,7 @@
 #define P2A_INT_ENABLE			0x3070
 #define P2A_INT_ENA_ALL			0xf
 #define RP_LTSSM			0x3c64
+#define RP_LTSSM_MASK			0x1f
 #define LTSSM_L0			0xf
 
 /* TLP configuration type 0 and 1 */
@@ -140,7 +141,7 @@ static void tlp_write_tx(struct altera_pcie *pcie,
 
 static bool altera_pcie_link_is_up(struct altera_pcie *pcie)
 {
-	return !!(cra_readl(pcie, RP_LTSSM) & LTSSM_L0);
+	return !!((cra_readl(pcie, RP_LTSSM) & RP_LTSSM_MASK) == LTSSM_L0);
 }
 
 static bool altera_pcie_valid_config(struct altera_pcie *pcie,
-- 
2.2.0

