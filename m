Return-Path: <liudongdong3@huawei.com>
Return-Path: <liudongdong3@huawei.com>
Subject: Re: [RFC PATCH V2 3/3] PCI/ACPI: hisi: Add ACPI support for HiSilicon
 SoCs Host Controllers
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <1472644094-82731-1-git-send-email-liudongdong3@huawei.com>
 <2194589.LrAdKSkzcT@vostro.rjw.lan> <57C79F3E.4050405@huawei.com>
 <2811400.eXt00oZUV7@vostro.rjw.lan>
CC: <helgaas@kernel.org>, <arnd@arndb.de>, <rafael@kernel.org>,
        <Lorenzo.Pieralisi@arm.com>, <tn@semihalf.com>,
        <wangzhou1@hisilicon.com>, <pratyush.anand@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jcm@redhat.com>,
        <gabriele.paoloni@huawei.com>, <charles.chenxin@huawei.com>,
        <hanjun.guo@linaro.org>, <linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <57C8F6E4.4080104@huawei.com>
Date: Fri, 2 Sep 2016 11:49:56 +0800
MIME-Version: 1.0
In-Reply-To: <2811400.eXt00oZUV7@vostro.rjw.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael

在 2016/9/2 7:38, Rafael J. Wysocki 写道:
> On Thursday, September 01, 2016 11:23:42 AM Dongdong Liu wrote:
>>
>> 在 2016/9/1 6:56, Rafael J. Wysocki 写道:
>>> On Wednesday, August 31, 2016 07:48:14 PM Dongdong Liu wrote:
>>>> Add specific quirks for PCI config space accessors.This involves:
>>>> 1. New initialization call hisi_pcie_acpi_init() to get RC config resource
>>>> with hardcoded range address and setup ecam mapping.
>>>> 2. New entry in common quirk array.
>>>>
>>>> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
>>>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>>>
>>> Well, what exactly is the ACPI support you're adding?  Is it the ECAM part only
>>> or is there anything more to it?
>>>
>>
>> Hi Rafael, thanks for replying.
>>
>> Our host bridge is non ECAM only for the RC bus config space;
>> for any other bus underneath the root bus we support ECAM access.
>>
>> In our case we cannot use the standard MCFG object to pass the RC itself config space addresses.
>> The more discuss information can be found:
>> https://lkml.org/lkml/2016/2/22/1087
>> [...]
>> I have looked into this and in our case we cannot use the
>> standard MCFG object to pass the RC config space addresses.
>>
>> The reason is that in our HW we have the config base addresses of the
>> root complex ports that are less than 0x100000 byte distant one from
>> the other as we only map the first 0x10000 bytes.
>> Now the MCFG acpi framework always fix the MCFG resource size to 0x100000
>> for each bus; therefore if we pass our RC addresses through MCFG we end
>> up with a resource conflict.
>> To give you a practical example we are in a situation where we have:
>>
>> port0: [0x00000000b0080000 - 0x00000000b0080000 + 0x10000]
>> port1: [0x00000000b0090000 - 0x00000000b0090000 + 0x10000]
>> port2: [0x00000000b00A0000 - 0x00000000b00A0000 + 0x10000]
>> port3: [0x00000000b00B0000 - 0x00000000b00B0000 + 0x10000]
>> So if we pass the base addresses through MCFG the resources
>> will overlap as MCFG will consider 0x100000 size for each base
>> address of the root complex (only the RC bus uses that address)
>> So far I do not see many option other than using _DSD to pass
>> these RC config base addresses.
>
> It still is not entirely clear to me what the "ACPI support" is here.
>
> Do you read any configuration information from the ACPI tables or similar?
>
> If so, where is the format of it documented?
>

Since Our host bridge is non ECAM only for the RC bus config space,for any other bus underneath the root bus we support ECAM access,
we need to override these accessors prior to PCI buses enumeration.

As below is MCFG table configuration.
0x22004000000~0x220040fffff (bus 0x40) addresses are wasted, because Our host bridge is non ECAM only for the RC.
We use RC base address(0xb0080000)+offset to access our RC config space.
0x22004100000~0x22007ffffff addresses are used to aceess EP config space (bus 0x41~0x7f).This support ECAM access.

MCFG Table
...
{
       0x22000000000,                                      //Base Address
       0x0001,                                             //Segment Group Number
       0x40,                                               //Start Bus Number
       0x7f,                                               //End Bus Number
       0x00000000,                                         //Reserved
},
...

DSDT Table
//PCIe Root bus
Device (PCI1)
{
	Name (_HID, "PNP0A08") // PCI Express Root Bridge
	Name (_CID, "PNP0A03") // Compatible PCI Root Bridge
	Name(_SEG, 1) // Segment of this Root complex
	Name(_BBN, 0x40) // Base Bus Number
	Name(_CCA, 1)
	Method (_CRS, 0, Serialized) { // Root complex resources
		Name (RBUF, ResourceTemplate () {
			WordBusNumber ( // Bus numbers assigned to this root
				ResourceProducer, MinFixed, MaxFixed, PosDecode,
				0,    // AddressGranularity
				0x40, // AddressMinimum - Minimum Bus Number
				0x7f, // AddressMaximum - Maximum Bus Number
				0,    // AddressTranslation - Set to 0
				0x40  // RangeLength - Number of Busses
			)
			...
			...
		}) // Name(RBUF)
       Return (RBUF)
     } // Method(_CRS)
} // Device(PCI1)


As below hisi_pcie_acpi_rd_conf() is our config read implementation.
static int hisi_pcie_acpi_rd_conf(struct pci_bus *bus, u32 devfn, int where,
				  int size, u32 *val)
{
	struct pci_config_window *cfg = bus->sysdata;
	void __iomem *reg_base = cfg->priv;

	if (hisi_pcie_acpi_valid_config(cfg, bus, PCI_SLOT(devfn)) == 0)
		return PCIBIOS_DEVICE_NOT_FOUND;
	/* Access RC config space */
	if (bus->number == cfg->busr.start)
		return hisi_pcie_common_cfg_read(reg_base, where, size, val);

	/* Access EP config space */
	return pci_generic_config_read(bus, devfn, where, size, val);
}

Thanks
Dongdong
> Thanks,
> Rafael
>
>
> .
>
