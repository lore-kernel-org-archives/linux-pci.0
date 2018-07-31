Return-Path: <SRS0=BdnE=KP=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=BdnE=KP=arm.com=lorenzo.pieralisi@kernel.org>
Date: Tue, 31 Jul 2018 18:27:42 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/3] PCI: mobiveil: Misc fixes
Message-ID: <20180731172742.GA11381@red-moon>
References: <20180730134316.11719-1-lorenzo.pieralisi@arm.com>
 <20180731165600.GL45322@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180731165600.GL45322@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 31, 2018 at 11:56:00AM -0500, Bjorn Helgaas wrote:
> On Mon, Jul 30, 2018 at 02:43:13PM +0100, Lorenzo Pieralisi wrote:
> > Subrahmanya,
> > 
> > I put together this series so that the Mobiveil controller driver
> > can compile (successfully). Please review and ack as soon as possible
> > since the current situation is a bit embarassing to be honest, we
> > should be sending these patches as fixes this week so that they
> > can make it for v4.18, currently the driver is in the kernel for
> > nothing.
> 
> There doesn't seem to be much interest in the Mobiveil driver (the
> last patch I see was on May 10), and as you say, it's not even in the
> Makefile, so it has gotten zero testing or even building.
> 
> Should we just drop the driver and see if anybody wants to try again
> next cycle?  I'm a little hesitant about flipping the switch to enable
> a brand-new driver this late in the cycle.

I totally share your concern - I do not know what's the best way
to drop it but I think that reverting it is sensible given what
this series has to do to enable it in the first place.

Thanks,
Lorenzo
