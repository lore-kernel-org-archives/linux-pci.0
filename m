Return-Path: <SRS0=4ynr=YS=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=4ynr=YS=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Peter Wu <peter@lekensteyn.nl>, Lukas Wunner <lukas@wunner.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kilian Singer <kilian.singer@quantumtechnology.info>, linux-pci <linux-pci@vger.kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Date: Wed, 04 Jan 2017 02:09:45 +0100
Message-ID: <12091208.zU0uMkOWQ0@aspire.rjw.lan>
In-Reply-To: <20170104000557.GA13950@bhelgaas-glaptop.roam.corp.google.com>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com> <16155135.jUckSz7QPL@aspire.rjw.lan> <20170104000557.GA13950@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, January 03, 2017 06:05:57 PM Bjorn Helgaas wrote:
> On Wed, Jan 04, 2017 at 12:13:18AM +0100, Rafael J. Wysocki wrote:
> > On Tuesday, January 03, 2017 04:25:09 PM Bjorn Helgaas wrote:
> > > On Tue, Jan 03, 2017 at 10:38:24PM +0100, Rafael J. Wysocki wrote:
> > > > On Tuesday, January 03, 2017 12:12:21 PM Bjorn Helgaas wrote:
> > > > > On Tue, Jan 03, 2017 at 05:31:30PM +0100, Peter Wu wrote:
> > > > > > On Tue, Jan 03, 2017 at 05:11:23PM +0100, Lukas Wunner wrote:
> > > > > > > [cc += Dave Airlie:
> > > > > > > 
> > > > > > > Dave, we're about to lose support for newer Optimus laptops which use
> > > > > > > _PR3 to cut power to the discrete GPU because Bjorn Helgaas has queued
> > > > > > > a commit on his for-linus branch to remove runtime PM for PCIe ports.
> > > > > > > This fixes a regression on Kilian Singer's laptop on which locking the
> > > > > > > screen breaks USB and PS/2 input devices:  Mouse movements are still
> > > > > > > visible, but button or key presses no longer have any effect.  The GPU
> > > > > > > is powered down upon locking the screen and the current theory is that
> > > > > > > this causes the issues.]
> > > > > > 
> > > > > > (+cc Alex: this might affect amdgpu/radeon too.]
> > > > > > 
> > > > > > Bjorn, please reconsider the rpm patch. Reverting support would
> > > > > > introduce other regressions (see issues below) and make future
> > > > > > Thunderbolt work harder (according to Lukas). If Kilian's laptop has
> > > > > > issues, what about a "temporary" quirk?
> > > > > 
> > > > > As I mentioned at the beginning, the outcome I'm hoping for is a patch
> > > > > that fixes Kilian's laptop while preserving the runtime PM support.
> > > > > 
> > > > > As I also mentioned at the beginning, preserving the runtime PM
> > > > > support at the expense of breaking Kilian's laptop is not one of the
> > > > > options.
> > > > 
> > > > But the revert doesn't really help.
> > > > 
> > > > It doesn't fix system suspend/resume on that laptop, which also breaks when
> > > > PCIe ports PM is enabled on it.
> > > > 
> > > > If you really want to use a sledgehammer approach here (which I don't recommend,
> > > > but that's your call), you can change the initial value of pci_bridge_d3_disable to
> > > > "true" (and update the pcie_ports_pm= command line to take "on" in case
> > > > someone wants to enable the feature).  That at least will take care of the
> > > > regression entirely and not just partly.
> > > 
> > > What the heck is the problem here?  I'm not trying to be difficult,
> > > but I didn't write this code and I'm not really interested in figuring
> > > out how to fix it, so my only real option is to solicit fixes and, if
> > > none appear, revert changes that break things.
> > > 
> > > As I've said more than once, I hope and expect that there is a better
> > > solution than reverting the patch.  But *I* am not going to write it.
> > > As soon as somebody proposes a better patch, I'll use it instead of
> > > the revert.
> > > 
> > > If you want to fix the regression by changing the
> > > pci_bridge_d3_disable value, all you have to do is post a patch doing
> > > that.
> > 
> > OK, please find appended.
> > 
> > > I really don't understand why people are so wrapped around the axle
> > > about this.  This is just the way Linux works -- we try really hard
> > > not to cause regressions on platforms that used to work.
> > 
> > I haven't seen anyone in this thread questioning that.
> > 
> > IMO the point people are trying to make is that reverting stuff may not really be
> > the way to go.
> > 
> > > I *SAID* in the very first posting of the revert that I assume Mika will have a
> > > better solution soon.
> > 
> > In which case I wouldn't have queued up a revert had I been you.
> > 
> > > When a better patch appears, I'll take that and drop the revert.
> > > What's the problem with that?
> > 
> > There are people for whom the commit in question fixed serious issues and the
> > revert would just take that away from them without any option to make their
> > systems work.
> 
> I don't *want* to apply the revert.  It's on my for-linus branch as a
> worst-case scenario change if we can't figure out a better fix.
> 
> The patch below is preferable, but I'd rather not take even it,
> because it takes away functionality and forces people to use a boot
> parameter to restore it.  I expect that somebody will figure out how
> to fix the regression Kilian found and also keep the new functionality
> (without requiring boot parameters) before v4.10.
> 
> Of course, if a better fix is far off and the patch below is much
> better in the interim (avoids memory corruption, fixes problems for
> more people, etc.), I will replace the revert with it.  I just
> haven't seen the argument for doing that.

That is very simple.

If you revert, runtime PM will not work for any PCIe ports no matter what and
there is no way to enable it whatever.  Therefore, if there's anyone who
depends on it whatever the reason, they have no way to enable it other than
patching the kernel and rebuilding it.  There are users who may not be able
to do that.

With this patch, in turn, they at least have a kernel command line option to
enable the feature if they need it.  To me, this would be a good enough reason
to apply this patch instead of the revert.

> My main point is that Kilian found a pretty serious regression and
> spent a lot of time bisecting it and testing things, and we need to
> address it in some way before v4.10.

Let me repeat then that nobody here is questioning the need to address the
issue.

That said to me, reverting would be almost as bad as leaving it unfixed.

Thanks,
Rafael
