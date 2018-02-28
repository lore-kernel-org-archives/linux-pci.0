Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752109AbeB1KOH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Feb 2018 05:14:07 -0500
Date: Wed, 28 Feb 2018 10:13:56 +0000
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
Subject: Re: [PATCH v7 0/9] PCI: dwc: Enables MSI-X driver support
Message-ID: <20180228101356.GA18879@e107981-ln.cambridge.arm.com>
References: <cover.1519318663.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1519318663.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 23, 2018 at 03:10:23PM +0000, Gustavo Pimentel wrote:
> Changes into a new IRQ handler mechanism (multiplexed IRQ domain hierarchy)
> more suitable and appropriate to use on pcie-designware and on each SoC
> specific driver in order to allow new and more complex features like MSI-X.
> 
> Adds Synopsys Root Complex driver support for MSI-X feature.
> 
> Expands the maximum number of IRQs from 32 to 256 distributed by
> a maximum of 8 controller registers.
> 
> The patch set was made against the Bjorn's next branch.

Hi Gustavo,

please rebase your series against v4.16-rc1, it does not apply to
it as-is.

Do not base it against Bjorn's next branch since it is a moving target,
it is up to us to handle the conflicts (if any), if there is a
dependency against a branch on my tree or Bjorn's please let us know.

> Gustavo Pimentel (9):
>   PCI: dwc: Add new IRQ API to pcie-desigware
                                           ^
s/desigware/designware

update the respective patch $SUBJECT.

Thanks,
Lorenzo

>   PCI: dwc: exynos: Switch to use the new IRQ API
>   PCI: dwc: imx6: Switch to use the new IRQ API
>   PCI: dwc: artpec6: Switch to use the new IRQ API
>   PCI: dwc: designware: Switch to use the new IRQ API
>   PCI: dwc: qcom: Switch to use the new IRQ API
>   PCI: dwc: keystone: Switch to use the new IRQ API
>   PCI: dwc: Remove old IRQ API
>   PCI: dwc: Expand maximum number of IRQs from 32 to 256
> 
>  drivers/pci/dwc/pci-exynos.c           |  18 --
>  drivers/pci/dwc/pci-imx6.c             |  18 --
>  drivers/pci/dwc/pci-keystone-dw.c      |  91 +-------
>  drivers/pci/dwc/pci-keystone.c         |   1 +
>  drivers/pci/dwc/pci-keystone.h         |   4 +-
>  drivers/pci/dwc/pci-layerscape.c       |   3 +-
>  drivers/pci/dwc/pcie-artpec6.c         |  18 --
>  drivers/pci/dwc/pcie-designware-host.c | 398 +++++++++++++++++++--------------
>  drivers/pci/dwc/pcie-designware-plat.c |  16 --
>  drivers/pci/dwc/pcie-designware.h      |  30 ++-
>  drivers/pci/dwc/pcie-qcom.c            |  16 --
>  11 files changed, 258 insertions(+), 355 deletions(-)
> 
> -- 
> 2.7.4
> 
> 
