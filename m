Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:54677 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753484AbeCFLzI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Mar 2018 06:55:08 -0500
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: marc.zyngier@arm.com, Joao.Pinto@synopsys.com, bhelgaas@google.com,
        jingoohan1@gmail.com, kishon@ti.com, lorenzo.pieralisi@arm.com
Cc: linux-pci@vger.kernel.org, m-karicheri2@ti.com,
        thomas.petazzoni@free-electrons.com, minghuan.Lian@freescale.com,
        mingkai.hu@freescale.com, tie-fei.zang@freescale.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        niklas.cassel@axis.com, shawn.guo@linaro.org,
        jesper.nilsson@axis.com, wangzhou1@hisilicon.com,
        gabriele.paoloni@huawei.com, svarbanov@mm-sol.com, nsekhar@ti.com,
        gustavo.pimentel@synopsys.com
Subject: [PATCH v10 0/3] PCI: dwc: Enables MSI-X driver support
Date: Tue,  6 Mar 2018 11:54:52 +0000
Message-Id: <cover.1520336185.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Implement a multiplexed IRQ domain hierarchy API in the pcie-designware
host bridge driver that funnels all MSI IRQs into a single parent
interrupt, moving away from the obsolete struct msi_controller based
API.

Remove all existing dwc based host bridges MSI IRQs handlers, in that the
hierarchical API now handles MSI IRQs through the hierarchical/chained
MSI domain implementation.

The Synopsys PCIe Root Complex supports up to MSI 256 IRQs distributed
over 8 controller registers, therefore the maximum number of MSI IRQs
can be changed to 256. The number of controllers can be calculated based
on the number of vectors used by the specific SoC driver.

Adds Synopsys Root Complex driver support for MSI-X feature.

The patch set was made against the Bjorn's master branch (v4.16-rc1).

Gustavo Pimentel (3):
  PCI: dwc: Move MSI IRQs allocation to IRQ domains hierarchical API
  PCI: dwc: Remove old MSI IRQs API
  PCI: dwc: Expand maximum number of MSI IRQs from 32 to 256

 drivers/pci/dwc/pci-exynos.c           |  18 --
 drivers/pci/dwc/pci-imx6.c             |  18 --
 drivers/pci/dwc/pci-keystone-dw.c      |  91 +-------
 drivers/pci/dwc/pci-keystone.c         |   1 +
 drivers/pci/dwc/pci-keystone.h         |   4 +-
 drivers/pci/dwc/pci-layerscape.c       |   3 +-
 drivers/pci/dwc/pcie-artpec6.c         |  18 --
 drivers/pci/dwc/pcie-designware-host.c | 396 +++++++++++++++++++--------------
 drivers/pci/dwc/pcie-designware-plat.c |  16 --
 drivers/pci/dwc/pcie-designware.h      |  30 ++-
 drivers/pci/dwc/pcie-histb.c           |  15 --
 drivers/pci/dwc/pcie-qcom.c            |  16 --
 12 files changed, 256 insertions(+), 370 deletions(-)

-- 
2.7.4
