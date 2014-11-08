Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:54398 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752407AbaKHV1C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 8 Nov 2014 16:27:02 -0500
Message-ID: <545E8AA2.6050301@hauke-m.de>
Date: Sat, 08 Nov 2014 22:26:58 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
CC: linux-pci@vger.kernel.org, zajec5@gmail.com, florian@openwrt.org
Subject: Re: [RFC] PCI: BCM5301X: add PCIe2 driver for BCM5301X SoCs
References: <1415470392-28229-1-git-send-email-hauke@hauke-m.de> <1756974.RYWuW6FYtL@wuerfel>
In-Reply-To: <1756974.RYWuW6FYtL@wuerfel>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/08/2014 08:47 PM, Arnd Bergmann wrote:
> On Saturday 08 November 2014 19:13:12 Hauke Mehrtens wrote:
> 
>> diff --git a/drivers/pci/host/pci-host-bcm5301x.c b/drivers/pci/host/pci-host-bcm5301x.c
>> new file mode 100644
>> index 0000000..8b7ba62
>> --- /dev/null
>> +++ b/drivers/pci/host/pci-host-bcm5301x.c
>> @@ -0,0 +1,483 @@
>> +/*
>> + * Northstar PCI-Express driver
>> + * Only supports Root-Complex (RC) mode
>> + *
>> + * Notes:
>> + * PCI Domains are being used to identify the PCIe port 1:1.
>> + *
>> + * Only MEM access is supported, PAX does not support IO.
> 
> What is PAX?

This is the name of the PCIe controller I think, This was copied from
the vendor driver, I hope Florian knows more details.

>> +static int bcma_pcie2_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
>> +{
>> +	struct pci_sys_data *sys = pdev->sysdata;
>> +	struct bcma_device *bdev = sys->private_data;
>> +
>> +	/*
>> +	 * Every PCIe controller has 5 IRQ number and the last one is
>> +	 * triggered every time, use that one
>> +	 */
>> +	if (bdev && bdev->dev.of_node)
>> +		return irq_of_parse_and_map(bdev->dev.of_node, 4);
>> +
>> +	return bdev->irq;
>> +}
> 
> If you have an OF device node for the PCI host, you don't need this,
> there should already be an interrupt-map property that correctly
> maps this into the interrupt domain of the bcma bus, so you can use
> the default of_irq_parse_and_map_pci function.

So I just have to define a interrupt-map property for the device this
driver gets registered for and then I can use the default implementation?

>> +static u32 bcma_pcie2_cfg_base(struct bcma_device *bdev, int busno,
>> +			       unsigned int devfn, int where)
>> +{
>> +	int slot = PCI_SLOT(devfn);
>> +	int fn = PCI_FUNC(devfn);
>> +	u32 addr_reg;
>> +
>> +	if (busno == 0) {
>> +		if (slot >= 1)
>> +			return 0;
>> +		bcma_write32(bdev, BCMA_CORE_PCIE2_CONFIGINDADDR,
>> +			     where & 0xffc);
>> +		return BCMA_CORE_PCIE2_CONFIGINDDATA;
>> +	}
>> +	if (fn > 1)
>> +		return 0;
>> +	addr_reg = (busno & 0xff) << 20 | (slot << 15) | (fn << 12) |
>> +		   (where & 0xffc) | (1 & 0x3);
>> +
>> +	bcma_write32(bdev, BCMA_CORE_PCIE2_CFG_ADDR, addr_reg);
>> +	return BCMA_CORE_PCIE2_CFG_DATA;
>> +}
> 
> The normal buses seem to be ECAM compliant, I wonder if we can have the
> code to access those shared between this driver, pci-host-generic.c and
> the ACPI PCI implementation.

There are just a few lines we can share I do not think that would be
worth the effort.

> The root bus is unfortunately not compliant, which for some reason
> is common on a lot of controllers.
> 
>> +static u32 bcma_pcie2_read_config(struct bcma_device *bdev, int busno,
>> +				  unsigned int devfn, int where, int size)
>> +{
>> +	u32 base;
>> +	u32 data_reg;
>> +	u32 mask;
>> +	int shift;
>> +
>> +	base = bcma_pcie2_cfg_base(bdev, busno, devfn, where);
>> +
>> +	if (!base)
>> +		return ~0UL;
>> +
>> +	data_reg = bcma_read32(bdev, base);
>> +
>> +	/* NS: CLASS field is R/O, and set to wrong 0x200 value */
>> +	if (busno == 0 && devfn == 0) {
>> +		/*
>> +		 * RC's class is 0x0280, but Linux PCI driver needs 0x604
>> +		 * for a PCIe bridge. So we must fixup the class code
>> +		 * to 0x604 here.
>> +		 */
>> +		if ((where & 0xffc) == PCI_CLASS_REVISION) {
>> +			data_reg &= 0xff;
>> +			data_reg |= 0x604 << 16;
>> +		}
>> +	}
>> +	/* HEADER_TYPE=00 indicates the port in EP mode */
>> +
>> +	if (size == 4)
>> +		return data_reg;
>> +
>> +	mask = (1 << (size * 8)) - 1;
>> +	shift = (where % 4) * 8;
>> +	return (data_reg >> shift) & mask;
>> +}
> 
> Interesting. 0x0280 is PCI_CLASS_NETWORK_OTHER, I guess this is the
> same PCI core that is used on broadcom network adapters in endpoint
> mode, and when someone tweaked the core to do root complex mode,
> they forgot to fix this.

