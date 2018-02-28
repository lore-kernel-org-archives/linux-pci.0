Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55628 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932126AbeB1SM7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Feb 2018 13:12:59 -0500
Subject: Re: [PATCH v9 0/3] PCI: dwc: Enables MSI-X driver support
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Joao.Pinto@synopsys.com, bhelgaas@google.com, jingoohan1@gmail.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com
Cc: linux-pci@vger.kernel.org, m-karicheri2@ti.com,
        thomas.petazzoni@free-electrons.com, minghuan.Lian@freescale.com,
        mingkai.hu@freescale.com, tie-fei.zang@freescale.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        niklas.cassel@axis.com, jesper.nilsson@axis.com,
        wangzhou1@hisilicon.com, svarbanov@mm-sol.com, nsekhar@ti.com
References: <cover.1519834018.git.gustavo.pimentel@synopsys.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <08046a31-fa8c-d43f-bea0-d83efb3adc0c@arm.com>
Date: Wed, 28 Feb 2018 18:12:54 +0000
MIME-Version: 1.0
In-Reply-To: <cover.1519834018.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 28/02/18 16:10, Gustavo Pimentel wrote:
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
>  drivers/pci/dwc/pcie-designware-plat.c |  16 --
>  drivers/pci/dwc/pcie-designware.h      |  30 ++-
>  drivers/pci/dwc/pcie-qcom.c            |  16 --
>  11 files changed, 258 insertions(+), 355 deletions(-)
> 

For the whole series:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

There is certainly some more cleanups to be done, but that's a huge step
in the right direction. Many thanks Gustavo and Joao for having stuck
with it.

	M.
-- 
Jazz is not dead. It just smells funny...
