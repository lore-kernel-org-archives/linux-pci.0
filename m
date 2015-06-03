Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39541 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752416AbbFCMtj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 3 Jun 2015 08:49:39 -0400
Date: Wed, 3 Jun 2015 13:49:41 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Lv Zheng <lv.zheng@intel.com>,
	"lenb @ kernel . org" <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"x86 @ kernel . org" <x86@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Patch v4 5/8] ARM64/PCI/ACPI: Introduce struct pci_controller
 for ACPI
Message-ID: <20150603124940.GA28247@red-moon>
References: <1433225576-8215-1-git-send-email-jiang.liu@linux.intel.com>
 <1433225576-8215-6-git-send-email-jiang.liu@linux.intel.com>
 <20150602093525.GA23543@red-moon>
 <556EBE6D.90907@linaro.org>
 <556ECA93.7040800@linux.intel.com>
 <20150603100343.GA27917@red-moon>
 <556ED51C.4070302@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <556ED51C.4070302@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 03, 2015 at 11:21:16AM +0100, Jiang Liu wrote:
> On 2015/6/3 18:03, Lorenzo Pieralisi wrote:
> > On Wed, Jun 03, 2015 at 10:36:19AM +0100, Jiang Liu wrote:
> >> On 2015/6/3 16:44, Hanjun Guo wrote:
> >>> On 2015???06???02??? 17:35, Lorenzo Pieralisi wrote:
> >>>> On Tue, Jun 02, 2015 at 07:12:53AM +0100, Jiang Liu wrote:
> >>>>> From: Hanjun Guo <hanjun.guo@linaro.org>
> >>>>>
> >>>>> ARM64 ACPI based PCI host bridge init needs a arch dependent
> >>>>> struct pci_controller to accommodate common PCI host bridge
> >>>>> code which is introduced later, or it will lead to compile
> >>>>> errors on ARM64.
> >>>>>
> >>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> >>>>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> >>>>> CC: Arnd Bergmann <arnd@arndb.de>
> >>>>> CC: Catalin Marinas <catalin.marinas@arm.com>
> >>>>> CC: Liviu Dudau <Liviu.Dudau@arm.com>
> >>>>> CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> >>>>> CC: Will Deacon <will.deacon@arm.com>
> >>>>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> >>>>> ---
> >>>>>   arch/arm64/include/asm/pci.h |   10 ++++++++++
> >>>>>   1 file changed, 10 insertions(+)
> >>>>>
> >>>>> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> >>>>> index b008a72f8bc0..70884957f253 100644
> >>>>> --- a/arch/arm64/include/asm/pci.h
> >>>>> +++ b/arch/arm64/include/asm/pci.h
> >>>>> @@ -10,6 +10,16 @@
> >>>>>   #include <asm-generic/pci-bridge.h>
> >>>>>   #include <asm-generic/pci-dma-compat.h>
> >>>>>
> >>>>> +struct acpi_device;
> >>>>> +
> >>>>> +struct pci_controller {
> >>>>> +#ifdef CONFIG_ACPI
> >>>>> +    struct acpi_device *companion;    /* ACPI companion device */
> >>>>> +#endif
> >>>>> +    int        segment;    /* PCI domain */
> >>>>> +    int        node;        /* NUMA node */
> >>>>> +};
> >>>>
> >>>> There is nothing ARM64 specific in this structure. The only
> >>>> reason I see you want to keep it arch specific is the iommu
> >>>> pointer on x86,
> >>>
> >>> And also plarform_data for IA64 too.
> >>>
> >>>> but I think we should find a way to make
> >>>> the common bits shared across archs (ie the struct above) and
> >>>> add (maybe a void*) to the generic struct to cater for arch
> >>>> specific data.
> >>>>
> >>>> Thoughts ?
> >>>
> >>> We discussed this already, it has limitations to make it
> >>> common to all archs, I think the limitation are:
> >>>
> >>>   - struct pci_controller are also used for other archs
> >>>     such as PowerPC and Tile, they will not use it for
> >>>     ACPI purpose, so we can not used for all archs.
> >>>
> >>>   - if we let struct pci_controller defined only for archs
> >>>     using ACPI, such as introduce it in linux/acpi.h, we still
> >>>     can not satisfy that the struct pci_controller is not
> >>>     only used for ACPI case on x86, it will be used for
> >>>     non-ACPI too.
> >>>
> >>> So it's pretty difficult to share it with across archs to me,
> >>> any more ideas?
> >> Hi Hanjun and Lorenzo,
> >> 	As mentioned by Hanjun, I have no idea yet about how to
> >> consolidating "struct pci_controller" further. One possible
> >> way is to move "struct pci_controller" related code into
> >> arch, but apparently that will reduce code reusing.
> > 
> > I guess you can't move that struct pci_controller to generic code
> > since it is present on other archs too (with completely different
> > members).
> > 
> > What you can do is creating a new struct (ie same purpose of pci_controller
> > with a different name) common to all archs that contains the common bits
> > + a void* data that contains arch specific data, and convert x86 and ia64
> > to using it.
> > 
> > It is weird to be forced to declare a pci_controller structure in arm64
> > code with 0 arch specific data in it.
> 
> Hi Lorenzo,
> 	I have thought to consolidate pci_controller for x86 and ia64,
> but that will make the change set much more bigger. How about to
> consolidate pci_controller by another patch set. That will be easier
> for review.

Agreed, but with this set you are forcing arm64 to define pci_controller
as pci_bus sysdata and I am not really keen on that, there are already
function calls in the arm64 pci layer that are there to make ACPI
compile and it is a bit annoying, instead of removing them we are
adding arch stuff on top.

How about passing a void* pointer (ie that is what pci_create_root_bus
expects) to acpi_pci_root_create through a member in acpi_pci_root_info
(I mean acpi_pci_root_info replaces the controller member with a void*
where you can add x86/ia64 pci_controller) ?

I understand this forces you to alloc the pci_controller in arch code,
but that's not a big deal right ? This way you can drop the
pci_controller struct from arm64 (I do not even know if it will ever
be needed, by looking at Hanjun's code, the bits of code that
need the pci_controller can be moved to generic PCI layer).

https://lkml.org/lkml/2015/5/26/215

This way we can add the generic struct we discussed later
(pci_controller refactoring), I agree it is going to be a bigger
change but at least you do not force something into arm64 that we do
not even know if it is required.

Thanks anyway for putting this series together.
Lorenzo
