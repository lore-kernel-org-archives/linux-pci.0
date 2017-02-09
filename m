Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v5] PCI: Xilinx NWL: Modifying irq chip for legacy
 interrupts
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 bhelgaas@google.com, robh@kernel.org, paul.gortmaker@windriver.com,
 colin.king@canonical.com, linux-pci@vger.kernel.org
References: <1486364596-19699-1-git-send-email-bharatku@xilinx.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <4b04e834-08b6-a728-8fe5-13106d50b3b2@arm.com>
Date: Thu, 9 Feb 2017 08:51:51 +0000
MIME-Version: 1.0
In-Reply-To: <1486364596-19699-1-git-send-email-bharatku@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
 Bharat Kumar Gogada <bharatku@xilinx.com>, rgummal@xilinx.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 06/02/17 07:03, Bharat Kumar Gogada wrote:
> - Adding spinlock for protecting legacy mask register
> - Few wifi end points which only support legacy interrupts,
> performs hardware reset functionalities after disabling interrupts
> by invoking disable_irq and then re-enable using enable_irq, they
> enable hardware interrupts first and then virtual irq line later.
> - The legacy irq line goes low only after DEASSERT_INTx is
> received.As the legacy irq line is high immediately after hardware
> interrupts are enabled but virq of EP is still in disabled state
> and EP handler is never executed resulting no DEASSERT_INTx.If dummy
> irq chip is used, interrutps are not masked and system is
> hanging with CPU stall.
> - Adding irq chip functions instead of dummy irq chip for legacy
> interrupts.
> - Legacy interrupts are level sensitive, so using handle_level_irq
> is more appropriate as it is masks interrupts until End point handles
> interrupts and unmasks interrutps after End point handler is executed.
> - Legacy interrupts are level triggered, virtual irq line of End
> Point shows as edge in /proc/interrupts.
> - Setting irq flags of virtual irq line of EP to level triggered
> at the time of mapping.

I'm now OK with the code (modulo the small nit below), but the commit
message is a complete mess. How about something like:

The current handling of legacy interrupts in the Xilinx NWL driver is
completely dysfunctional: Interrupts are handled as edge instead of
level, and there is no way to mask an interrupt, leading to drivers
misbehaving.

Let's address this by making it a full blown irqchip, implement
mask/unmask methods, and use handle_level_irq as the flow handler.

> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> ---
>  drivers/pci/host/pcie-xilinx-nwl.c | 45 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
> index 43eaa4a..36f4fb4 100644
> --- a/drivers/pci/host/pcie-xilinx-nwl.c
> +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> @@ -184,6 +184,7 @@ struct nwl_pcie {
>  	u8 root_busno;
>  	struct nwl_msi msi;
>  	struct irq_domain *legacy_irq_domain;
> +	raw_spinlock_t leg_mask_lock;
>  };
>  
>  static inline u32 nwl_bridge_readl(struct nwl_pcie *pcie, u32 off)
> @@ -395,11 +396,52 @@ static void nwl_pcie_msi_handler_low(struct irq_desc *desc)
>  	chained_irq_exit(chip, desc);
>  }
>  
> +static void nwl_mask_leg_irq(struct irq_data *data)
> +{
> +	struct irq_desc *desc = irq_to_desc(data->irq);
> +	struct nwl_pcie *pcie;
> +	unsigned long flags;
> +	u32 mask;
> +	u32 val;
> +
> +	pcie = irq_desc_get_chip_data(desc);
> +	mask = 1 << (data->hwirq - 1);
> +	raw_spin_lock_irqsave(&pcie->leg_mask_lock, flags);
> +	val = nwl_bridge_readl(pcie, MSGF_LEG_MASK);
> +	nwl_bridge_writel(pcie, (val & (~mask)), MSGF_LEG_MASK);
> +	raw_spin_unlock_irqrestore(&pcie->leg_mask_lock, flags);
> +}
> +
> +static void nwl_unmask_leg_irq(struct irq_data *data)
> +{
> +	struct irq_desc *desc = irq_to_desc(data->irq);
> +	struct nwl_pcie *pcie;
> +	unsigned long flags;
> +	u32 mask;
> +	u32 val;
> +
> +	pcie = irq_desc_get_chip_data(desc);
> +	mask = 1 << (data->hwirq - 1);
> +	raw_spin_lock_irqsave(&pcie->leg_mask_lock, flags);
> +	val = nwl_bridge_readl(pcie, MSGF_LEG_MASK);
> +	nwl_bridge_writel(pcie, (val | mask), MSGF_LEG_MASK);
> +	raw_spin_unlock_irqrestore(&pcie->leg_mask_lock, flags);
> +}
> +
> +static struct irq_chip nwl_leg_irq_chip = {
> +	.name = "nwl_pcie:legacy",
> +	.irq_enable = nwl_unmask_leg_irq,
> +	.irq_disable = nwl_mask_leg_irq,

You don't need these two if they are implemented in terms of mask/unmask.

> +	.irq_mask = nwl_mask_leg_irq,
> +	.irq_unmask = nwl_unmask_leg_irq,
> +};
> +
>  static int nwl_legacy_map(struct irq_domain *domain, unsigned int irq,
>  			  irq_hw_number_t hwirq)
>  {
> -	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> +	irq_set_chip_and_handler(irq, &nwl_leg_irq_chip, handle_level_irq);
>  	irq_set_chip_data(irq, domain->host_data);
> +	irq_set_status_flags(irq, IRQ_LEVEL);
>  
>  	return 0;
>  }
> @@ -538,6 +580,7 @@ static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
>  		return -ENOMEM;
>  	}
>  
> +	raw_spin_lock_init(&pcie->leg_mask_lock);
>  	nwl_pcie_init_msi_irq_domain(pcie);
>  	return 0;
>  }
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
