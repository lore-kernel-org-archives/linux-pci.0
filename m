Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [Bugfix v3] x86/PCI/ACPI: Fix regression caused by commit 63f1789ec716
Date: Thu, 09 Apr 2015 23:37:42 +0200
Message-ID: <3369608.UAniFEi9kX@vostro.rjw.lan>
In-Reply-To: <5525E8DA.601@linux.intel.com>
References: <1427683243-14355-1-git-send-email-jiang.liu@linux.intel.com> <1859870.HzuzAL1ZiX@vostro.rjw.lan> <5525E8DA.601@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, April 09, 2015 10:50:02 AM Jiang Liu wrote:
> On 2015/4/9 7:44, Rafael J. Wysocki wrote:
> > On Wednesday, April 08, 2015 01:48:46 PM Jiang Liu wrote:
> >> On 2015/4/7 8:28, Rafael J. Wysocki wrote:
> >>> On Friday, April 03, 2015 10:04:11 PM Bjorn Helgaas wrote:
> >>>> Hi Jiang,
> >> <snip>
> >>>>> Currently acpi_dev_filter_resource_type() is only used by ACPI pci
> >>>>> host bridge and IOAPIC driver, so it shouldn't affect other drivers.
> >>>>
> >>>> We should assume it will eventually be used for all ACPI devices,
> >>>> shouldn't we?
> >>>
> >>> I'm not sure about that, really.  In fact, I'd restrict its use to devices
> >>> types that actually can "produce" resources (ie. do not require the resources
> >>> to be provided by their ancestors or to be available from a global pool).
> >>>
> >>> Otherwise we're pretty much guaranteed to get into trouble.
> >>>
> >>> And all of the above rules need to be documented in the kernel source tree
> >>> or people will get confused.
> >> Hi Rafael,
> >>     How about following comments for acpi_dev_filter_resource_type()?
> >> Thanks!
> >> Gerry
> >> --------------------------------------------------------------------
> >> /**
> >>  * According to ACPI specifications, Consumer/Producer flag in ACPI resource
> >>  * descriptor means:
> >>  *      1(CONSUMER): This device consumes this resource
> >>  *      0(PRODUCER): This device produces and consumes this resource
> >>  * But for ACPI PCI host bridge, it is interpreted in another way:
> > 
> > So first of all, this leads to a question: Why is it interpreted for ACPI PCI
> > host bridges differently?
> > 
> > Is it something we've figured out from experience, or is there a standard
> > mandating that? 
> Hi Rafael,
> 	I think we got this knowledge by experiences. PCI FW spec only
> states _CRS reports resources assigned to the host bridge by firmware.
> There's no statement about whether the resource is consumed by host
> bridge itself or provided to it's child bus/devices. On x86/IA64 side,
> the main resource consumed by PCI host bridge is IOPORT 0xCF8-0xCFF,
> but not sure about ARM64 side. So how about:

This:

> PCI Firmware specification states that _CRS reports resources
> assigned to the host bridge, but there's no way to tell whether
> the resource is consumed by host bridge itself or provided to
> its child bus/devices.

looks OK to me, but I'd replace the below with something like:

"However, experience shows, that in the PCI host bridge case firmware writers
 expect the resource to be provided to devices on the bus (below the bridge) for
 consumption entirely if its Consumer/Producer flag is clear.  That expectation
 is reflected by the code in this routine as follows:".
 

> So according to experiences, PCI host bridge
> interprets Consumer/Producer flag as below to tell whether the resource
> is consumed by host bridge itself.
> 
> > 
> >>  *      1(CONSUMER): PCI host bridge itself consumes the resource, such as
> >>  *                   IOPORT 0xCF8-0xCFF to access PCI configuraiton space.
> >>  *      0(PRODUCER): PCI host bridge provides this resource to its child
> >>  *                   bus and devices.
> >>  *
> >>  * So this is a specially designed helper function to support ACPI PCI host
> >>  * bridge and ACPI IOAPIC, and its usage should be limited to those specific
> > 
> > And this will make the reader wonder why the IOAPIC should be treated the same
> > way as a PCI host bridge in that respect.

Your responses would be easier to follow if they were clearly separate from the
original message text (ie. add an empty line between the paragraph you're
responding to and the response).

> If a hot-pluggable IOAPIC is represented as an ACPI device, its _CRS
> reports MMIO address assigned to the IOAPIC. And an IOAPIC device
> won't produce MMIO resources by itself. So we could reuse
> acpi_dev_filter_resource_type() here.
> How about:
>   * So this is a specially designed helper function to support:
>   * 1) ACPI PCI host bridge, as explained above
>   * 2) ACPI IOAPIC, its _CRS reports only one MMIO resource and
>   *    it won't produce MMIO resources by itself.

OK, so I'd like to see how the code would look like if those two cases had their
own "filter" routines, if that's not a problem.

Rafael

