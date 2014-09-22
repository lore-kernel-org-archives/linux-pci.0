Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:52932 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbaIVL2y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 07:28:54 -0400
Date: Mon, 22 Sep 2014 12:28:50 +0100
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3] Add PCI domain support to R-Car drivers
Message-ID: <20140922112849.GL1994@e106497-lin.cambridge.arm.com>
References: <1411379470-20639-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
In-Reply-To: <1411379470-20639-1-git-send-email-phil.edworthy@renesas.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 22, 2014 at 10:51:07AM +0100, Phil Edworthy wrote:
> The Renesas R-Car devices (r8a7790 and r8a7791) use two PCI controller drivers,
> one for an external PCIe slot, the other for an internal PCI bridge to USB
> controllers.
> 
> However, they currently do not work at the same time as they use the same PCI
> domain and use the same root bus number. We can't use different root bus numbers
> due to the way root bus numbers are assigned in pcibios_init_hw() in
> arch/arm/kernel/bios32.c.
> 
> Since the two PCI controllers are completely independent, I think it makes sense
> to use different PCI domains for them.
> 
> I've marked the third patch as RFC as I am not sure of the impact of enabling
> PCI domains for all ARM devices. In the march to 'one kernel to rule them all',
> I steered clear of mach specific changes.
> 
> These patches require the following patch from Liviu Dudau:
>   [PATCH v11 07/10] OF: Introduce helper function for getting PCI domain_nr
> Based on comments on this patch from Jason Gunthorpe, there is still the issue
> that the domain numbers may change depending on the ordering at probe time.
> However, this can be fixed later on by adding the entries in the DT files.

Hi Phil,

I'm happy that you found use for my patch, but I can't help wondering if it is
not a better idea to convert your drivers to the whole new API in my series.
Do you have any thoughts on that?

One other thing to note: Rob Herring is not very happy with the mix of OF
parsing and domain number allocation going in together, so I might remove the
OF parsing entirely for now. Would that cause you any problems (other than
the fact that if of_pci_get_domain_nr() doesn't do anything OF related I might
rename it to pci_get_domain_nr()). You don't seem to have any alias defined
for pci-domain in the DT, so I'll guess not.

Best regards,
Liviu

> 
> 
> Phil Edworthy (3):
>   PCI: rcar-pcie: Add call to get domain nr
>   PCI: rcar-internal-pci: Add call to get domain nr
>   ARM: Enable PCI domains
> 
>  arch/arm/Kconfig                 | 2 +-
>  drivers/pci/host/pci-rcar-gen2.c | 6 ++++++
>  drivers/pci/host/pcie-rcar.c     | 9 ++++++---
>  3 files changed, 13 insertions(+), 4 deletions(-)
> 
> -- 
> 2.1.0
> 
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

