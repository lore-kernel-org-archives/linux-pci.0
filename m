Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51857 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716AbbKIRJx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 Nov 2015 12:09:53 -0500
Date: Mon, 9 Nov 2015 17:10:43 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, arnd@arndb.de
Subject: Re: [Patch v7 4/7] PCI/ACPI: Add interface acpi_pci_root_create()
Message-ID: <20151109171042.GA11909@red-moon>
References: <1444804182-6596-1-git-send-email-jiang.liu@linux.intel.com>
 <1444804182-6596-5-git-send-email-jiang.liu@linux.intel.com>
 <563B65EE.7000406@semihalf.com>
 <20151105181959.GA352@red-moon>
 <563C6A5F.5030500@linux.intel.com>
 <563C82FA.7050707@semihalf.com>
 <563C930F.4060206@linux.intel.com>
 <563C9FBE.2090303@semihalf.com>
 <563CA9A6.7050309@linux.intel.com>
 <5640A8AA.4000806@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5640A8AA.4000806@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[CC'ing Arnd]

On Mon, Nov 09, 2015 at 03:07:38PM +0100, Tomasz Nowicki wrote:
> On 06.11.2015 14:22, Jiang Liu wrote:
> >On 2015/11/6 20:40, Tomasz Nowicki wrote:
> >>On 06.11.2015 12:46, Jiang Liu wrote:
> >>>On 2015/11/6 18:37, Tomasz Nowicki wrote:
> >>>>On 06.11.2015 09:52, Jiang Liu wrote:
> >>>>Sure, ARM64 (0-16M IO space) QEMU example:
> >>>>DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
> >>>>           0x00000000,         // Granularity
> >>>>           0x00000000,         // Range Minimum
> >>>>           0x0000FFFF,         // Range Maximum
> >>>>           0x3EFF0000,         // Translation Offset
> >>>>           0x00010000,         // Length
> >>>>           ,, , TypeStatic)
> >>>The above DWordIO resource descriptor doesn't confirm to the ACPI spec.
> >>>According to my understanding, ARM/ARM64 has no concept of IO port
> >>>address space, so the PCI host bridge will map IO port on PCI side
> >>>onto MMIO on host side. In other words, PCI host bridge on ARM64
> >>>implement a IO Port->MMIO translation instead of a IO Port->IO Port
> >>>translation. If that's true, it should use 'TypeTranslation' instead
> >>>of 'TypeStatic'. And kernel ACPI resource parsing interface doesn't
> >>>support 'TypeTranslation' yet, so we need to find a solution for it.
> >>
> >>I think you are right, we need TypeTranslation flag for ARM64 DWordIO
> >>descriptors and an extra kernel patch to support it.
> >How about the attached to patch to support TypeTranslation?
> >It only passes compilation:)
> 
> Based on the further discussion, your draft patch looks good to me.
> Lorenzo, do you agree?

No, because I still do not understand the difference between ia64 and
arm64 (they both drive IO ports cycles through MMIO so the resource
descriptors content must be the same or better they must mean the same
thing). On top of that, this is something that was heavily debated for DT:

http://www.spinics.net/lists/arm-kernel/msg345633.html

and I would like to get Arnd and Bjorn opinion on this because we
should not "interpret" ACPI specifications, we should understand
what they are supposed to describe and write kernel code accordingly.

In particular, I would like to understand, for an eg DWordIO descriptor,
what Range Minimum, Range Maximum and Translation Offset represent,
they can't mean different things depending on the SW parsing them,
this totally defeats the purpose.

By the way, ia64 ioremaps the translation_offset (ie new_space()), so
basically that's the CPU physical address at which the PCI host bridge
map the IO space transactions), I do not think ia64 is any different from
arm64 in this respect, if it is please provide an HW description here from
the PCI bus perspective here (also an example of ia64 ACPI PCI host bridge
tables would help).

Thanks,
Lorenzo
