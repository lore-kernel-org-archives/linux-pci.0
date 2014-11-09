Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:61223 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbaKIU2f (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 9 Nov 2014 15:28:35 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>, linux-pci@vger.kernel.org,
	zajec5@gmail.com, florian@openwrt.org
Subject: Re: [RFC] PCI: BCM5301X: add PCIe2 driver for BCM5301X SoCs
Date: Sun, 09 Nov 2014 21:27:40 +0100
Message-ID: <11068573.lefhT3BUSj@wuerfel>
In-Reply-To: <545E8AA2.6050301@hauke-m.de>
References: <1415470392-28229-1-git-send-email-hauke@hauke-m.de> <1756974.RYWuW6FYtL@wuerfel> <545E8AA2.6050301@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday 08 November 2014 22:26:58 Hauke Mehrtens wrote:
> On 11/08/2014 08:47 PM, Arnd Bergmann wrote:
> > On Saturday 08 November 2014 19:13:12 Hauke Mehrtens wrote:
> > 
> >> diff --git a/drivers/pci/host/pci-host-bcm5301x.c b/drivers/pci/host/pci-host-bcm5301x.c
> >> new file mode 100644
> >> index 0000000..8b7ba62
> >> --- /dev/null
> >> +++ b/drivers/pci/host/pci-host-bcm5301x.c
> >> @@ -0,0 +1,483 @@
> >> +/*
> >> + * Northstar PCI-Express driver
> >> + * Only supports Root-Complex (RC) mode
> >> + *
> >> + * Notes:
> >> + * PCI Domains are being used to identify the PCIe port 1:1.
> >> + *
> >> + * Only MEM access is supported, PAX does not support IO.
> > 
> > What is PAX?
> 
> This is the name of the PCIe controller I think, This was copied from
> the vendor driver, I hope Florian knows more details.

Just clarify this in the comment.

> >> +static int bcma_pcie2_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
> >> +{
> >> +	struct pci_sys_data *sys = pdev->sysdata;
> >> +	struct bcma_device *bdev = sys->private_data;
> >> +
> >> +	/*
> >> +	 * Every PCIe controller has 5 IRQ number and the last one is
> >> +	 * triggered every time, use that one
> >> +	 */
> >> +	if (bdev && bdev->dev.of_node)
> >> +		return irq_of_parse_and_map(bdev->dev.of_node, 4);
> >> +
> >> +	return bdev->irq;
> >> +}
> > 
> > If you have an OF device node for the PCI host, you don't need this,
> > there should already be an interrupt-map property that correctly
> > maps this into the interrupt domain of the bcma bus, so you can use
> > the default of_irq_parse_and_map_pci function.
> 
> So I just have to define a interrupt-map property for the device this
> driver gets registered for and then I can use the default implementation?

It depends on what you want to cover. For all I know, you normally don't
need a DT entry for this PCI host, as it's covered by the upstream bus.

However adding a DT node would let you do some things that you can't
currently do:

- specify the inbound and outbound windows to configure
- list different interrupts, e.g. if there is a PCIe-to-PCI bridge
  and the device connected to it is routed to a GPIO pin or the
  another input of the main interrupt controller.

> >> +static u32 bcma_pcie2_cfg_base(struct bcma_device *bdev, int busno,
> >> +			       unsigned int devfn, int where)
> >> +{
> >> +	int slot = PCI_SLOT(devfn);
> >> +	int fn = PCI_FUNC(devfn);
> >> +	u32 addr_reg;
> >> +
> >> +	if (busno == 0) {
> >> +		if (slot >= 1)
> >> +			return 0;
> >> +		bcma_write32(bdev, BCMA_CORE_PCIE2_CONFIGINDADDR,
> >> +			     where & 0xffc);
> >> +		return BCMA_CORE_PCIE2_CONFIGINDDATA;
> >> +	}
> >> +	if (fn > 1)
> >> +		return 0;
> >> +	addr_reg = (busno & 0xff) << 20 | (slot << 15) | (fn << 12) |
> >> +		   (where & 0xffc) | (1 & 0x3);
> >> +
> >> +	bcma_write32(bdev, BCMA_CORE_PCIE2_CFG_ADDR, addr_reg);
> >> +	return BCMA_CORE_PCIE2_CFG_DATA;
> >> +}
> > 
> > The normal buses seem to be ECAM compliant, I wonder if we can have the
> > code to access those shared between this driver, pci-host-generic.c and
> > the ACPI PCI implementation.
> 
> There are just a few lines we can share I do not think that would be
> worth the effort.

Well, the idea would be that for the root bus, you use simplified pci_ops
that just do BCMA_CORE_PCIE2_CONFIGINDADDR/DATA, while for the other
buses you use the standard pci ops.

> > Which code depends on this? I think I've seem something similar in
> > other host drivers, so maybe we can change the core code instead.
> 
> It is used in many places in the core PCI code, I think it is better to
> change this to the correct value, but the pci-tegra.c driver does it in
> a better way, by adding a DECLARE_PCI_FIXUP_EARLY only changing the
> struct data, I will use that version.

Yes, sounds good.

> >> +	/*
> >> +	 * Inbound address translation setup
> >> +	 * Northstar only maps up to 128 MiB inbound, DRAM could be up to 1 GiB.
> >> +	 *
> >> +	 * For now allow access to entire DRAM, assuming it is less than 128MiB,
> >> +	 * otherwise DMA bouncing mechanism may be required.
> >> +	 * Also consider DMA mask to limit DMA physical address
> >> +	 */
> >> +	/* 64-bit LE regs, write low word, high is 0 at reset */
> >> +	bcma_write32(bdev, BCMA_CORE_PCIE2_FUNC0_IMAP1, PHYS_OFFSET | 0x1);
> >> +	bcma_write32(bdev, BCMA_CORE_PCIE2_IARR1_LOWER,
> >> +			   PHYS_OFFSET | ((SZ_128M >> 20) & 0xff));
> > 
> > Maybe I should bully you into enabling swiotlb on arm32 ;-)
> 
> This sounds complicated, I hope I can avoid it. ;-)

I'd really hope that it's not that hard. We basically just need a copy of
coherent_swiotlb_dma_ops/noncoherent_swiotlb_dma_ops from arm64 and
use those on bcma devices, with the right dma_mask set.

	Arnd
