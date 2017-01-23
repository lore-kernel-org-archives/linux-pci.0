Return-Path: <SRS0=vUM2=ZF=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=vUM2=ZF=linux.intel.com=mika.westerberg@kernel.org>
Date: Mon, 23 Jan 2017 23:12:47 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kilian.singer@quantumtechnology.info, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20170123211247.GB17297@lahna.fi.intel.com>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com>
 <20170117145628.GD22776@bhelgaas-glaptop.roam.corp.google.com>
 <20170123203335.GA4707@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170123203335.GA4707@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 23, 2017 at 02:33:35PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 17, 2017 at 08:56:28AM -0600, Bjorn Helgaas wrote:
> > On Tue, Dec 27, 2016 at 05:57:37PM -0600, Bjorn Helgaas wrote:
> > > Hi Killian,
> > > 
> > > Thanks for the report (https://bugzilla.kernel.org/show_bug.cgi?id=190861)
> > > and all the debugging you've done.  Below is a revert of the troublesome
> > > commit.  Can you test it and verify that it also fixes the problem?
> > > 
> > > I assume Mika is looking at this and will have a better solution soon.
> > > But if not, I'll queue this up for v4.10.
> > 
> > Can somebody please summarize the current state of this issue?  I
> > assume somebody has already posted a better patch that should replace
> > this naive revert, but I haven't been following the whole thread.
> 
> This is somewhat frustrating.  Is there a better patch than the revert
> mentioned below?  There was a lot of hullabaloo when I first posted
> it, but I haven't seen a good alternative yet.  I intended the revert
> as a worst-case scenario fix, with the expectation that somebody would
> fix the problem or at least avoid it without having to do the revert.
> Maybe somebody posted that better fix and I just missed it?

I understood that there is a patch here:

https://patchwork.freedesktop.org/patch/132478/

that is supposed to fix the issue. I'm waiting Kilian to test it.

> >From my perspective (and I have not followed the whole 100 message
> thread), the bare bones of the situation are that 006d44e49a25 ("PCI:
> Add runtime PM support for PCIe ports") probably reduced power
> consumption on some machines.  But it also made Kilian's system
> unresponsive when locking the screen.
> 
> Given only those assumptions, a revert seems like a reasonable
> approach.  I understand and agree that we want to save power, but
> not at the expense of making systems unresponsive.

But even if you revert the runtime PM commit, the same thing happens
when the system is suspended.

> Maybe 006d44e49a25 actually fixed a functional problem in addition to
> saving power?  I don't think the changelog mentions anything like
> that, but if that's the case, we should certainly consider that.
> 
> We're at -rc5 already, so if we want something other than a revert,
> now is the time to propose it.

Hmm, runtime PM patches went in for 4.9 IIRC. It is not a regression
introduced in v4.10 release cycle so I'm not sure why we are in such
hurry here?

I understand that the issue should be fixed but not why it should be
fixed for v4.10 as it is not a regression introduced by v4.10-rc1.
