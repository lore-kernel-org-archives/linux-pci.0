Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:41296 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbdEORD4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2017 13:03:56 -0400
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: bhelgaas@google.com, marc.zyngier@arm.com
Cc: jingoohan1@gmail.com, m-karicheri2@ti.com,
        thomas.petazzoni@free-electrons.com, minghuan.Lian@freescale.com,
        mingkai.hu@freescale.com, tie-fei.zang@freescale.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        niklas.cassel@axis.com, jesper.nilsson@axis.com,
        wangzhou1@hisilicon.com, gabriele.paoloni@huawei.com,
        svarbanov@mm-sol.com, linux-pci@vger.kernel.org,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [RFC v2 0/8] add new irq api to pcie-designware
Date: Mon, 15 May 2017 18:03:40 +0100
Message-Id: <cover.1494867112.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series adds the new interrupt api to pcie-designware
make it possible to use features like MSIX.

The work consisted of adapting the pcie-designware-host and each SoC
specific driver.

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
 drivers/pci/dwc/pcie-designware-host.c | 372 ++++++++++++++++++---------------
 drivers/pci/dwc/pcie-designware-plat.c |  15 --
 drivers/pci/dwc/pcie-designware.h      |  18 +-
 drivers/pci/dwc/pcie-qcom.c            |  15 --
 11 files changed, 231 insertions(+), 349 deletions(-)

-- 
2.9.3
