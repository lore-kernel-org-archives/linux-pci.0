Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Simon Horman <horms@verge.net.au>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Resend: PATCH v2 0/3] Fix rcar-pcie for arm64
Date: Thu, 26 Nov 2015 08:32:43 +0000
Message-ID: <PS1PR06MB118027A91BEF26FC73A6E76EF5040@PS1PR06MB1180.apcprd06.prod.outlook.com>
References: <1448465439-2132-1-git-send-email-phil.edworthy@renesas.com>
 <20151125164033.GA1380@localhost>
In-Reply-To: <20151125164033.GA1380@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

HI Bjorn,

On 25 November 2015 16:41, Bjorn Helgaas wrote:
> Hi Phil,
> 
> On Wed, Nov 25, 2015 at 03:30:36PM +0000, Phil Edworthy wrote:
> > The first patches fixes the build problem
> 
> I'm trying to figure out if v4.4 has a build problem we need to fix.
> If I understand correctly, "PCI: rcar: Convert to DT resource parsing
> API" doesn't fix a build problem in the current tree; rather, it
> removes a dependency on ARM so that we can build it on ARM64.
v4.4 doesn't have a build problem because commit 7c537c67d2e4 ensures
it doesn't get built on arm64. If we revert this commit, then there is a
build failure as the pci_ioremap_io() function is not available on arm64.
That's the build failure which "PCI: rcar: Convert to DT resource parsing API"
fixes.

> > , and the second patch reverts the
> > patch that removed the driver from arm64 builds. The final patch add a compat
> > string for the r8a7795 (arm64) device.
> >
> > Tested on arm Koelsch board, all ok.
> >
> > Tested on arm64 Salvator-X board using renesas-drivers-2015-10-27-v4.3-rc7
> from
> > git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git with
> PCI
> > next merged.
> > Apart from patches to add the PCIe clock and DT nodes, it also needs this fix:
> > ("PCI: MSI: Only use the generic MSI layer when domain is hierarchical")
> 
> I assume you mean this one from Marc: https://lkml.org/lkml/2015/11/23/388
> (Was that posted to linux-pci?  I don't see it in patchwork or my
> linux-pci archives, so I hadn't seen it yet.)
Ok, yes that's the patch.

> How exactly is that related to this series?  If I merge these before
> Marc's change, do we have a tree that builds for arm64 but doesn't
> work?
Correct.

> What about the PCIe clock and DT changes you mention?  Is there a
> reason to keep them separate?  Would it be feasible to include the DT
> changes in the same patch as the driver change that uses those
> changes?
The approach for all other drivers has been to keep these separate. There
are no changes to the dt bindings, it's just adding the node to the new
device and board, so there is no problem with ordering of these patches.

Thanks
Phil

> Bjorn
> 
> > Resent with whole series marked as v2 and acks, etc added.
> >
> > Harunobu Kurokawa (1):
> >   PCI: pcie-rcar: Add support for R-Car H3.
> >
> > Phil Edworthy (2):
> >   PCI: rcar: Convert to DT resource parsing API
> >   Revert "PCI: rcar: Build pcie-rcar.c only on ARM"
> >
> >  Documentation/devicetree/bindings/pci/rcar-pci.txt |   3 +-
> >  drivers/pci/host/Kconfig                           |   3 +-
> >  drivers/pci/host/pcie-rcar.c                       | 117 +++++++++++++--------
> >  3 files changed, 77 insertions(+), 46 deletions(-)
> >
> > --
> > 2.5.0
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
