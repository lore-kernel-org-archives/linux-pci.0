Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752064AbeCUOnM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Mar 2018 10:43:12 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Ley Foon Tan <lftan@altera.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: [PATCH v2 03/10] PCI: kirin: Fix missing dependency on PCI_MSI_IRQ_DOMAIN
Date: Wed, 21 Mar 2018 14:42:47 +0000
Message-Id: <20180321144254.7406-4-lorenzo.pieralisi@arm.com>
In-Reply-To: <20180321144254.7406-1-lorenzo.pieralisi@arm.com>
References: <20180321144254.7406-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rob Herring <robh@kernel.org>

PCIE_DW_HOST depends on PCI_MSI_IRQ_DOMAIN and since kirin selects
PCIE_DW_HOST, it must also depend on PCI_MSI_IRQ_DOMAIN. This was found
by 0-day once building on all arches was enabled.

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/pci/dwc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index 0f666b1ce289..2f3f5c50aa48 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -176,6 +176,7 @@ config PCIE_ARTPEC6_EP
 config PCIE_KIRIN
 	depends on OF && ARM64
 	bool "HiSilicon Kirin series SoCs PCIe controllers"
+	depends on PCI_MSI_IRQ_DOMAIN
 	depends on PCI
 	select PCIEPORTBUS
 	select PCIE_DW_HOST
-- 
2.15.0
