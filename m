Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v4] PCI: Xilinx NWL: Modifying irq chip for legacy
 interrupts
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 bhelgaas@google.com, paul.gortmaker@windriver.com, robh@kernel.org,
 colin.king@canonical.com, linux-pci@vger.kernel.org
References: <1486120110-15205-1-git-send-email-bharatku@xilinx.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <3c78506f-9bcb-0b43-4625-27229ee1f642@arm.com>
Date: Fri, 3 Feb 2017 11:43:21 +0000
MIME-Version: 1.0
In-Reply-To: <1486120110-15205-1-git-send-email-bharatku@xilinx.com>
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

On 03/02/17 11:08, Bharat Kumar Gogada wrote:
> - Adding mutex lock for protecting legacy mask register
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
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> ---
>  drivers/pci/host/pcie-xilinx-nwl.c |   45 +++++++++++++++++++++++++++++++++++-
>  1 files changed, 44 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
> index 43eaa4a..e4605f9 100644
> --- a/drivers/pci/host/pcie-xilinx-nwl.c
> +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> @@ -184,6 +184,7 @@ struct nwl_pcie {
>  	u8 root_busno;
>  	struct nwl_msi msi;
>  	struct irq_domain *legacy_irq_domain;
> +	spinlock_t leg_mask_lock;
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
> +	spin_lock_irqsave(&pcie->leg_mask_lock, flags);

I've asked you to use a raw spinlock for a reason. If using RT, this
gets turned into a sleeping lock...

	M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
