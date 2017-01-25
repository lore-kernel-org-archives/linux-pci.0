Return-Path: <SRS0=DDPm=ZH=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=DDPm=ZH=linux.intel.com=mika.westerberg@kernel.org>
Date: Wed, 25 Jan 2017 11:48:31 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kilian.singer@quantumtechnology.info, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20170125094831.GP17297@lahna.fi.intel.com>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com>
 <20170117145628.GD22776@bhelgaas-glaptop.roam.corp.google.com>
 <20170123203335.GA4707@bhelgaas-glaptop.roam.corp.google.com>
 <20170123211247.GB17297@lahna.fi.intel.com>
 <20170124200103.GA14743@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170124200103.GA14743@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 24, 2017 at 02:01:03PM -0600, Bjorn Helgaas wrote:
> On Mon, Jan 23, 2017 at 11:12:47PM +0200, Mika Westerberg wrote:
> > On Mon, Jan 23, 2017 at 02:33:35PM -0600, Bjorn Helgaas wrote:
> > > From my perspective (and I have not followed the whole 100 message
> > > thread), the bare bones of the situation are that 006d44e49a25 ("PCI:
> > > Add runtime PM support for PCIe ports") probably reduced power
> > > consumption on some machines.  But it also made Kilian's system
> > > unresponsive when locking the screen.
> > > 
> > > Given only those assumptions, a revert seems like a reasonable
> > > approach.  I understand and agree that we want to save power, but
> > > not at the expense of making systems unresponsive.
> > 
> > But even if you revert the runtime PM commit, the same thing happens
> > when the system is suspended.
> 
> In other words, we always had bug A, and after adding 006d44e49a25, we
> have bug A and bug B.  It is worthwhile to avoid B even if A still
> exists.

I meant the same PCI PM series also added support for powering down PCI
bridges when the system is suspended. So the same issue happens when the
system is suspended even if the runtime PM patch is reverted.

> Kilian tripped over B, and no doubt others have as well.  Most others
> will be frustrated and unable to work around it.  We're lucky Kilian
> was patient and sophisticated enough to track it down.

I agree. Thanks Kilian for the patience :)

> > > Maybe 006d44e49a25 actually fixed a functional problem in addition to
> > > saving power?  I don't think the changelog mentions anything like
> > > that, but if that's the case, we should certainly consider that.
> > > 
> > > We're at -rc5 already, so if we want something other than a revert,
> > > now is the time to propose it.
> > 
> > Hmm, runtime PM patches went in for 4.9 IIRC. It is not a regression
> > introduced in v4.10 release cycle so I'm not sure why we are in such
> > hurry here?
> > 
> > I understand that the issue should be fixed but not why it should be
> > fixed for v4.10 as it is not a regression introduced by v4.10-rc1.
> 
> As far as I can tell, the downside of a revert is only that we'll
> consume a little more power.  I'm not sure why we would release v4.10
> with a known issue that we can easily avoid.

I've been told that reverting the nouveau driver back to use ACPI _DSM
method causes other issues.

I would rather try to understand what is actually going on and why this
happens in the first place, even if it takes longer than when v4.10 is
released, if 3846fd9b8600 ("drm/probe-helpers: Drop locking from
poll_enable") does not solve the issue.
