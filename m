Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938813AbcIFRvU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Sep 2016 13:51:20 -0400
Date: Tue, 6 Sep 2016 12:43:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH 0/6] PCI: fix pci_remap_iospace() failure paths
Message-ID: <20160906174357.GC7554@localhost>
References: <1471279854-11916-1-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471279854-11916-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 15, 2016 at 05:50:40PM +0100, Lorenzo Pieralisi wrote:
> On ARM/ARM64 architectures, PCI IO ports are emulated through memory
> mapped IO, by reserving a chunk of virtual address space starting at
> PCI_IOBASE and by mapping the PCI host bridges memory address space
> driving PCI IO cycles to it.
> 
> PCI host bridge drivers that enable downstream PCI IO cycles map the
> host bridge memory address responding to PCI IO cycles to the fixed
> virtual address space through the pci_remap_iospace() API.
> 
> This means that if the pci_remap_iospace() function fails, the
> corresponding host bridge PCI IO resource must be considered invalid, in
> that there is no way for the kernel to actually drive PCI IO transactions
> if the memory addresses responding to PCI IO cycles cannot be mapped into
> the CPU virtual address space.
> 
> As a follow-up to the linux-pci mailing list thread ([0]), this series
> fixes the pci_remap_iospace() failure paths by adding code that handles
> the failures and takes the required actions.
> 
> Compile tested on all affected PCI host controllers, testing and
> reviewing much appreciated.
> 
> [0] http://marc.info/?l=linux-pci&m=145816042427417&w=2
> 
> Lorenzo Pieralisi (6):
>   drivers: pci: host: aardvark: fix pci_remap_iospace() failure path
>   drivers: pci: host: designware: fix pci_remap_iospace() failure path
>   drivers: pci: host: versatile: fix pci_remap_iospace() failure path
>   drivers: pci: host: rcar: fix pci_remap_iospace() failure path
>   drivers: pci: host: common: fix pci_remap_iospace() failure path
>   drivers: pci: host: tegra: fix pci_remap_iospace() failure path
> 
>  drivers/pci/host/pci-aardvark.c    |  8 +++++---
>  drivers/pci/host/pci-host-common.c |  8 +++++---
>  drivers/pci/host/pci-tegra.c       |  7 +++++--
>  drivers/pci/host/pci-versatile.c   |  8 +++++---
>  drivers/pci/host/pcie-designware.c | 21 ++++++++++++---------
>  drivers/pci/host/pcie-rcar.c       |  9 ++++++---
>  6 files changed, 38 insertions(+), 23 deletions(-)

Applied to pci/enumeration for v4.9, thanks!
