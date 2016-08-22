Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 22 Aug 2016 14:33:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Subject: Re: [PATCH -next] PCI: keystone: Fix error return code in
 ks_add_pcie_port()
Message-ID: <20160822193315.GJ18628@localhost>
References: <1469722578-14863-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1469722578-14863-1-git-send-email-weiyj.lk@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Murali Karicheri <m-karicheri2@ti.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 28, 2016 at 04:16:18PM +0000, Wei Yongjun wrote:
> Fix to return a negative error code from the request IRQ error
> handling case instead of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>

Applied with Murali's ack to pci/host-keystone for v4.9, thanks!

> ---
>  drivers/pci/host/pci-keystone.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
> index 8ba2883..82b461b 100644
> --- a/drivers/pci/host/pci-keystone.c
> +++ b/drivers/pci/host/pci-keystone.c
> @@ -334,8 +334,9 @@ static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
>  	if (ks_pcie->error_irq <= 0)
>  		dev_info(&pdev->dev, "no error IRQ defined\n");
>  	else {
> -		if (request_irq(ks_pcie->error_irq, pcie_err_irq_handler,
> -				IRQF_SHARED, "pcie-error-irq", ks_pcie) < 0) {
> +		ret = request_irq(ks_pcie->error_irq, pcie_err_irq_handler,
> +				  IRQF_SHARED, "pcie-error-irq", ks_pcie);
> +		if (ret < 0) {
>  			dev_err(&pdev->dev, "failed to request error IRQ %d\n",
>  				ks_pcie->error_irq);
>  			return ret;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
