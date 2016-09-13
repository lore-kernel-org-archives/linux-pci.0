Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Po Liu <po.liu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: RE: [PATCH v4 1/2] nxp/dts: add pcie aer interrupt-name property in
 the dts
Date: Tue, 13 Sep 2016 03:02:05 +0000
Message-ID: <VI1PR0401MB170970A4F177949FCE4827A892FE0@VI1PR0401MB1709.eurprd04.prod.outlook.com>
References: <1465892645-32381-2-git-send-email-po.liu@nxp.com>
 <1472625442-23309-1-git-send-email-po.liu@nxp.com>
 <20160912221358.GI23532@localhost>
In-Reply-To: <20160912221358.GI23532@localhost>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Stuart Yoder <stuart.yoder@nxp.com>, "M.H. Lian" <minghuan.lian@nxp.com>,
 Murali Karicheri <m-karicheri2@ti.com>, Vincent Hu <mingkai.hu@nxp.com>,
 Roy Zang <roy.zang@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Leo Li <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn, Shawn, Rob,

Thanks for reply. I'll upload new patches:
 - separate the patches with arm and arm64 dts for new version.
 - Modify the binding comments to make it clear for explain the 'aer' property.

Best regards,
Liu Po

-----Original Message-----
From: Bjorn Helgaas [mailto:helgaas@kernel.org] 
Sent: Tuesday, September 13, 2016 6:14 AM
To: Po Liu
Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Bjorn Helgaas; Shawn Guo; Marc Zyngier; Rob Herring; Roy Zang; Vincent Hu; Stuart Yoder; Leo Li; Arnd Bergmann; M.H. Lian; Murali Karicheri
Subject: Re: [PATCH v4 1/2] nxp/dts: add pcie aer interrupt-name property in the dts

On Wed, Aug 31, 2016 at 02:37:21PM +0800, Po Liu wrote:
> NXP some platforms aer interrupt was not MSI/MSI-X/INTx but using 
> interrupt line independently. This patch add a "aer"
> interrupt-names for aer interrupt.
> With the interrupt-names "aer", code could probe aer interrupt line 
> for pcie root port, replace the aer interrupt service irq.
> This is intend to fixup the Layerscape platforms which aer interrupt 
> was not MSI/MSI-X/INTx, but using interrupt line independently.
> 
> Signed-off-by: Po Liu <po.liu@nxp.com>

Rob and Shawn had comments here, and I'm not sure they ever got resolved.

> ---
> changes for V4:
> 	- Add comments explain why to add this patch
> 	- Move the binding changes to pci code patch
> 
>  arch/arm/boot/dts/ls1021a.dtsi                 |  6 ++++--
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 18 
> +++++++++---------  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 
> 16 ++++++++--------
>  3 files changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi 
> b/arch/arm/boot/dts/ls1021a.dtsi index 368e219..443e50b 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -634,7 +634,8 @@
>  			reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
>  			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
>  			reg-names = "regs", "config";
> -			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> +			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
> +			interrupt-names = "aer";
>  			fsl,pcie-scfg = <&scfg 0>;
>  			#address-cells = <3>;
>  			#size-cells = <2>;
> @@ -657,7 +658,8 @@
>  			reg = <0x00 0x03500000 0x0 0x00010000   /* controller registers */
>  			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
>  			reg-names = "regs", "config";
> -			interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
> +			interrupt-names = "aer";
>  			fsl,pcie-scfg = <&scfg 1>;
>  			#address-cells = <3>;
>  			#size-cells = <2>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi 
> b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> index e669fbd..654071d 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> @@ -527,9 +527,9 @@
>  			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
>  			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
>  			reg-names = "regs", "config";
> -			interrupts = <0 118 0x4>, /* controller interrupt */
> -				     <0 117 0x4>; /* PME interrupt */
> -			interrupt-names = "intr", "pme";
> +			interrupts = <0 117 0x4>, /* PME interrupt */
> +					 <0 118 0x4>; /* aer interrupt */
> +			interrupt-names = "pme", "aer";
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> @@ -552,9 +552,9 @@
>  			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
>  			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
>  			reg-names = "regs", "config";
> -			interrupts = <0 128 0x4>,
> -				     <0 127 0x4>;
> -			interrupt-names = "intr", "pme";
> +			interrupts = <0 127 0x4>,
> +					 <0 128 0x4>;
> +			interrupt-names = "pme", "aer";
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> @@ -577,9 +577,9 @@
>  			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
>  			       0x50 0x00000000 0x0 0x00002000>; /* configuration space */
>  			reg-names = "regs", "config";
> -			interrupts = <0 162 0x4>,
> -				     <0 161 0x4>;
> -			interrupt-names = "intr", "pme";
> +			interrupts = <0 161 0x4>,
> +					 <0 162 0x4>;
> +			interrupt-names = "pme", "aer";
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi 
> b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> index 21023a3..58844e8 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> @@ -583,8 +583,8 @@
>  			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
>  			       0x10 0x00000000 0x0 0x00002000>; /* configuration space */
>  			reg-names = "regs", "config";
> -			interrupts = <0 108 0x4>; /* Level high type */
> -			interrupt-names = "intr";
> +			interrupts = <0 108 0x4>; /* aer interrupt */
> +			interrupt-names = "aer";
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> @@ -607,8 +607,8 @@
>  			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
>  			       0x12 0x00000000 0x0 0x00002000>; /* configuration space */
>  			reg-names = "regs", "config";
> -			interrupts = <0 113 0x4>; /* Level high type */
> -			interrupt-names = "intr";
> +			interrupts = <0 113 0x4>; /* aer interrupt */
> +			interrupt-names = "aer";
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> @@ -631,8 +631,8 @@
>  			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
>  			       0x14 0x00000000 0x0 0x00002000>; /* configuration space */
>  			reg-names = "regs", "config";
> -			interrupts = <0 118 0x4>; /* Level high type */
> -			interrupt-names = "intr";
> +			interrupts = <0 118 0x4>; /* aer interrupt */
> +			interrupt-names = "aer";
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> @@ -655,8 +655,8 @@
>  			reg = <0x00 0x03700000 0x0 0x00100000   /* controller registers */
>  			       0x16 0x00000000 0x0 0x00002000>; /* configuration space */
>  			reg-names = "regs", "config";
> -			interrupts = <0 123 0x4>; /* Level high type */
> -			interrupt-names = "intr";
> +			interrupts = <0 123 0x4>; /* aer interrupt */
> +			interrupt-names = "aer";
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> --
> 2.1.0.27.g96db324
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
