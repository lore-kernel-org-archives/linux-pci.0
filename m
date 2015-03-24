Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59970 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752362AbbCXTbo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Mar 2015 15:31:44 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, Len Brown <lenb@kernel.org>,
	Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [Bugfix] x86/PCI/ACPI: Fix regression caused by commit 63f1789ec716
Date: Tue, 24 Mar 2015 20:55:47 +0100
Message-ID: <4432037.c8LZLCjoUX@vostro.rjw.lan>
In-Reply-To: <CAErSpo6uBK2FWK838BUob+54T1NHoak9HiO34TstPwGPazp72A@mail.gmail.com>
References: <1427095334-7430-1-git-send-email-jiang.liu@linux.intel.com> <5510D327.5060400@linux.intel.com> <CAErSpo6uBK2FWK838BUob+54T1NHoak9HiO34TstPwGPazp72A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, March 24, 2015 08:18:35 AM Bjorn Helgaas wrote:
> On Mon, Mar 23, 2015 at 9:59 PM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
> > On 2015/3/24 10:42, Bjorn Helgaas wrote:
> >> On Mon, Mar 23, 2015 at 9:22 PM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
> >>> On 2015/3/24 0:48, Bjorn Helgaas wrote:
> >>>> On Mon, Mar 23, 2015 at 03:22:14PM +0800, Jiang Liu wrote:
> >>>>> Commit 63f1789ec716("Ignore resources consumed by host bridge itself")
> >>>>> tries to ignore resources consumed by PCI host bridge itself by
> >>>>> checking IORESOURCE_WINDOW flag, which causes regression on some
> >>>>> platforms.
> >>>>
> >>>> "Do.  Or do not.  There is no try."
> >>>> [http://www.starwars.com/video/do-or-do-not]
> >>>>
> >>>> That commit doesn't *try* to do something.  It *does* something.  Just
> >>>> explain what it does and what's wrong with what it does.
> >>>>
> >>>>> For example, PC Engines APU.1C platform defines PCI MMIO resources with
> >>>>> ACPI Memory32Fixed operator as below:
> >>>>> Name (CRES, ResourceTemplate ()
> >>>>> {
> >>>>>     ...
> >>>>>     WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode,
> >>>>>         0x0000,             // Granularity
> >>>>>         0x0D00,             // Range Minimum
> >>>>>         0xFFFF,             // Range Maximum
> >>>>>         0x0000,             // Translation Offset
> >>>>>         0xF300,             // Length
> >>>>>         ,, , TypeStatic)
> >>>>>     Memory32Fixed (ReadOnly,
> >>>>>         0x000A0000,         // Address Base
> >>>>>         0x00020000,         // Address Length
> >>>>>         )
> >>>>>     Memory32Fixed (ReadOnly,
> >>>>>         0x00000000,         // Address Base
> >>>>>         0x00000000,         // Address Length
> >>>>>         _Y00)
> >>>>> })
> >>>>>
> >>>>> Memory32Fixed operator doesn't support concept of "producer/consumer"
> >>>>> and it will be treated as "consumer" by the ACPI resource parsing
> >>>>> interface, thus cause regression. So the fix is only to check
> >>>>> "producer/consumer" flag for resources having "producer/consumer" flag.
> >>>>
> >>>> Apparently the problem is with the Memory32Fixed resources above; it sounds
> >>>> like we ignore them after 63f1789ec716?  I don't quite understand how this
> >>>> fix works.  acpi_dev_filter_resource_type() has cases for both
> >>>> ACPI_RESOURCE_TYPE_FIXED_MEMORY32 and ACPI_RESOURCE_TYPE_ADDRESSxx, but
> >>>> this patch only touches the latter, not the
> >>>> ACPI_RESOURCE_TYPE_FIXED_MEMORY32 case.
> >>> The idea is:
> >>> 1) caller specifies IORESOURCE_WINDOW to query resources provided
> >>>    by the device, otherwise it's querying resources consumed by
> >>>    the device.
> >>> 2) For resource descriptors having producer/consumer flag, such as
> >>>     ACPI_RESOURCE_TYPE_ADDRESSxx, we check the producer/consumer flag.
> >>> 3) For resource descriptors not having producer/consumer flag, such
> >>>    as ACPI_RESOURCE_TYPE_FIXED_MEMORY32, we skip checking the
> >>>    producer/consumer flag.
> >>
> >> I figured out that much by reading the code.  But I think the code is
> >> very hard to read, and I still don't really understand how it works.
> >>
> >> Before this fix, we ignore Memory32Fixed resources.  After this fix,
> >> we use Memory32Fixed as a window.  I think that's an incorrect
> >> interpretation of Memory32Fixed.
> > Hi Bjorn,
> >         I think it's illegal to use Memory32Fixed for PCI host
> > bridge resource window too. The fix is to solve the regression
> > by relaxing constraints, but that may not be the right solution.
> 
> Relaxing the constraint for all platforms is only a solution if we're
> confident that it works for all platforms.  I'm not confident because
> I don't know what effect this patch has on systems that use
> Memory32Fixed correctly.
> 
> It's possible that you can analyze the behavior and explain that if
> you relax the constraint, the Memory32Fixed handling (both for bridge
> and non-bridge devices) will be the same as it was before
> 63f1789ec716.  If you can do that, I think it would be reasonable
> because you'd be preserving the previous, known-working behavior.
> 
> If you go that route, I'd like to see a patch that explicitly touches
> the Memory32Fixed handling.  The current patch claims to change the
> way we handle Memory32Fixed, but nothing in the code change is
> directly related to Memory32Fixed, so it's very confusing.
> 
> >         How about waiting for a while to see whether there are more
> > bug reports related to this. If only limited platform affected,
> > we could treat it as BIOS bugs and use quirk to handle it.
> > Otherwise we may need to relax the constraint.
> 
> I don't think waiting is a good strategy.  We know we have a
> regression, and I think we need to fix that ASAP without waiting for
> more failure reports.

Agreed on all points.

Rafael

