Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 05/11] x86, pci, acpi: Move arch-agnostic MMCONFIG (aka
 ECAM) and ACPI code out of arch/x86/ directory
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20150526170817.GU1565@arm.com> <55657B02.5090805@linaro.org>
 <20150602133215.GC23650@red-moon> <55701A31.808@linaro.org>
 <20150604102253.GA31773@red-moon> <5570447D.3020705@linaro.org>
 <557504A2.3060203@linaro.org> <20150608151443.GA16151@red-moon>
 <55E4340D.6050004@linaro.org> <55ED6010.3020406@linaro.org>
 <20150908150727.GF29293@red-moon>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"msalter@redhat.com" <msalter@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>
From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Message-ID: <55F0388B.1090607@linaro.org>
Date: Wed, 9 Sep 2015 15:47:55 +0200
MIME-Version: 1.0
In-Reply-To: <20150908150727.GF29293@red-moon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On 08.09.2015 17:07, Lorenzo Pieralisi wrote:
> Hi Tomasz,
>
> On Mon, Sep 07, 2015 at 10:59:44AM +0100, Tomasz Nowicki wrote:
>> On 31.08.2015 13:01, Tomasz Nowicki wrote:
>>> On 08.06.2015 17:14, Lorenzo Pieralisi wrote:
>>>> On Mon, Jun 08, 2015 at 03:57:38AM +0100, Hanjun Guo wrote:
>>>>
>>>> [...]
>>>>
>>>>>>>>>>> Why can't we make use of the ECAM implementation used by
>>>>>>>>>>> pci-host-generic
>>>>>>>>>>> and drivers/pci/access.c?
>>>>>>>>>>
>>>>>>>>>> We had that question when I had posted MMCFG patch set separately,
>>>>>>>>>> please see:
>>>>>>>>>> https://lkml.org/lkml/2015/3/11/492
>>>>>>>>>
>>>>>>>>> Yes, but the real question is, why do we need to have PCI config
>>>>>>>>> space
>>>>>>>>> up and running before a bus struct is even created ? I think the
>>>>>>>>> reason is
>>>>>>>>> the PCI configuration address space format (ACPI 6.0, Table 5-27,
>>>>>>>>> page
>>>>>>>>> 108):
>>>>>>>>>
>>>>>>>>> "PCI Configuration space addresses must be confined to devices on
>>>>>>>>> PCI Segment Group 0, bus 0. This restriction exists to accommodate
>>>>>>>>> access to fixed hardware prior to PCI bus enumeration".
>>>>>>>>>
>>>>>>>>> On HW reduced platforms I do not even think this is required at all,
>>>>>>>>> we have to look into this to avoid code duplication that might well
>>>>>>>>> turn out useless.
>>>>>>>>
>>>>>>>> This is only for the fixed hardware, which will be not available for
>>>>>>>> ARM64 (reduced hardware mode), but in Generic Hardware Programming
>>>>>>>> Model, we using OEM-provided ACPI Machine Language (AML) code to
>>>>>>>> access
>>>>>>>> generic hardware registers, this will be available for reduced
>>>>>>>> hardware
>>>>>>>> too.
>>>>>>>>
>>>>>>>> So in ACPI spec, it says: (ACPI 6.0 page 66, last paragraph)
>>>>>>>>
>>>>>>>> ACPI defines eight address spaces that may be accessed by generic
>>>>>>>> hardware implementations. These include:
>>>>>>>> * System I/O space
>>>>>>>> * System memory space
>>>>>>>> * PCI configuration space
>>>>>>>> * Embedded controller space
>>>>>>>> * System Management Bus (SMBus) space
>>>>>>>> * CMOS
>>>>>>>> * PCI BAR Target
>>>>>>>> * IPMI space
>>>>>>>>
>>>>>>>> So if any device using the PCI address space for control, such
>>>>>>>> as a system reset control device, its address space can be reside
>>>>>>>> in PCI configuration space (who can prevent a OEM do that crazy
>>>>>>>> thing? :) ), and it should be accessible before the PCI bus is
>>>>>>>> created.
>>>>>>>
>>>>>>> Us, by changing attitude and questioning features whose usefulness
>>>>>>> is questionable. I will look into this and raise the point, I am not
>>>>>>> thrilled by the idea of adding another set of PCI accessor functions
>>>>>>> and drivers because we have to access a register through PCI before
>>>>>>> enumerating the bus (and on arm64 this is totally useless since
>>>>>>> we are not meant to support fixed HW anyway). Maybe we can make acpica
>>>>>>> code use a "special" stub (ACPI specific, PCI configuration space
>>>>>>> address
>>>>>>> space has restrictions anyway), I have to review this set in its
>>>>>>> entirety to see how to do that (and I would kindly ask you to do
>>>>>>> it too, before saying it is not possible to implement it).
>>>>>>
>>>>>> I'm willing to do that, actually, if we don't need a mechanism to
>>>>>> access PCI config space before the bus is created, the code can be
>>>>>> simplified a lot.
>>>>>
>>>>> After more investigation on the spec and the ACPI core code, I'm
>>>>> still not convinced that accessing to PCI config space before PCI
>>>>> bus creating is impossible, also there is no enough ARM64 hardware
>>>>> to prove that too. But I think we can go in this way, reuse the
>>>>> ECAM implementation by pci-host-generic for now, and implement the PCI
>>>>> accessor functions before enumerating PCI bus when needed in the
>>>>> future, does it make sense?
>>>>
>>>> You mean we rewrite the patch to make sure we can use the PCI host
>>>> generic
>>>> driver with MCFG and we leave the acpica PCI config call empty stubs on
>>>> arm64 (as they are now) ?
>>>>
>>>
>>> Hi Bjorn, Rafael,
>>>
>>> Lorenzo pointed out very important problem we are having with PCI config
>>> space access for ARM64. Please refer to the above discussion and add
>>> your 2 cents. Can we forget about accessing PCI config space (for
>>> Hardware Reduced profile) before PCI bus creation? If not, do you see a
>>> way to use drivers/pci/access.c accessors here, like acpica change? Any
>>> opinion is very appreciated.
>>>
>>
>> Kindly remainder.
>
> I think (but I am happy to be corrected) that the map_bus() hook
> (ie that's why struct pci_bus is required in eg pci_generic_config_write)
> is there to ensure that when the generic accessors are called
> a) we have a valid bus b) the host controllers implementing it
> has been initialized.
>
> I had another look and I noticed you are trying to solve multiple
> things at once:
>
> 1) ACPICA seems to need PCI config space on bus 0 to be working
>     before PCI enumerates (ie before we have a root bus), we need to
>     countercheck on that, but you can't use the generic PCI accessors
>     for that reasons (ie root bus might not be available, you do not
>     have a pci_bus struct)
> 2) the raw_pci_read/write require _generic_ mmio back-ends, since AMD
>     can't cope with standard x86 read/write{b,w,l}
>
> Overall, it seems to me that we can avoid code duplication by
> shuffling your code a bit.
>
> You could modify the generic accessors in drivers/pci/access.c to
> use your mmio back-end instead of using plain read/write{b,w,l}
> functions (we should check if RobH is ok with that there can be
> reasons that prevent this from happening). This would solve the
> AMD mmio issue.
>
> By factoring out the code that actually carries out the reads
> and writes in the accessors basically you decouple the functions
> requiring the struct pci_bus from the ones that does not require it
> (ie raw_pci_{read/write}.
>
> The generic MMIO layer belongs in the drivers/pci/access.c file, it has
> nothing to do with ECAM.
>
> The mmcfg interface should probably live in pci-acpi.c, I do not think
> you need an extra file in there but that's a detail.
>
> Basically the generic accessors would become something like eg:
>
> int pci_generic_config_write(struct pci_bus *bus, unsigned int devfn,
> 			     int where, int size, u32 val)
> {
> 	void __iomem *addr;
>
> 	addr = bus->ops->map_bus(bus, devfn, where);
> 	if (!addr)
> 		return PCIBIOS_DEVICE_NOT_FOUND;
>
> 	pci_mmio_write(size, addr + where, value);
>
> 	return PCIBIOS_SUCCESSFUL;
> }
>
> With that in place using raw_pci_write/read or the generic accessors
> becomes almost identical, with code requiring the pci_bus to be
> created using the generic accessors and ACPICA using the raw version.
>
> I might be missing something, so apologies if that's the case.
>

Actually, I think you showed me the right direction :) Here are some 
conclusions/comments/concerns. Please correct me if I am wrong:

