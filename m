Return-Path: <SRS0=JmCW=YV=lekensteyn.nl=peter@kernel.org>
Return-Path: <SRS0=JmCW=YV=lekensteyn.nl=peter@kernel.org>
Date: Sat, 7 Jan 2017 13:36:35 +0100
From: Peter Wu <peter@lekensteyn.nl>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Kilian Singer <kilian.singer@quantumtechnology.info>,
	linux-pci <linux-pci@vger.kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Dave Airlie <airlied@redhat.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20170107123635.GA13241@al>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
 <3913750.OA6IItgEjC@aspire.rjw.lan>
 <20170103222509.GA4499@bhelgaas-glaptop.roam.corp.google.com>
 <16155135.jUckSz7QPL@aspire.rjw.lan>
 <20170104000557.GA13950@bhelgaas-glaptop.roam.corp.google.com>
 <20170104081639.GA21076@wunner.de>
 <20170104210954.GA11946@al>
 <20170105144220.GA21446@wunner.de>
 <20170107113510.GA10680@al>
 <20170107121959.GB22429@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170107121959.GB22429@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jan 07, 2017 at 01:19:59PM +0100, Lukas Wunner wrote:
> On Sat, Jan 07, 2017 at 12:35:10PM +0100, Peter Wu wrote:
> > On Thu, Jan 05, 2017 at 03:42:20PM +0100, Lukas Wunner wrote:
> > > On Wed, Jan 04, 2017 at 10:09:54PM +0100, Peter Wu wrote:
> > > > [ Help/ideas are welcome, I suspect that these failures to restore power
> > > > on laptops designed for Win8+ all have the same cause, related to some
> > > > unknown interaction between ACPI and PCI. Some links:
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=190861
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=156341 ]
> > > 
> > > Looking at Kilian's acpidump again I notice that the methods to power
> > > the GPU on or off (GPON / GPOF) are called from two places:
> > > 
> > > - From the _PS0 and _PS3 methods of the GPU and
> > > - from the _PR3 power resource of the root port above the GPU.
> > > 
> > > In the former case they're called for pre Windows 2013 or if VDAD is true.
> > > In the latter case they're called unconditionally but GPOF becomes a no-op
> > > in the pre Windows 2013 case.
> > > 
> > > This means that GPOF would be executed *twice* on Windows 2013+ if VDAD
> > > is true.  I could imagine this to cause issues.
> > 
> > There is a flag "DGOS" which is set when PGON/PGOF are called, so
> > multiple invocations should not matter for the powerdown/up sequence.
> > There are some SMI calls though that might have side-effects though.
> 
> The PGON method becomes a no-op if DGOS is true.  But the PGOF method
> doesn't check DGOS.

You are right, GPON does not check that. Hopefully "VDAD" is 0 then when
_PS3 is called, otherwise it might invoke PGOF multiple times (though
NVP3._OFF and through _PS3).
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl
