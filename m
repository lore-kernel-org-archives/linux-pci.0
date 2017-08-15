Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751598AbdHOVfB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Aug 2017 17:35:01 -0400
Date: Tue, 15 Aug 2017 16:34:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul Burton <paul.burton@imgtec.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH v7 0/3] PCI: xilinx: Optimisation & MIPS support
Message-ID: <20170815213458.GN32525@bhelgaas-glaptop.roam.corp.google.com>
References: <20170815191117.19882-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170815191117.19882-1-paul.burton@imgtec.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 15, 2017 at 12:11:14PM -0700, Paul Burton wrote:
> This series implements a couple of optimisations around interrupt
> handling for the Xilinx AXI PCIe Host Bridge IP, then enables building
> our driver for the MIPS architecture in order to make use of it on the
> MIPS Boston development board.
> 
> The INTD fix was moved out of this series in v7 and is now part of a
> "PCI: INTx interrupt fixes & cleanup" series which should be applied
> first in order to avoid hitting the broken INTD interrupt issue on MIPS
> Boston boards.
> 
> Applies atop v4.13-rc5, ideally after my "PCI: INTx interrupt fixes &
> cleanup" series.
> 
> Paul Burton (3):
>   PCI: xilinx: Unify INTx & MSI interrupt decode
>   PCI: xilinx: Don't enable config completion interrupts
>   PCI: xilinx: Allow build on MIPS platforms
> 
>  drivers/pci/host/Kconfig       |  2 +-
>  drivers/pci/host/pcie-xilinx.c | 53 ++++++++++++++----------------------------
>  2 files changed, 19 insertions(+), 36 deletions(-)

I tentatively applied these (and the other Xilinx patches) on
pci/host-xilinx.  I'd like to get maintainer acks for the whole shebang.

See https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-xilinx

Bjorn
