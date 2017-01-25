Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] PCI: Xilinx NWL: Modifying irq chip for legacy
 interrupts
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 bhelgaas@google.com, paul.gortmaker@windriver.com, robh@kernel.org,
 colin.king@canonical.com, linux-pci@vger.kernel.org
References: <1485334353-26815-1-git-send-email-bharatku@xilinx.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <a5ec5158-a8ac-26a9-37f2-91307a2320ba@arm.com>
Date: Wed, 25 Jan 2017 09:23:17 +0000
MIME-Version: 1.0
In-Reply-To: <1485334353-26815-1-git-send-email-bharatku@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: arnd@arndb.de, michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
 Bharat Kumar Gogada <bharatku@xilinx.com>, rgummal@xilinx.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

The subject line is not very descriptive. How about "Enforce level
triggering for legacy interrupts"?

On 25/01/17 08:52, Bharat Kumar Gogada wrote:
> - Few wifi end points which only support legacy interrupts,
> performs hardware reset functionalities after disabling interrupts
> by invoking disable_irq and then re-enable using enable_irq, they
> enable hardware interrupts first and then virtual irq line later.
> - The legacy irq line goes low only after DEASSERT_INTx is
> received.As the legacy irq line is high immediately after hardware
> interrupts are enabled but virq of EP is still in disabled state
> and EP handler is never executed resulting no DEASSERT_INTx.If dummy
> irq chip is used, interrutps are not masked and system is

                    interrupts

> hanging with CPU stall.
> - Adding irq chip functions instead of dummy irq chip for legacy
> interrupts.
> - Legacy interrupts are level sensitive, so using handle_level_irq
> is more appropriate as it is masks interrupts until End point handles
> interrupts and unmasks interrutps after End point handler is executed.

                         interrupts

> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> ---
>  drivers/pci/host/pcie-xilinx-nwl.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
> index 43eaa4a..6ac3e1d 100644
> --- a/drivers/pci/host/pcie-xilinx-nwl.c
> +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> @@ -395,10 +395,44 @@ static void nwl_pcie_msi_handler_low(struct irq_desc *desc)
>  	chained_irq_exit(chip, desc);
>  }
>  
> +static void nwl_mask_leg_irq(struct irq_data *data)
> +{
> +	struct irq_desc *desc = irq_to_desc(data->irq);
> +	struct nwl_pcie *pcie;
> +	u32 mask;
> +	u32 val;
> +
> +	pcie = irq_desc_get_chip_data(desc);
> +	mask = 1 << (data->hwirq - 1);
> +	val = nwl_bridge_readl(pcie, MSGF_LEG_MASK);
> +	nwl_bridge_writel(pcie, (val & (~mask)), MSGF_LEG_MASK);

Oh please! Think of the following:

	cpu0	cpu1
	read
		read
		write
	write

How can you make this reliable if you don't have any form of mutual
exclusion that spans both mask and unmask, and ensures the atomicity of
the RMW sequence?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
