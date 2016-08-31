Return-Path: <peter@lekensteyn.nl>
Return-Path: <peter@lekensteyn.nl>
Date: Wed, 31 Aug 2016 13:46:39 +0200
From: Peter Wu <peter@lekensteyn.nl>
To: Roland Singer <roland.singer@desertbit.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	dri-devel@lists.freedesktop.org, emil.l.velikov@gmail.com,
	"imirkin@alum.mit.edu >> Ilia Mirkin" <imirkin@alum.mit.edu>
Subject: Re: Kernel Freeze with American Megatrends BIOS
Message-ID: <20160831114639.GD19420@al>
References: <004c7dbe-2014-c691-29d1-7a45f3b73dfa@desertbit.com>
 <20160829160210.GA24451@localhost>
 <20160830195337.GA18805@al>
 <e7318236-9737-518e-c360-398c66220961@desertbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e7318236-9737-518e-c360-398c66220961@desertbit.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 31, 2016 at 01:27:36PM +0200, Roland Singer wrote:
> Am 30.08.2016 um 21:53 schrieb Peter Wu:
> > On Mon, Aug 29, 2016 at 11:02:10AM -0500, Bjorn Helgaas wrote:
> >> [+cc linux-acpi, linux-kernel, dri-devel]
> >>
> >> Hi Roland,
> >>
> >> I have no idea how to debug this problem.  Are you seeing something
> >> that suggests it may be a PCI problem?
> > 
> > Yes I suspect there is an ACPI and/ or PCI problem, possibly
> > device-specific. Steps to reproduce on the affected machines:
> > 
> >  1. Load nouveau.
> >  2. Wait for it to runtime suspend.
> >  2. Invoke 'lspci', this resumes the Nvidia PCI device via nouveau.
> >  3. lspci never returns, few moments later an AML_INFINITE_LOOP is
> >     reported.
> > 
> 
> I can confirm this. Same result on my machine.
> 
> Here is a link to my ACPI tables:
> https://bugs.launchpad.net/lpbugreporter/+bug/752542/+attachment/4722651/+files/Razer-Blade.tar.gz
> 
> The specific source for the NVIDIA card can be found in the ssdt5.dsl file.
> 
> 
>     Method (PGON, 1, Serialized)
>     {
>         /* ... */
> 
>         GPPR (PION, One)
>         If ((OSYS == 0x07D9))  /* Is Windows 2009 - In my case, setting to Windows 2009 only works! */
>         {
[..]
>         }
>         Else
>         {
>             LKEN (PION)
>         }
> 
>         /* ... */
>         
>         Return (Zero)
>     }
> 
> 
> 
> If not set to Windows 2009, then this is triggered:
> 
> 
>     Method (LKEN, 1, NotSerialized)
>     {
[..]
>     }

Yep, this is the same code. I stripped out irrelevant parts from the
previous mail for brevity.

> Is it possible to override the specific ACPI table functions (SSDT) in the DSDT?
> This way I could try to debug to find some more information...

See Documentation/acpi/initrd_table_override.txt and note that it is
important that the tables are really located at /kernel/firmware/acpi/
in your initrd (which must be the first, even before any possible
microcode updates).

What are you trying to do? For ACPI method tracing, see
Documentation/acpi/method-tracing.txt
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl
