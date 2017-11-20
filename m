Return-Path: <SRS0=ilQs=CS=gmail.com=ckoenig.leichtzumerken@kernel.org>
Return-Path: <SRS0=ilQs=CS=gmail.com=ckoenig.leichtzumerken@kernel.org>
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH v9 4/5] x86/PCI: Enable a 64bit BAR on AMD Family 15h
 (Models 30h-3fh) Processors v5
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>, helgaas@kernel.org,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <20171018135821.3248-1-deathsimple@vodafone.de>
 <20171018135821.3248-5-deathsimple@vodafone.de>
 <c5ca14bc-3812-ff15-7dd0-e862ce85a348@oracle.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d81d50e6-c267-fe43-214f-278e57903448@gmail.com>
Date: Mon, 20 Nov 2017 17:07:19 +0100
MIME-Version: 1.0
In-Reply-To: <c5ca14bc-3812-ff15-7dd0-e862ce85a348@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Am 20.11.2017 um 16:51 schrieb Boris Ostrovsky:
> On 10/18/2017 09:58 AM, Christian König wrote:
>> From: Christian König <christian.koenig@amd.com>
>>
>> Most BIOS don't enable this because of compatibility reasons.
>>
>> Manually enable a 64bit BAR of 64GB size so that we have
>> enough room for PCI devices.
>>
>> v2: style cleanups, increase size, add resource name, set correct flags,
>>      print message that windows was added
>> v3: add defines for all the magic numbers, style cleanups
>> v4: add some comment that the BIOS should actually allow this using
>>      _PRS and _SRS.
>> v5: only enable this if CONFIG_PHYS_ADDR_T_64BIT is set
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> ---
>>   arch/x86/pci/fixup.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 80 insertions(+)
>>
>> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
>> index 11e407489db0..7b6bd76713c5 100644
>> --- a/arch/x86/pci/fixup.c
>> +++ b/arch/x86/pci/fixup.c
>> @@ -618,3 +618,83 @@ static void quirk_apple_mbp_poweroff(struct pci_dev *pdev)
>>   		dev_info(dev, "can't work around MacBook Pro poweroff issue\n");
>>   }
>>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8c10, quirk_apple_mbp_poweroff);
>> +
>> +#ifdef CONFIG_PHYS_ADDR_T_64BIT
>> +
>> +#define AMD_141b_MMIO_BASE(x)	(0x80 + (x) * 0x8)
>> +#define AMD_141b_MMIO_BASE_RE_MASK		BIT(0)
>> +#define AMD_141b_MMIO_BASE_WE_MASK		BIT(1)
>> +#define AMD_141b_MMIO_BASE_MMIOBASE_MASK	GENMASK(31,8)
>> +
>> +#define AMD_141b_MMIO_LIMIT(x)	(0x84 + (x) * 0x8)
>> +#define AMD_141b_MMIO_LIMIT_MMIOLIMIT_MASK	GENMASK(31,8)
>> +
>> +#define AMD_141b_MMIO_HIGH(x)	(0x180 + (x) * 0x4)
>> +#define AMD_141b_MMIO_HIGH_MMIOBASE_MASK	GENMASK(7,0)
>> +#define AMD_141b_MMIO_HIGH_MMIOLIMIT_SHIFT	16
>> +#define AMD_141b_MMIO_HIGH_MMIOLIMIT_MASK	GENMASK(23,16)
>> +
>> +/*
>> + * The PCI Firmware Spec, rev 3.2 notes that ACPI should optionally allow
>> + * configuring host bridge windows using the _PRS and _SRS methods.
>> + *
>> + * But this is rarely implemented, so we manually enable a large 64bit BAR for
>> + * PCIe device on AMD Family 15h (Models 30h-3fh) Processors here.
>> + */
>> +static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
>> +{
>> +	struct resource *res, *conflict;
>> +	u32 base, limit, high;
>> +	unsigned i;
>> +
>> +	for (i = 0; i < 8; ++i) {
>> +		pci_read_config_dword(dev, AMD_141b_MMIO_BASE(i), &base);
>> +		pci_read_config_dword(dev, AMD_141b_MMIO_HIGH(i), &high);
>> +
>> +		/* Is this slot free? */
>> +		if (!(base & (AMD_141b_MMIO_BASE_RE_MASK |
>> +			      AMD_141b_MMIO_BASE_WE_MASK)))
>> +			break;
>> +
>> +		base >>= 8;
>> +		base |= high << 24;
>> +
>> +		/* Abort if a slot already configures a 64bit BAR. */
>> +		if (base > 0x10000)
>> +			return;
>> +	}
>> +	if (i == 8)
>> +		return;
>> +
>> +	res = kzalloc(sizeof(*res), GFP_KERNEL);
>> +	if (!res)
>> +		return;
>> +
>> +	res->name = "PCI Bus 0000:00";
>> +	res->flags = IORESOURCE_PREFETCH | IORESOURCE_MEM |
>> +		IORESOURCE_MEM_64 | IORESOURCE_WINDOW;
>> +	res->start = 0x100000000ull;
>> +	res->end = 0xfd00000000ull - 1;
>> +
>> +	/* Just grab the free area behind system memory for this */
>> +	while ((conflict = request_resource_conflict(&iomem_resource, res)))
>> +		res->start = conflict->end + 1;
>
> I get stuck in the infinite loop here.
>
> Presumably because on a multi-socket system we succeed for the first
> processor (0000:00:18.1) and add 'res' to iomem_resource. For
> 0000:00:19.1 we find the slot in the 'for' loop above but then we fail
> to find a place to add 'res'. And with final sibling being [0 - max
> possible addr] we are stuck here.
>
> A possible solution to get out of the loop could be
>      if (conflict->end >= res->end) {
>                              kfree(res);
>                              return;
>     }

Ah, sorry for that. Yes problem is obvious now.

> but I don't know whether this is what we actually want.

Actually we would probably want to add the range to all cores at the 
same time.

>
> This is a 2-socket
>
> vendor_id    : AuthenticAMD
> cpu family    : 21
> model        : 1
> model name    : AMD Opteron(TM) Processor 6272
> stepping    : 2
>
>
> (and then it breaks differently as a Xen guest --- we hung on the last
> pci_read_config_dword(), I haven't looked at this at all yet)

Hui? How does this fix applies to a Xen guest in the first place?

Please provide the output of "lspci -nn" and explain further what is 
your config with Xen.

Regards,
Christian.


>
>
>
> -boris
>
>
>> +
>> +	dev_info(&dev->dev, "adding root bus resource %pR\n", res);
>> +
>> +	base = ((res->start >> 8) & AMD_141b_MMIO_BASE_MMIOBASE_MASK) |
>> +		AMD_141b_MMIO_BASE_RE_MASK | AMD_141b_MMIO_BASE_WE_MASK;
>> +	limit = ((res->end + 1) >> 8) & AMD_141b_MMIO_LIMIT_MMIOLIMIT_MASK;
>> +	high = ((res->start >> 40) & AMD_141b_MMIO_HIGH_MMIOBASE_MASK) |
>> +		((((res->end + 1) >> 40) << AMD_141b_MMIO_HIGH_MMIOLIMIT_SHIFT)
>> +		 & AMD_141b_MMIO_HIGH_MMIOLIMIT_MASK);
>> +
>> +	pci_write_config_dword(dev, AMD_141b_MMIO_HIGH(i), high);
>> +	pci_write_config_dword(dev, AMD_141b_MMIO_LIMIT(i), limit);
>> +	pci_write_config_dword(dev, AMD_141b_MMIO_BASE(i), base);
>> +
>> +	pci_bus_add_resource(dev->bus, res, 0);
>> +}
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x141b, pci_amd_enable_64bit_bar);
>> +
>> +#endif
