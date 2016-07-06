Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:23475 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751712AbcGFLED (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2016 07:04:03 -0400
From: Jisheng Zhang <jszhang@marvell.com>
To: <jingoohan1@gmail.com>, <pratyush.anand@gmail.com>,
	<bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 2/2] PCI: designware: let dw_pcie_link_up() beware of LTSSM training bit
Date: Wed, 6 Jul 2016 18:59:42 +0800
Message-ID: <1467802782-3024-3-git-send-email-jszhang@marvell.com>
In-Reply-To: <1467802782-3024-1-git-send-email-jszhang@marvell.com>
References: <1467802782-3024-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The link may be UP but still in link training. In this case, we can't
think the link is up and operating correctly. So we need to teach
dw_pcie_link_up() beware of the PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING bit.

This patch also rewrite PCIE_PHY_DEBUG_R1_LINK_UP definition so that
it's consistent with other MACROS.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/pci/host/pcie-designware.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 9df879a..29e10dd 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -73,7 +73,8 @@
 /* PCIe Port Logic registers */
 #define PLR_OFFSET			0x700
 #define PCIE_PHY_DEBUG_R1		(PLR_OFFSET + 0x2c)
-#define PCIE_PHY_DEBUG_R1_LINK_UP	0x00000010
+#define PCIE_PHY_DEBUG_R1_LINK_UP	(0x1 << 4)
+#define PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING	(0x1 << 29)
 
 /* Parameters for the waiting for link up routine */
 #define LINK_WAIT_MAX_RETRIES		10
@@ -417,7 +418,8 @@ int dw_pcie_link_up(struct pcie_port *pp)
 		return pp->ops->link_up(pp);
 
 	val = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
-	return val & PCIE_PHY_DEBUG_R1_LINK_UP;
+	return ((val & PCIE_PHY_DEBUG_R1_LINK_UP) &&
+		(!(val & PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING)));
 }
 
 static int dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
-- 
2.8.1

