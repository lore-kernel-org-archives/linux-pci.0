Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 14 May 2018 07:47:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nipun Gupta <nipun.gupta@nxp.com>
Subject: Re: [PATCH v4 5/6] bus: fsl-mc: supoprt dma configure for devices on
 fsl-mc bus
Message-ID: <20180514124757.GA253589@bhelgaas-glaptop.roam.corp.google.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-6-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
In-Reply-To: <1525069641-8523-6-git-send-email-nipun.gupta@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, stuyoder@gmail.com, linux-pci@vger.kernel.org,
 will.deacon@arm.com, shawnguo@kernel.org, bharat.bhushan@nxp.com, hch@lst.de,
 m.szyprowski@samsung.com, robh@kernel.org, frowand.list@gmail.com,
 joro@8bytes.org, catalin.marinas@arm.com, devicetree@vger.kernel.org,
 robin.murphy@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org, laurentiu.tudor@nxp.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

When you add the changleog, please also fix the subject typo:

- bus: fsl-mc: supoprt dma configure for devices on fsl-mc bus
               ^^^^^^^
+ bus: fsl-mc: support dma configure for devices on fsl-mc bus

On Mon, Apr 30, 2018 at 11:57:20AM +0530, Nipun Gupta wrote:
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
>  drivers/bus/fsl-mc/fsl-mc-bus.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 5d8266c..624828b 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -127,6 +127,16 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>  	return 0;
>  }
>  
> +static int fsl_mc_dma_configure(struct device *dev)
> +{
> +	struct device *dma_dev = dev;
> +
> +	while (dev_is_fsl_mc(dma_dev))
> +		dma_dev = dma_dev->parent;
> +
> +	return of_dma_configure(dev, dma_dev->of_node, 0);
> +}
> +
>  static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
>  {
> @@ -148,6 +158,7 @@ struct bus_type fsl_mc_bus_type = {
>  	.name = "fsl-mc",
>  	.match = fsl_mc_bus_match,
>  	.uevent = fsl_mc_bus_uevent,
> +	.dma_configure  = fsl_mc_dma_configure,
>  	.dev_groups = fsl_mc_dev_groups,
>  };
>  EXPORT_SYMBOL_GPL(fsl_mc_bus_type);
> @@ -616,6 +627,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>  		mc_dev->icid = parent_mc_dev->icid;
>  		mc_dev->dma_mask = FSL_MC_DEFAULT_DMA_MASK;
>  		mc_dev->dev.dma_mask = &mc_dev->dma_mask;
> +		mc_dev->dev.coherent_dma_mask = mc_dev->dma_mask;
>  		dev_set_msi_domain(&mc_dev->dev,
>  				   dev_get_msi_domain(&parent_mc_dev->dev));
>  	}
> @@ -633,10 +645,6 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>  			goto error_cleanup_dev;
>  	}
>  
> -	/* Objects are coherent, unless 'no shareability' flag set. */
> -	if (!(obj_desc->flags & FSL_MC_OBJ_FLAG_NO_MEM_SHAREABILITY))
> -		arch_setup_dma_ops(&mc_dev->dev, 0, 0, NULL, true);
> -
>  	/*
>  	 * The device-specific probe callback will get invoked by device_add()
>  	 */
> -- 
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
