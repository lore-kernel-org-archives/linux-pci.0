Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751220AbdL1S53 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Dec 2017 13:57:29 -0500
Date: Thu, 28 Dec 2017 12:56:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: marc.zyngier@arm.com, Joao.Pinto@synopsys.com, bhelgaas@google.com,
        jingoohan1@gmail.com, kishon@ti.com, linux-pci@vger.kernel.org,
        m-karicheri2@ti.com, thomas.petazzoni@free-electrons.com,
        minghuan.Lian@freescale.com, mingkai.hu@freescale.com,
        tie-fei.zang@freescale.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, niklas.cassel@axis.com,
        jesper.nilsson@axis.com, wangzhou1@hisilicon.com,
        gabriele.paoloni@huawei.com, svarbanov@mm-sol.com, nsekhar@ti.com
Subject: Re: [PATCH v3 0/9] add new irq api to pcie-designware
Message-ID: <20171228185652.GA211339@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1514455857.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1514455857.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 28, 2017 at 11:56:38AM +0000, Gustavo Pimentel wrote:
> This patch series adds the new interrupt api to pcie-designware make it
> possible to use features like MSIX.
> The work consisted of adapting the pcie-designware-host and each SoC
> specific driver.
> The patch set was made against the Bjorn' next branch.
> A new patch set (v3) was created that includes Kishon's fixes (pci end
> point error and a dra7xx warning) in file
> 0007-pci-keystone-SoC-driver-adapted-to-new-irq-API.patch.
> 
> Gustavo Pimentel (9):
>   pci: adding new irq api to pci-designware
>   pci: exynos SoC driver adapted to new irq API
>   pci: imx6 SoC driver adapted to new irq API
>   pci: artpec6 SoC driver adapted to new irq API
>   pci: generic PCIe DW driver adapted to new irq API
>   pci: qcom SoC driver adapted to new irq API
>   pci: keystone SoC driver adapted to new irq API
>   pci: removing old irq api from pcie-designware
>   pci: remove limitation of the number of the available IRQs

Please update the summary lines to match the drivers/pci conventions:

  PCI: dwc: Add new IRQ API
  PCI: dwc: exynos: Adapt to new IRQ API
  PCI: dwc: imx6: Adapt to new IRQ API
  PCI: dwc: artpec6: Adapt to new IRQ API
  PCI: dwc: designware: Adapt to new IRQ API
  PCI: dwc: qcom: Adapt to new IRQ API
  PCI: dwc: keystone: Adapt to new IRQ API
  PCI: dwc: Remove old IRQ API
  PCI: dwc: Remove limitation on number of IRQs

The first patch summary should contain more information than "Add new
IRQ API".  That summary doesn't tell us anything about what is new or
why we want it.  Even the changelog doesn't contain that information.

Please also update the changelogs to consistently capitalize IRQ, API,
etc.  It's currently a mix, which is distracting to read.

Also, instead of saying "This patch adds the ...", simply say "Add the
...".  The "This patch" context is obvious since the changelog is an
integral part of the commit.

Please use blank lines to separate paragraphs.

>  drivers/pci/dwc/pci-exynos.c           |  18 --
>  drivers/pci/dwc/pci-imx6.c             |  18 --
>  drivers/pci/dwc/pci-keystone-dw.c      |  88 +-------
>  drivers/pci/dwc/pci-keystone.c         |   1 +
>  drivers/pci/dwc/pci-keystone.h         |   4 +-
>  drivers/pci/dwc/pci-layerscape.c       |   4 +-
>  drivers/pci/dwc/pcie-artpec6.c         |  18 --
>  drivers/pci/dwc/pcie-designware-host.c | 391 +++++++++++++++++++--------------
>  drivers/pci/dwc/pcie-designware-plat.c |  16 --
>  drivers/pci/dwc/pcie-designware.h      |  30 ++-
>  drivers/pci/dwc/pcie-qcom.c            |  16 --
>  11 files changed, 254 insertions(+), 350 deletions(-)
> 
> -- 
> 2.7.4
> 
> 
