Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:36676 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935893AbeFRTMb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Jun 2018 15:12:31 -0400
Date: Tue, 19 Jun 2018 03:12:07 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: kbuild-all@01.org, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [RFC PATCH] PCI: dwc: dw_pcie_ep_find_capability() can be static
Message-ID: <20180618191207.GA111117@ivb43>
References: <5beae521c5ee475b1c0e04f5eec07d0120b0fa2b.1529329262.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5beae521c5ee475b1c0e04f5eec07d0120b0fa2b.1529329262.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Fixes: 43f8cf4686e0 ("PCI: dwc: Add MSI-X callbacks handler")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 pcie-designware-ep.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index beee64e..ffc2065 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -59,7 +59,7 @@ static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
 	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
 }
 
-u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap)
+static u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap)
 {
 	u8 next_cap_ptr;
 	u16 reg;
