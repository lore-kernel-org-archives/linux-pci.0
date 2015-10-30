Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57925 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758892AbbJ3Nb4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 30 Oct 2015 09:31:56 -0400
Date: Fri, 30 Oct 2015 08:31:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Wolfram Sang <wsa@the-dreams.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] PCI: rcar: Add support for ARM64 and multiple
 instances
Message-ID: <20151030133150.GA17889@localhost>
References: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
 <20151029123755.GC2351@katana>
 <PS1PR06MB118061CA5128E4C1A2C70A18F5200@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <20151029163930.GC22218@katana>
 <PS1PR06MB11804B39B09D6FCAA9B3D9DCF5200@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <20151029184800.GB8992@katana>
 <20151029230314.GA11994@localhost>
 <PS1PR06MB1180BAA32BDBEE6BFD8229C3F52F0@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <PS1PR06MB11807765B8231D1DD01B05ADF52F0@PS1PR06MB1180.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <PS1PR06MB11807765B8231D1DD01B05ADF52F0@PS1PR06MB1180.apcprd06.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 30, 2015 at 09:00:20AM +0000, Phil Edworthy wrote:
> Hi Bjorn,
> 
> On 30 October 2015 07:24, Phil wrote:
> > On 30 October 2015 07:19, Phil wrote
> > > On 29 October 2015 23:03, Bjorn wrote:
> > > > On Thu, Oct 29, 2015 at 07:48:00PM +0100, Wolfram Sang wrote:
> > > > > On Thu, Oct 29, 2015 at 04:44:06PM +0000, Phil Edworthy wrote:
> > > > > > Hi Wolfram,
> > > > > >
> > > > > > On 29 October 2015 16:40, Wolfram wrote:
> > > > > > > > Ouch, my bad. I have been working with our out-of-tree BSP for the
> > > > Salvator-X
> > > > > > > board on
> > > > > > > > http://git.kernel.org/cgit/linux/kernel/git/horms/renesas-bsp.git,
> > rcar-
> > > > 3.0.2
> > > > > > > tag along
> > > > > > > > with some patches from colleagues. I hadn't noticed this patch:
> > > > > > >
> > > > > > > Thanks! Any plans for pushing this upstream? We will have the build
> > error
> > > > > > > otherwise...
> > > > > > After some digging, that patch won't be accepted upstream. I'm looking
> > into
> > > > how the
> > > > > > driver can be modified so it doesn't need to call this, but I don't expect a
> > > small
> > > > or
> > > > > > imminent fix.
> > > > >
> > > > > Yes, I'd think so, too. However, a fix for 4.4 would be needed to
> > > > > prevent having a final release with a build error.
> > > >
> > > > I'm thinking I should drop my pci/host-rcar branch until we
> > > > have a fix for this.  It currently contains:
> > > >
> > > >   9ac724f20774 PCI: rcar: Fix I/O offset for multiple host bridges
> > > >   7d75b413f5c6 PCI: rcar: Set root bus nr to that provided in DT
> > > >   4c22eab88c68 PCI: rcar: Remove dependency on ARM-specific struct hw_pci
> > > >   ef18d2e55ea0 PCI: rcar: Make PCI aware of the I/O resources
> > > >
> > > > Is that right?  Last I heard, Linus expects to release v4.3 on Sunday,
> > > > so we really don't have much time to sort this out.
> > > The simple thing is to re-add Geert's patch to stop this driver being built for
> > > arm64.
> > Btw, it's this one: https://patchwork.ozlabs.org/patch/512040/
> It's worth mentioning that Geert's patch stops both the rcar-pcie driver and the
> rcar-pci-gen2 driver from being built on arm64 due to build failures for both of
> them. The rcar-pci-gen2 driver is not for R-Car Gen3 devices, and so should not
> be built for arm64. The rcar-pcie driver will be used on R-Car Gen3 devices.
> 
> So if we don't use Geert's patch, I need to fix the rcar-pcie driver so it doesn't
> use pci_ioremap_io(), _and_ fix Kconfig so that the rcar-pci-gen2 driver doesn't
> get built on arm64. 
> Let's just use Geert's patch for now.

OK, I re-added Geert's patch.  I split it into two, one for
rcar-pci-gen2 and another for rcar-pcie, to help me keep things
straight.  If I understand correctly,

  - rcar-pci-gen2 depends on the ARM-specific pci_sys_data, and I
    don't have anything queued to address that.

  - rcar-pcie depended on the ARM-specific pci_sys_data and
    pci_ioremap_io().  Your patches remove the pci_sys_data
    dependency, and it sounds like future changes will remove the
    pci_ioremap_io() dependency.

The result is in my pci/host-rcar branch:
https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-rcar

Bjorn
