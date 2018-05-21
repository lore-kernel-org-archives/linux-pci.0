Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam03on0057.outbound.protection.outlook.com ([104.47.42.57]:6496
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752943AbeEURa4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 May 2018 13:30:56 -0400
From: Alan Douglas <adouglas@cadence.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "cyrille.pitchen@free-electrons.com"
        <cyrille.pitchen@free-electrons.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: [PATCH v2 1/4] PCI: cadence: Update cdns_pcie_writel function
 signature
Date: Mon, 21 May 2018 17:30:55 +0000
Message-ID: <SN6PR07MB4512BA57E8D259911D244E20D8950@SN6PR07MB4512.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Alan Douglas <adouglas@cadence.com>

Change cdns_pcie_writel() signature, u16 value changed to u32, since
this function should write a long value

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/pci/cadence/pcie-cadence.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/cadence/pcie-cadence.h b/drivers/pci/cadence/pcie-=
cadence.h
index 4bb2733..ed336cc 100644
--- a/drivers/pci/cadence/pcie-cadence.h
+++ b/drivers/pci/cadence/pcie-cadence.h
@@ -279,7 +279,7 @@ static inline void cdns_pcie_ep_fn_writew(struct cdns_p=
cie *pcie, u8 fn,
 }
=20
 static inline void cdns_pcie_ep_fn_writel(struct cdns_pcie *pcie, u8 fn,
-					  u32 reg, u16 value)
+					  u32 reg, u32 value)
 {
 	writel(value, pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
 }
--=20
2.2.2
