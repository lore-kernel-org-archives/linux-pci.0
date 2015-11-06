Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 6 Nov 2015 14:45:34 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Tomasz Nowicki <tn@semihalf.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [Patch v7 4/7] PCI/ACPI: Add interface acpi_pci_root_create()
Message-ID: <20151106144534.GC5146@red-moon>
References: <1444804182-6596-1-git-send-email-jiang.liu@linux.intel.com>
 <1444804182-6596-5-git-send-email-jiang.liu@linux.intel.com>
 <563B65EE.7000406@semihalf.com>
 <20151105181959.GA352@red-moon>
 <563C6A5F.5030500@linux.intel.com>
 <563C82FA.7050707@semihalf.com>
 <563C930F.4060206@linux.intel.com>
 <563C9FBE.2090303@semihalf.com>
 <563CA9A6.7050309@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <563CA9A6.7050309@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 06, 2015 at 09:22:46PM +0800, Jiang Liu wrote:
> On 2015/11/6 20:40, Tomasz Nowicki wrote:
> > On 06.11.2015 12:46, Jiang Liu wrote:
> >> On 2015/11/6 18:37, Tomasz Nowicki wrote:
> >>> On 06.11.2015 09:52, Jiang Liu wrote:
> >>> Sure, ARM64 (0-16M IO space) QEMU example:
> >>> DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
> >>>           0x00000000,         // Granularity
> >>>           0x00000000,         // Range Minimum
> >>>           0x0000FFFF,         // Range Maximum
> >>>           0x3EFF0000,         // Translation Offset
> >>>           0x00010000,         // Length
> >>>           ,, , TypeStatic)
> >> The above DWordIO resource descriptor doesn't confirm to the ACPI spec.
> >> According to my understanding, ARM/ARM64 has no concept of IO port
> >> address space, so the PCI host bridge will map IO port on PCI side
> >> onto MMIO on host side. In other words, PCI host bridge on ARM64
> >> implement a IO Port->MMIO translation instead of a IO Port->IO Port
> >> translation. If that's true, it should use 'TypeTranslation' instead
> >> of 'TypeStatic'. And kernel ACPI resource parsing interface doesn't
> >> support 'TypeTranslation' yet, so we need to find a solution for it.
> > 
> > I think you are right, we need TypeTranslation flag for ARM64 DWordIO
> > descriptors and an extra kernel patch to support it.
> How about the attached to patch to support TypeTranslation?
> It only passes compilation:)

Eh, hopefully there are not any ACPI tables out there with that bit
set that work _today_ and would not work with the patch attached :)

My question is still there: do we want to handle the same problem
as ia64 has in a different manner ? Certainly we won't be able
to update ia64 platforms ACPI tables, so we would end up with
two platforms handling IO resources in different ways unless I am
missing something here.

BTW, why would we add offset to res->start only if TypeTranslation is
clear ? Is not that something we would do just to make things "work" ?
That flag has no bearing on the offset, only on the resource type AFAIK.

This without taking into account ARM64 systems shipping with ACPI
tables that does not set the TypeTranslation at present.

On top of that, I noticed that core ACPI code handles Sparse
Translation (ie _TRS), that should be considered meaningful only if _TTP
is set (and that's not checked).

Thoughts ?

Thanks,
Lorenzo
