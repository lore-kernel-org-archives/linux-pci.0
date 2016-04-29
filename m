Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 29 Apr 2016 10:41:08 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jon Masters <jcm@redhat.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Tomasz Nowicki <tn@semihalf.com>,
	Jayachandran C <jchandra@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Sinan Kaya <okaya@codeaurora.org>, jiang.liu@linux.intel.com,
	linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org,
	Liviu.Dudau@arm.com, David Daney <ddaney@caviumnetworks.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	robert.richter@caviumnetworks.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, Wangyijing <wangyijing@huawei.com>,
	Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH V6 08/13] PCI: generic, thunder: update to use generic
 ECAM API
Message-ID: <20160429094108.GB3249@red-moon>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <8950494.UV8UrWiFbx@wuerfel>
 <20160428201439.GD25125@localhost>
 <5813591.CkzahFEfSl@wuerfel>
 <20160428211834.GE25125@localhost>
 <572284E3.6050209@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <572284E3.6050209@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 28, 2016 at 05:47:15PM -0400, Jon Masters wrote:

[...]

> >>> In general, there's no reason we can't reassign BARs, whether we're
> >>> using DT, ACPI, or whatever.  In many cases, systems with ACPI also
> >>> assign all the BARs in firmware, and Linux doesn't reassign them
> >>> unless it needs to.  But that's just a coincidence.  There's no
> >>> requirement that Linux leave BARs as firmware programmed them.
> 
> There's no requirement, generally, that PCI compliant devices with ECAM
> can't be programmed with different base addresses. There's this PCI
> change called EA that is disjoint and some vendors have chosen to use
> it. We didn't catch that early in the definition of the SBSA for ARM,
> but just as an aside, I have already suggested we require future
> generations of chips to not use EA and only support writeable BARs (even
> for the decoders in the on-SoC platformish devices doing "PCI"). This
> isn't Cavium's fault - they did the right thing with the data at hand
> and nobody really considered the impact of PCI getting EA added. Again,
> that's something that will likely happen on x86 at some point (maybe it
> already is, I don't get any data about future Intel stuff).

PCI EA support in the kernel was implemented by Intel, for the records.

And I do not think anyone is questioning EA here (I mean implemented
through a real PCI capability, not config space quirks).

> On the rest of the quirks and hacks. Without going into too much detail,
> some "concerned citizens" are chatting with various folks to ensure that
> many of these common quirks aren't needed in future parts.
> 
> >> I'm thought I've seen systems in which the ACPI BIOS assumes that
> >> certain PCI devices never move around, because it pokes the registers
> >> from AML, and changing them would require never using the same device
> >> through ACPI. It's likely that this is against some standard, but that
> >> won't help you if you have to deal with the system anyway.
> 
> Right. This has happened, I think, and there you're no worse off on ARM
> than you would be on x86 if you had AML poking at something underneath.

Except that (if I read their code correctly - arch/x86/pci/i386.c,
see pcibios_resource_survey()) X86 claims the resources as
set-up by FW and thus does not reassign them, whereas on ARM we reassign
the whole PCI address space and we totally ignore the FW set-up (in DT
and ACPI alike), whether that's a problem or not time will tell,
as Bjorn mentioned I do not think that by the time FW hands over to
the OS there is any requirement whatsoever that prevents the OS
from reprogramming the PCI BARs set-up.

> > Yes, I'm pretty sure there are systems like that, e.g., I think SMM
> > code on some HP servers assumes the iLO address never changes.  I
> > think that is a firmware defect because I don't think there's any spec
> > that says firmware retains control over PCI BARs after handoff.  And
> > this particular case isn't really ACPI-specific.
> 
> If you substitute SMM for EL3 on ARM we're bound to eventually have the
> same kinds of things happening on some systems. It's just life.
> 
> > But as you say, we have to deal with these systems anyway, even if we
> > consider that behavior broken.  My proposal has been to add quirks to
> > mark those devices as IORESOURCE_PCI_FIXED, but I don't think anybody
> > has gotten around to doing that.

Well, that's going to be interesting. To me it is more something FW
should be able to communicate to the OS rather than a device specific
quirk, it is not that the device has fixed BARs, it is that the FW
expects them to be immutable (not saying that's the correct FW
behaviour - but it looks like a FW specific issue, not device specific).

I wonder whether this can be solved (at least in ACPI) through
a PCI BAR Target Operation Region (ACPI 6.0, 5.5.2.4.2), I will have
a look into that.

Lorenzo
