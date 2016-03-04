Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160303225152.GA10472@localhost>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <1455630825-27253-2-git-send-email-tn@semihalf.com> <20160303225152.GA10472@localhost>
From: Jayachandran Chandrashekaran Nair
	<jayachandran.chandrashekaran@broadcom.com>
Date: Fri, 4 Mar 2016 14:05:56 +0530
Message-ID: <CAKc_7PUyf8ND8Nd32yDBtBnFbkd1mJ-VsCih6YsEA5ZuBUz5zA@mail.gmail.com>
Subject: Re: [PATCH V5 01/15] ACPI: MCFG: Move mmcfg_list management to drivers/acpi
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Tomasz Nowicki <tn@semihalf.com>, Arnd Bergmann <arnd@arndb.de>,
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
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 4, 2016 at 4:21 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> Hi Tomasz, Jayachandran, et al,
>
> On Tue, Feb 16, 2016 at 02:53:31PM +0100, Tomasz Nowicki wrote:
>> From: Jayachandran C <jchandra@broadcom.com>
>>
>> Move pci_mmcfg_list handling to a drivers/acpi/pci_mcfg.c. This is
>> to share the API and code with ARM64 later. The corresponding
>> declarations are moved from asm/pci_x86.h to linux/pci-acpi.h
>>
>> As a part of this we introduce three functions that can be
>> implemented by the arch code: pci_mmconfig_map_resource() to map a
>> mcfg entry, pci_mmconfig_unmap_resource to do the corresponding
>> unmap and pci_mmconfig_enabled to see if the arch setup of
>> mcfg entries was successful. We also provide weak implementations
>> of these, which will be used from ARM64. On x86, we retain the
>> old logic by providing platform specific implementation.
>>
>> This patch is purely rearranging code, it should not have any
>> impact on the logic of MCFG parsing or list handling.
>
> I definitely want to figure out how to make this work well on ARM64.
> I need to ponder this some more, so these are just some initial
> thoughts.
>
> My first impression is that (a) the x86 MCFG code is an unmitigated
> disaster, and (b) we're trying a little too hard to make that mess
> generic.  I think we might be better served if we came up with some
> cleaner, more generic code that we can use for ARM64 today, and
> migrate x86 toward that over time.
>
> My concern is that if we elevate the current x86 code to be
> "arch-independent", we will be perpetuating some interfaces and
> designs that shouldn't be allowed to escape arch/x86.

I think the major decision is whether to maintain the pci_mmcfg_list
for all architectures or not. My initial plan was not to do this because
of the mess (basically the ECAM region info should be attached to
the pci root and not maintained in a separate list that needs locking),
The patch I posted initially https://patchwork.ozlabs.org/patch/553464/
had a much simpler way of handling the MCFG table without using
the list.

In x86 case it is not feasible to remove using the pci_mmcfg_list.
The only use of it outside is in xen that can be fixed up.

> Some of the code that moved to drivers/acpi/pci_mcfg.c is not really
> ACPI-specific, and could potentially be used for non-ACPI bridges that
> support ECAM.  I'd like to see that sort of code moved to a new file
> like drivers/pci/ecam.c.
>
> There's a little bit of overlap here with the ECAM code in
> pci-host-generic.c.  I'm not sure whether or how to include that, but
> it's a very good example of how simple this *should* be: probe the
> host bridge, discover the ECAM region, request the region, ioremap it,
> done.

I had a similar approach in my initial patchset, please see the patch
above. The resource for ECAM is mapped similar to the the way
pci-host-generic.c handled it. An additional step I could do was to
move the common code (ioremap and mapbus) into a common
file and share the code with pci-host-generic.c

