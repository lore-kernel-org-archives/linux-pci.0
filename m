Return-Path: <SRS0=GjRy=ED=pengutronix.de=l.stach@kernel.org>
Return-Path: <SRS0=GjRy=ED=pengutronix.de=l.stach@kernel.org>
Message-ID: <1515409414.12538.12.camel@pengutronix.de>
Subject: Re: Why do we check for "link-up" in *_pcie_valid_device()?
From: Lucas Stach <l.stach@pengutronix.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bharat Kumar Gogada
	 <bharatku@xilinx.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 "joao.pinto@synopsys.com" <joao.pinto@synopsys.com>, Ley Foon Tan
 <lftan@altera.com>, Shawn Lin <shawn.lin@rock-chips.com>, Michal Simek
 <michal.simek@xilinx.com>, Jim Quinlan <jim2101024@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "rfi@lists.rocketboards.org" <rfi@lists.rocketboards.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>
Date: Mon, 08 Jan 2018 12:03:34 +0100
In-Reply-To: <20180105154303.GB24933@red-moon>
References: <20171214225821.GN30595@bhelgaas-glaptop.roam.corp.google.com>
	 <BLUPR0201MB1505F95E1BE417834E847EE6A5020@BLUPR0201MB1505.namprd02.prod.outlook.com>
	 <20171222172815.GA55396@bhelgaas-glaptop.roam.corp.google.com>
	 <BLUPR0201MB1505659A7B1DDA658EFB7049A51C0@BLUPR0201MB1505.namprd02.prod.outlook.com>
	 <20180105154303.GB24933@red-moon>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Am Freitag, den 05.01.2018, 15:43 +0000 schrieb Lorenzo Pieralisi:
> On Fri, Jan 05, 2018 at 02:26:34PM +0000, Bharat Kumar Gogada wrote:
> > On Fri, Dec 22, 2017 at 01:02:28PM +0000, Bharat Kumar Gogada
> > wrote:
> > > Bjorn wrote:
> > > > In the PCI config access path, the *_pcie_valid_device()
> > > > functions in 
> > > > the dwc, altera, rockchip, and xilinx drivers all check whether
> > > > the 
> > > > link is up.
> > > > 
> > > > I think this is racy because the link may go down after we
> > > > check but 
> > > > before we perform the config access.
> > > > 
> > > > What would blow up if we removed the *_pcie_link_up() checks?
> > > > 
> > > > I'd like to either remove the checks or add comments about why
> > > > the 
> > > > race is acceptable.  If we've covered this before, I apologize.
> > > > Adding a comment will keep me from pestering you about this
> > > > again in 
> > > > the future.
> > > In both Xilinx driver cases when link is down, hardware responds
> > > by 
> > > AXI DECERR/SLVERR status which causes an exception, synchronous 
> > > external abort to CPU.  This causes system to hang, so we need
> > > this 
> > > check for both of our drivers.  We will add comments.
> > 
> > This is a problem, and checking whether the link is up is a
> > workaround but not a real solution.  That means your system may
> > hang if the link happens to go down at the wrong time.
> > 
> > A real solution would be to handle the synchronous external abort
> > so it doesn't cause a system hang.
> > 
> > Yes, I agree that this is workaround. For pcie-xilinx.c for arm32,
> > we can have fault handling similar to "imx6q_pcie_abort_handler" in
> > drivers/pci/dwc/pci-imx6.c.
> > Since this driver is same for Microblaze architecture also, it
> > requires separate handling.
> > 
> > For pcie-xilinx-nwl.c ARM64 as per link [1], linux kernel will hang
> > for the above AXI responses. 
> > As of now arm64 RAS is still work in progress [2].  
> > 
> > [1] https://www.spinics.net/lists/arm-kernel/msg624203.html
> > 
> > [2] https://patchwork.kernel.org/patch/9973967/
> > 
> > The check can be removed, if above issues were addressed.
> 
> I do not see why the above "issues" should be addressed in order to
> remove that check - as it was pointed out in this thread it just does
> not solve anything, so what's the reason for keeping it ?

I solves the issue that you hang the system on PCIe enumeration in 100%
of the cases when the link is down and you don't have the abort handler
in place.

It doesn't solve the race issue, but that is a lot less likely to be
hit in the real world. I guess it's not a good idea to remove something
that covers 98% of the problem just because it doesn't cover the
remaining 2%, right?

Regards,
Lucas
