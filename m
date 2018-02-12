Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751388AbeBLMXo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Feb 2018 07:23:44 -0500
Date: Mon, 12 Feb 2018 12:23:34 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: marc.zyngier@arm.com, Joao.Pinto@synopsys.com, bhelgaas@google.com,
        jingoohan1@gmail.com, kishon@ti.com, linux-pci@vger.kernel.org,
        m-karicheri2@ti.com, thomas.petazzoni@free-electrons.com,
        minghuan.Lian@freescale.com, mingkai.hu@freescale.com,
        tie-fei.zang@freescale.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, niklas.cassel@axis.com,
        jesper.nilsson@axis.com, wangzhou1@hisilicon.com,
        gabriele.paoloni@huawei.com, svarbanov@mm-sol.com, nsekhar@ti.com
Subject: Re: [PATCH v6 0/9] PCI: dwc: MSI-X feature
Message-ID: <20180212122334.GA25396@e107981-ln.cambridge.arm.com>
References: <cover.1516984229.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1516984229.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 26, 2018 at 04:35:35PM +0000, Gustavo Pimentel wrote:
> Replaces the use of IRQ domain hierarchy by the IRQ chained used by
> pcie-designware and each SoC specific driver in order to allow new and
> complex features like MSI-X.
> 
> Adds Synopsys Root Complex support for MSI-X feature.

Hi Gustavo,

please CC me for future patch versions. I have a question for you,
the series definitely looks like it is going in the right direction
but I do not understand the cover letter.

- You are not replacing the IRQ domain hierarchy, you are actually
  introducing it properly. It may be just nomenclature but I though
  I would mention that.
- I really do not understand why this series is advertised as
  "implementing MSI-X". I want to understand why MSI-X it is not
  currently supported and why this series would enable it, I
  honestly do not understand the reasoning behind this, it looks
  a bit fuzzy.

Please note I am just asking clarifications on the $SUBJECT for my own
understanding, the series is definitely the right thing to do and I am
happy to target v4.17 for it.

Thanks,
Lorenzo

> Expands the maximum number of IRQs from 32 to 256 distributed by
> a maximum of 8 controller registers.
> 
> The patch set was made against the Bjorn's next branch.
> 
> Gustavo Pimentel (9):
>   PCI: dwc: Add IRQ chained API support
>   PCI: dwc: exynos: Switch to use the IRQ chained API
>   PCI: dwc: imx6: Switch to use the IRQ chained API
>   PCI: dwc: artpec6: Switch to use the IRQ chained API
>   PCI: dwc: designware: Switch to use the IRQ chained API
>   PCI: dwc: qcom: Switch to use the IRQ chained API
>   PCI: dwc: keystone: Switch to use the IRQ chained API
>   PCI: dwc: Remove IRQ domain hierarchy API support
>   PCI: dwc: Expand maximum number of IRQs from 32 to 256
> 
>  drivers/pci/dwc/pci-exynos.c           |  18 --
>  drivers/pci/dwc/pci-imx6.c             |  18 --
>  drivers/pci/dwc/pci-keystone-dw.c      |  91 +-------
>  drivers/pci/dwc/pci-keystone.c         |   1 +
>  drivers/pci/dwc/pci-keystone.h         |   4 +-
>  drivers/pci/dwc/pci-layerscape.c       |   3 +-
>  drivers/pci/dwc/pcie-artpec6.c         |  18 --
>  drivers/pci/dwc/pcie-designware-host.c | 402 +++++++++++++++++++--------------
>  drivers/pci/dwc/pcie-designware-plat.c |  16 --
>  drivers/pci/dwc/pcie-designware.h      |  30 ++-
>  drivers/pci/dwc/pcie-qcom.c            |  16 --
>  11 files changed, 260 insertions(+), 357 deletions(-)
> 
> -- 
> 2.7.4
> 
> 
