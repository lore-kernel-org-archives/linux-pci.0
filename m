Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2lp0238.outbound.protection.outlook.com ([207.46.163.238]:41022
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753934AbaFYC4N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 Jun 2014 22:56:13 -0400
Message-ID: <53AA3A3A.2050401@amd.com>
Date: Tue, 24 Jun 2014 21:55:54 -0500
From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>
CC: Marc Zyngier <Marc.Zyngier@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] arm/gic: Add supports for GICv2m MSI(-X)
References: <1403569980-12913-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1403569980-12913-3-git-send-email-suravee.suthikulpanit@amd.com>
 <20140624101111.GD5856@leverpostej>
In-Reply-To: <20140624101111.GD5856@leverpostej>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Mark,

Thank you for all your comments. Please see my reply below. I have 
omitted the minor ones.

On 6/24/2014 5:11 AM, Mark Rutland wrote:
> On Tue, Jun 24, 2014 at 01:33:00AM +0100, suravee.suthikulpanit@amd.com wrote:
>> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> +static int alloc_msi_irq(struct gicv2m_msi_data *data, int nvec, int *irq)
>> +{
>> +       int size = sizeof(unsigned long) * data->bm_sz;
>> +       int next = size, ret, num;
>> +
>> +       spin_lock(&data->msi_cnt_lock);
>> +
>> +       for (num = nvec; num > 0; num--) {
>> +               next = bitmap_find_next_zero_area(data->bm,
>> +                                       size, 0, num, 0);
>> +               if (next < size)
>> +                       break;
>> +       }
>
> If max_spi_cnt is not a multiple of BITS_PER_LONG, this can allocate a
> number greater or equal to max_spi_cnt, but below size. We should never
> allocate max_spi_cnt or above.
>
Thanks for the catch. I also need to clean up this logic for V2.

>> +       spin_unlock(&data->msi_cnt_lock);
>> +
>> +       return ret;
>> +}
>> +
>> +static void free_msi_irq(struct gicv2m_msi_data *data, unsigned int irq)
>> +{
>> +       int pos;
>> +
>> +       spin_lock(&data->msi_cnt_lock);
>> +
>> +       pos = irq - data->spi_start;
>> +       if (pos >= 0 && pos < data->max_spi_cnt)
>
> Should either of these cases ever happen?

This is to check if the irq provided is within the MSI range.

>> +static int gicv2m_setup_msi_irq(struct msi_chip *chip, struct pci_dev *pdev,
>> +                     struct msi_desc *desc)
>> +{
>> +       int avail, irq = 0;
>> +       struct msi_msg msg;
>> +       phys_addr_t addr;
>> +       struct gicv2m_msi_data *data = to_gicv2m_msi_data(chip);
>> +
>> +       if (data == NULL) {
>
> If container_of returns NULL, you have bigger problems.

It was just sanity check. But, if you think this is obvious, I'll remove 
this check then.

>> +int __init gicv2m_msi_init(struct device_node *node,
>> +                          struct gicv2m_msi_data *msi)
>> +{
>> +       unsigned int val;
>> +       const __be32 *msi_be;
>
> Every time I see a __be32* in a DT probe function I weep. There is no
> need to deal with the internal details of the DTB.
>
>> +
>> +       msi_be = of_get_address(node, GIC_OF_MSIV2M_RANGE_INDEX, NULL, NULL);
>> +       if (!msi_be) {
>> +               pr_err("GICv2m failed. Fail to locate MSI base.\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       msi->paddr64 = of_translate_address(node, msi_be);
>> +       msi->base = of_iomap(node, GIC_OF_MSIV2M_RANGE_INDEX);
>
> You can instead use of_address_to_resource to query the address from the
> DTB once, without having to muck about with endianness conversion
> manually. Take a look at what of_iomap does.

Thanks for this suggestion. I was not quite familiar with the "of_" 
interface. I am cleaning up this whole section now.

> I'm surprised we don't have an ioremap_resource given we have a devm_
> variant.
>

>> +
>> +       /*
>> +       * MSI_TYPER:
>> +       *     [31:26] Reserved
>> +       *     [25:16] lowest SPI assigned to MSI
>> +       *     [15:10] Reserved
>> +       *     [9:0]   Numer of SPIs assigned to MSI
>> +       */
>> +       val = __raw_readl(msi->base + MSI_TYPER);
>
> Are you sure you want to use __raw_readl?
>
Probably not.  I am replacing this with ioread32(msi->base + MSI_TYPER).

>> +       if (!val) {
>> +               pr_warn("GICv2m: Failed to read MSI_TYPER register\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       msi->spi_start = (val >> 16) & 0x3ff;
>> +       msi->max_spi_cnt = val & 0x3ff;
>> +
>> +       pr_debug("GICv2m: SPI = %u, cnt = %u\n",
>> +               msi->spi_start, msi->max_spi_cnt);
>> +
>> +       if (msi->spi_start < GIC_V2M_MIN_SPI ||
>> +               msi->max_spi_cnt >= GIC_V2M_MAX_SPI) {
>> +                       pr_err("GICv2m: Init failed\n");
>> +                       return -EINVAL;
>> +       }
>> +
>> +       msi->bm_sz = BITS_TO_LONGS(msi->max_spi_cnt);
>
> So msi->bm_sz is msi->max_spi_cnt in _longs_ (rounded up)...
>
>> +       msi->bm = kzalloc(msi->bm_sz, GFP_KERNEL);
>
> ...yet we allocate that many _bytes_?
>
Sorry, I got a bit confused here. I'll fix this.

>> +
>> +       gic_arch_extn.irq_mask = gicv2m_mask_msi;
>> +       gic_arch_extn.irq_unmask = gicv2m_unmask_msi;
>
> I'll leave others to comment on the validity of this...
>
Marc has commented this part in the other patch.

>> +       void __iomem *base;       /* GICv2m virt address */
>> +       unsigned int spi_start;   /* The SPI number that MSIs start */
>> +       unsigned int max_spi_cnt; /* The number of SPIs for MSIs */
>> +       unsigned long *bm;        /* MSI vector bitmap */
>> +       unsigned long bm_sz;      /* MSI bitmap size */
>
> It's a bit odd in my mind that this is in longs. Why not just use
> max_spi_cnt, which you can trivially use to determine bytes or longs?

That's true. I'm cleaning this up.

>> @@ -246,7 +254,8 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>>                              bool force)
>>   {
>>          void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + (gic_irq(d) & ~3);
>> -       unsigned int cpu, shift = (gic_irq(d) % 4) * 8;
>> +       unsigned int shift = (gic_irq(d) % 4) * 8;
>> +       unsigned int cpu = cpumask_any_and(mask_val, cpu_online_mask);
>
> Unrelated change?

Sorry, this was not supposed to be part of this patch.

Thanks,

Suravee

