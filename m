Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 12/17] sh: Add PCI host bridge driver for SH7751
Date: Mon, 13 Jun 2016 10:38:28 +0200
Message-ID: <3663292.cfJj8naP7U@wuerfel>
In-Reply-To: <1465714475-24111-13-git-send-email-ysato@users.sourceforge.jp>
References: <1465714475-24111-1-git-send-email-ysato@users.sourceforge.jp> <1465714475-24111-13-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sunday, June 12, 2016 3:54:30 PM CEST Yoshinori Sato wrote:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/sh7751-pci.txt
> +		ranges = <0x02000000 0x00000000 0xfd000000 0xfd000000 0x00000000 0x01000000>,
> +		         <0x01000000 0x00000000 0xfe240000 0x00000000 0x00000000 0x00040000>;
> +		reg = <0xfe200000 0x0400>,
> +		      <0x0c000000 0x04000000>,
> +		      <0xff800000 0x0030>;
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0x1800 0 7>;
> +		interrupt-map = <0x0000 0 1 &cpldintc evt2irq(0x2a0) 0
> +		                 0x0000 0 2 &cpldintc evt2irq(0x2c0) 0
> +		                 0x0000 0 3 &cpldintc evt2irq(0x2e0) 0
> +		                 0x0000 0 4 &cpldintc evt2irq(0x300) 0
> +
> +		                 0x0800 0 1 &cpldintc evt2irq(0x2c0) 0
> +		                 0x0800 0 2 &cpldintc evt2irq(0x2e0) 0
> +		                 0x0800 0 3 &cpldintc evt2irq(0x300) 0
> +		                 0x0800 0 4 &cpldintc evt2irq(0x2a0) 0

Is this not the default swizzling? I would guess that you can just
list the interrupt once.

The formatting is slightly inconsistent here, my recommendation is
to always enclose each entry in '< >' so you have a comma-separated
list.

> +
> +#define pcic_writel(val, reg) __raw_writel(val, pci_reg_base + (reg))
> +#define pcic_readl(reg) __raw_readl(pci_reg_base + (reg))

We generally try not to use __raw_*() accessors in drivers, because
they are not portable, lack barriers and atomicity, and don't work
when you change endianess.

> +unsigned long PCIBIOS_MIN_IO;
> +unsigned long PCIBIOS_MIN_MEM;

These should probably be in architecture code, otherwise you cannot
build more than one such driver into the kernel.

> +DEFINE_RAW_SPINLOCK(pci_config_lock);

This seems unnecessary, the config operations are always called
under a spinlock already.

> +static __initconst const struct fixups {
> +	char *compatible;
> +	void (*fixup)(void __iomem *, void __iomem *);
> +} fixup_list[] = {
> +	{
> +		.compatible = "iodata,landisk",
> +		.fixup = landisk_fixup,
> +	},
> +};

Just move the fixup pointer into the existing of match table
as the .data pointer, or add a structure to which .data
points.

> +/*
> + * Functions for accessing PCI configuration space with type 1 accesses
> + */
> +static int sh4_pci_read(struct pci_bus *bus, unsigned int devfn,
> +			   int where, int size, u32 *val)
> +{
> +	struct gen_pci *pci = bus->sysdata;
> +	void __iomem *pci_reg_base;
> +	unsigned long flags;
> +	u32 data;
> +
> +	pci_reg_base = ioremap(pci->cfg.res.start,
> +			       pci->cfg.res.end - pci->cfg.res.start);

You cannot call normally ioremap from pci_read, because it
gets called under a spinlock and ioremap can normally sleep
(that might be architecture specific).

Better map it a probe time, or use fixmap.

> +	/*
> +	 * PCIPDR may only be accessed as 32 bit words,
> +	 * so we must do byte alignment by hand
> +	 */
> +	raw_spin_lock_irqsave(&pci_config_lock, flags);
> +	pcic_writel(CONFIG_CMD(bus, devfn, where), SH4_PCIPAR);
> +	data = pcic_readl(SH4_PCIPDR);
> +	raw_spin_unlock_irqrestore(&pci_config_lock, flags);

This is shorter to express this using a 'map' function
in pci_ops combined with pci_generic_config_read32
and pci_generic_config_write32.

> +/*
> + * Called after each bus is probed, but before its children
> + * are examined.
> + */
> +void pcibios_fixup_bus(struct pci_bus *bus)
> +{
> +}

This doesn't really belong into the driver.

> +/*
> + * We need to avoid collisions with `mirrored' VGA ports
> + * and other strange ISA hardware, so we always want the
> + * addresses to be allocated in the 0x000-0x0ff region
> + * modulo 0x400.
> + */
> +resource_size_t pcibios_align_resource(void *data,
> +				       const struct resource *res,
> +				       resource_size_t size,
> +				       resource_size_t align)
> +{
> +	resource_size_t start = res->start;
> +
> +	return start;
> +}

The comment does not match what the function does, you should
change one or the other. Also move it to the same file as
pcibios_fixup_bus.

> +int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
> +			enum pci_mmap_state mmap_state, int write_combine)
> +{
> +	/*
> +	 * I/O space can be accessed via normal processor loads and stores on
> +	 * this platform but for now we elect not to do this and portable
> +	 * drivers should not do this anyway.
> +	 */
> +
> +	if (mmap_state == pci_mmap_io)
> +		return -EINVAL;
> +
> +	/*
> +	 * Ignore write-combine; for now only return uncached mappings.
> +	 */
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +
> +	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> +			       vma->vm_end - vma->vm_start,
> +			       vma->vm_page_prot);
> +}

Do you actually need HAVE_PCI_MMAP? Maybe you can just unset that
and remove the function here.

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pci_reg_base = ioremap(res->start, res->end - res->start);
> +	if (IS_ERR(pci_reg_base))
> +		return PTR_ERR(pci_reg_base);
> +
> +	wres = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (IS_ERR(wres))
> +		return PTR_ERR(wres);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +	bcr = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(bcr))


You map three distinct memory resources here, but your
binding just describes one as "reg: base address and
length of the PCI controller registers".

If there are multiple register ranges, please list each
one in the binding and document in which order they
are expected, or use named resources and list the required
names.

	Arnd
