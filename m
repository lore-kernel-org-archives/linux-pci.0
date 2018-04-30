Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57406 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753102AbeD3KTo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Apr 2018 06:19:44 -0400
Date: Mon, 30 Apr 2018 11:19:40 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/9] Add new helper to allocate irq domain for hosts
Message-ID: <20180430101940.GB32033@e107981-ln.cambridge.arm.com>
References: <1524817322-239028-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524817322-239028-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 27, 2018 at 04:22:02PM +0800, Shawn Lin wrote:
> 
> Hi Bjorn and Lorenzo,
> 
> PCI drivers use highly similar code block to allocate irq domain which
> leads to code duplication than expected. This patchset adds a new helper,
> pci_alloc_intx_irqd(), to avoid that as much as possible. Just leave
> pcie-rockchip out now as it's under re-construct and will add incremental
> patch for it if this series looks ok and the pcie-rockchip ongoing patches
> got merge.

Is this patch series v1 of:

https://patchwork.ozlabs.org/patch/906006/

?

Thanks,
Lorenzo

> 
> 
> 
> 
> Shawn Lin (9):
>   PCI: Add new helper for allocating irq domain for INTx
>   PCI: dra7xx: Use pci_alloc_intx_irqd() helper to simplify the code
>   PCI: keystone-dw: Use pci_alloc_intx_irqd() helper to get irq domain
>     for INTx
>   PCI: aardvark: Use pci_alloc_intx_irqd() helper to get irq domain for
>     INTx
>   PCI: faraday: Use pci_alloc_intx_irqd() helper to get irq domain for
>     INTx
>   PCI: altera: Use pci_alloc_intx_irqd() helper to get irq domain for
>     INTx
>   PCI: mediatek: Use pci_alloc_intx_irqd() helper to get irq domain for
>     INTx
>   PCI: xilinx-nwl: Use pci_alloc_intx_irqd() helper to get irq domain
>     for INTx
>   PCI: xilinx: Use pci_alloc_intx_irqd() helper to get irq domain for
>     INTx
> 
>  drivers/pci/dwc/pci-dra7xx.c       | 41 ++-------------------
>  drivers/pci/dwc/pci-keystone-dw.c  | 12 +++----
>  drivers/pci/host/pci-aardvark.c    | 24 +++----------
>  drivers/pci/host/pci-ftpci100.c    | 15 +++-----
>  drivers/pci/host/pcie-altera.c     | 38 +++-----------------
>  drivers/pci/host/pcie-mediatek.c   | 29 ++-------------
>  drivers/pci/host/pcie-xilinx-nwl.c | 21 +++--------
>  drivers/pci/host/pcie-xilinx.c     | 43 ++--------------------
>  include/linux/pci.h                | 74 ++++++++++++++++++++++++++++++++++++++
>  9 files changed, 104 insertions(+), 193 deletions(-)
> 
> -- 
> 1.9.1
> 
> 
