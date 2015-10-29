Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38155 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756820AbbJ2XDU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 29 Oct 2015 19:03:20 -0400
Date: Thu, 29 Oct 2015 18:03:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] PCI: rcar: Add support for ARM64 and multiple
 instances
Message-ID: <20151029230314.GA11994@localhost>
References: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
 <20151029123755.GC2351@katana>
 <PS1PR06MB118061CA5128E4C1A2C70A18F5200@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <20151029163930.GC22218@katana>
 <PS1PR06MB11804B39B09D6FCAA9B3D9DCF5200@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <20151029184800.GB8992@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151029184800.GB8992@katana>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[-cc Nobuhiro (bouncing)]

On Thu, Oct 29, 2015 at 07:48:00PM +0100, Wolfram Sang wrote:
> On Thu, Oct 29, 2015 at 04:44:06PM +0000, Phil Edworthy wrote:
> > Hi Wolfram,
> > 
> > On 29 October 2015 16:40, Wolfram wrote:
> > > > Ouch, my bad. I have been working with our out-of-tree BSP for the Salvator-X
> > > board on
> > > > http://git.kernel.org/cgit/linux/kernel/git/horms/renesas-bsp.git,  rcar-3.0.2
> > > tag along
> > > > with some patches from colleagues. I hadn't noticed this patch:
> > > 
> > > Thanks! Any plans for pushing this upstream? We will have the build error
> > > otherwise...
> > After some digging, that patch won't be accepted upstream. I'm looking into how the
> > driver can be modified so it doesn't need to call this, but I don't expect a small or
> > imminent fix.
> 
> Yes, I'd think so, too. However, a fix for 4.4 would be needed to
> prevent having a final release with a build error.

I'm thinking I should drop my pci/host-rcar branch until we
have a fix for this.  It currently contains:

  9ac724f20774 PCI: rcar: Fix I/O offset for multiple host bridges
  7d75b413f5c6 PCI: rcar: Set root bus nr to that provided in DT
  4c22eab88c68 PCI: rcar: Remove dependency on ARM-specific struct hw_pci
  ef18d2e55ea0 PCI: rcar: Make PCI aware of the I/O resources

Is that right?  Last I heard, Linus expects to release v4.3 on Sunday,
so we really don't have much time to sort this out.

Bjorn
