Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35448 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268AbcCIKvB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Mar 2016 05:51:01 -0500
Received: by mail-wm0-f49.google.com with SMTP id l68so171972377wml.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Mar 2016 02:51:01 -0800 (PST)
Subject: Re: [PATCH V5 01/15] ACPI: MCFG: Move mmcfg_list management to
 drivers/acpi
To: Jayachandran Chandrashekaran Nair
	<jayachandran.chandrashekaran@broadcom.com>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <1455630825-27253-2-git-send-email-tn@semihalf.com>
 <20160303225152.GA10472@localhost>
 <CAKc_7PUyf8ND8Nd32yDBtBnFbkd1mJ-VsCih6YsEA5ZuBUz5zA@mail.gmail.com>
 <20160305041443.GA15110@localhost> <56DFE91E.10105@semihalf.com>
 <CAKc_7PW3YMgT7h2MDpR31ysORJ-UjjbQmeD8qoDPw9fzEwPZTg@mail.gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	Jayachandran Chandrashekaran Nair <jchandra@broadcom.com>,
	Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>,
	robert.richter@caviumnetworks.com, Marcin Wojtas <mw@semihalf.com>,
	Liviu.Dudau@arm.com, David Daney <ddaney@caviumnetworks.com>,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	Jon Masters <jcm@redhat.com>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <56E00009.6010302@semihalf.com>
Date: Wed, 9 Mar 2016 11:50:49 +0100
MIME-Version: 1.0
In-Reply-To: <CAKc_7PW3YMgT7h2MDpR31ysORJ-UjjbQmeD8qoDPw9fzEwPZTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jayachandran,

