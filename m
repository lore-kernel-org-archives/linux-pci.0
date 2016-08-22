Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52141 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751754AbcHVNWS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Aug 2016 09:22:18 -0400
Date: Mon, 22 Aug 2016 14:21:24 +0100
From: Will Deacon <will.deacon@arm.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 5/6] drivers: pci: host: common: fix pci_remap_iospace()
 failure path
Message-ID: <20160822132124.GG14680@arm.com>
References: <1471279854-11916-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1471279854-11916-6-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471279854-11916-6-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 15, 2016 at 05:50:45PM +0100, Lorenzo Pieralisi wrote:
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
> that there is no way for the kernel to actually drive PCI IO
> transactions if the memory addresses responding to PCI
> IO cycles cannot be mapped into the CPU virtual address space.
> 
> The PCI common host bridge driver does not remove the PCI IO
> resource from the host bridge resource windows if the
> pci_remap_iospace() call fails; this is an actual bug in that the
> PCI host bridge would consider the PCI IO resource valid (and possibly
> assign it to downstream devices) even if the kernel was not able
> to map the PCI host bridge memory address driving IO cycle to the
> CPU virtual address space (ie pci_remap_iospace() failures).
> 
> Fix the PCI host bridge driver pci_remap_iospace() failure path, by
> destroying the PCI host bridge PCI IO resources retrieved through
> firmware when the pci_remap_iospace() function call fails, therefore
> preventing the kernel from adding the respective PCI IO resource to the
> list of PCI host bridge valid resources, fixing the issue.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Fixes: 4e64dbe226e7 ("PCI: generic: Expose pci_host_common_probe() for
> use by other drivers")
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  drivers/pci/host/pci-host-common.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Looks good to me:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
