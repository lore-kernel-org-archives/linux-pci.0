Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Ley Foon Tan <lftan@altera.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	=?ISO-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Simon Horman <horms@verge.net.au>, linux-tegra@vger.kernel.org,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Rocketboard Maillist <rfi@lists.rocketboards.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 00/10] drivers/pci: avoid module_init in non-modular host/pci*
Date: Mon, 14 Dec 2015 11:27:02 +0100
Message-ID: <3302340.SIljl1qYTl@wuerfel>
In-Reply-To: <20151214091940.GA15126@ulmo.nvidia.com>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com> <CAFiDJ5-Y8afg5kDRQLK1pain-k1kPQAn3vhWrVkB1ADPRHvx+A@mail.gmail.com> <20151214091940.GA15126@ulmo.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 14 December 2015 10:19:40 Thierry Reding wrote:
> > PCIe host driver that use fixup (DECLARE_PCI_FIXUP_*) can't use tristate.
> > Fixup region is in kernel region and this region if not updated when
> > loading a module.
> 
> Interesting, I hadn't thought about that. I suppose this means that the
> module will end up containing an unused section with the fixup code. It
> might be useful to add a way for that to trigger a warning at build
> time.
> 
> Perhaps to fix this a mechanism could be introduced to add a table of
> fixups to a host controller driver and that will get applied to all
> children of the bridge. It could be problematic to cover all of the
> different fixup stages, though.
> 


I think a lot of the fixups shouldn't really be there in the first place,
they are about stuff that we can fix up in the probe function, or that should
be fixed up in the probe function with some appropriate core support added.

	Arnd
