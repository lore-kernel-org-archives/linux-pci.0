Return-Path: <SRS0=cakr=3I=chromium.org=briannorris@kernel.org>
Return-Path: <SRS0=cakr=3I=chromium.org=briannorris@kernel.org>
Date: Fri, 31 Mar 2017 09:40:16 -0700
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	Wenrui Li <wenrui.li@rock-chips.com>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org, Ray Jui <rjui@broadcom.com>
Subject: Re: [PATCH v2 3/5] PCI: rockchip: add remove() support
Message-ID: <20170331164015.GB146301@google.com>
References: <20170310024617.67303-1-briannorris@chromium.org>
 <20170310024617.67303-3-briannorris@chromium.org>
 <20170324142541.GA25380@bhelgaas-glaptop.roam.corp.google.com>
 <20170324172218.GA119093@google.com>
 <20170330232825.GB3912@bhelgaas-glaptop.roam.corp.google.com>
 <20170331002608.GA72818@google.com>
 <20170331051702.GA13240@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170331051702.GA13240@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Fri, Mar 31, 2017 at 12:17:02AM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 30, 2017 at 05:26:09PM -0700, Brian Norris wrote:
> > On Thu, Mar 30, 2017 at 06:28:25PM -0500, Bjorn Helgaas wrote:
> > > Can we fix them all at the same time as you fix Rockchip?  Maybe we
> > > should have a series that adds ".suppress_bind_attrs = true" to all
> > > these drivers,
> > 
> > Sure, I can do that.
> > 
> > > including Rockchip.
> > 
> > Huh? Why? So I can revert that in the next patch?
> > 
> > > Then you could have this current 
> > > series to make Rockchip modular on top, if there's still value in it.
> > 
> > I do see value in it. That's the whole reason I wrote this patchset.
> > It's useful for stressing out certain behaviors that will happen all the
> > time (i.e., boot-time initialization, from platform probe, to bus init,
> > to client/EP init), via repeated bind/unbind (or modprobe/rmmod). It's
> > much faster than reboot testing.
> 
> I didn't phrase that very well.  There's certainly value in stressing
> the bind/unbind paths, but I thought the primary reason you wrote this
> was to fix the fact that you could crash the system like this:
> 
>   # echo f8000000.pcie > /sys/bus/platform/drivers/rockchip-pcie/unbind
>   # lspci

Well, they're kinda two sides of the same coin; I was wanting to test
the bind path, and when I tried this, I noticed that I could trivially
crash the system. The crash seemed like a more important thing to
document (because otherwise, it just looks like I'm adding a feature).

> From my point of view, that's the issue that *has* to be fixed.
> Better test coverage is icing.

I didn't really view messing with /sys/.../unbind as a big issue,
outside of development and testing (there's a lot of damage a malicious
actor can do with unconstrained access to /sys/), so I guess I didn't
put that aspect as super-high priority. If you'd like to prioritize
that, then I'm OK with that.

> It sounds like several drivers have that same issue, and the simplest
> possible fix is to set .suppress_bind_attrs, so I suggested doing that 
> so it's easy to analyze the tree as a whole and say "these drivers
> all have the same problem, and all the fixes look the same."

Sure, that is the simplest approach.

> I guess if you'd rather skip that for Rockchip and apply a more
> complicated fix there, I could go along with that.  But I don't think
> it would hurt anything to set .suppress_bind_attrs, then remove it
> when you add module support.  The concepts of .suppress_bind_attrs and
> modularity are related, and doing this in a separate patch would make
> it a nice example to follow if somebody wants to make other drivers
> modular as well.

I'll leave that up to you, and I can resubmit things if desired. As you
have since noticed, I already sent a patch to add .suppress_bind_attrs
to all the other drivers. If you'd like, feel free to add
pcie-rockchip.c into that mix, it's not hard -- or I can redo it myself.
Then I can modify and resend (or you can do the trivial modification
required to) the current patch set.

Just let me know.

> > Personally, I'd rather just patch the other drivers, and you can wait
> > until I follow through on that promise before applying my existing work
> > for the Rockchip driver, if that's what you'd prefer.
> 
> It's not so much a question of using the Rockchip change as a stick.
> I'm just thinking that it makes a more logical progression to fix the
> more important issue globally first.

Sure, I can grok that. Just let me know if you want any more action from
me.

Brian
