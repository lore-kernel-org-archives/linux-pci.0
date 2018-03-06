Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753920AbeCFSW2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Mar 2018 13:22:28 -0500
Date: Tue, 6 Mar 2018 18:22:15 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: marc.zyngier@arm.com, Joao.Pinto@synopsys.com, bhelgaas@google.com,
        jingoohan1@gmail.com, kishon@ti.com, linux-pci@vger.kernel.org,
        m-karicheri2@ti.com, thomas.petazzoni@free-electrons.com,
        minghuan.Lian@freescale.com, mingkai.hu@freescale.com,
        tie-fei.zang@freescale.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, niklas.cassel@axis.com,
        shawn.guo@linaro.org, jesper.nilsson@axis.com,
        wangzhou1@hisilicon.com, gabriele.paoloni@huawei.com,
        svarbanov@mm-sol.com, nsekhar@ti.com
Subject: Re: [PATCH v11 0/4] PCI: dwc: Enables MSI-X driver support
Message-ID: <20180306182207.GA3208@e107981-ln.cambridge.arm.com>
References: <cover.1520358461.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1520358461.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 06, 2018 at 05:54:26PM +0000, Gustavo Pimentel wrote:
> Implement a multiplexed IRQ domain hierarchy API in the pcie-designware
> host bridge driver that funnels all MSI IRQs into a single parent
> interrupt, moving away from the obsolete struct msi_controller based
> API.
> 
> Remove all existing dwc based host bridges MSI IRQs handlers, in that the
> hierarchical API now handles MSI IRQs through the hierarchical/chained
> MSI domain implementation.
> 
> The Synopsys PCIe Root Complex supports up to MSI 256 IRQs distributed
> over 8 controller registers, therefore the maximum number of MSI IRQs
> can be changed to 256. The number of controllers can be calculated based
> on the number of vectors used by the specific SoC driver.
> 
> Adds Synopsys Root Complex driver support for MSI-X feature.
> 
> The patch set was made against the Bjorn's master branch (v4.16-rc1).
> 
> Gustavo Pimentel (4):
>   PCI: dwc: Move MSI IRQs allocation to IRQ domains hierarchical API
>   PCI: dwc: Remove old MSI IRQs API
>   PCI: dwc: Expand maximum number of MSI IRQs from 32 to 256
>   PCI: dwc: Code cleanup

Ok, so a couple of suggestions:

0) Remove Gabriele from the CC list - his email must be bouncing for you too
   right ?
1) Consider patches on my pci/dwc-msi branch immutable from now onwards,
   that's important for me and other maintainers CC'ed
2) Related to (1), first 3 patches must NOT be posted again
3) Patch (4) is a potpourri of clean-ups. It is tempting to squash
   all clean ups in one patch but every patch has to be *logically*
   split so that it contains one logical change. I will comment on it.
   You will need to split patch (4) and repost it, but first trim the
   CC list, do not copy any maintainer other than pci/dwc ones on the series
   resulting from patch (4) rework.

If there is anything unclear please do let me know.

Thanks,
Lorenzo
