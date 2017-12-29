Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:51313 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751215AbeABTIY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jan 2018 14:08:24 -0500
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
Subject: [PATCH v4 00/10] PCI: dwc: MSI-X feature
Date: Fri, 29 Dec 2017 14:21:32 +0000
Message-Id: <cover.1514524551.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replaces the use of IRQ domain hierarchy by the IRQ chained used by
pcie-designware and each SoC specific driver in order to allow new and
complex features like MSI-X.

Adds Synopsys Root Complex support for MSI-X feature.

Expands the maximum number of IRQs from 32 to 256 distributed by
a maximum of 8 controller registers.

The patch set was made against the Bjorn's next branch.

Gustavo Pimentel (10):
  PCI: dwc: Add IRQ chained API support
  PCI: dwc: exynos: Switch to use the IRQ chained API
  PCI: dwc: imx6: Switch to use the IRQ chained API
  PCI: dwc: artpec6: Switch to use the IRQ chained API
  PCI: dwc: designware: Switch to use the IRQ chained API
  PCI: dwc: qcom: Switch to use the IRQ chained API
  PCI: dwc: keystone: Switch to use the IRQ chained API
  PCI: dwc: keystone: Reuse designware domain allocation
  PCI: dwc: Remove IRQ domain hierarchy API support
  PCI: dwc: Expand maximum number of IRQs from 32 to 256

 drivers/pci/dwc/pci-exynos.c           |  18 --
 drivers/pci/dwc/pci-imx6.c             |  18 --
 drivers/pci/dwc/pci-keystone-dw.c      |  86 +------
 drivers/pci/dwc/pci-keystone.c         |   1 +
 drivers/pci/dwc/pci-keystone.h         |   4 +-
 drivers/pci/dwc/pci-layerscape.c       |   3 +-
 drivers/pci/dwc/pcie-artpec6.c         |  18 --
 drivers/pci/dwc/pcie-designware-host.c | 403 +++++++++++++++++++--------------
 drivers/pci/dwc/pcie-designware-plat.c |  16 --
 drivers/pci/dwc/pcie-designware.h      |  30 ++-
 drivers/pci/dwc/pcie-qcom.c            |  16 --
 11 files changed, 257 insertions(+), 356 deletions(-)

-- 
2.7.4
