Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] PCI: add driver for Cortina Gemini Host Bridge
Date: Wed, 01 Feb 2017 12:11:57 +0100
Message-ID: <2695922.yyinjvNuJK@wuerfel>
In-Reply-To: <20170128204839.18330-2-linus.walleij@linaro.org>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
 <20170128204839.18330-2-linus.walleij@linaro.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: openwrt-devel@openwrt.org, Florian Fainelli <f.fainelli@gmail.com>,
 Paulius Zaleckas <paulius.zaleckas@gmail.com>, linux-pci@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Janos Laube <janos.dev@gmail.com>, Hans Ulli Kroll <ulli.kroll@googlemail.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday, January 28, 2017 9:48:37 PM CET Linus Walleij wrote:
> +static int gemini_pci_read_config(struct pci_bus *bus, unsigned int fn,
> +				  int config, int size, u32 *value)
> +{
> +	struct gemini_pci *p = bus->sysdata;
> +	unsigned long irq_flags;
> +
> +	spin_lock_irqsave(&p->lock, irq_flags);
> +
> +	writel(PCI_CONF_BUS(bus->number) |
> +			PCI_CONF_DEVICE(PCI_SLOT(fn)) |
> +			PCI_CONF_FUNCTION(PCI_FUNC(fn)) |
> +			PCI_CONF_WHERE(config) |
> +			PCI_CONF_ENABLE,
> +			p->base + PCI_CONFIG);
> +
> +	*value = readl(p->base + PCI_DATA);
> +
> +	if (size == 1)
> +		*value = (*value >> (8 * (config & 3))) & 0xFF;
> +	else if (size == 2)
> +		*value = (*value >> (8 * (config & 3))) & 0xFFFF;
> +
> +	spin_unlock_irqrestore(&p->lock, irq_flags);

The read_config/write_config functions are called under a spinlock,
no need for another one.

> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	p->base = devm_ioremap_resource(dev, regs);
> +	if (IS_ERR(p->base))
> +		return PTR_ERR(p->base);
> +
> +	ret = of_pci_get_host_bridge_resources(dev->of_node, 0, 0xff,
> +					       &res, &io_base);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_request_pci_bus_resources(dev, &res);
> +	if (ret)
> +		return ret;
> +
> +	/* No clue what these do */
> +	pcibios_min_io = 0x100;
> +	pcibios_min_mem = 0;

Don't touch these

> +	/* setup I/O space to 1MB size */
> +	writel(GEMINI_PCI_IOSIZE_1M, p->base + PCI_IOSIZE);

Maybe get the size from the resource instead? Note that pci_remap_iospace
only registers 64K of I/O space, so you could also use that.

> +	/* setup hostbridge */
> +	val = readl(p->base + PCI_CTRL);
> +	val |= PCI_COMMAND_IO;
> +	val |= PCI_COMMAND_MEMORY;
> +	val |= PCI_COMMAND_MASTER;
> +	writel(val, p->base + PCI_CTRL);
> +
> +	/* Get the I/O and memory ranges from DT */
> +	resource_list_for_each_entry(win, &res) {
> +		switch (resource_type(win->res)) {
> +		case IORESOURCE_IO:
> +			io = win->res;
> +			io->name = "Gemini PCI I/O";
> +			ret = pci_remap_iospace(io, io_base);
> +			if (ret) {
> +				dev_warn(dev, "error %d: failed to map resource %pR\n",
> +					 ret, io);
> +				continue;
> +			}
> +			break;
> +		case IORESOURCE_MEM:
> +			mem = win->res;
> +			mem->name = "Gemini PCI MEM";
> +			break;
> +		case IORESOURCE_BUS:
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	bus = pci_scan_root_bus(&pdev->dev, 0, &gemini_pci_ops, p, &res);

Can you try using the new pci_register_host_bridge() API?

	Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
