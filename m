Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 12 Nov 2015 12:08:36 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [Patch v7 4/7] PCI/ACPI: Add interface acpi_pci_root_create()
Message-ID: <20151112120836.GC2657@red-moon>
References: <1444804182-6596-1-git-send-email-jiang.liu@linux.intel.com>
 <564185B6.8040006@linux.intel.com>
 <20151111174647.GA30051@red-moon>
 <4357616.eloqZ4oI6r@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4357616.eloqZ4oI6r@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 11, 2015 at 09:55:37PM +0100, Arnd Bergmann wrote:
> On Wednesday 11 November 2015 17:46:47 Lorenzo Pieralisi wrote:
> > On Tue, Nov 10, 2015 at 01:50:46PM +0800, Jiang Liu wrote:
> > If we go with this approach though, you are not adding the offset to
> > the resource when parsing the memory spaces in acpi_decode_space(), are we
> > sure that's what we really want ?
> > 
> > In DT, a host bridge range has a:
> > 
> > - CPU physical address
> > - PCI bus address
> > 
> > We use that to compute the offset between primary bus (ie CPU physical
> > address) and secondary bus (ie PCI bus address).
> > 
> > The value ending up in the PCI resource struct (for memory space) is
> > the CPU physical address, if you do not add the offset in acpi_decode_space
> > that does not hold true on platforms where CPU<->PCI offset != 0 on ACPI,
> > am I wrong ?
> 
> Sinan Kaya pointed out that SBSA mandates a 1:1 mapping for memory space.

acpi_decode_space() is generic code though, it has to work on all arches,
I was worried about triggering regressions on x86 and ia64 here.

[...]

> > To sum it up for a, say, DWordIo/Memory descriptor:
> > 
> > - AddressMinimum, AddressMaximum represent the PCI bus addresses defining
> >   the resource start..end
> > - AddressTranslation is the offset that has to be added to AddressMinimum
> >   and AddressMaximum to get the window in CPU physical address space
> > 
> > So:
> > 
> > - Either we go with the patch attached (but please check my comment on
> >   the memory spaces)
> > - Or we patch acpi_pci_root_validate_resources() to amend the way
> >   IORESOURCE_IO is currently checked against ioport_resource, it can't
> >   work on arm64 at present, I described why above
> > 
> > Thoughts appreciated it is time we got this sorted and thanks for
> > the patch.
> 
> The easiest way would be to assume that nobody is building a server
> system that has multiple I/O spaces. SBSA explicitly makes I/O space
> optional, and really the only reason anyone includes that feature these
> days is for initializing GPUs through the BIOS POST method, so that
> is not relevant for servers. Even when you do have multiple PCIe
> host controllers that all support I/O space, the most logical implementation
> would be to share one common space.
> 
> If that fails, there are still two cases you have to care about, and
> it really depends on what hardware makers decide to use here (and whether
> we have any influence over them). The easier way for us to do this is
> if every hardware sets up the mapping between CPU physical and PCI I/O
> in a way that the I/O space numbers are non-overlapping between the
> host controllers. That way we can still make Linux ioport_resource
> addresses the same as PCI I/O space addresses (using io_offset=0),
> with the downside being that only the first PCIe host (as enumerated
> by the bootloader) can have I/O space addresses below 1024 that may
> be required for ISA compatibility on some hardware.

Yes, I think the approach we have in place on arm64 sound, I will work with
Jiang to make sure we interpret and manage IO space on arm64 the same
way we do with DT, I do not expect any issue on that side, I was more
worried about the interpretation of ACPI tables, I really really do not
want to end up with ACPI tables that are set-up in a way that can cause
regressions, we have to agree (and make it crystal clear in the ACPI
specs) what the resource descriptors define and how, then the ACPI kernel
resource layer should be made compliant.

Thanks,
Lorenzo
