Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:38666 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbdE3LdE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2017 07:33:04 -0400
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: bhelgaas@google.com, marc.zyngier@arm.com
Cc: m-karicheri2@ti.com, thomas.petazzoni@free-electrons.com,
        minghuan.Lian@freescale.com, mingkai.hu@freescale.com,
        tie-fei.zang@freescale.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, niklas.cassel@axis.com,
        jesper.nilsson@axis.com, wangzhou1@hisilicon.com,
        gabriele.paoloni@huawei.com, svarbanov@mm-sol.com,
        linux-pci@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH 0/8] add new irq api to pcie-designware
Date: Tue, 30 May 2017 12:32:45 +0100
Message-Id: <cover.1496142978.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series adds a new interrupt api to pcie-designware-host
making it possible to use features like MSIX.

The work consisted of adapting the pcie-designware-host and each SoC
specific driver.

The update of pcie-designwar-host was broken into 2 patches
to improve patch readability.

Joao Pinto (8):
  pci: adding new irq api to pci-designware
  pci: exynos SoC driver adapted to new irq API
  pci: imx6 SoC driver adapted to new irq API
  pci: artpec6 SoC driver adapted to new irq API
  pci: generic PCIe DW driver adapted to new irq API
  pci: qcom SoC driver adapted to new irq API
  pci: keystone SoC driver adapted to new irq API
  pci: removing old irq api from pcie-designware

 drivers/pci/dwc/pci-exynos.c           |  18 --
 drivers/pci/dwc/pci-imx6.c             |  18 --
 drivers/pci/dwc/pci-keystone-dw.c      |  97 +--------
 drivers/pci/dwc/pci-keystone.c         |   1 +
 drivers/pci/dwc/pci-keystone.h         |   4 +-
 drivers/pci/dwc/pci-layerscape.c       |   4 +-
 drivers/pci/dwc/pcie-artpec6.c         |  18 --
 drivers/pci/dwc/pcie-designware-host.c | 374 ++++++++++++++++++---------------
 drivers/pci/dwc/pcie-designware-plat.c |  15 --
 drivers/pci/dwc/pcie-designware.h      |  18 +-
 drivers/pci/dwc/pcie-qcom.c            |  15 --
 11 files changed, 233 insertions(+), 349 deletions(-)

-- 
2.9.3
