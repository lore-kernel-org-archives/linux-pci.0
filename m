Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>
Subject: RE: [PATCH 5/6 v3] bus: fsl-mc: supoprt dma configure for devices on
 fsl-mc bus
Date: Wed, 16 May 2018 08:48:57 +0000
Message-ID: <HE1PR0401MB24253CF729DDCF3F883AC256E6920@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1524824826-29473-6-git-send-email-nipun.gupta@nxp.com>
 <5AF9916E.8000504@nxp.com>
In-Reply-To: <5AF9916E.8000504@nxp.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Bharat Bhushan <bharat.bhushan@nxp.com>,
 "stuyoder@gmail.com" <stuyoder@gmail.com>,
 "frowand.list@gmail.com" <frowand.list@gmail.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Laurentiu Tudor
> Sent: Monday, May 14, 2018 7:10 PM
> To: Nipun Gupta <nipun.gupta@nxp.com>; robin.murphy@arm.com;
> will.deacon@arm.com; mark.rutland@arm.com; catalin.marinas@arm.com
> Cc: hch@lst.de; gregkh@linuxfoundation.org; joro@8bytes.org;
> robh+dt@kernel.org; m.szyprowski@samsung.com; shawnguo@kernel.org;
> frowand.list@gmail.com; bhelgaas@google.com; iommu@lists.linux-
> foundation.org; linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org; linux-
> pci@vger.kernel.org; Bharat Bhushan <bharat.bhushan@nxp.com>;
> stuyoder@gmail.com; Leo Li <leoyang.li@nxp.com>
> Subject: Re: [PATCH 5/6 v3] bus: fsl-mc: supoprt dma configure for devices
> on fsl-mc bus
> 
> Hi Nipun,
> 
> On 04/27/2018 01:27 PM, Nipun Gupta wrote:
> > Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> > ---
> >   drivers/bus/fsl-mc/fsl-mc-bus.c | 16 ++++++++++++----
> >   1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-
> bus.c
> > index 5d8266c..624828b 100644
> > --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> > +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> > @@ -127,6 +127,16 @@ static int fsl_mc_bus_uevent(struct device *dev,
> struct kobj_uevent_env *env)
> >   	return 0;
> >   }
> >
> > +static int fsl_mc_dma_configure(struct device *dev)
> > +{
> > +	struct device *dma_dev = dev;
> > +
> > +	while (dev_is_fsl_mc(dma_dev))
> > +		dma_dev = dma_dev->parent;
> > +
> > +	return of_dma_configure(dev, dma_dev->of_node, 0);
> > +}
> > +
> >   static ssize_t modalias_show(struct device *dev, struct device_attribute
> *attr,
> >   			     char *buf)
> >   {
> > @@ -148,6 +158,7 @@ struct bus_type fsl_mc_bus_type = {
> >   	.name = "fsl-mc",
> >   	.match = fsl_mc_bus_match,
> >   	.uevent = fsl_mc_bus_uevent,
> > +	.dma_configure  = fsl_mc_dma_configure,
> >   	.dev_groups = fsl_mc_dev_groups,
> >   };
> >   EXPORT_SYMBOL_GPL(fsl_mc_bus_type);
> > @@ -616,6 +627,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc
> *obj_desc,
> >   		mc_dev->icid = parent_mc_dev->icid;
> >   		mc_dev->dma_mask = FSL_MC_DEFAULT_DMA_MASK;
> >   		mc_dev->dev.dma_mask = &mc_dev->dma_mask;
> > +		mc_dev->dev.coherent_dma_mask = mc_dev->dma_mask;
> 
> This change seems a bit unrelated to the patch subject. I wonder if it
> makes sense to split it it in a distinct patch.

Okay. I will spin a v5 after splitting this patch and adding changelog (Greg's comment), fixing typo (Bjorn's comment).

Regards,
Nipun

> 
> ---
> Best Regards, Laurentiu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
