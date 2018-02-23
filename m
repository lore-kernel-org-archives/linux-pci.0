Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:50192 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751661AbeBWPKl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Feb 2018 10:10:41 -0500
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: marc.zyngier@arm.com, Joao.Pinto@synopsys.com, bhelgaas@google.com,
        jingoohan1@gmail.com, kishon@ti.com, lorenzo.pieralisi@arm.com
Cc: linux-pci@vger.kernel.org, m-karicheri2@ti.com,
        thomas.petazzoni@free-electrons.com, minghuan.Lian@freescale.com,
        mingkai.hu@freescale.com, tie-fei.zang@freescale.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        niklas.cassel@axis.com, jesper.nilsson@axis.com,
        wangzhou1@hisilicon.com, gabriele.paoloni@huawei.com,
        svarbanov@mm-sol.com, nsekhar@ti.com, gustavo.pimentel@synopsys.com
Subject: [PATCH v7 0/9] PCI: dwc: Enables MSI-X driver support
Date: Fri, 23 Feb 2018 15:10:23 +0000
Message-Id: <cover.1519318663.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changes into a new IRQ handler mechanism (multiplexed IRQ domain hierarchy)
more suitable and appropriate to use on pcie-designware and on each SoC
specific driver in order to allow new and more complex features like MSI-X.

Adds Synopsys Root Complex driver support for MSI-X feature.

Expands the maximum number of IRQs from 32 to 256 distributed by
a maximum of 8 controller registers.

The patch set was made against the Bjorn's next branch.

Gustavo Pimentel (9):
  PCI: dwc: Add new IRQ API to pcie-desigware
  PCI: dwc: exynos: Switch to use the new IRQ API
  PCI: dwc: imx6: Switch to use the new IRQ API
  PCI: dwc: artpec6: Switch to use the new IRQ API
  PCI: dwc: designware: Switch to use the new IRQ API
  PCI: dwc: qcom: Switch to use the new IRQ API
  PCI: dwc: keystone: Switch to use the new IRQ API
  PCI: dwc: Remove old IRQ API
  PCI: dwc: Expand maximum number of IRQs from 32 to 256

 drivers/pci/dwc/pci-exynos.c           |  18 --
 drivers/pci/dwc/pci-imx6.c             |  18 --
 drivers/pci/dwc/pci-keystone-dw.c      |  91 +-------
 drivers/pci/dwc/pci-keystone.c         |   1 +
 drivers/pci/dwc/pci-keystone.h         |   4 +-
 drivers/pci/dwc/pci-layerscape.c       |   3 +-
 drivers/pci/dwc/pcie-artpec6.c         |  18 --
 drivers/pci/dwc/pcie-designware-host.c | 398 +++++++++++++++++++--------------
 drivers/pci/dwc/pcie-designware-plat.c |  16 --
 drivers/pci/dwc/pcie-designware.h      |  30 ++-
 drivers/pci/dwc/pcie-qcom.c            |  16 --
 11 files changed, 258 insertions(+), 355 deletions(-)

-- 
2.7.4
