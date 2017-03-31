Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 31 Mar 2017 00:17:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Ray Jui <rjui@broadcom.com>
Subject: Re: [PATCH v2 3/5] PCI: rockchip: add remove() support
Message-ID: <20170331051702.GA13240@bhelgaas-glaptop.roam.corp.google.com>
References: <20170310024617.67303-1-briannorris@chromium.org>
 <20170310024617.67303-3-briannorris@chromium.org>
 <20170324142541.GA25380@bhelgaas-glaptop.roam.corp.google.com>
 <20170324172218.GA119093@google.com>
 <20170330232825.GB3912@bhelgaas-glaptop.roam.corp.google.com>
 <20170331002608.GA72818@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170331002608.GA72818@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 30, 2017 at 05:26:09PM -0700, Brian Norris wrote:
> Hi Bjorn,
> 
> On Thu, Mar 30, 2017 at 06:28:25PM -0500, Bjorn Helgaas wrote:
> > On Fri, Mar 24, 2017 at 10:22:19AM -0700, Brian Norris wrote:
> > > On Fri, Mar 24, 2017 at 09:25:41AM -0500, Bjorn Helgaas wrote:
> > > > These don't have .remove:
> > > > 
> > > >   imx6_pcie_driver
> > > >   ls_pcie_driver
> > > >   armada8k_pcie_driver
> > > >   artpec6_pcie_driver
> > > >   dw_plat_pcie_driver
> > > >   hisi_pcie_driver
> > > >   hisi_pcie_almost_ecam_driver
> > > >   spear13xx_pcie_driver
> > > >   gen_pci_driver
> > > 
> > > I think these are all technically broken.
> > 
> > Can we fix them all at the same time as you fix Rockchip?  Maybe we
> > should have a series that adds ".suppress_bind_attrs = true" to all
> > these drivers,
> 
> Sure, I can do that.
> 
> > including Rockchip.
> 
> Huh? Why? So I can revert that in the next patch?
> 
> > Then you could have this current 
> > series to make Rockchip modular on top, if there's still value in it.
> 
> I do see value in it. That's the whole reason I wrote this patchset.
> It's useful for stressing out certain behaviors that will happen all the
> time (i.e., boot-time initialization, from platform probe, to bus init,
> to client/EP init), via repeated bind/unbind (or modprobe/rmmod). It's
> much faster than reboot testing.

I didn't phrase that very well.  There's certainly value in stressing
the bind/unbind paths, but I thought the primary reason you wrote this
was to fix the fact that you could crash the system like this:

  # echo f8000000.pcie > /sys/bus/platform/drivers/rockchip-pcie/unbind
  # lspci

>From my point of view, that's the issue that *has* to be fixed.
Better test coverage is icing.

It sounds like several drivers have that same issue, and the simplest
possible fix is to set .suppress_bind_attrs, so I suggested doing that 
so it's easy to analyze the tree as a whole and say "these drivers
all have the same problem, and all the fixes look the same."

I guess if you'd rather skip that for Rockchip and apply a more
complicated fix there, I could go along with that.  But I don't think
it would hurt anything to set .suppress_bind_attrs, then remove it
when you add module support.  The concepts of .suppress_bind_attrs and
modularity are related, and doing this in a separate patch would make
it a nice example to follow if somebody wants to make other drivers
modular as well.

> Personally, I'd rather just patch the other drivers, and you can wait
> until I follow through on that promise before applying my existing work
> for the Rockchip driver, if that's what you'd prefer.

It's not so much a question of using the Rockchip change as a stick.
I'm just thinking that it makes a more logical progression to fix the
more important issue globally first.

> > If we find a common problem, I'd like to fix it everywhere we know
> > about so it doesn't get forgotten or copied to even more places.
> 
> Sure. But you only just pointed out how broken several drivers were; I
> didn't really notice :)

Yeah, you're right, I had in my head the idea that if we've identified
the same problem in several drivers, we should fix them all, but I
neglected to turn that into words.

Bjorn
