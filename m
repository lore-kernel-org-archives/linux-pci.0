Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH 05/11] x86, pci, acpi: Move arch-agnostic MMCONFIG (aka
 ECAM) and ACPI code out of arch/x86/ directory
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20150602133215.GC23650@red-moon> <55701A31.808@linaro.org>
 <20150604102253.GA31773@red-moon> <5570447D.3020705@linaro.org>
 <557504A2.3060203@linaro.org> <20150608151443.GA16151@red-moon>
 <55E4340D.6050004@linaro.org> <55ED6010.3020406@linaro.org>
 <20150908150727.GF29293@red-moon> <55F0388B.1090607@linaro.org>
 <20150911112018.GA13033@red-moon>
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
Message-ID: <55F2CA98.7050905@linaro.org>
Date: Fri, 11 Sep 2015 14:35:36 +0200
MIME-Version: 1.0
In-Reply-To: <20150911112018.GA13033@red-moon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11.09.2015 13:20, Lorenzo Pieralisi wrote:
> On Wed, Sep 09, 2015 at 02:47:55PM +0100, Tomasz Nowicki wrote:
>
> [...]
>
>>> I think (but I am happy to be corrected) that the map_bus() hook
>>> (ie that's why struct pci_bus is required in eg pci_generic_config_write)
>>> is there to ensure that when the generic accessors are called
>>> a) we have a valid bus b) the host controllers implementing it
>>> has been initialized.
>>>
>>> I had another look and I noticed you are trying to solve multiple
>>> things at once:
>>>
>>> 1) ACPICA seems to need PCI config space on bus 0 to be working
>>>      before PCI enumerates (ie before we have a root bus), we need to
>>>      countercheck on that, but you can't use the generic PCI accessors
>>>      for that reasons (ie root bus might not be available, you do not
>>>      have a pci_bus struct)
>>> 2) the raw_pci_read/write require _generic_ mmio back-ends, since AMD
>>>      can't cope with standard x86 read/write{b,w,l}
>>>
>>> Overall, it seems to me that we can avoid code duplication by
>>> shuffling your code a bit.
>>>
>>> You could modify the generic accessors in drivers/pci/access.c to
>>> use your mmio back-end instead of using plain read/write{b,w,l}
>>> functions (we should check if RobH is ok with that there can be
>>> reasons that prevent this from happening). This would solve the
>>> AMD mmio issue.
>>>
>>> By factoring out the code that actually carries out the reads
>>> and writes in the accessors basically you decouple the functions
>>> requiring the struct pci_bus from the ones that does not require it
>>> (ie raw_pci_{read/write}.
>>>
>>> The generic MMIO layer belongs in the drivers/pci/access.c file, it has
>>> nothing to do with ECAM.
>>>
>>> The mmcfg interface should probably live in pci-acpi.c, I do not think
>>> you need an extra file in there but that's a detail.
>>>
>>> Basically the generic accessors would become something like eg:
>>>
>>> int pci_generic_config_write(struct pci_bus *bus, unsigned int devfn,
>>>                             int where, int size, u32 val)
>>> {
>>>        void __iomem *addr;
>>>
>>>        addr = bus->ops->map_bus(bus, devfn, where);
>>>        if (!addr)
>>>                return PCIBIOS_DEVICE_NOT_FOUND;
>>>
>>>        pci_mmio_write(size, addr + where, value);
>>>
>>>        return PCIBIOS_SUCCESSFUL;
>>> }
>>>
>>> With that in place using raw_pci_write/read or the generic accessors
>>> becomes almost identical, with code requiring the pci_bus to be
>>> created using the generic accessors and ACPICA using the raw version.
>>>
>>> I might be missing something, so apologies if that's the case.
>>>
>>
>> Actually, I think you showed me the right direction :) Here are some
>> conclusions/comments/concerns. Please correct me if I am wrong:
>>
>> 1. We need raw_pci_write/read accessors (based on ECAM) for ARM64 too
>> but only up to the point where buses are enumerated. From that point on,
>> we should reuse generic accessors from access.c file, right?
>
> Well, I still have not figured out whether on arm64 the raw accessors
> required by ACPICA make sense.
>
> So either arm64 relies on the generic MCFG based raw read and writes
> or we define the global raw read and writes as empty (ie x86 overrides
> them anyway).
>
> I will get back to you on this.
>
>> 2. For ARM64 ACPI PCI, we can use generic accessors right away, .map_bus
>> would call common code part (pci_dev_base()). The only thing that worry
>> me is fact that MCFG regions are RCU list so it needs rcu_read_lock()
>> for the .map_bus (mcfg lookup) *and* read/write operation.
>
> Do you mean the address look-up and the mmio operation should be carried
> out atomically right ?
Yes.

  I have to review the MCFG descriptor locking anyway
> to check if and when there is a problem here.
>
>> 3. Changing generic accessors to introduce generic MMIO layer (because
>> of AMD issue) like this:
>> int pci_generic_config_write(struct pci_bus *bus, unsigned int devfn,
>>                               int where, int size, u32 val)
>> {
>>          void __iomem *addr;
>>
>>          addr = bus->ops->map_bus(bus, devfn, where);
>>          if (!addr)
>>                  return PCIBIOS_DEVICE_NOT_FOUND;
>>
>>          pci_mmio_write(size, addr + where, val);
>>
>>          return PCIBIOS_SUCCESSFUL;
>> }
>> would imply using those accessors for x86 ACPI PCI host bridge driver,
>> see arch/x86/pci/common.c
>>
>> int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
>>                                                  int reg, int len, u32 *val)
>> {
>>          if (domain == 0 && reg < 256 && raw_pci_ops)
>>                  return raw_pci_ops->read(domain, bus, devfn, reg, len, val);
>>          if (raw_pci_ext_ops)
>>                  return raw_pci_ext_ops->read(domain, bus, devfn, reg, len, val);
>>          return -EINVAL;
>> }
>> [...]
>> static int pci_read(struct pci_bus *bus, unsigned int devfn, int where,
>> int size, u32 *value)
>> {
>>          return raw_pci_read(pci_domain_nr(bus), bus->number,
>>                                   devfn, where, size, value);
>> }
>> [...]
>> struct pci_ops pci_root_ops = {
>>          .read = pci_read,
>>          .write = pci_write,
>> };
>>
>> Currently, the above code may call lots of different accessors (not
>> necessarily generic accessor friendly :), moreover it possible that x86
>> may have registered two accessor sets (raw_pci_ops, raw_pci_ext_ops). I
>> am happy to fix that but I would need x86 PCI expert to get know if that
>> is possible at all.
>
> Well, we can let x86 code use the same pci_ops as they are using
> today without bothering converting it to generic accessors.
>
> Honestly, even the AMD requirement for special MMIO back-end could
> be left in x86 code, which would simplify your task even more (it
> would leave more x86 churn but that's not my call).
AMD special MMIO back-end was my optional goal and wanted to kill two 
birds with one stone :) I will drop this in next version and focus on 
main aspect of these patches.

Regards,
Tomasz
