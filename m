Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 25 Nov 2015 10:40:33 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Resend: PATCH v2 0/3] Fix rcar-pcie for arm64
Message-ID: <20151125164033.GA1380@localhost>
References: <1448465439-2132-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448465439-2132-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Phil,

On Wed, Nov 25, 2015 at 03:30:36PM +0000, Phil Edworthy wrote:
> The first patches fixes the build problem

I'm trying to figure out if v4.4 has a build problem we need to fix.
If I understand correctly, "PCI: rcar: Convert to DT resource parsing
API" doesn't fix a build problem in the current tree; rather, it
removes a dependency on ARM so that we can build it on ARM64.  

> , and the second patch reverts the
> patch that removed the driver from arm64 builds. The final patch add a compat
> string for the r8a7795 (arm64) device.
> 
> Tested on arm Koelsch board, all ok.
> 
> Tested on arm64 Salvator-X board using renesas-drivers-2015-10-27-v4.3-rc7 from
> git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git with PCI
> next merged. 
> Apart from patches to add the PCIe clock and DT nodes, it also needs this fix:
> ("PCI: MSI: Only use the generic MSI layer when domain is hierarchical")

I assume you mean this one from Marc: https://lkml.org/lkml/2015/11/23/388
(Was that posted to linux-pci?  I don't see it in patchwork or my
linux-pci archives, so I hadn't seen it yet.)

How exactly is that related to this series?  If I merge these before
Marc's change, do we have a tree that builds for arm64 but doesn't
work?

What about the PCIe clock and DT changes you mention?  Is there a
reason to keep them separate?  Would it be feasible to include the DT
changes in the same patch as the driver change that uses those
changes?

Bjorn

> Resent with whole series marked as v2 and acks, etc added.
> 
> Harunobu Kurokawa (1):
>   PCI: pcie-rcar: Add support for R-Car H3.
> 
> Phil Edworthy (2):
>   PCI: rcar: Convert to DT resource parsing API
>   Revert "PCI: rcar: Build pcie-rcar.c only on ARM"
> 
>  Documentation/devicetree/bindings/pci/rcar-pci.txt |   3 +-
>  drivers/pci/host/Kconfig                           |   3 +-
>  drivers/pci/host/pcie-rcar.c                       | 117 +++++++++++++--------
>  3 files changed, 77 insertions(+), 46 deletions(-)
> 
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
