Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 20 Oct 2015 07:49:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 0/4] PCI: rcar: Add support for ARM64 and multiple
 instances
Message-ID: <20151020124933.GA8224@localhost>
References: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
 <20151019231634.GA13841@localhost>
 <20151020013650.GA13721@verge.net.au>
 <CAMuHMdWiH4ZUSmKQ01qQYvXcjb_3K4XBFLjVGSe1dUoKi=Jb_Q@mail.gmail.com>
 <SIXPR06MB04158545EDCA19F6C66A6783F5390@SIXPR06MB0415.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <SIXPR06MB04158545EDCA19F6C66A6783F5390@SIXPR06MB0415.apcprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 20, 2015 at 08:00:10AM +0000, Phil Edworthy wrote:
> Hi Geert,
> 
> On 20 October 2015 08:37, Geert wrote:
> > On Tue, Oct 20, 2015 at 3:36 AM, Simon Horman <horms@verge.net.au> wrote:
> > > On Mon, Oct 19, 2015 at 06:16:34PM -0500, Bjorn Helgaas wrote:
> > >> [+cc Geert]
> > >>
> > >> On Fri, Oct 02, 2015 at 11:25:03AM +0100, Phil Edworthy wrote:
> > >> > Fixes and changes to get PCIe working on ARM64 with mulitple instances.
> > >> >
> > >> > I've tested these on ARM (Koelsch board), and it works fine.
> > >> > I've also tested on ARM64 (Salvator-X board), but I currently have an issue
> > >> > with inbound PCI accesses. I am reasonably sure that this problem is
> > hardware
> > >> > related.
> > >> >
> > >> > Phil Edworthy (4):
> > >> >   PCI: rcar-pcie: Make PCI aware of the IO resources
> > >> >   PCI: rcar-pcie: Remove dependency on ARM-specific struct hw_pci
> > >> >   PCI: rcar-pcie: Set root bus nr to that provided in DT
> > >> >   PCI: rcar-pcie: Fix IO offset for multiple instances
> > >>
> > >> I applied these with Simon's ack to pci/host-rcar for v4.4.
> > >>
> > >> Note that these are on top of Geert's patch to make rcar build only
> > >> for ARM, which is probably not necessary after you remove the struct
> > >> hw_pci dependency.  I can drop Geert's patch if you want.
> > >
> > > I'm happy with that if Geert is.
> > 
> > Iff the driver compiles/works on arm64 now, my patch should/must be
> > dropped/reverted.
> Yes, the driver works on the ARM64 Salvator-X board. 

I dropped Geert's patch and redid the merges to my "next" branch, so
rcar should build for both ARM and ARM64.

Bjorn
