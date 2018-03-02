Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1426463AbeCBSDB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Mar 2018 13:03:01 -0500
Date: Fri, 2 Mar 2018 18:03:20 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: marc.zyngier@arm.com, Joao.Pinto@synopsys.com, bhelgaas@google.com,
        jingoohan1@gmail.com, kishon@ti.com, linux-pci@vger.kernel.org,
        m-karicheri2@ti.com, thomas.petazzoni@free-electrons.com,
        minghuan.Lian@freescale.com, mingkai.hu@freescale.com,
        tie-fei.zang@freescale.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, niklas.cassel@axis.com,
        jesper.nilsson@axis.com, wangzhou1@hisilicon.com,
        svarbanov@mm-sol.com, nsekhar@ti.com,
        Shawn Guo <shawn.guo@linaro.org>, Vignesh R <vigneshr@ti.com>,
        Pratyush Anand <pratyush.anand@gmail.com>
Subject: Re: [PATCH v9 0/3] PCI: dwc: Enables MSI-X driver support
Message-ID: <20180302180320.GA5404@red-moon>
References: <cover.1519834018.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1519834018.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Shawn, Vignesh, Pratyush]
On Wed, Feb 28, 2018 at 04:10:22PM +0000, Gustavo Pimentel wrote:
> Changes into a new IRQ handler mechanism (multiplexed IRQ domain hierarchy)
> more suitable and appropriate to use on pcie-designware and on each SoC
> specific driver in order to allow new and more complex features like MSI-X.
> 
> Adds Synopsys Root Complex driver support for MSI-X feature.
> 
> Expands the maximum number of IRQs from 32 to 256 distributed by
> a maximum of 8 controller registers.
> 
> The patch set was made against the Bjorn's master branch (v4.16-rc1).
> 
> Gustavo Pimentel (3):
>   PCI: dwc: Add new IRQ API
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

Hi Gustavo,

I was reviewing a patch and this raised a question:

-  why pcie-histb.c is not in the list of converted drivers above,
   given that it uses dw_handle_msi_irq() the same way as others
   you converted ?

Is it correct to leave pcie-histb.c as-is ? I do not think it is.

I also would like to get this tested on DRA7 and SPEAR13XX which
are the other host drivers using dw_handle_msi_irq() (even though
in a different way than pcie-histb.c).

The difference here seems to be struct pcie_port->msi_irq usage, that's
extremely confusing how it is used (or not used) in the drivers I
mentioned above.

I have CC'ed the related maintainers I need feedback and this needs
testing; this series code is in my branch:

pci/dwc-msi

Thanks,
Lorenzo

>  drivers/pci/dwc/pcie-designware-plat.c |  16 --
>  drivers/pci/dwc/pcie-designware.h      |  30 ++-
>  drivers/pci/dwc/pcie-qcom.c            |  16 --
>  11 files changed, 258 insertions(+), 355 deletions(-)
> 
> -- 
> 2.7.4
> 
> 
