Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:50591 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753335AbdL1L5r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Dec 2017 06:57:47 -0500
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: marc.zyngier@arm.com, Joao.Pinto@synopsys.com, bhelgaas@google.com,
        jingoohan1@gmail.com, kishon@ti.com
Cc: linux-pci@vger.kernel.org, m-karicheri2@ti.com,
        thomas.petazzoni@free-electrons.com, minghuan.Lian@freescale.com,
        mingkai.hu@freescale.com, tie-fei.zang@freescale.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        niklas.cassel@axis.com, jesper.nilsson@axis.com,
        wangzhou1@hisilicon.com, gabriele.paoloni@huawei.com,
        svarbanov@mm-sol.com, nsekhar@ti.com,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v3 0/9] add new irq api to pcie-designware
Date: Thu, 28 Dec 2017 11:56:38 +0000
Message-Id: <cover.1514455857.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series adds the new interrupt api to pcie-designware make it
possible to use features like MSIX.
The work consisted of adapting the pcie-designware-host and each SoC
specific driver.
The patch set was made against the Bjorn' next branch.
A new patch set (v3) was created that includes Kishon's fixes (pci end
point error and a dra7xx warning) in file
0007-pci-keystone-SoC-driver-adapted-to-new-irq-API.patch.

Gustavo Pimentel (9):
  pci: adding new irq api to pci-designware
  pci: exynos SoC driver adapted to new irq API
  pci: imx6 SoC driver adapted to new irq API
  pci: artpec6 SoC driver adapted to new irq API
  pci: generic PCIe DW driver adapted to new irq API
  pci: qcom SoC driver adapted to new irq API
  pci: keystone SoC driver adapted to new irq API
  pci: removing old irq api from pcie-designware
  pci: remove limitation of the number of the available IRQs

 drivers/pci/dwc/pci-exynos.c           |  18 --
 drivers/pci/dwc/pci-imx6.c             |  18 --
 drivers/pci/dwc/pci-keystone-dw.c      |  88 +-------
 drivers/pci/dwc/pci-keystone.c         |   1 +
 drivers/pci/dwc/pci-keystone.h         |   4 +-
 drivers/pci/dwc/pci-layerscape.c       |   4 +-
 drivers/pci/dwc/pcie-artpec6.c         |  18 --
 drivers/pci/dwc/pcie-designware-host.c | 391 +++++++++++++++++++--------------
 drivers/pci/dwc/pcie-designware-plat.c |  16 --
 drivers/pci/dwc/pcie-designware.h      |  30 ++-
 drivers/pci/dwc/pcie-qcom.c            |  16 --
 11 files changed, 254 insertions(+), 350 deletions(-)

-- 
2.7.4
