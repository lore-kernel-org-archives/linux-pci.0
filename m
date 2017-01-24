Return-Path: <SRS0=IQUN=ZG=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=IQUN=ZG=wunner.de=lukas@kernel.org>
Date: Tue, 24 Jan 2017 05:53:20 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	kilian.singer@quantumtechnology.info, linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20170124045320.GA27136@wunner.de>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com>
 <20170117145628.GD22776@bhelgaas-glaptop.roam.corp.google.com>
 <20170123203335.GA4707@bhelgaas-glaptop.roam.corp.google.com>
 <20170123211247.GB17297@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170123211247.GB17297@lahna.fi.intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 23, 2017 at 11:12:47PM +0200, Mika Westerberg wrote:
> On Mon, Jan 23, 2017 at 02:33:35PM -0600, Bjorn Helgaas wrote:
> > On Tue, Jan 17, 2017 at 08:56:28AM -0600, Bjorn Helgaas wrote:
> > > On Tue, Dec 27, 2016 at 05:57:37PM -0600, Bjorn Helgaas wrote:
> > > > Hi Killian,
> > > > 
> > > > Thanks for the report (https://bugzilla.kernel.org/show_bug.cgi?id=190861)
> > > > and all the debugging you've done.  Below is a revert of the troublesome
> > > > commit.  Can you test it and verify that it also fixes the problem?
> > > > 
> > > > I assume Mika is looking at this and will have a better solution soon.
> > > > But if not, I'll queue this up for v4.10.
> > > 
> > > Can somebody please summarize the current state of this issue?  I
> > > assume somebody has already posted a better patch that should replace
> > > this naive revert, but I haven't been following the whole thread.
> > 
> > This is somewhat frustrating.  Is there a better patch than the revert
> > mentioned below?  There was a lot of hullabaloo when I first posted
> > it, but I haven't seen a good alternative yet.  I intended the revert
> > as a worst-case scenario fix, with the expectation that somebody would
> > fix the problem or at least avoid it without having to do the revert.
> > Maybe somebody posted that better fix and I just missed it?
> 
> I understood that there is a patch here:
> 
> https://patchwork.freedesktop.org/patch/132478/
> 
> that is supposed to fix the issue. I'm waiting Kilian to test it.

That patch landed in Linus' tree tonight (commit 3846fd9b8600,
merge commit 3258943ddb90).

@Kilian: Could you retest with the tip of Linus' master branch?

Thanks,

Lukas
