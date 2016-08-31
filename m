Return-Path: <lorenzo.pieralisi@arm.com>
Return-Path: <lorenzo.pieralisi@arm.com>
Date: Wed, 31 Aug 2016 11:07:55 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Duc Dang <dhdang@apm.com>, Marc Zyngier <marc.zyngier@arm.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Rafael Wysocki <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, patches <patches@apm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: Defining polarity and trigger mode for static interrupts in _PRT
Message-ID: <20160831100755.GC1650@red-moon>
References: <CADaLND=MkDmYNESmL9zLEQQ5NaZp4_aGv4SnQ4=VS4LmFkFG6g@mail.gmail.com>
 <20160825195917.0e75a8db@arm.com>
 <20160826090813.GA1038@red-moon>
 <20160826130832.2fde2327@arm.com>
 <f747c2c3-096a-f843-908c-3f76238a6acd@codeaurora.org>
 <20160826170615.GC23885@red-moon>
 <66f94732-7ce4-e577-9bec-52f0dc8e6ddb@codeaurora.org>
 <20160830100834.GA368@red-moon>
 <CADaLND=DCFZB5KGN+yqdF0pzHhvmDhKHf9fMgZ57c+2GE0n9jQ@mail.gmail.com>
 <16855e90-43e8-b36b-788a-cf0871261432@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16855e90-43e8-b36b-788a-cf0871261432@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 30, 2016 at 01:54:24PM -0400, Sinan Kaya wrote:
> On 8/30/2016 11:51 AM, Duc Dang wrote:
> > On Tue, Aug 30, 2016 at 3:08 AM, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> >> On Fri, Aug 26, 2016 at 06:53:29PM -0400, Sinan Kaya wrote:
> >>>
> >>>>> Let me throw option d here.
> >>>>>
> >>>>> I know Bjorn wants to keep ACTIVE_LOW in the code for common code but
> >>>>> can't we override this in an arch specific way (arm64's pci.c) while
> >>>>> creating the root bridge?
> >>>>
> >>>> On what basis ? You were not copied in from the beginning, but that
> >>>> is not different from Duc's initial proposal, which Marc discarded
> >>>> because it should not be done at arch level, it depends on the interrupt
> >>>> controller.
> >>>
> >>> I happen to watch the linux-pci and linux-acpi mail-lists. I also saw
> >>> Duc's initial proposal.
> >>>
> >>> I can't imagine someone building an ACPI compliant ARM64 platform
> >>> without a GIC interrupt controller.
> >>>
> >>> The SBSA spec already mentions what kind of compatibility should be
> >>> maintained with respect to GIC. You can't have an ACPI system that's
> >>> SBSA compliant and not using GIC.
> >>>
> >>> Can't we just hard code this to ACTIVE_HIGH in arch directory if ACPI
> >>> is defined.  Why do we have to reach out to the interrupt controller?
> >>
> >> Patch below (horrible but no solution will be shiny either).
> >>
> >>> https://lists.linaro.org/pipermail/linaro-acpi/2015-November/005973.html
> >>
> >> [...]
> >>
> >>> If you look at my email above, I tried getting rid of PCI Link object
> >>> and I couldn't. I sticked to only thing that works.
> >>
> >> That's what I object to. If the ACPI bindings do not work for ARM
> >> we do not work around issues, we upgrade the specs because what may work
> >> for you has to work on all ARM platforms (and all FW developers have
> >> to be aware of that). Granted, this is a tiny snag, but the point is
> >> that no one knows what's the correct way of describing PCI legacy IRQs
> >> on ARM and we need that rectified.
> >>
> >> This does the trick for me (I can turn it into a function/look-up
> >> that returns the polarity), I am sure it will ruffle feathers but
> >> we have to find a solution so here it is (that acpi_irq_model gem
> >> is already used in generic code drivers/acpi/pci_link.c ;-))
> >>
> > 
> > Good catch! This acpi_irq_model gem does help X-Gene :)
> > 
> 
> +1 to this too. 
> 
> We don't need to invent some fake API or push stuff to the arch directory.

Ok, I will make it a proper patch and post it then.

Thanks,
Lorenzo
