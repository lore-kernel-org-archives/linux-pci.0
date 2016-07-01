Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] PCI: Rockchip: Add Rockchip PCIe controller
 support
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>
References: <1467336290-11282-1-git-send-email-shawn.lin@rock-chips.com>
 <1467336290-11282-2-git-send-email-shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>,
	Doug Anderson <dianders@chromium.org>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <577646D3.7040207@arm.com>
Date: Fri, 1 Jul 2016 11:32:51 +0100
MIME-Version: 1.0
In-Reply-To: <1467336290-11282-2-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/07/16 02:24, Shawn Lin wrote:
> This patch adds Rockchip PCIe controller support found
> on RK3399 Soc platform.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---

[...]

> +static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct rockchip_pcie_port *port;
> +	u32 reg;
> +
> +	chained_irq_enter(chip, desc);
> +	port = irq_desc_get_handler_data(desc);
> +
> +	reg = pcie_read(port, PCIE_CLIENT_INT_STATUS);
> +	reg = (reg & ROCKCHIP_PCIE_RPIFR1_INTR_MASK) >>
> +	       ROCKCHIP_PCIE_RPIFR1_INTR_SHIFT;
> +	if (reg)
> +		generic_handle_irq(irq_find_mapping(port->irq_domain,
> +						    ffs(reg)));

Can't you get multiple pending interrupts at the same time? Here, you
seem to only process one interrupt at a time, which is going to be
pretty inefficient.

How about something like:

	while (reg) {
		int hwirq = ffs(reg);
		int irq;
		
		reg &= ~BIT(hwirq);
		irq = irq_find_mapping(port->irq_domain, hwirq);
		if (irq)
			generic_handle_irq(irq);
	}

> +	chained_irq_exit(chip, desc);
> +}
> +

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
