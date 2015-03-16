Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5506EAD9.1070900@linaro.org>
Date: Mon, 16 Mar 2015 15:38:17 +0100
From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
MIME-Version: 1.0
To: Mark Salter <msalter@redhat.com>
CC: bhelgaas@google.com, wangyijing@huawei.com, arnd@arndb.de,
	hanjun.guo@linaro.org, Liviu.Dudau@arm.com, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net,
	al.stone@linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linaro-acpi@lists.linaro.org
Subject: Re: [PATCH v3 4/9] x86, pci, acpi: Move arch-agnostic MMCONFIG (aka
 ECAM) and ACPI code out of arch/x86/ directory
References: <1425987320-15020-1-git-send-email-tomasz.nowicki@linaro.org>	 <1425987320-15020-5-git-send-email-tomasz.nowicki@linaro.org> <1426264500.20110.22.camel@deneb.redhat.com>
In-Reply-To: <1426264500.20110.22.camel@deneb.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 13.03.2015 17:35, Mark Salter wrote:
> On Tue, 2015-03-10 at 12:35 +0100, Tomasz Nowicki wrote:
>> ECAM standard and MCFG table are architecture independent and it makes
>> sense to share common code across all architectures. Both are going to
>> corresponding files - ecam.c and mcfg.c
>>
>> While we are here, rename pci_parse_mcfg to acpi_parse_mcfg.
>> We already have acpi_parse_mcfg prototype which is used nowhere.
>> At the same time, we need pci_parse_mcfg been global so acpi_parse_mcfg
>> can be used perfectly here.
>>
>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>> ---
>>   arch/x86/Kconfig               |   2 +
>>   arch/x86/include/asm/pci_x86.h |  33 -----
>>   arch/x86/pci/acpi.c            |   1 +
>>   arch/x86/pci/mmconfig-shared.c | 296 +----------------------------------------
>>   arch/x86/pci/mmconfig_32.c     |   1 +
>>   arch/x86/pci/mmconfig_64.c     |   1 +
>>   arch/x86/pci/numachip.c        |   1 +
>>   drivers/acpi/Makefile          |   1 +
>>   drivers/acpi/mcfg.c            |  81 +++++++++++
>>   drivers/pci/Kconfig            |   4 +
>>   drivers/pci/Makefile           |   5 +
>>   drivers/pci/ecam.c             | 243 +++++++++++++++++++++++++++++++++
>>   include/linux/ecam.h           |  51 +++++++
>>   13 files changed, 394 insertions(+), 326 deletions(-)
>>   create mode 100644 drivers/acpi/mcfg.c
>>   create mode 100644 drivers/pci/ecam.c
>>   create mode 100644 include/linux/ecam.h
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index c2fb8a8..dd926f4 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2276,6 +2276,7 @@ config PCI_DIRECT
>>
>>   config PCI_MMCONFIG
>>   	def_bool y
>> +	select PCI_ECAM
>>   	depends on X86_32 && PCI && (ACPI || SFI) && (PCI_GOMMCONFIG || PCI_GOANY)
>>
>>   config PCI_OLPC
>> @@ -2293,6 +2294,7 @@ config PCI_DOMAINS
>>
>>   config PCI_MMCONFIG
>>   	bool "Support mmconfig PCI config space access"
>> +	select PCI_ECAM
>>   	depends on X86_64 && PCI && ACPI
>>
>>   config PCI_CNB20LE_QUIRK
>> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
>> index c57c225..e8a237f 100644
>> --- a/arch/x86/include/asm/pci_x86.h
>> +++ b/arch/x86/include/asm/pci_x86.h
>> @@ -122,41 +122,8 @@ extern int pci_legacy_init(void);
>>   extern void pcibios_fixup_irqs(void);
>>
>>   /* pci-mmconfig.c */
>> -
>> -/* "PCI MMCONFIG %04x [bus %02x-%02x]" */
>> -#define PCI_MMCFG_RESOURCE_NAME_LEN (22 + 4 + 2 + 2)
>> -
>> -struct pci_mmcfg_region {
>> -	struct list_head list;
>> -	struct resource res;
>> -	u64 address;
>> -	char __iomem *virt;
>> -	u16 segment;
>> -	u8 start_bus;
>> -	u8 end_bus;
>> -	char name[PCI_MMCFG_RESOURCE_NAME_LEN];
>> -};
>> -
>> -struct pci_mmcfg_mmio_ops {
>> -	u32 (*read)(int len, void __iomem *addr);
>> -	void (*write)(int len, void __iomem *addr, u32 value);
>> -};
>> -
>> -extern int __init pci_mmcfg_arch_init(void);
>> -extern void __init pci_mmcfg_arch_free(void);
>> -extern int pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg);
>> -extern void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg);
>>   extern int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
>>   			       phys_addr_t addr);
>> -extern int pci_mmconfig_delete(u16 seg, u8 start, u8 end);
>> -extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
>> -extern u32 pci_mmio_read(int len, void __iomem *addr);
>> -extern void pci_mmio_write(int len, void __iomem *addr, u32 value);
>> -extern void pci_mmconfig_register_mmio(struct pci_mmcfg_mmio_ops *ops);
>> -
>> -extern struct list_head pci_mmcfg_list;
>> -
>> -#define PCI_MMCFG_BUS_OFFSET(bus)      ((bus) << 20)
>>
>>   /*
>>    * AMD Fam10h CPUs are buggy, and cannot access MMIO config space
>> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
>> index 6ac2738..5dfccef 100644
>> --- a/arch/x86/pci/acpi.c
>> +++ b/arch/x86/pci/acpi.c
>> @@ -4,6 +4,7 @@
>>   #include <linux/irq.h>
>>   #include <linux/dmi.h>
>>   #include <linux/slab.h>
>> +#include <linux/ecam.h>
>>   #include <asm/numa.h>
>>   #include <asm/pci_x86.h>
>>
>> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
>> index 685cd4c..5064302 100644
>> --- a/arch/x86/pci/mmconfig-shared.c
>> +++ b/arch/x86/pci/mmconfig-shared.c
>> @@ -18,6 +18,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/mutex.h>
>>   #include <linux/rculist.h>
>> +#include <linux/ecam.h>
>>   #include <asm/e820.h>
>>   #include <asm/pci_x86.h>
>>   #include <asm/acpi.h>
>> @@ -27,52 +28,6 @@
>>   /* Indicate if the mmcfg resources have been placed into the resource table. */
>>   static bool pci_mmcfg_running_state;
>>   static bool pci_mmcfg_arch_init_failed;
>> -static DEFINE_MUTEX(pci_mmcfg_lock);
>> -
>> -LIST_HEAD(pci_mmcfg_list);
>> -
>> -static u32
>> -pci_mmconfig_generic_read(int len, void __iomem *addr)
>> -{
>> -	u32 data = 0;
>> -
>> -	switch (len) {
>> -	case 1:
>> -		data = readb(addr);
>> -		break;
>> -	case 2:
>> -		data = readw(addr);
>> -		break;
>> -	case 4:
>> -		data = readl(addr);
>> -		break;
>> -	}
>> -
>> -	return data;
>> -}
>> -
>> -static void
>> -pci_mmconfig_generic_write(int len, void __iomem *addr, u32 value)
>> -{
>> -	switch (len) {
>> -	case 1:
>> -		writeb(value, addr);
>> -		break;
>> -	case 2:
>> -		writew(value, addr);
>> -		break;
>> -	case 4:
>> -		writel(value, addr);
>> -		break;
>> -	}
>> -}
>> -
>> -static struct pci_mmcfg_mmio_ops pci_mmcfg_mmio_default = {
>> -	.read = pci_mmconfig_generic_read,
>> -	.write = pci_mmconfig_generic_write,
>> -};
>> -
>> -static struct pci_mmcfg_mmio_ops *pci_mmcfg_mmio = &pci_mmcfg_mmio_default;
>>
>>   static u32
>>   pci_mmconfig_amd_read(int len, void __iomem *addr)
>> @@ -115,128 +70,6 @@ static struct pci_mmcfg_mmio_ops pci_mmcfg_mmio_amd_fam10h = {
>>   	.write = pci_mmconfig_amd_write,
>>   };
>>
>> -void
>> -pci_mmconfig_register_mmio(struct pci_mmcfg_mmio_ops *ops)
>> -{
>> -	pci_mmcfg_mmio = ops;
>> -}
>> -
>> -u32
>> -pci_mmio_read(int len, void __iomem *addr)
>> -{
>> -	if (!pci_mmcfg_mmio) {
>> -		pr_err("PCI config space has no accessors !");
>> -		return 0;
>> -	}
>> -
>> -	return pci_mmcfg_mmio->read(len, addr);
>> -}
>> -
>> -void
>> -pci_mmio_write(int len, void __iomem *addr, u32 value)
>> -{
>> -	if (!pci_mmcfg_mmio) {
>> -		pr_err("PCI config space has no accessors !");
>> -		return;
>> -	}
>> -
>> -	pci_mmcfg_mmio->write(len, addr, value);
>> -}
>> -
>> -static void __init pci_mmconfig_remove(struct pci_mmcfg_region *cfg)
>> -{
>> -	if (cfg->res.parent)
>> -		release_resource(&cfg->res);
>> -	list_del(&cfg->list);
>> -	kfree(cfg);
>> -}
>> -
>> -static void __init free_all_mmcfg(void)
>> -{
>> -	struct pci_mmcfg_region *cfg, *tmp;
>> -
>> -	pci_mmcfg_arch_free();
>> -	list_for_each_entry_safe(cfg, tmp, &pci_mmcfg_list, list)
>> -		pci_mmconfig_remove(cfg);
>> -}
>> -
>> -static void list_add_sorted(struct pci_mmcfg_region *new)
>> -{
>> -	struct pci_mmcfg_region *cfg;
>> -
>> -	/* keep list sorted by segment and starting bus number */
>> -	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list) {
>> -		if (cfg->segment > new->segment ||
>> -		    (cfg->segment == new->segment &&
>> -		     cfg->start_bus >= new->start_bus)) {
>> -			list_add_tail_rcu(&new->list, &cfg->list);
>> -			return;
>> -		}
>> -	}
>> -	list_add_tail_rcu(&new->list, &pci_mmcfg_list);
>> -}
>> -
>> -static struct pci_mmcfg_region *pci_mmconfig_alloc(int segment, int start,
>> -						   int end, u64 addr)
>> -{
>> -	struct pci_mmcfg_region *new;
>> -	struct resource *res;
>> -
>> -	if (addr == 0)
>> -		return NULL;
>> -
>> -	new = kzalloc(sizeof(*new), GFP_KERNEL);
>> -	if (!new)
>> -		return NULL;
>> -
>> -	new->address = addr;
>> -	new->segment = segment;
>> -	new->start_bus = start;
>> -	new->end_bus = end;
>> -
>> -	res = &new->res;
>> -	res->start = addr + PCI_MMCFG_BUS_OFFSET(start);
>> -	res->end = addr + PCI_MMCFG_BUS_OFFSET(end + 1) - 1;
>> -	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
>> -	snprintf(new->name, PCI_MMCFG_RESOURCE_NAME_LEN,
>> -		 "PCI MMCONFIG %04x [bus %02x-%02x]", segment, start, end);
>> -	res->name = new->name;
>> -
>> -	return new;
>> -}
>> -
>> -static struct pci_mmcfg_region *__init pci_mmconfig_add(int segment, int start,
>> -							int end, u64 addr)
>> -{
>> -	struct pci_mmcfg_region *new;
>> -
>> -	new = pci_mmconfig_alloc(segment, start, end, addr);
>> -	if (new) {
>> -		mutex_lock(&pci_mmcfg_lock);
>> -		list_add_sorted(new);
>> -		mutex_unlock(&pci_mmcfg_lock);
>> -
>> -		pr_info(PREFIX
>> -		       "MMCONFIG for domain %04x [bus %02x-%02x] at %pR "
>> -		       "(base %#lx)\n",
>> -		       segment, start, end, &new->res, (unsigned long)addr);
>> -	}
>> -
>> -	return new;
>> -}
>> -
>> -struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus)
>> -{
>> -	struct pci_mmcfg_region *cfg;
>> -
>> -	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list)
>> -		if (cfg->segment == segment &&
>> -		    cfg->start_bus <= bus && bus <= cfg->end_bus)
>> -			return cfg;
>> -
>> -	return NULL;
>> -}
>> -
>>   static const char *__init pci_mmcfg_e7520(void)
>>   {
>>   	u32 win;
>> @@ -657,73 +490,6 @@ static void __init pci_mmcfg_reject_broken(int early)
>>   	}
>>   }
>>
>> -static int __init acpi_mcfg_check_entry(struct acpi_table_mcfg *mcfg,
>> -					struct acpi_mcfg_allocation *cfg)
>> -{
>> -	int year;
>> -
>> -	if (cfg->address < 0xFFFFFFFF)
>> -		return 0;
>> -
>> -	if (!strncmp(mcfg->header.oem_id, "SGI", 3))
>> -		return 0;
>> -
>> -	if (mcfg->header.revision >= 1) {
>> -		if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) &&
>> -		    year >= 2010)
>> -			return 0;
>> -	}
>> -
>> -	pr_err(PREFIX "MCFG region for %04x [bus %02x-%02x] at %#llx "
>> -	       "is above 4GB, ignored\n", cfg->pci_segment,
>> -	       cfg->start_bus_number, cfg->end_bus_number, cfg->address);
>> -	return -EINVAL;
>> -}
>
> This looks very arch-specific. Shouldn't this be only generic checks
> with some hook for architectures to add arch-specific checks?

Yes, you are right it should go to arch specific call. Thanks.

Tomasz
