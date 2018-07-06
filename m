Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Robin Murphy <robin.murphy@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>, "bhelgaas@google.com" <bhelgaas@google.com>
Subject: RE: [PATCH 7/7 v5] arm64: dts: ls208xa: comply with the iommu map
 binding for fsl_mc
Date: Fri, 6 Jul 2018 12:18:49 +0000
Message-ID: <HE1PR0401MB2425F914BA7A9DDCB3D76AEDE6470@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
 <1526824191-7000-8-git-send-email-nipun.gupta@nxp.com>
 <88626adc-6f5b-86df-88a0-620d258f8053@arm.com>
In-Reply-To: <88626adc-6f5b-86df-88a0-620d258f8053@arm.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "stuyoder@gmail.com" <stuyoder@gmail.com>,
 Bharat Bhushan <bharat.bhushan@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "frowand.list@gmail.com" <frowand.list@gmail.com>, "hch@lst.de" <hch@lst.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy@arm.com]
> Sent: Tuesday, July 3, 2018 10:06 PM
> To: Nipun Gupta <nipun.gupta@nxp.com>; will.deacon@arm.com;
> robh+dt@kernel.org; robh@kernel.org; mark.rutland@arm.com;
> catalin.marinas@arm.com; gregkh@linuxfoundation.org; Laurentiu Tudor
> <laurentiu.tudor@nxp.com>; bhelgaas@google.com
> Cc: hch@lst.de; joro@8bytes.org; m.szyprowski@samsung.com;
> shawnguo@kernel.org; frowand.list@gmail.com; iommu@lists.linux-
> foundation.org; linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org; linux-
> pci@vger.kernel.org; Bharat Bhushan <bharat.bhushan@nxp.com>;
> stuyoder@gmail.com; Leo Li <leoyang.li@nxp.com>
> Subject: Re: [PATCH 7/7 v5] arm64: dts: ls208xa: comply with the iommu map
> binding for fsl_mc
> 
> On 20/05/18 14:49, Nipun Gupta wrote:
> > fsl-mc bus support the new iommu-map property. Comply to this binding
> > for fsl_mc bus.
> >
> > Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> > Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > ---
> >   arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> > index 137ef4d..6010505 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> > @@ -184,6 +184,7 @@
> >   		#address-cells = <2>;
> >   		#size-cells = <2>;
> >   		ranges;
> > +		dma-ranges = <0x0 0x0 0x0 0x0 0x10000 0x00000000>;
> >
> >   		clockgen: clocking@1300000 {
> >   			compatible = "fsl,ls2080a-clockgen";
> > @@ -357,6 +358,8 @@
> >   			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal
> base */
> >   			      <0x00000000 0x08340000 0 0x40000>; /* MC
> control reg */
> >   			msi-parent = <&its>;
> > +			iommu-map = <0 &smmu 0 0>;	/* This is fixed-up by
> u-boot */
> > +			dma-coherent;
> >   			#address-cells = <3>;
> >   			#size-cells = <1>;
> >
> > @@ -460,6 +463,8 @@
> >   			compatible = "arm,mmu-500";
> >   			reg = <0 0x5000000 0 0x800000>;
> >   			#global-interrupts = <12>;
> > +			#iommu-cells = <1>;
> > +			stream-match-mask = <0x7C00>;
> >   			interrupts = <0 13 4>, /* global secure fault */
> >   				     <0 14 4>, /* combined secure interrupt */
> >   				     <0 15 4>, /* global non-secure fault */
> > @@ -502,7 +507,6 @@
> >   				     <0 204 4>, <0 205 4>,
> >   				     <0 206 4>, <0 207 4>,
> >   				     <0 208 4>, <0 209 4>;
> > -			mmu-masters = <&fsl_mc 0x300 0>;
> 
> Since we're in here, is the SMMU itself also coherent? If it is, you
> probably want to say so and avoid the overhead of pointlessly cleaning
> cache lines on every page table update.

Yes, dma-coherent property is also required here. I missed it somehow.
Thanks for pointing this.

Regards,
Nipun

> 
> Robin.
> 
> >   		};
> >
> >   		dspi: dspi@2100000 {
> >
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
