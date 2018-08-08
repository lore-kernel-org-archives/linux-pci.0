Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbeHHSBI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Aug 2018 14:01:08 -0400
Date: Wed, 8 Aug 2018 16:40:58 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Nadav Haklai <nadavh@marvell.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/6] PCI: mvebu: cleanup and improvements
Message-ID: <20180808154058.GA19383@red-moon>
References: <20180803143848.21551-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180803143848.21551-1-thomas.petazzoni@bootlin.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 03, 2018 at 04:38:42PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> This is the v2 of the pci-mvebu cleanup and improvements, mainly
> aiming at using pci_host_bridge.
> 
> Since v1, the changes are:
> 
>  - Rebase on v4.18-rc1 to make sure the patches apply
> 
>  - Add a patch fixing the I/O space end calculation (using
>    resource_size() as the .end address of a resource is not correct)
> 
>  - Only remap the I/O space if there is a PCI I/O aperture described
>    in the DT.
> 
>  - Use resource_size() in the loop mapping the I/O space, as suggested
>    by Lorenzo.
> 
>  - Use pci_add_resource() instead of pci_add_resource_offset(), as
>    suggested by Lorenzo.
> 
>  - Revert to using pci_ioremap_io(), since we need to map with a
>    special memory type on Armada platforms, and pci_remap_iospace()
>    doesn't allow to do that. Noticed by Lorenzo.

Pulled into pci/mvebu (I reworded some commit logs in the process
please have a look) for (tentatively) v4.19 but it is a bit late
in the cycle so let's see how things go.

Thanks,
Lorenzo

> 
> Thanks!
> 
> Thomas
> 
> Thomas Petazzoni (6):
>   PCI: mvebu: Remove redundant platform_set_drvdata() call
>   PCI: mvebu: fix I/O space end address calculation
>   PCI: mvebu: only remap I/O space if configured
>   PCI: mvebu: use resource_size() to remap I/O space
>   PCI: mvebu: Convert to use pci_host_bridge directly
>   PCI: mvebu: Drop bogus comment above mvebu_pcie_map_registers()
> 
>  drivers/pci/controller/pci-mvebu.c | 153 +++++++++++++++++--------------------
>  1 file changed, 68 insertions(+), 85 deletions(-)
> 
> -- 
> 2.14.4
> 