>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>> new file mode 100644
>> index 0000000..ea84365
>> --- /dev/null
>> +++ b/drivers/acpi/pci_mcfg.c
>> ...
>> +int __weak pci_mmconfig_map_resource(struct device *dev,
>> +     struct pci_mmcfg_region *mcfg)
>> +{
>> +     struct resource *tmp;
>> +     void __iomem *vaddr;
>> +
>> +     tmp = insert_resource_conflict(&iomem_resource, &mcfg->res);
>> +     if (tmp) {
>> +             dev_warn(dev, "MMCONFIG %pR conflicts with %s %pR\n",
>> +                     &mcfg->res, tmp->name, tmp);
>> +             return -EBUSY;
>> +     }
>
> I think this is a mistake in the x86 MCFG support that we should not
> carry over to a generic implementation.  We should not use the MCFG
> table for resource reservation because MCFG is not defined by the ACPI
> spec and an OS need not include support for it.  The platform must
> indicate in some other, more generic way, that ECAM space is reserved.
> This probably means ECAM space should be declared in a PNP0C02 _CRS
> method (see the PCI Firmware Spec r3.0, sec 4.1.2, note 2).
>
> We might need some kind of x86-specific quirk that does this, or a
> pcibios hook or something here; I just don't think it should be
> generic.
>
>> +int __init pci_mmconfig_parse_table(void)
>> +{
>> +     return acpi_sfi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
>> +}
>
> I don't like the fact that we parse the entire MCFG table at once
> here.  I think we should look for the information we need when we are
> claiming a PCI host bridge, e.g., in acpi_pci_root_add().  This might
> not be a great fit for the way ACPI table management works, but I
> think it's better to do things on-demand rather than just-in-case.

There is an overhead of looking up this table, and the information
available there is very limited (i.e, segment, start_bus, end_bus
and address). My approach in the above patch is to save this info
into an array at boot time and avoid multiple lookups.

>> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
>> index 89ab057..e9450ef 100644
>> --- a/include/linux/pci-acpi.h
>> +++ b/include/linux/pci-acpi.h
>> @@ -106,6 +106,39 @@ extern const u8 pci_acpi_dsm_uuid[];
>>  #define RESET_DELAY_DSM              0x08
>>  #define FUNCTION_DELAY_DSM   0x09
>>
>> +/* common API to maintain list of MCFG regions */
>> +/* "PCI MMCONFIG %04x [bus %02x-%02x]" */
>> +#define PCI_MMCFG_RESOURCE_NAME_LEN (22 + 4 + 2 + 2)
>> +
>> +struct pci_mmcfg_region {
>> +     struct list_head list;
>> +     struct resource res;
>> +     u64 address;
>> +     char __iomem *virt;
>> +     u16 segment;
>> +     u8 start_bus;
>> +     u8 end_bus;
>> +     char name[PCI_MMCFG_RESOURCE_NAME_LEN];
>> +};
>> +
>> +extern int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
>> +                            phys_addr_t addr);
>> +extern int pci_mmconfig_delete(u16 seg, u8 start, u8 end);
>> +
>> +extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
>> +extern struct pci_mmcfg_region *pci_mmconfig_add(int segment, int start,
>> +                                                     int end, u64 addr);
>> +extern int pci_mmconfig_map_resource(struct device *dev,
>> +     struct pci_mmcfg_region *mcfg);
>> +extern void pci_mmconfig_unmap_resource(struct pci_mmcfg_region *mcfg);
>> +extern int pci_mmconfig_enabled(void);
>> +extern int __init pci_mmconfig_parse_table(void);
>> +
>> +extern struct list_head pci_mmcfg_list;
>> +
>> +#define PCI_MMCFG_BUS_OFFSET(bus)      ((bus) << 20)
>> +#define PCI_MMCFG_OFFSET(bus, devfn)   ((bus) << 20 | (devfn) << 12)
>> +
>
> With the exception of pci_mmconfig_parse_table(), nothing here is
> ACPI-specific.  I'd like to see the PCI ECAM-related interfaces
> (hopefully not these exact ones, but a more rational set) put in
> something like include/linux/pci-ecam.h.
>
>>  #else        /* CONFIG_ACPI */
>>  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>>  static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }

I can update this patch to
 -  drop the pci_mmcfg_list handling from generic case
 -  move common ECAM code so that it can be shared with
    pci-host-generic.c
if that is what you are looking for. The code will end up looking much
simpler.

Thanks,
JC.
