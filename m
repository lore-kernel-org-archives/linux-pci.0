Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:13037 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbaDAKa0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 1 Apr 2014 06:30:26 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N3C004XOL6OWP70@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Tue, 01 Apr 2014 19:30:24 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, 'Mohit Kumar' <mohit.kumar@st.com>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Marek Vasut' <marex@denx.de>,
	'Richard Zhu' <r65037@freescale.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH] PCI: designware: Remove unnecessary RC BAR setting
Date: Tue, 01 Apr 2014 19:30:24 +0900
Message-id: <000801cf4d95$64322ef0$2c968cd0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

According to the spec, the synopsys core does not implement the
optional BARs such as BAR0/1. This is based on the assumption
that the RC host probably has registers on some other internal
bus and has knowledge and setup access to these registers already.
So, remove unnecessary RC BAR setting.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
Tested on Exynos5440.

 drivers/pci/host/pcie-designware.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 6d23d8c..7bee01f 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -798,10 +798,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	}
 	dw_pcie_writel_rc(pp, val, PCIE_LINK_WIDTH_SPEED_CONTROL);
 
-	/* setup RC BARs */
-	dw_pcie_writel_rc(pp, 0x00000004, PCI_BASE_ADDRESS_0);
-	dw_pcie_writel_rc(pp, 0x00000000, PCI_BASE_ADDRESS_1);
-
 	/* setup interrupt pins */
 	dw_pcie_readl_rc(pp, PCI_INTERRUPT_LINE, &val);
 	val &= 0xffff00ff;
-- 
1.7.10.4


