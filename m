Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] PCI: Xilinx NWL: Fix, proc interrupts for legacy
 virtual irq shown as edge
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 bhelgaas@google.com, paul.gortmaker@windriver.com, robh@kernel.org,
 colin.king@canonical.com, linux-pci@vger.kernel.org
References: <1485334353-26815-1-git-send-email-bharatku@xilinx.com>
 <1485334353-26815-2-git-send-email-bharatku@xilinx.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <0833bdec-b05e-57c0-c740-ac7735036450@arm.com>
Date: Wed, 25 Jan 2017 09:24:14 +0000
MIME-Version: 1.0
In-Reply-To: <1485334353-26815-2-git-send-email-bharatku@xilinx.com>
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

On 25/01/17 08:52, Bharat Kumar Gogada wrote:
> - Legacy interrupts are level triggered, virtual irq line of End
> Point shows as edge in /proc/interrupts.
> - Setting irq flags of virtual irq line of EP to level triggered
> at the time of mapping.
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> ---
>  drivers/pci/host/pcie-xilinx-nwl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
> index 6ac3e1d..1cddd1f 100644
> --- a/drivers/pci/host/pcie-xilinx-nwl.c
> +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> @@ -434,6 +434,7 @@ static int nwl_legacy_map(struct irq_domain *domain, unsigned int irq,
>  {
>  	irq_set_chip_and_handler(irq, &nwl_leg_irq_chip, handle_level_irq);
>  	irq_set_chip_data(irq, domain->host_data);
> +	irq_set_status_flags(irq, IRQ_LEVEL);
>  
>  	return 0;
>  }
> 

As said in my previous review [1], this should be folded in the previous
patch, as it doesn't make much sense on its own.

Thanks,

	M.

[1] http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1316912.html
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
