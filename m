Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <550197B1.8000405@linaro.org>
Date: Thu, 12 Mar 2015 14:42:09 +0100
From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
MIME-Version: 1.0
To: Rob Herring <robherring2@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Al Stone <al.stone@linaro.org>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 7/9] x86, pci, ecam: mmconfig_64.c becomes default
 implementation for ECAM driver.
References: <1426083169-8698-1-git-send-email-tomasz.nowicki@linaro.org> <1426083169-8698-8-git-send-email-tomasz.nowicki@linaro.org> <CAL_JsqJfvOcQ9sSuKfq3YCWubL9QctEDU0CR2mjBze2ZyB+nVg@mail.gmail.com>
In-Reply-To: <CAL_JsqJfvOcQ9sSuKfq3YCWubL9QctEDU0CR2mjBze2ZyB+nVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11.03.2015 16:37, Rob Herring wrote:
> On Wed, Mar 11, 2015 at 9:12 AM, Tomasz Nowicki
> <tomasz.nowicki@linaro.org> wrote:
>> Architectures which want to take advantage of ECAM generic goodness
>
> This is not necessarily an architecture decision. It is likely per host.
Right, good point.

>
>> should select CONFIG_PCI_ECAM_GENERIC. Otherwise, like x86 32bits machines,
>> are obligated to provide own low-level ECAM calls.
>>
>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>> ---
>
> [...]
>
>> diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
>> index c588234..796b6e7 100644
>> --- a/drivers/pci/ecam.c
>> +++ b/drivers/pci/ecam.c
>> @@ -23,6 +23,119 @@ static DEFINE_MUTEX(pci_mmcfg_lock);
>>
>>   LIST_HEAD(pci_mmcfg_list);
>>
>> +#ifdef CONFIG_GENERIC_PCI_ECAM
>> +static char __iomem *pci_dev_base(unsigned int seg, unsigned int bus,
>> +                                 unsigned int devfn)
>> +{
>> +       struct pci_mmcfg_region *cfg = pci_mmconfig_lookup(seg, bus);
>> +
>> +       if (cfg && cfg->virt)
>> +               return cfg->virt + (PCI_MMCFG_BUS_OFFSET(bus) | (devfn << 12));
>> +       return NULL;
>> +}
>> +
>> +int pci_mmcfg_read(unsigned int seg, unsigned int bus,
>> +                         unsigned int devfn, int reg, int len, u32 *value)
>> +{
>> +       char __iomem *addr;
>> +
>> +       /* Why do we have this when nobody checks it. How about a BUG()!? -AK */
>> +       if (unlikely((bus > 255) || (devfn > 255) || (reg > 4095))) {
>> +err:           *value = -1;
>> +               return -EINVAL;
>> +       }
>> +
>> +       rcu_read_lock();
>
> What is the purpose of the rcu lock other than the old implementation had it?

Read/write calls consist on lookup RCU list (with MMCONFIG regions) and 
then corresponding operation. It is possible to hotplug another pci root 
bridge which leads to RCU list modification.

>
>> +       addr = pci_dev_base(seg, bus, devfn);
>
> The .map_bus op provides the same function if you restructure to use
> the generic accessors.

As you noticed, pci_mmcfg_{read,write} and 
pci_generic_config_{read,write} prototypes are different.

int pci_mmcfg_read(unsigned int seg, unsigned int bus,
                    unsigned int devfn, int reg, int len, u32 *value);
vs
int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
                             int where, int size, u32 *val);

This is because pci_mmcfg_{read,write} can be used before pci root 
bridge initialization (while we have no struct pci_bus *bus) inside of 
ACPICA code (osl.c --> acpi_os_read_pci_configuration())

For that reason, I decide to create ECAM related new accessors which do 
not depend on host bridge presence. In other words, 
pci_generic_config_{read,write} can be built on pci_mmcfg_{read,write} 
but not the other way around.

In the light of above, I could not used .map_bus. I might not see a 
nicer way to solve that so any opinion/suggestion very appreciated :)

>
>> +       if (!addr) {
>> +               rcu_read_unlock();
>> +               goto err;
>> +       }
>> +
>> +       *value = pci_mmio_read(len, addr + reg);
>> +       rcu_read_unlock();
>> +
>> +       return 0;
>> +}
>> +
>> +int pci_mmcfg_write(unsigned int seg, unsigned int bus,
>> +                          unsigned int devfn, int reg, int len, u32 value)
>> +{
>> +       char __iomem *addr;
>> +
>> +       /* Why do we have this when nobody checks it. How about a BUG()!? -AK */
>> +       if (unlikely((bus > 255) || (devfn > 255) || (reg > 4095)))
>> +               return -EINVAL;
>> +
>> +       rcu_read_lock();
>> +       addr = pci_dev_base(seg, bus, devfn);
>> +       if (!addr) {
>> +               rcu_read_unlock();
>> +               return -EINVAL;
>> +       }
>> +
>> +       pci_mmio_write(len, addr + reg, value);
>> +       rcu_read_unlock();
>> +
>> +       return 0;
>> +}
>> +
>> +static void __iomem *mcfg_ioremap(struct pci_mmcfg_region *cfg)
>> +{
>> +       void __iomem *addr;
>> +       u64 start, size;
>> +       int num_buses;
>> +
>> +       start = cfg->address + PCI_MMCFG_BUS_OFFSET(cfg->start_bus);
>> +       num_buses = cfg->end_bus - cfg->start_bus + 1;
>> +       size = PCI_MMCFG_BUS_OFFSET(num_buses);
>> +       addr = ioremap_nocache(start, size);
>> +       if (addr)
>> +               addr -= PCI_MMCFG_BUS_OFFSET(cfg->start_bus);
>> +       return addr;
>> +}
>> +
>> +int __init pci_mmcfg_arch_init(void)
>
> Where would this be called for the case of the generic host and using DT?
>
I focused on sharing the code in ACPI context and did not consider DT. I 
think we can improve that code as next steps.

Tomasz
