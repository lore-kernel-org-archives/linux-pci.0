Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 2/2] pci: Add PCIe driver for Rockchip Soc
To: Marc Zyngier <marc.zyngier@arm.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>
References: <1463740105-7061-1-git-send-email-shawn.lin@rock-chips.com>
 <1463740156-7148-1-git-send-email-shawn.lin@rock-chips.com>
 <57483CAA.8000005@arm.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
From: Wenrui Li <wenrui.li@rock-chips.com>
Message-ID: <574E4EF5.7040005@rock-chips.com>
Date: Wed, 1 Jun 2016 10:56:53 +0800
MIME-Version: 1.0
In-Reply-To: <57483CAA.8000005@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi:

On 2016/5/27 20:25, Marc Zyngier Wrote:
> [+Lorenzo]
>
> On 20/05/16 11:29, Shawn Lin wrote:
>> RK3399 has a PCIe controller which can be used as Root Complex.
>> This driver supports a PCIe controller as Root Complex mode.
>>

[....]

>> +static int rockchip_pcie_init_irq_domain(struct rockchip_pcie_port *pp)
>> +{
>> +	struct device *dev = pp->dev;
>> +	struct device_node *node = dev->of_node;
>> +	struct device_node *pcie_intc_node =  of_get_next_child(node, NULL);
>
> That's really ugly, as it depends on the layout of your DT.
>
>> +
>> +	if (!pcie_intc_node) {
>> +		dev_err(dev, "No PCIe Intc node found\n");
>> +		return PTR_ERR(pcie_intc_node);
>> +	}
>> +	pp->irq_domain = irq_domain_add_linear(pcie_intc_node, 4,
>> +					       &intx_domain_ops, pp);
>
> Why can't you just register your host controller as the interrupt
> controller? You don't need an intermediate node for that.

OK, the child node is really no need here, we will use the host 
controller as interrupt controller next patch. Thanks!

>
>> +	if (!pp->irq_domain) {
>> +		dev_err(dev, "Failed to get a INTx IRQ domain\n");
>> +		return PTR_ERR(pp->irq_domain);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
>> +{
>> +	struct rockchip_pcie_port *pp = arg;
>> +	u32 reg;
>> +	u32 sub_reg;
>> +
>> +	reg = pcie_read(pp, PCIE_CLIENT_INT_STATUS);
>> +	if (reg & LOC_INT) {
>> +		dev_dbg(pp->dev, "local interrupt recived\n");
>> +		sub_reg = pcie_read(pp, PCIE_CORE_INT_STATUS);
>> +		if (sub_reg & PRFPE)
>> +			dev_dbg(pp->dev, "Parity error detected while reading from the PNP Receive FIFO RAM\n");
>> +
>> +		if (sub_reg & CRFPE)
>> +			dev_dbg(pp->dev, "Parity error detected while reading from the Completion Receive FIFO RAM\n");
>> +
>> +		if (sub_reg & RRPE)
>> +			dev_dbg(pp->dev, "Parity error detected while reading from Replay Buffer RAM\n");
>> +
>> +		if (sub_reg & PRFO)
>> +			dev_dbg(pp->dev, "Overflow occurred in the PNP Receive FIFO\n");
>> +
>> +		if (sub_reg & CRFO)
>> +			dev_dbg(pp->dev, "Overflow occurred in the Completion Receive FIFO\n");
>> +
>> +		if (sub_reg & RT)
>> +			dev_dbg(pp->dev, "Replay timer timed out\n");
>> +
>> +		if (sub_reg & RTR)
>> +			dev_dbg(pp->dev, "Replay timer rolled over after 4 transmissions of the same TLP\n");
>> +
>> +		if (sub_reg & PE)
>> +			dev_dbg(pp->dev, "Phy error detected on receive side\n");
>> +
>> +		if (sub_reg & MTR)
>> +			dev_dbg(pp->dev, "Malformed TLP received from the link\n");
>> +
>> +		if (sub_reg & UCR)
>> +			dev_dbg(pp->dev, "Malformed TLP received from the link\n");
>> +
>> +		if (sub_reg & FCE)
>> +			dev_dbg(pp->dev, "An error was observed in the flow control advertisements from the other side\n");
>> +
>> +		if (sub_reg & CT)
>> +			dev_dbg(pp->dev, "A request timed out waiting for completion\n");
>> +
>> +		if (sub_reg & UTC)
>> +			dev_dbg(pp->dev, "Unmapped TC error\n");
>> +
>> +		if (sub_reg & MMVC)
>> +			dev_dbg(pp->dev, "MSI mask register changes\n");
>> +
>> +		pcie_write(pp, sub_reg, PCIE_CORE_INT_STATUS);
>> +	}
>> +
>> +	pcie_write(pp, reg, PCIE_CLIENT_INT_STATUS);
>> +
>> +	return IRQ_HANDLED;
>> +}

[....]

>> +static irqreturn_t rockchip_pcie_legacy_int_handler(int irq, void *arg)
>> +{
>> +	struct rockchip_pcie_port *pp = arg;
>> +	u32 reg;
>> +
>> +	reg = pcie_read(pp, PCIE_CLIENT_INT_STATUS);
>> +	reg = (reg & ROCKCHIP_PCIE_RPIFR1_INTR_MASK) >>
>> +	       ROCKCHIP_PCIE_RPIFR1_INTR_SHIFT;
>> +	generic_handle_irq(irq_find_mapping(pp->irq_domain, ffs(reg)));
>
> NAK. What you have here is a chained interrupt controller, please
> implement it as such.

Your mean is use handle_nested_irq instead of generic_handle_irq here?
But, I found all other pci host controller drivers use this api.

>
>> +
>> +	pcie_write(pp, reg, PCIE_CLIENT_INT_STATUS);
>> +	return IRQ_HANDLED;
>> +}
>> +

[...]

>> +static struct platform_driver rockchip_pcie_driver = {
>> +	.driver = {
>> +		.name = "rockchip-pcie",
>> +		.of_match_table = rockchip_pcie_of_match,
>> +		.suppress_bind_attrs = true,
>> +	},
>> +	.probe = rockchip_pcie_probe,
>> +	.remove = rockchip_pcie_remove,
>> +};
>> +module_platform_driver(rockchip_pcie_driver);
>> +
>> +MODULE_AUTHOR("Rockchip Inc");
>> +MODULE_DESCRIPTION("Rockchip AXI PCIe driver");
>> +MODULE_LICENSE("GPL v2");
>>
>
> This definitely requires some rework for both the interrupt and MSI
> parts. I'll leave Lorenzo to comment on the PCI side of things.
>
> Thanks,
>
> 	M.
>

Best Regards,
Li
