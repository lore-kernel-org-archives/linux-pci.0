Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 1 Aug 2017 16:29:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul Burton <paul.burton@imgtec.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
        James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH] PCI: xilinx: Remove platform/architecture restrictions
Message-ID: <20170801212931.GA26498@bhelgaas-glaptop.roam.corp.google.com>
References: <1500856777-23383-1-git-send-email-linux@roeck-us.net>
 <16692965.isATtC65hJ@np-p-burton>
 <20170731233608.GA27307@bhelgaas-glaptop.roam.corp.google.com>
 <83428319.6ITjLHsrBP@np-p-burton>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <83428319.6ITjLHsrBP@np-p-burton>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 31, 2017 at 04:49:59PM -0700, Paul Burton wrote:
> On Monday, 31 July 2017 16:36:08 PDT Bjorn Helgaas wrote:
> > On Mon, Jul 31, 2017 at 04:19:13PM -0700, Paul Burton wrote:
> > > Hi Bjorn,
> > > 
> > > On Monday, 31 July 2017 15:58:22 PDT Bjorn Helgaas wrote:
> > > > On Mon, Jul 24, 2017 at 11:49:22AM +0100, Paul Burton wrote:
> > > > > Hi Guenter & all,
> > > > > 
> > > > > On Monday, 24 July 2017 01:39:37 BST Guenter Roeck wrote:
> > > > > > The MIPS Boston board configuration tries to enable
> > > > > > CONFIG_PCIE_XILINX.
> > > > > > That doesn't work since PCIE_XILINX depends on ARCH_ZYNQ ||
> > > > > > MICROBLAZE.
> > > > > > Remove that restriction.
> > > > > 
> > > > > I'd prefer that this patch does not go in standalone. The intent for
> > > > > the
> > > > > MIPS Boston board is that this driver is enabled for MIPS by this
> > > > > patch:
> > > > > 
> > > > > https://patchwork.kernel.org/patch/9794361/
> > > > > 
> > > > > But not until after earlier patches in that series fix issues with the
> > > > > driver:
> > > > > 
> > > > > https://patchwork.kernel.org/patch/9794355/
> > > > > https://patchwork.kernel.org/patch/9794357/
> > > > > https://patchwork.kernel.org/patch/9794359/
> > > > > 
> > > > > That has been held up by disagreement about whether the driver should
> > > > > be
> > > > > using 0-3 or 1-4 for hardware IRQ numbers, sadly, despite the driver
> > > > > already being in tree & clearly broken, and my series not changing
> > > > > which
> > > > > the driver uses...
> > > > 
> > > > It's true that your v5 series only changes xilinx from using hwirq 0-3
> > > > to 0-4 (with 0 being unused in both cases, and the addition of 4
> > > > fixing the "INTD doesn't work" bug).
> > > 
> > > That isn't true - the xilinx-pcie driver already uses 1-4, and my change
> > > simply prevents it from hitting a WARN() in the IRQ code when doing so.
> > 
> > My apologies.  I was relying on the changelog, which says the current
> > code "creates an IRQ domain of size 4 (ie.  IRQ numbers 0 through 3)"
> > and the patch:
> > 
> >   -       port->leg_domain = irq_domain_add_linear(pcie_intc_node, 4,
> >   +       port->leg_domain = irq_domain_add_linear(pcie_intc_node, 1 + 4,
> > 
> > I'm not enough of an IRQ expert to understand why what I said was
> > incorrect (other than maybe INTD actually works, but emits a warning?)
> 
> The driver does create an IRQ domain of size 4, as though it is going to use 
> numbering 0-3 with it. However the driver then goes on to use numbers 1-4, 
> which leads to a warning from the IRQ code because the domain isn't big enough 
> to cover the case where hwirq=4 (ie. INTD).
> 
> It still works because irq_domain_associate() ends up inserting a mapping for 
> the IRQ into a radix tree rather than the linear_revmap array, but it's 
> clearly wrong that the driver creates a domain of size 4 & then uses hwirq=4, 
> hence the warnings.

Does it really work?  It looks like irq_domain_associate() returns
-EINVAL after emitting the "error: hwirq 0x%x is too large for %s"
warning, so it doesn't look like it would call radix_tree_insert().

> > > > However, I *would* like to see this issue cleaned up consistently
> > > > across all our drivers.  I mooted a couple ideas in [1], but nobody
> > > > seemed interested.  If I merged your series as-is, there would be even
> > > > less interest.
> > > 
> > > I've been travelling & haven't had time to look at any reworks as of yet,
> > > but I do think the driver as-is is clearly broken & my fix is a pretty
> > > obvious one, even if you would like the driver(s) to improve further in
> > > future.
> > 
> > My problem is that if all the drivers work because they use 5 numbers
> > (0-4), the issue will completely drop off everybody's radar.
> 
> I understand, and it's your call, but I'd argue that the driver as-is isn't 
> just suboptimal but plain broken - and I think that fixing it so that it's 
> "just" suboptimal is a worthwhile improvement that shouldn't be held up. But 
> you're the maintainer, and if you'd like to use this to bribe me or someone 
> else into improving things at some later date then so be it.

This issue has been raised before.  Each time it comes up it takes me
a long time to re-figure out what's going on, and I'm sort of tired of
doing that.  Given that I have no budget or staff, my tools for
getting things fixed are pretty limited, so I'm going to hold out for
a more comprehensive fix here.

Bjorn
