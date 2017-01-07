Return-Path: <SRS0=JmCW=YV=lekensteyn.nl=peter@kernel.org>
Return-Path: <SRS0=JmCW=YV=lekensteyn.nl=peter@kernel.org>
Date: Sat, 7 Jan 2017 12:35:10 +0100
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
Message-ID: <20170107113510.GA10680@al>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
 <3913750.OA6IItgEjC@aspire.rjw.lan>
 <20170103222509.GA4499@bhelgaas-glaptop.roam.corp.google.com>
 <16155135.jUckSz7QPL@aspire.rjw.lan>
 <20170104000557.GA13950@bhelgaas-glaptop.roam.corp.google.com>
 <20170104081639.GA21076@wunner.de>
 <20170104210954.GA11946@al>
 <20170105144220.GA21446@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170105144220.GA21446@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 05, 2017 at 03:42:20PM +0100, Lukas Wunner wrote:
> On Wed, Jan 04, 2017 at 10:09:54PM +0100, Peter Wu wrote:
> > [ Help/ideas are welcome, I suspect that these failures to restore power
> > on laptops designed for Win8+ all have the same cause, related to some
> > unknown interaction between ACPI and PCI. Some links:
> > https://bugzilla.kernel.org/show_bug.cgi?id=190861
> > https://bugzilla.kernel.org/show_bug.cgi?id=156341 ]
> 
> Looking at Kilian's acpidump again I notice that the methods to power
> the GPU on or off (GPON / GPOF) are called from two places:
> 
> - From the _PS0 and _PS3 methods of the GPU and
> - from the _PR3 power resource of the root port above the GPU.
> 
> In the former case they're called for pre Windows 2013 or if VDAD is true.
> In the latter case they're called unconditionally but GPOF becomes a no-op
> in the pre Windows 2013 case.
> 
> This means that GPOF would be executed *twice* on Windows 2013+ if VDAD
> is true.  I could imagine this to cause issues.

There is a flag "DGOS" which is set when PGON/PGOF are called, so
multiple invocations should not matter for the powerdown/up sequence.
There are some SMI calls though that might have side-effects though.

> VDAD is at 0x7CE7D018 + 0xEE2 + 6. It's not set in the DSDT.
> 
> @Kilian, what do you get if you execute this as root:
> 
> dd iflag=skip_bytes,count_bytes skip=$((0x7CE7D018 + 0xEE2 + 6)) count=1 \
>   if=/dev/mem 2>/dev/null | hexdump
> 
> Another oddity I've noticed is that when calling the Optimus DSM with
> the capabilities function number (0x1A, NOUVEAU_DSM_OPTIMUS_CAPS) and
> a special argument, it's possible to influence the behaviour of GPOF
> (the method to power the GPU off):  GPOF is a no-op unless it's running
> on Windows 2013+ or OMPR has value 0x03.  Initially OMPR has value 0x02,
> but by setting bits 18 and 19 in the argument given to the capabilities
> function, it can be set to 0x3.  After GPOF has finished, OMPR reverts
> back to 0x02.  This means that pre Windows 2013, GPOF only has any effect
> if the DSM capabilities function is called with an appropriate argument.

Pre-Windows 2013 (Win8), the DSM method was used to regulate power.
Value 3 means that _PS3 should power down the dGPU.  Value 2 means that
the platform should not do that.

Starting from Win8, PR3 is supported so this is used instead of DSM.

> The same functionality can be seen in the Clevo P651RA ssdt3/7.  What
> confuses me is that the bits are at position 18 and 19, but in
> nouveau_switcheroo_optimus_dsm() we're setting bits 0 and 1 as well as
> bits 24 and 25?  This may be a dumb question, I'm not familiar with
> Optimus, only Macs.

nouveau_switcheroo_optimus_dsm calls two different functions:

 - NOUVEAU_DSM_OPTIMUS_CAPS (0x1A) with bits 25:24 set (value 3 << 24).
   This enables powering down in _PS3.
 - NOUVEAU_DSM_OPTIMUS_FLAGS (0x1B) with bits 1:0 set (value 3).
   This enables the "dGPU audio codec flag" via SMI.

When the old DSM method is in use, these functions are always invoked
before _PS3.
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl
