Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:5169 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750732AbbJTNWC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 20 Oct 2015 09:22:02 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: RE: [PATCH 0/4] PCI: rcar: Add support for ARM64 and multiple
 instances
Date: Tue, 20 Oct 2015 13:21:56 +0000
Message-ID: <SIXPR06MB041582EF048D34F18AFD0E9FF5390@SIXPR06MB0415.apcprd06.prod.outlook.com>
References: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
 <20151019231634.GA13841@localhost> <20151020013650.GA13721@verge.net.au>
 <CAMuHMdWiH4ZUSmKQ01qQYvXcjb_3K4XBFLjVGSe1dUoKi=Jb_Q@mail.gmail.com>
 <SIXPR06MB04158545EDCA19F6C66A6783F5390@SIXPR06MB0415.apcprd06.prod.outlook.com>
 <20151020124933.GA8224@localhost>
In-Reply-To: <20151020124933.GA8224@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 20 October 2015 13:50, Bjorn wrote:
> On Tue, Oct 20, 2015 at 08:00:10AM +0000, Phil Edworthy wrote:
> > Hi Geert,
> >
> > On 20 October 2015 08:37, Geert wrote:
> > > On Tue, Oct 20, 2015 at 3:36 AM, Simon Horman <horms@verge.net.au>
> wrote:
> > > > On Mon, Oct 19, 2015 at 06:16:34PM -0500, Bjorn Helgaas wrote:
> > > >> [+cc Geert]
> > > >>
> > > >> On Fri, Oct 02, 2015 at 11:25:03AM +0100, Phil Edworthy wrote:
> > > >> > Fixes and changes to get PCIe working on ARM64 with mulitple
> instances.
> > > >> >
> > > >> > I've tested these on ARM (Koelsch board), and it works fine.
> > > >> > I've also tested on ARM64 (Salvator-X board), but I currently have an
> issue
> > > >> > with inbound PCI accesses. I am reasonably sure that this problem is
> > > hardware
> > > >> > related.
> > > >> >
> > > >> > Phil Edworthy (4):
> > > >> >   PCI: rcar-pcie: Make PCI aware of the IO resources
> > > >> >   PCI: rcar-pcie: Remove dependency on ARM-specific struct hw_pci
> > > >> >   PCI: rcar-pcie: Set root bus nr to that provided in DT
> > > >> >   PCI: rcar-pcie: Fix IO offset for multiple instances
> > > >>
> > > >> I applied these with Simon's ack to pci/host-rcar for v4.4.
> > > >>
> > > >> Note that these are on top of Geert's patch to make rcar build only
> > > >> for ARM, which is probably not necessary after you remove the struct
> > > >> hw_pci dependency.  I can drop Geert's patch if you want.
> > > >
> > > > I'm happy with that if Geert is.
> > >
> > > Iff the driver compiles/works on arm64 now, my patch should/must be
> > > dropped/reverted.
> > Yes, the driver works on the ARM64 Salvator-X board.
> 
> I dropped Geert's patch and redid the merges to my "next" branch, so
> rcar should build for both ARM and ARM64.
Thanks for sorting that out.
Phil
