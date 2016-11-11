Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 11 Nov 2016 15:51:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Subject: Re: [PATCH -next] PCI: xilinx-nwl: Add missing of_node_put() in
 nwl_pcie_init_irq_domain()
Message-ID: <20161111215107.GN9868@bhelgaas-glaptop.roam.corp.google.com>
References: <1476716297-31808-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1476716297-31808-1-git-send-email-weiyj.lk@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: bharat.kumar.gogada@xilinx.com, linux-pci@vger.kernel.org,
 michal.simek@xilinx.com, paul.gortmaker@windriver.com,
 Wei Yongjun <weiyongjun1@huawei.com>, linux-arm-kernel@lists.infradead.org,
 bhelgaas@google.com, colin.king@canonical.com, soren.brinkmann@xilinx.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 17, 2016 at 02:58:17PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> This node pointer is returned by of_get_next_child() with refcount
> incremented in this function. of_node_put() on it before exitting
> this function on error.
> 
> This is detected by Coccinelle semantic patch.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied to pci/host-xilinx for v.10, thanks!

> ---
>  drivers/pci/host/pcie-xilinx-nwl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
> index 43eaa4a..c16b26c 100644
> --- a/drivers/pci/host/pcie-xilinx-nwl.c
> +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> @@ -535,6 +535,7 @@ static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
>  
>  	if (!pcie->legacy_irq_domain) {
>  		dev_err(dev, "failed to create IRQ domain\n");
> +		of_node_put(legacy_intc_node);
>  		return -ENOMEM;
>  	}
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
