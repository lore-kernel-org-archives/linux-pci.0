Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751848AbdHOVdS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Aug 2017 17:33:18 -0400
Date: Tue, 15 Aug 2017 16:33:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul Burton <paul.burton@imgtec.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 0/8] PCI: INTx interrupt fixes & cleanup
Message-ID: <20170815213315.GM32525@bhelgaas-glaptop.roam.corp.google.com>
References: <20170815190223.18807-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170815190223.18807-1-paul.burton@imgtec.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 15, 2017 at 12:02:15PM -0700, Paul Burton wrote:
> This series fixes our handling of the PCI INTD interrupts in both Xilinx
> PCIe controller drivers, and cleans up a wasted IRQ domain entry in the
> Altera PCIe controller driver. It also adds a common PCI_INTX_NUM
> definition which all relevant drivers under drivers/pci/host/ are
> adjusted to make use of.
> 
> - Patch 1 moves enum pci_interrupt_pin to somewhere we can use it from
>   PCI host code.
> 
> - Patch 2 introduces a helper function to translate 1-4 INTx ranges into
>   the 0-3 range, by using it as a struct irq_domain's xlate callback.
> 
> - Patches 3 adjusts the Altera driver to avoid wasting an IRQ domain
>   entry.
> 
> - Patches 4 & 5 fix the INTD interrupt for Xilinx PCIe drivers.
> 
> - Patches 6-8 make use of PCI_NUM_INTX to replace custom definitions or
>   magic numbers in drivers.
> 
> The series versioning is continuing on from that of my "PCI: xilinx:
> Fixes, optimisation & MIPS support" series which some of the earlier
> patches were originally a part of, in order to prevent individual
> patches from jumping backwards in versioning.
> 
> Applies atop v4.13-rc5.
> 
> Paul Burton (8):
>   PCI: Move enum pci_interrupt_pin to linux/pci.h
>   PCI: Introduce pci_irqd_intx_xlate()
>   PCI: altera: Use size=4 IRQ domain for legacy INTx
>   PCI: xilinx: Translate INTx range to hwirqs 0-3
>   PCI: xilinx-nwl: Translate INTx range to hwirqs 0-3
>   PCI: aardvark: Use PCI_NUM_INTX
>   PCI: ftpci100: Use PCI_NUM_INTX
>   PCI: rockchip: Use PCI_NUM_INTX
> 
>  drivers/pci/host/pci-aardvark.c    |  5 ++--
>  drivers/pci/host/pci-ftpci100.c    |  2 +-
>  drivers/pci/host/pcie-altera.c     |  9 +++----
>  drivers/pci/host/pcie-rockchip.c   |  2 +-
>  drivers/pci/host/pcie-xilinx-nwl.c |  9 +++----
>  drivers/pci/host/pcie-xilinx.c     |  7 ++---
>  include/linux/pci-epf.h            |  9 +------
>  include/linux/pci.h                | 54 ++++++++++++++++++++++++++++++++++++++
>  8 files changed, 71 insertions(+), 26 deletions(-)

Thanks for updating these, Paul.  I applied them on pci/irq-intx and the
individual driver branches.  I added Thomas' reviewed-by for Aardvark, and
I expect we'll get more for the others.

I found two more places we can use PCI_NUM_INTX; I'll post those in a
minute.

Thanks for all your work on this!
