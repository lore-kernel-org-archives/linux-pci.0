Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 29 Jan 2018 17:10:10 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] PCI: exynos: fix the potential null pointer dereference
Message-ID: <20180129171010.GA23955@e107981-ln.cambridge.arm.com>
References: <CGME20180122022856epcas1p494a9efeae478b299e3e8006adad71e6a@epcas1p4.samsung.com>
 <20180122022854.3634-1-jh80.chung@samsung.com>
MIME-Version: 1.0
In-Reply-To: <20180122022854.3634-1-jh80.chung@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
 krzk@kernel.org, kgene@kernel.org, jingoohan1@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 22, 2018 at 11:28:54AM +0900, Jaehoon Chung wrote:
> Before calling the callback function, it needs to check whether
> init_clk_resources is assigned or not.
> Otherwise, it can be occurred the NULL pointer dereference when
> init_clk_resources is not assigned.
> 
> Even though init_clk_resources is assigned now, it needs to prevent the
> potential NULL pointer dereference in future.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/pci/dwc/pci-exynos.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
> index 56f32aeebd0a..39f08881f9a4 100644
> --- a/drivers/pci/dwc/pci-exynos.c
> +++ b/drivers/pci/dwc/pci-exynos.c
> @@ -499,7 +499,8 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
>  			return ret;
>  	}
>  
> -	if (ep->ops && ep->ops->get_clk_resources) {
> +	if (ep->ops && ep->ops->get_clk_resources &&
> +			ep->ops->init_clk_resources) {
>  		ret = ep->ops->get_clk_resources(ep);
>  		if (ret)
>  			return ret;
> -- 
> 2.15.1

I applied it to pci/dwc for 4.16.

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
