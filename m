Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 3/4] PCI: Xilinx NWL: Modifying flow handler for legacy
 interrupts
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 bhelgaas@google.com, paul.gortmaker@windriver.com, robh@kernel.org,
 colin.king@canonical.com, linux-pci@vger.kernel.org
References: <1484997072-19276-1-git-send-email-bharatku@xilinx.com>
 <1484997072-19276-3-git-send-email-bharatku@xilinx.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <bab088a5-ed6d-1d9d-b38f-0a271c2bc766@arm.com>
Date: Mon, 23 Jan 2017 18:38:26 +0000
MIME-Version: 1.0
In-Reply-To: <1484997072-19276-3-git-send-email-bharatku@xilinx.com>
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

On 21/01/17 11:11, Bharat Kumar Gogada wrote:
> Legacy interrupts are level sensitive, so using handle_level_irq
> is more approprate as it is masks interrupts until End point handles
> interrupts and unmasks interrutps after End point handler is executed.
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> ---
>  drivers/pci/host/pcie-xilinx-nwl.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
> index e1809f9..50f9c0d 100644
> --- a/drivers/pci/host/pcie-xilinx-nwl.c
> +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> @@ -433,7 +433,7 @@ static void nwl_unmask_leg_irq(struct irq_data *data)
>  static int nwl_legacy_map(struct irq_domain *domain, unsigned int irq,
>  			  irq_hw_number_t hwirq)
>  {
> -	irq_set_chip_and_handler(irq, &nwl_leg_irq_chip, handle_simple_irq);
> +	irq_set_chip_and_handler(irq, &nwl_leg_irq_chip, handle_level_irq);
>  	irq_set_chip_data(irq, domain->host_data);
>  
>  	return 0;
> 

Please merge this patch and the following one in patch #2. There is no
need for going through equally broken intermediate steps.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
