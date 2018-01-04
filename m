Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 4 Jan 2018 18:40:40 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: honghui.zhang@mediatek.com
Subject: Re: [PATCH v5 1/2] PCI: mediatek: Clear IRQ status after IRQ
 dispatched to avoid reentry
Message-ID: <20180104184040.GE12239@red-moon>
References: <1514336394-17747-1-git-send-email-honghui.zhang@mediatek.com>
 <1514336394-17747-2-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
In-Reply-To: <1514336394-17747-2-git-send-email-honghui.zhang@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 hongkun.cao@mediatek.com, ryder.lee@mediatek.com, marc.zyngier@arm.com,
 linux-pci@vger.kernel.org, sean.wang@mediatek.com, xinping.qian@mediatek.com,
 linux-kernel@vger.kernel.org, yt.shen@mediatek.com, matthias.bgg@gmail.com,
 linux-mediatek@lists.infradead.org, yong.wu@mediatek.com, bhelgaas@google.com,
 yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+Marc]

On Wed, Dec 27, 2017 at 08:59:53AM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> There maybe a same IRQ reentry scenario after IRQ received in current
> IRQ handle flow:
> 	EP device		PCIe host driver	EP driver
> 1. issue an IRQ
> 			2. received IRQ
> 			3. clear IRQ status
> 			4. dispatch IRQ
> 						5. clear IRQ source
> The IRQ status was not successfully cleared at step 2 since the IRQ
> source was not cleared yet. So the PCIe host driver may receive the
> same IRQ after step 5. Then there's an IRQ reentry occurred.
> Even worse, if the reentry IRQ was not an IRQ that EP driver expected,
> it may not handle the IRQ. Then we may run into the infinite loop from
> step 2 to step 4.
> Clear the IRQ status after IRQ have been dispatched to avoid the IRQ
> reentry.
> This patch also fix another INTx IRQ issue by initialize the iterate
> before the loop. If an INTx IRQ re-occurred while we are dispatching
> the INTx IRQ, then iterate may start from PCI_NUM_INTX + INTX_SHIFT
> instead of INTX_SHIFT for the second time entering the
> for_each_set_bit_from() loop.

This looks like two different issues that should be fixed with two
patches.

> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pci/host/pcie-mediatek.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

For the sake of uniformity, I first want to understand why this
driver does not call:

chained_irq_enter/exit()

in the primary handler (mtk_pcie_intr_handler()).

With the GIC as a primary interrupt controller we have not
even figured out how current code can actually work without
calling the chained_* API.

I want to come up with a consistent handling of IRQ domains for
all host bridges and any discrepancy should be explained.

> diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
> index db93efd..fc29a9a 100644
> --- a/drivers/pci/host/pcie-mediatek.c
> +++ b/drivers/pci/host/pcie-mediatek.c
> @@ -601,15 +601,16 @@ static irqreturn_t mtk_pcie_intr_handler(int irq, void *data)
>  	struct mtk_pcie_port *port = (struct mtk_pcie_port *)data;
>  	unsigned long status;
>  	u32 virq;
> -	u32 bit = INTX_SHIFT;
> +	u32 bit;
>  
>  	while ((status = readl(port->base + PCIE_INT_STATUS)) & INTX_MASK) {
> +		bit = INTX_SHIFT;
>  		for_each_set_bit_from(bit, &status, PCI_NUM_INTX + INTX_SHIFT) {
> -			/* Clear the INTx */
> -			writel(1 << bit, port->base + PCIE_INT_STATUS);
>  			virq = irq_find_mapping(port->irq_domain,
>  						bit - INTX_SHIFT);
>  			generic_handle_irq(virq);
> +			/* Clear the INTx */
> +			writel(1 << bit, port->base + PCIE_INT_STATUS);

I think that these masking/acking should actually be done through
the irq_chip hooks (see for instance pci-ftpci100.c) - that would
make this kind of bugs much easier to prevent (because the IRQ
layer does the sequencing for you).

Marc (CC'ed) has a more comprehensive view on this than me - I would
like to get to a point where all host bridges uses a consistent
approach for chained IRQ handling and I hope this bug fix can be
a starting point.

Thanks,
Lorenzo

>  		}
>  	}
>  
> @@ -619,10 +620,10 @@ static irqreturn_t mtk_pcie_intr_handler(int irq, void *data)
>  
>  			while ((imsi_status = readl(port->base + PCIE_IMSI_STATUS))) {
>  				for_each_set_bit(bit, &imsi_status, MTK_MSI_IRQS_NUM) {
> -					/* Clear the MSI */
> -					writel(1 << bit, port->base + PCIE_IMSI_STATUS);
>  					virq = irq_find_mapping(port->msi_domain, bit);
>  					generic_handle_irq(virq);
> +					/* Clear the MSI */
> +					writel(1 << bit, port->base + PCIE_IMSI_STATUS);
>  				}
>  			}
>  			/* Clear MSI interrupt status */
> -- 
> 2.6.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
