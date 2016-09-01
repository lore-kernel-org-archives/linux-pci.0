Return-Path: <liudongdong3@huawei.com>
Return-Path: <liudongdong3@huawei.com>
Subject: Re: [RFC PATCH V2 1/3] PCI: hisi: re-architect Hip05/Hip06
 controllers driver to preapare for ACPI
To: Arnd Bergmann <arnd@arndb.de>
References: <1472644094-82731-1-git-send-email-liudongdong3@huawei.com>
 <4925807.5nZM1s8II1@wuerfel> <57C78CE9.3010707@huawei.com>
 <5913196.I3zIbc2qla@wuerfel>
CC: <helgaas@kernel.org>, <rafael@kernel.org>, <Lorenzo.Pieralisi@arm.com>,
        <tn@semihalf.com>, <wangzhou1@hisilicon.com>,
        <pratyush.anand@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jcm@redhat.com>, <gabriele.paoloni@huawei.com>,
        <charles.chenxin@huawei.com>, <hanjun.guo@linaro.org>,
        <linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <57C822C1.9000203@huawei.com>
Date: Thu, 1 Sep 2016 20:44:49 +0800
MIME-Version: 1.0
In-Reply-To: <5913196.I3zIbc2qla@wuerfel>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd

在 2016/9/1 15:41, Arnd Bergmann 写道:
> On Thursday, September 1, 2016 10:05:29 AM CEST Dongdong Liu wrote:
>>
>> 在 2016/8/31 19:45, Arnd Bergmann 写道:
>>> On Wednesday, August 31, 2016 7:48:12 PM CEST Dongdong Liu wrote:
>>>> +
>>>> +/* HipXX PCIe host only supports 32-bit config access */
>>>> +int hisi_pcie_common_cfg_read(void __iomem *reg_base, int where, int size,
>>>> +                             u32 *val)
>>>> +{
>>>> +       u32 reg;
>>>> +       u32 reg_val;
>>>> +       void *walker = &reg_val;
>>>> +
>>>> +       walker += (where & 0x3);
>>>> +       reg = where & ~0x3;
>>>> +       reg_val = readl(reg_base + reg);
>>>> +
>>>> +       if (size == 1)
>>>> +               *val = *(u8 __force *) walker;
>>>> +       else if (size == 2)
>>>> +               *val = *(u16 __force *) walker;
>>>
>>> What is the __force for?
>>
>> Hi Arnd, thanks for replying.
>>
>> __force is used to, well, force a conversion, like casting from or to a bitwise type, else the Sparse checker will throw a warning.
>
> I know what it's for in general, but in this case there is no __bitwise
> or __iomem or any other annotation on either side of the assignment.

Thanks for you point that.

>
>>>
>>>> +       else if (size == 4)
>>>> +               *val = reg_val;
>>>> +       else
>>>> +               return PCIBIOS_BAD_REGISTER_NUMBER;
>>>> +
>>>> +       return PCIBIOS_SUCCESSFUL;
>>>
>>> It looks like you are reimplementing pci_generic_config_read32/pci_generic_config_write32
>>> read here, better use them directly.
>>>
>>
>> For our host bridge, access RC and EP config space are not the same way.
>> Our host bridge is non ECAM only for the RC bus config space;
>> for any other bus underneath the root bus we support ECAM access.
>>
>> hisi_pcie_common_cfg_read is used to read RC config space, only supports 32-bit config access.
>> hisi_pcie_common_cfg_read/hisi_pcie_common_cfg_write may change as below will be better.
>>
>> /* HipXX PCIe host only supports 32-bit config access */
>> int hisi_pcie_common_cfg_read(void __iomem *reg_base, int where, int size,
>> 			      u32 *val)
>> {
>> 	void __iomem *addr;
>>
>> 	addr = reg_base + (where & ~0x3);
>> 	*val = readl(addr);
>>
>> 	if (size <= 2)
>> 		*val = (*val >> (8 * (where & 3))) & ((1 << (size * 8)) - 1);
>>
>> 	return PCIBIOS_SUCCESSFUL;
>> }
>
> My point was: why not call pci_generic_config_read32() when accessing
> the RC config space instead of duplicating the code from it?

I know your point.

1. For our host bridge , ".map_bus = pci_ecam_map_bus" is only suitable for
accessing the EP config space.
pci_generic_config_read32() need to call "addr = bus->ops->map_bus(bus, devfn, where & ~0x3);",

drivers/pci/host/pcie-hisi-acpi.c
static struct pci_ops hisi_pcie_ops = {
	.map_bus = pci_ecam_map_bus,
	.read = hisi_pcie_acpi_rd_conf,
	.write = hisi_pcie_acpi_wr_conf,
};

Yes, we can change ".map_bus = pci_ecam_map_bus" to ".map_bus = hisi_pci_map_bus", and implentment hisi_pci_map_bus as below,
then we will not need to call hisi_pcie_common_cfg_read().

void __iomem *hisi_pci_map_bus(struct pci_bus *bus, unsigned int devfn, int where)
{
	struct pci_config_window *cfg = bus->sysdata;
	void __iomem *reg_base = cfg->priv;

	/* for RC config access*/
	if (bus->number == cfg->busr.start)
		return reg_base + (where & ~0x3);
	else
		/* for EP config access */
		return pci_ecam_map_bus(bus, devfn, where);
}

and hisi_pcie_acpi_rd_conf() need to change as below.
static int hisi_pcie_acpi_rd_conf(struct pci_bus *bus, u32 devfn, int where,
				  int size, u32 *val)
{
	struct pci_config_window *cfg = bus->sysdata;

	if (hisi_pcie_acpi_valid_config(cfg, bus, PCI_SLOT(devfn)) == 0)
		return PCIBIOS_DEVICE_NOT_FOUND;
	
	/* access RC config space */
	if (bus->number == cfg->busr.start)
		return pci_generic_config_read32(bus, devfn, where, size, val);
	
	/* access EP config space */
	return pci_generic_config_read(bus, devfn, where, size, val);
}


2. We need to backward compatible with the old dt way config access as below code,
so we have to call hisi_pcie_common_cfg_read() when accessing the RC config space.
For this, we have to call hisi_pcie_common_cfg_read().

drivers/pci/host/pcie-hisi.c
static inline int hisi_pcie_cfg_read(struct pcie_port *pp, int where,
		int size, u32 *val)
{
	struct hisi_pcie *pcie = to_hisi_pcie(pp);

	return hisi_pcie_common_cfg_read(pcie->reg_base, where, size, val);
}

static struct pcie_host_ops hisi_pcie_host_ops = {
	.rd_own_conf = hisi_pcie_cfg_read,
	.wr_own_conf = hisi_pcie_cfg_write,
	.link_up = hisi_pcie_link_up,
};

Thanks
Dongdong
>
> 	Arnd
>
> .
>
