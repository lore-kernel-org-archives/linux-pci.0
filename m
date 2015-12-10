Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 10 Dec 2015 13:27:21 +0900
From: Simon Horman <horms@verge.net.au>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Resend: PATCH v2 0/3] Fix rcar-pcie for arm64
Message-ID: <20151210042719.GA6964@verge.net.au>
References: <1448465439-2132-1-git-send-email-phil.edworthy@renesas.com>
 <20151125164033.GA1380@localhost>
 <PS1PR06MB118027A91BEF26FC73A6E76EF5040@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <20151209165954.GG31930@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151209165954.GG31930@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 09, 2015 at 10:59:54AM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 26, 2015 at 08:32:43AM +0000, Phil Edworthy wrote:
> > HI Bjorn,
> > 
> > On 25 November 2015 16:41, Bjorn Helgaas wrote:
> > > Hi Phil,
> > > 
> > > On Wed, Nov 25, 2015 at 03:30:36PM +0000, Phil Edworthy wrote:
> > > > The first patches fixes the build problem
> > > 
> > > I'm trying to figure out if v4.4 has a build problem we need to fix.
> > > If I understand correctly, "PCI: rcar: Convert to DT resource parsing
> > > API" doesn't fix a build problem in the current tree; rather, it
> > > removes a dependency on ARM so that we can build it on ARM64.
> > v4.4 doesn't have a build problem because commit 7c537c67d2e4 ensures
> > it doesn't get built on arm64. If we revert this commit, then there is a
> > build failure as the pci_ioremap_io() function is not available on arm64.
> > That's the build failure which "PCI: rcar: Convert to DT resource parsing API"
> > fixes.
> > 
> > > > , and the second patch reverts the
> > > > patch that removed the driver from arm64 builds. The final patch add a compat
> > > > string for the r8a7795 (arm64) device.
> > > >
> > > > Tested on arm Koelsch board, all ok.
> > > >
> > > > Tested on arm64 Salvator-X board using renesas-drivers-2015-10-27-v4.3-rc7
> > > from
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git with
> > > PCI
> > > > next merged.
> > > > Apart from patches to add the PCIe clock and DT nodes, it also needs this fix:
> > > > ("PCI: MSI: Only use the generic MSI layer when domain is hierarchical")
> > > 
> > > I assume you mean this one from Marc: https://lkml.org/lkml/2015/11/23/388
> > > (Was that posted to linux-pci?  I don't see it in patchwork or my
> > > linux-pci archives, so I hadn't seen it yet.)
> > Ok, yes that's the patch.
> > 
> > > How exactly is that related to this series?  If I merge these before
> > > Marc's change, do we have a tree that builds for arm64 but doesn't
> > > work?
> > Correct.
> 
> OK, great!  I just asked Linus to pull that patch (3845d2953aac ("PCI/MSI:
> Only use the generic MSI layer when domain is hierarchical")) for v4.4, so
> these changes will be merged after that one.
> 
> I put all three of these on pci/host-rcar for v4.5.
> 
> Simon, I only see your explicit ack on the first one, but I assume you're
> OK with all three.  Let me know if otherwise.

Sorry for not being clearer: I'm ok with these changes.
