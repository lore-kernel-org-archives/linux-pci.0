Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam03on0077.outbound.protection.outlook.com ([104.47.42.77]:32319
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751214AbeEVN1L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 May 2018 09:27:11 -0400
From: Alan Douglas <adouglas@cadence.com>
To: <bhelgaas@google.com>, <kishon@ti.com>,
        <lorenzo.pieralisi@arm.com>, <linux-pci@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.com>,
        <cyrille.pitchen@free-electrons.com>,
        Alan Douglas <adouglas@cadence.com>
Subject: [RESEND PATCH 1/4] PCI: cadence: Update cdns_pcie_writel function signature
Date: Tue, 22 May 2018 14:26:53 +0100
Message-ID: <1526995613-8560-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Change cdns_pcie_writel() signature, u16 value changed to u32, since
this function should write a long value

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/pci/cadence/pcie-cadence.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/cadence/pcie-cadence.h b/drivers/pci/cadence/pcie-cadence.h
index 4bb2733..ed336cc 100644
--- a/drivers/pci/cadence/pcie-cadence.h
+++ b/drivers/pci/cadence/pcie-cadence.h
@@ -279,7 +279,7 @@ static inline void cdns_pcie_ep_fn_writew(struct cdns_pcie *pcie, u8 fn,
 }
 
 static inline void cdns_pcie_ep_fn_writel(struct cdns_pcie *pcie, u8 fn,
-					  u32 reg, u16 value)
+					  u32 reg, u32 value)
 {
 	writel(value, pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
 }
-- 
2.2.2
