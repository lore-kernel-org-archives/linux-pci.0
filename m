Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751590AbdFOVfI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jun 2017 17:35:08 -0400
Date: Thu, 15 Jun 2017 16:35:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul Burton <paul.burton@imgtec.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH v4 0/4] PCI: xilinx: Fixes, optimisation & MIPS support
Message-ID: <20170615213505.GG12735@bhelgaas-glaptop.roam.corp.google.com>
References: <20170602185420.22281-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170602185420.22281-1-paul.burton@imgtec.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 02, 2017 at 11:54:15AM -0700, Paul Burton wrote:
> This series fixes an issue found using INTx interrupts with the Xilinx
> AXI PCIe Host Bridge IP on the Imagination Technologies MIPS Boston
> development board, performs a couple of optimisations to interrupt
> handling & allows the driver to be used on MIPS systems.
> 
> Applies atop v4.12-rc3.
> 
> Paul Burton (4):
>   PCI: xilinx: Fix INTX irq dispatch
>   PCI: xilinx: Unify INTx & MSI interrupt decode
>   PCI: xilinx: Don't enable config completion interrupts
>   PCI: xilinx: Allow build on MIPS platforms
> 
>  drivers/pci/host/Kconfig       |  2 +-
>  drivers/pci/host/pcie-xilinx.c | 57 +++++++++++++++---------------------------
>  2 files changed, 21 insertions(+), 38 deletions(-)

Hi Paul, et al.,

Waiting for resolution on patch 1 and ack from maintainers.
