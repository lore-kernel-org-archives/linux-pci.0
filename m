Return-Path: <SRS0=OT3g=73=chromium.org=briannorris@kernel.org>
Return-Path: <SRS0=OT3g=73=chromium.org=briannorris@kernel.org>
Date: Thu, 24 Aug 2017 18:44:05 -0700
From: Brian Norris <briannorris@chromium.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
	Jeffy Chen <jeffy.chen@rock-chips.com>, Tejun Heo <tj@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 04/10] PCI: rockchip: fix system hang up if activating
 CONFIG_DEBUG_SHIRQ
Message-ID: <20170825014403.GA100450@google.com>
References: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
 <1503471758-73904-1-git-send-email-shawn.lin@rock-chips.com>
 <20170824202111.GS31858@bhelgaas-glaptop.roam.corp.google.com>
 <CAKdAkRRFxsAfJrzr=rjo_mtMzP0y9-cRz9Vz+M92AhbYd5B=ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKdAkRRFxsAfJrzr=rjo_mtMzP0y9-cRz9Vz+M92AhbYd5B=ww@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 24, 2017 at 02:10:52PM -0700, Dmitry Torokhov wrote:
> On Thu, Aug 24, 2017 at 1:21 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > [+cc Tejun, Dmitry, Michael, Stephen, linux-clk for devm/clk questions]
> >
> > On Wed, Aug 23, 2017 at 03:02:38PM +0800, Shawn Lin wrote:
> >> With CONFIG_DEBUG_SHIRQ enabled, the irq tear down routine
> >> would still access the irq handler registed as a shard irq.
> >> Per the comment within the function of __free_irq, it says
> >> "It's a shared IRQ -- the driver ought to be prepared for
> >> an IRQ event to happen even now it's being freed". However
> >> when failing to probe the driver, it may disable the clock
> >> for accessing the register and the following check for shared
> >> irq state would call the irq handler which accesses the register
> >> w/o the clk enabled. That will hang the system forever.

Side note: why is this driver even requesting a shared IRQ? This is for
rk3399, and the IRQ is a dedicated GIC interrupt for the PCIe
controller. It shouldn't need to be 'shared'.

The problem still might not be *only* theoretical though, since it's
still possible for this non-shared interrupt to
(a) trigger
(b) concurrently, we remove/tear down (including disable clocks)
(c) we service the IRQ      <-- dead, because clock is disabled
(d) if we ever got here... free_irq()

Brian