On 09.03.2016 11:10, Jayachandran Chandrashekaran Nair wrote:
> Hi Tomasz,
>
> On Wed, Mar 9, 2016 at 2:43 PM, Tomasz Nowicki <tn@semihalf.com> wrote:
>> Hi Bjorn,
>>
>> Thanks for your pointers! See my comments inline. Aslo, can you please have
>> a look at my previous patch set v4 and check how many of your comments are
>> already addressed there. We may want to back to it then.
>>
>> https://lkml.org/lkml/2016/2/4/646
>> Especially patches [0-6] which handle MMCONFIG refactoring.
>>
>>
>> On 05.03.2016 05:14, Bjorn Helgaas wrote:
>>>
>>> On Fri, Mar 04, 2016 at 02:05:56PM +0530, Jayachandran Chandrashekaran
>>> Nair wrote:
>>>>
>>>> On Fri, Mar 4, 2016 at 4:21 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>>
>>>>> Hi Tomasz, Jayachandran, et al,
>>>>>
>>>>> On Tue, Feb 16, 2016 at 02:53:31PM +0100, Tomasz Nowicki wrote:
>>>>>>
>>>>>> From: Jayachandran C <jchandra@broadcom.com>
>>>>>>
>>>>>> Move pci_mmcfg_list handling to a drivers/acpi/pci_mcfg.c. This is
>>>>>> to share the API and code with ARM64 later. The corresponding
>>>>>> declarations are moved from asm/pci_x86.h to linux/pci-acpi.h
>>>>>>
>>>>>> As a part of this we introduce three functions that can be
>>>>>> implemented by the arch code: pci_mmconfig_map_resource() to map a
>>>>>> mcfg entry, pci_mmconfig_unmap_resource to do the corresponding
>>>>>> unmap and pci_mmconfig_enabled to see if the arch setup of
>>>>>> mcfg entries was successful. We also provide weak implementations
>>>>>> of these, which will be used from ARM64. On x86, we retain the
>>>>>> old logic by providing platform specific implementation.
>>>>>>
>>>>>> This patch is purely rearranging code, it should not have any
>>>>>> impact on the logic of MCFG parsing or list handling.
>>>>>
>>>>>
>>>>> I definitely want to figure out how to make this work well on ARM64.
>>>>> I need to ponder this some more, so these are just some initial
>>>>> thoughts.
>>>>>
>>>>> My first impression is that (a) the x86 MCFG code is an unmitigated
>>>>> disaster, and (b) we're trying a little too hard to make that mess
>>>>> generic.  I think we might be better served if we came up with some
>>>>> cleaner, more generic code that we can use for ARM64 today, and
>>>>> migrate x86 toward that over time.
>>>>>
>>>>> My concern is that if we elevate the current x86 code to be
>>>>> "arch-independent", we will be perpetuating some interfaces and
>>>>> designs that shouldn't be allowed to escape arch/x86.
>>>>
>>>>
>>>> I think the major decision is whether to maintain the pci_mmcfg_list
>>>> for all architectures or not. My initial plan was not to do this because
>>>> of the mess (basically the ECAM region info should be attached to
>>>> the pci root and not maintained in a separate list that needs locking),
>>>> The patch I posted initially https://patchwork.ozlabs.org/patch/553464/
>>>> had a much simpler way of handling the MCFG table without using
>>>> the list.
>>>
>>>
>>> I agree that ECAM info should be attached to the PCI host controller.
>>> That should simplify locking and hot-add and hot-removal of host
>>> controllers.
>>>
>>> I think pci_mmcfg_list is an implementation detail that may not need
>>> to be generic.  I certainly don't think it needs to be part of the
>>> interface.
>>>
>>>> In x86 case it is not feasible to remove using the pci_mmcfg_list.
>>>> The only use of it outside is in xen that can be fixed up.
>>>>
>>>>> Some of the code that moved to drivers/acpi/pci_mcfg.c is not really
>>>>> ACPI-specific, and could potentially be used for non-ACPI bridges that
>>>>> support ECAM.  I'd like to see that sort of code moved to a new file
>>>>> like drivers/pci/ecam.c.
>>>>>
>>>>> There's a little bit of overlap here with the ECAM code in
>>>>> pci-host-generic.c.  I'm not sure whether or how to include that, but
>>>>> it's a very good example of how simple this *should* be: probe the
>>>>> host bridge, discover the ECAM region, request the region, ioremap it,
>>>>> done.
>>>>
>>>>
>>>> I had a similar approach in my initial patchset, please see the patch
>>>> above. The resource for ECAM is mapped similar to the the way
>>>> pci-host-generic.c handled it. An additional step I could do was to
>>>> move the common code (ioremap and mapbus) into a common
>>>> file and share the code with pci-host-generic.c
>>>>
>>>>>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>>>>>> new file mode 100644
>>>>>> index 0000000..ea84365
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/acpi/pci_mcfg.c
>>>>>> ...
>>>>>> +int __weak pci_mmconfig_map_resource(struct device *dev,
>>>>>> +     struct pci_mmcfg_region *mcfg)
>>>>>> +{
>>>>>> +     struct resource *tmp;
>>>>>> +     void __iomem *vaddr;
>>>>>> +
>>>>>> +     tmp = insert_resource_conflict(&iomem_resource, &mcfg->res);
>>>>>> +     if (tmp) {
>>>>>> +             dev_warn(dev, "MMCONFIG %pR conflicts with %s %pR\n",
>>>>>> +                     &mcfg->res, tmp->name, tmp);
>>>>>> +             return -EBUSY;
>>>>>> +     }
>>>>>
>>>>>
>>>>> I think this is a mistake in the x86 MCFG support that we should not
>>>>> carry over to a generic implementation.  We should not use the MCFG
>>>>> table for resource reservation because MCFG is not defined by the ACPI
>>>>> spec and an OS need not include support for it.  The platform must
>>>>> indicate in some other, more generic way, that ECAM space is reserved.
>>>>> This probably means ECAM space should be declared in a PNP0C02 _CRS
>>>>> method (see the PCI Firmware Spec r3.0, sec 4.1.2, note 2).
>>>>>
>>>>> We might need some kind of x86-specific quirk that does this, or a
>>>>> pcibios hook or something here; I just don't think it should be
>>>>> generic.
>>>>>
>>>>>> +int __init pci_mmconfig_parse_table(void)
>>>>>> +{
>>>>>> +     return acpi_sfi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
>>>>>> +}
>>>>>
>>>>>
>>>>> I don't like the fact that we parse the entire MCFG table at once
>>>>> here.  I think we should look for the information we need when we are
>>>>> claiming a PCI host bridge, e.g., in acpi_pci_root_add().  This might
>>>>> not be a great fit for the way ACPI table management works, but I
>>>>> think it's better to do things on-demand rather than just-in-case.
>>>>
>>>>
>>>> There is an overhead of looking up this table, and the information
>>>> available there is very limited (i.e, segment, start_bus, end_bus
>>>> and address). My approach in the above patch is to save this info
>>>> into an array at boot time and avoid multiple lookups.
>>>
>>>
>>> We need to look up MCFG info once per host bridge, so I don't think
>>> there's any performance issue here.  But we do use acpi_table_parse(),
>>> which is __init, and *that* is a reason why we might need to parse the
>>> entire MCFG at boot-time.  But this is the least of our worries in any
>>> case.
>>>
>>>>>> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
>>>>>> index 89ab057..e9450ef 100644
>>>>>> --- a/include/linux/pci-acpi.h
>>>>>> +++ b/include/linux/pci-acpi.h
>>>>>> @@ -106,6 +106,39 @@ extern const u8 pci_acpi_dsm_uuid[];
>>>>>>    #define RESET_DELAY_DSM              0x08
>>>>>>    #define FUNCTION_DELAY_DSM   0x09
>>>>>>
>>>>>> +/* common API to maintain list of MCFG regions */
>>>>>> +/* "PCI MMCONFIG %04x [bus %02x-%02x]" */
>>>>>> +#define PCI_MMCFG_RESOURCE_NAME_LEN (22 + 4 + 2 + 2)
>>>>>> +
>>>>>> +struct pci_mmcfg_region {
>>>>>> +     struct list_head list;
>>>>>> +     struct resource res;
>>>>>> +     u64 address;
>>>>>> +     char __iomem *virt;
>>>>>> +     u16 segment;
>>>>>> +     u8 start_bus;
>>>>>> +     u8 end_bus;
>>>>>> +     char name[PCI_MMCFG_RESOURCE_NAME_LEN];
>>>>>> +};
>>>>>> +
>>>>>> +extern int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start,
>>>>>> u8 end,
>>>>>> +                            phys_addr_t addr);
>>>>>> +extern int pci_mmconfig_delete(u16 seg, u8 start, u8 end);
>>>>>> +
>>>>>> +extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int
>>>>>> bus);
>>>>>> +extern struct pci_mmcfg_region *pci_mmconfig_add(int segment, int
>>>>>> start,
>>>>>> +                                                     int end, u64
>>>>>> addr);
>>>>>> +extern int pci_mmconfig_map_resource(struct device *dev,
>>>>>> +     struct pci_mmcfg_region *mcfg);
>>>>>> +extern void pci_mmconfig_unmap_resource(struct pci_mmcfg_region
>>>>>> *mcfg);
>>>>>> +extern int pci_mmconfig_enabled(void);
>>>>>> +extern int __init pci_mmconfig_parse_table(void);
>>>>>> +
>>>>>> +extern struct list_head pci_mmcfg_list;
>>>>>> +
>>>>>> +#define PCI_MMCFG_BUS_OFFSET(bus)      ((bus) << 20)
>>>>>> +#define PCI_MMCFG_OFFSET(bus, devfn)   ((bus) << 20 | (devfn) << 12)
>>>>>> +
>>>>>
>>>>>
>>>>> With the exception of pci_mmconfig_parse_table(), nothing here is
>>>>> ACPI-specific.  I'd like to see the PCI ECAM-related interfaces
>>>>> (hopefully not these exact ones, but a more rational set) put in
>>>>> something like include/linux/pci-ecam.h.
>>>>>
>>>>>>    #else        /* CONFIG_ACPI */
>>>>>>    static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>>>>>>    static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
>>>>
>>>>
>>>> I can update this patch to
>>>>    -  drop the pci_mmcfg_list handling from generic case
>>>>    -  move common ECAM code so that it can be shared with
>>>>       pci-host-generic.c
>>>> if that is what you are looking for. The code will end up looking much
>>>> simpler.
>>>
>>>
>>> I think we should ignore x86 mmconfig for now.  It is absurdly
>>> complicated and I'm not sure it's fixable.  I *do* want to keep
>>> drivers/acpi/pci_root.c for all ACPI host bridges, including x86,
>>> ia64, and arm64.
>>>
>>> So I think we should write generic MCFG and ECAM support from scratch
>>> for arm64.  Something like this:
>>>
>>>     - Add an acpi_mcfg_init(), maybe in drivers/acpi/pci_mcfg.c, to be
>>>       called from acpi_init() to copy MCFG info to something we can
>>>       access after __init.  This would not reserve resources, but
>>>       probably does have to ioremap() the regions to support
>>>       raw_pci_read().
>>
>>
>> As said, ECAM and ACPI specific code was isolated in previous patch. There,
>> I tried to leave x86 complication in arch/x86/ and extract generic
>> functionalities to driver/pci/ecam.c as the library.
>>
>>>
>>>     - Implement raw_pci_read(), which is "special" because ACPI needs it
>>>       for PCI config access from AML.  It's supposed to be "always
>>>       accessible" and we don't have a struct pci_bus *, so this probably
>>>       has to use the MCFG copy and the ioremap done above.  Maybe it
>>>       should go in the same file.  This is completely independent of
>>>       the PCI core and PCI data structures.
>>
>> We were looking for the answer which would justify RAW PCI config accessors
>> being for ARM64 world. Unfortunately, nobody was able to show real use case
>> for ARM64. Do you see the reason we need this? Our conclusion was to leave
>> it empty for ARM64 which in turn makes code simpler. I am not ASWG member
>> while that was under discussion so I will ask Lorenzo to elaborate more on
>> this.
>>
>>>
>>>     - Implement arm64 pci_acpi_scan_root() that calls
>>>       acpi_pci_root_create() with an .init_info() function that calls
>>>       acpi_pci_root_get_mcfg_addr() to read _CBA, and if that fails,
>>>       looks up the bus range in the MCFG copy from above.  It should
>>>       call request_mem_region().  For a region from _CBA, it should call
>>>       ioremap().  For regions from MCFG it can probably use the ioremap
>>>       done by acpi_mcfg_init().
>>
>> Yes, Expanding .init_info() to check for _CBA is good point.
>>
>>>
>>>       I know acpi_pci_root_add() calls acpi_pci_root_get_mcfg_addr()
>>>       before calling pci_acpi_scan_root(), but I think that's wrong
>>>       because (a) some arches, e.g., ia64, don't use ECAM and (b) _CBA
>>>       and MCFG should be handled in the same place.
>>>
>>>       I know calling request_mem_region() here will probably be an
>>>       ordering problem because the PNP0C02 driver hasn't reserved
>>>       resources yet.  But the host bridge driver is using the region and
>>>       it should reserve it.
>>>
>>>     - If we store the ECAM mapped base address in the sysdata or struct
>>>       pci_host_bridge, the normal config accessors can use
>>>       pci_generic_config_read() with a new generic .map_bus() function.
>>
>>
>> pci_generic_config_{read|write}() is what we want to use, actually we do
>> now, but ECAM region and sysdata association will remove ECAM region lookup
>> step (see patch 09/15 of this series).
>>
>>>
>>>       On x86, the normal config access path is:
>>>
>>>         pci_read(struct pci_bus *, ...)
>>>           raw_pci_read(seg, bus#, ...)
>>>            raw_pci_ext_ops->read(seg, bus#, ...)
>>>              pci_mmcfg_read(seg, bus#, ...)
>>>                pci_dev_base
>>>                  pci_mmconfig_lookup(seg, bus#)
>>>
>>>       I think this is somewhat backwards because we start with a pci_bus
>>>       pointer, so we *could* have a nice simple bus-specific accessor,
>>>       but we throw that pointer away, so pci_mmcfg_read() has to start
>>>       over and look up the ECAM offset from scratch, which makes it all
>>>       unnecessarily complicated.
>>>
>>
>> As you pointed out raw_pci_{read|write} make things complicated, so IMO we
>> should either say they are absolutely necessary (and then think how to
>> simplify it) or just use simple bus-specific accessor (patch 02/15) e.g. for
>> ARM64.
>
> Both raw_pci_read/write and a host controller with pci_generic_read/write can
> be done without much trouble, please see the patch I had at:
> https://patchwork.ozlabs.org/patch/575526/

Yes it is doable, I implemented it in the same way in one of my initial 
patch series, about year ago. I'm questioning raw accessors presence on 
per-arch basis. If it is really needed for all archs, then we definitely 
should implement it. If ARM64 does not care for it, there is no point to 
complicate it. Especially, I mean all kind of PCI config space quirk we 
will need to handle right after this patch got merged, see:
[PATCH V5 13/15] pci, acpi: Match PCI config space accessors against 
platfrom specific quirks.

and

https://lkml.org/lkml/2016/2/9/627
https://lkml.org/lkml/2016/2/8/967

Giving these quirks, raw accessors are not so easy.

>
> I have been looking at Bjorn's suggestions and trying to see if I can update
> my MCFG patch taking care of them. I will post an updated patch set soon,
> unless you want to take this up.
>

Yes, I want to post next version and keep this patch set together, if 
you and Bjorn are okay. I am feeling that my previous patch set is close 
to what Bjorn suggested, modulo the way we keep MCFG regions. Lets 
discuss it here, then I will post it as next version. I am looking 
forward to hear Bjorn's comment on my previous patch set.

Tomasz
