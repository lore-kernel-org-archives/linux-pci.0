Return-Path: <SRS0=9jKw=D5=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=9jKw=D5=arm.com=lorenzo.pieralisi@kernel.org>
Date: Tue, 2 Jan 2018 11:37:50 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bharat Kumar Gogada <bharatku@xilinx.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	"joao.pinto@synopsys.com" <joao.pinto@synopsys.com>,
	Ley Foon Tan <lftan@altera.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"rfi@lists.rocketboards.org" <rfi@lists.rocketboards.org>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>
Subject: Re: Why do we check for "link-up" in *_pcie_valid_device()?
Message-ID: <20180102113750.GC10536@red-moon>
References: <20171214225821.GN30595@bhelgaas-glaptop.roam.corp.google.com>
 <BLUPR0201MB1505F95E1BE417834E847EE6A5020@BLUPR0201MB1505.namprd02.prod.outlook.com>
 <20171222172815.GA55396@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171222172815.GA55396@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 22, 2017 at 11:28:15AM -0600, Bjorn Helgaas wrote:
> On Fri, Dec 22, 2017 at 01:02:28PM +0000, Bharat Kumar Gogada wrote:
> > Bjorn wrote:
> >> In the PCI config access path, the *_pcie_valid_device() functions
> >> in the dwc, altera, rockchip, and xilinx drivers all check whether
> >> the link is up.
> >> 
> >> I think this is racy because the link may go down after we check but
> >> before we perform the config access.
> >> 
> >> What would blow up if we removed the *_pcie_link_up() checks?
> >> 
> >> I'd like to either remove the checks or add comments about why the
> >> race is acceptable.  If we've covered this before, I apologize.
> >> Adding a comment will keep me from pestering you about this again in
> >> the future.
> 
> > In both Xilinx driver cases when link is down, hardware responds by
> > AXI DECERR/SLVERR status which causes an exception, synchronous
> > external abort to CPU.  This causes system to hang, so we need this
> > check for both of our drivers.  We will add comments. 
> 
> This is a problem, and checking whether the link is up is a workaround
> but not a real solution.  That means your system may hang if the link
> happens to go down at the wrong time.
> 
> A real solution would be to handle the synchronous external abort
> so it doesn't cause a system hang.

I still have no idea why checking (in a broken way) that the link
is up for _every_ given config access is a solution.

If, say, the link is down in xilinx_pcie_init_port(), what would bring
it up or, worded differently, why checking that the link is up for every
config access instead of host bridge probe time make this code any safer
?

It is not safe anyway, it would be good to understand though why the code
was written this way so that we can change it appropriately.

Thanks,
Lorenzo