1. We need raw_pci_write/read accessors (based on ECAM) for ARM64 too 
but only up to the point where buses are enumerated. From that point on, 
we should reuse generic accessors from access.c file, right?

2. For ARM64 ACPI PCI, we can use generic accessors right away, .map_bus 
would call common code part (pci_dev_base()). The only thing that worry 
me is fact that MCFG regions are RCU list so it needs rcu_read_lock() 
for the .map_bus (mcfg lookup) *and* read/write operation.

3. Changing generic accessors to introduce generic MMIO layer (because 
of AMD issue) like this:
int pci_generic_config_write(struct pci_bus *bus, unsigned int devfn,
			     int where, int size, u32 val)
{
	void __iomem *addr;

	addr = bus->ops->map_bus(bus, devfn, where);
	if (!addr)
		return PCIBIOS_DEVICE_NOT_FOUND;

	pci_mmio_write(size, addr + where, val);

	return PCIBIOS_SUCCESSFUL;
}
would imply using those accessors for x86 ACPI PCI host bridge driver, 
see arch/x86/pci/common.c

int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
						int reg, int len, u32 *val)
{
	if (domain == 0 && reg < 256 && raw_pci_ops)
		return raw_pci_ops->read(domain, bus, devfn, reg, len, val);
	if (raw_pci_ext_ops)
		return raw_pci_ext_ops->read(domain, bus, devfn, reg, len, val);
	return -EINVAL;
}
[...]
static int pci_read(struct pci_bus *bus, unsigned int devfn, int where, 
int size, u32 *value)
{
	return raw_pci_read(pci_domain_nr(bus), bus->number,
				 devfn, where, size, value);
}
[...]
struct pci_ops pci_root_ops = {
	.read = pci_read,
	.write = pci_write,
};

Currently, the above code may call lots of different accessors (not 
necessarily generic accessor friendly :), moreover it possible that x86 
may have registered two accessor sets (raw_pci_ops, raw_pci_ext_ops). I 
am happy to fix that but I would need x86 PCI expert to get know if that 
is possible at all.

I really appreciate your help.

Thanks,
Tomasz
