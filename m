Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1513739295.18782.1.camel@mtkswgap22>
Subject: Re: [PATCH] PCI: Mediatek: clear irq status after irq dispathed to
 avoid reentry
From: Ryder Lee <ryder.lee@mediatek.com>
To: <honghui.zhang@mediatek.com>
Date: Wed, 20 Dec 2017 11:08:15 +0800
In-Reply-To: <1513738334-26213-1-git-send-email-honghui.zhang@mediatek.com>
References: <1513738334-26213-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 hongkun.cao@mediatek.com, yt.shen@mediatek.com, linux-pci@vger.kernel.org,
 sean.wang@mediatek.com, xinping.qian@mediatek.com,
 linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
 linux-mediatek@lists.infradead.org, yong.wu@mediatek.com, bhelgaas@google.com,
 yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2017-12-20 at 10:52 +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> There maybe a same irq reentry scenario after irq received in current
> irq handle flow:
> 	EP device		PCIe host driver	EP driver
> 1. issue an irq
> 			2. received irq
> 			3. clear irq status
> 			4. dispatch irq
> 						5. clear irq source
> The irq status was not successfully cleared at step 2 since the irq
> source was not cleared yet. So the PCIe host driver may receive the
> same irq after step 5. Then there's an irq reentry occurred.
> Even worse, if the reentry irq was not an irq that EP driver expected,
> it may not handle the irq. Then we may run into the dead loop from
> step 2 to step 4.
> Clear the irq status after irq have been dispatched to avoid the irq
> reentry.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> ---
>  drivers/pci/host/pcie-mediatek.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
> index db93efd..3248771 100644
> --- a/drivers/pci/host/pcie-mediatek.c
> +++ b/drivers/pci/host/pcie-mediatek.c
> @@ -605,11 +605,11 @@ static irqreturn_t mtk_pcie_intr_handler(int irq, void *data)
>  
>  	while ((status = readl(port->base + PCIE_INT_STATUS)) & INTX_MASK) {
>  		for_each_set_bit_from(bit, &status, PCI_NUM_INTX + INTX_SHIFT) {
> -			/* Clear the INTx */
> -			writel(1 << bit, port->base + PCIE_INT_STATUS);
>  			virq = irq_find_mapping(port->irq_domain,
>  						bit - INTX_SHIFT);
>  			generic_handle_irq(virq);
> +			/* Clear the INTx */
> +			writel(1 << bit, port->base + PCIE_INT_STATUS);
>  		}
>  	}
>  
> @@ -619,10 +619,10 @@ static irqreturn_t mtk_pcie_intr_handler(int irq, void *data)
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

Acked-by: Ryder Lee <ryder.lee@mediatek.com>

Thanks.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