They did this with the old PCIe controller used on MIPS based SoCs,
there it was even the same core and one could only identify if it is
running in root complex mode with some strange register read and
checking the exception. In this generation they agve the core a
different number than the PCI client core used on wifi cards.

> Which code depends on this? I think I've seem something similar in
> other host drivers, so maybe we can change the core code instead.

It is used in many places in the core PCI code, I think it is better to
change this to the correct value, but the pci-tegra.c driver does it in
a better way, by adding a DECLARE_PCI_FIXUP_EARLY only changing the
struct data, I will use that version.

>> +
>> +static u8 bcma_pcie2_read_config8(struct bcma_device *bdev, int busno,
>> +				  unsigned int devfn, int where)
>> +{
>> +	return bcma_pcie2_read_config(bdev, busno, devfn, where, 1);
>> +}
>> +
>> +static u16 bcma_pcie2_read_config16(struct bcma_device *bdev, int busno,
>> +				    unsigned int devfn, int where)
>> +{
>> +	return bcma_pcie2_read_config(bdev, busno, devfn, where, 2);
>> +}
>> +
>> +static u32 bcma_pcie2_read_config32(struct bcma_device *bdev, int busno,
>> +				    unsigned int devfn, int where)
>> +{
>> +	return bcma_pcie2_read_config(bdev, busno, devfn, where, 4);
>> +}
> 
> These all seem to be relatively pointless, I'd just open-code the
> bcma_pcie2_read_config call in the calling function.

I will inline them.

>> +
>> +/*
>> + * Initializte the PCIe controller
>> + */
>> +static void bcma_pcie2_hw_init(struct bcma_device *bdev)
>> +{
>> +	u32 tmp32;
>> +	u16 tmp16;
>> +
>> +	/* Change MPS and MRRS to 512 */
>> +	tmp16 = bcma_pcie2_read_config16(bdev, 0, 0, 0x4d4);
>> +	tmp16 &= ~7;
>> +	tmp16 |= 2;
>> +	bcma_pcie2_write_config16(bdev, 0, 0, 0x4d4, tmp16);
>> +
>> +	tmp32 = bcma_pcie2_read_config32(bdev, 0, 0, 0xb4);
>> +	tmp32 &= ~((7 << 12) | (7 << 5));
>> +	tmp32 |= (2 << 12) | (2 << 5);
>> +	bcma_pcie2_write_config32(bdev, 0, 0, 0xb4, tmp32);
>> +
>> +	/*
>> +	 * Turn-on Root-Complex (RC) mode, from reset default of EP
>> +	 * The mode is set by straps, can be overwritten via DMU
>> +	 * register <cru_straps_control> bit 5, "1" means RC
>> +	 */
>> +
>> +	/* Send a downstream reset */
>> +	bcma_write32(bdev, BCMA_CORE_PCIE2_CLK_CONTROL,
>> +		     PCIE2_CLKC_RST_OE | PCIE2_CLKC_RST);
>> +	udelay(250);
>> +	bcma_write32(bdev, BCMA_CORE_PCIE2_CLK_CONTROL, PCIE2_CLKC_RST_OE);
>> +	mdelay(250);
>> +
>> +	/* TBD: take care of PM, check we're on */
>> +}
> 
> Can you turn the two delays into msleep()? Wasting 250ms of CPU time is
> really nasty.

Yes I will do that.

>> +	/*
>> +	 * Inbound address translation setup
>> +	 * Northstar only maps up to 128 MiB inbound, DRAM could be up to 1 GiB.
>> +	 *
>> +	 * For now allow access to entire DRAM, assuming it is less than 128MiB,
>> +	 * otherwise DMA bouncing mechanism may be required.
>> +	 * Also consider DMA mask to limit DMA physical address
>> +	 */
>> +	/* 64-bit LE regs, write low word, high is 0 at reset */
>> +	bcma_write32(bdev, BCMA_CORE_PCIE2_FUNC0_IMAP1, PHYS_OFFSET | 0x1);
>> +	bcma_write32(bdev, BCMA_CORE_PCIE2_IARR1_LOWER,
>> +			   PHYS_OFFSET | ((SZ_128M >> 20) & 0xff));
> 
> Maybe I should bully you into enabling swiotlb on arm32 ;-)

This sounds complicated, I hope I can avoid it. ;-)

> Do you have any machines with more than 128MB of RAM that use this?

Yes, the device I use mostly has 256 MB ram, but I have only activated
the first 128MB because the last time I tried activating the rest caused
some problems and I still had to fix some other stuff. ;-)

> According to wikidevi.com [http://tinyurl.com/pdtw2h4], most machines
> with bcm4708/81/9 have 256MB or 512MB. I think it shouldn't be too hard
> to get swiotlb to work on arm32, given that we already use it on arm64.

Hauke

Hauke
