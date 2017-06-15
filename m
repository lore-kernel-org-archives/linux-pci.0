Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 15 Jun 2017 16:11:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH] PCI: mediatek: fix error handling in
 mtk_pcie_parse_and_add_res()
Message-ID: <20170615211130.GF12735@bhelgaas-glaptop.roam.corp.google.com>
References: <1496644078-27122-1-git-send-email-ryder.lee@mediatek.com>
MIME-Version: 1.0
In-Reply-To: <1496644078-27122-1-git-send-email-ryder.lee@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 05, 2017 at 02:27:58PM +0800, Ryder Lee wrote:
> The 'linkup' variable would always increment by one whether the link
> status is true or not. Therefore, this patch fixes the return value in
> mtk_pcie_parse_and_add_res() and removes unnecessary 'linkup' variable.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

I folded this into pci/host-mediatek for v4.13, thanks!

I just noticed that we didn't get a MAINTAINERS update for this driver.
Can you send me that, too, please?

> ---
>  drivers/pci/host/pcie-mediatek.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
> index 8ec8fa8..3baafa8 100644
> --- a/drivers/pci/host/pcie-mediatek.c
> +++ b/drivers/pci/host/pcie-mediatek.c
> @@ -373,7 +373,7 @@ static int mtk_pcie_parse_and_add_res(struct mtk_pcie *pcie)
>  	struct of_pci_range_parser parser;
>  	struct of_pci_range range;
>  	struct resource res;
> -	int err, linkup = 0;
> +	int err;
>  
>  	/* parse shared resources */
>  	err = mtk_pcie_handle_shared_resource(pcie);
> @@ -444,11 +444,11 @@ static int mtk_pcie_parse_and_add_res(struct mtk_pcie *pcie)
>  
>  		/* enable each port, and then check link status */
>  		err = mtk_pcie_enable_ports(port);
> -		if (!err)
> -			linkup++;
> +		if (err)
> +			return err;
>  	}
>  
> -	return !linkup;
> +	return 0;
>  }
>  
>  static int mtk_pcie_request_resources(struct mtk_pcie *pcie)
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
