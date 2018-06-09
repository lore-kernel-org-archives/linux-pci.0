Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:65015 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751414AbeFIJpW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 9 Jun 2018 05:45:22 -0400
Date: Sat, 9 Jun 2018 17:44:12 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: kbuild-all@01.org, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [RFC PATCH] PCI: dwc: __dw_pcie_ep_find_next_cap() can be static
Message-ID: <20180609094411.GA86347@cairo>
References: <299abe22c35db333dca228a48fdb03ecc662e247.1527862777.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <299abe22c35db333dca228a48fdb03ecc662e247.1527862777.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Fixes: 797b96a7422e ("PCI: dwc: Add MSI-X callbacks handler")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 pcie-designware-ep.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
index c7f2fa9..a498f1f 100644
--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -40,8 +40,8 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
 	__dw_pcie_ep_reset_bar(pci, bar, 0);
 }
 
-u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
-			      u8 cap)
+static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
+				     u8 cap)
 {
 	u8 cap_id, next_cap_ptr;
 	u16 reg;
@@ -59,7 +59,7 @@ u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
 	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
 }
 
-u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap)
+static u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap)
 {
 	u8 next_cap_ptr;
 	u16 reg;
