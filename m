Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 22 Aug 2016 14:38:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Subject: Re: [PATCH -next] PCI: aardvark: Remove redundant dev_err call in
 advk_pcie_probe()
Message-ID: <20160822193809.GL18628@localhost>
References: <1469722634-15049-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1469722634-15049-1-git-send-email-weiyj.lk@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 28, 2016 at 04:17:14PM +0000, Wei Yongjun wrote:
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>

Applied with Thomas' reviewed-by to pci/host-aardvark for v4.9, thanks!

> ---
>  drivers/pci/host/pci-aardvark.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
> index ef9893f..05c33b5 100644
> --- a/drivers/pci/host/pci-aardvark.c
> +++ b/drivers/pci/host/pci-aardvark.c
> @@ -925,10 +925,8 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	pcie->base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(pcie->base)) {
> -		dev_err(&pdev->dev, "Failed to map registers\n");
> +	if (IS_ERR(pcie->base))
>  		return PTR_ERR(pcie->base);
> -	}
>  
>  	irq = platform_get_irq(pdev, 0);
>  	ret = devm_request_irq(&pdev->dev, irq, advk_pcie_irq_handler,
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
