Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:46899 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbaIVUVa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 16:21:30 -0400
Received: by mail-ig0-f181.google.com with SMTP id h18so3435861igc.2
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2014 13:21:29 -0700 (PDT)
Date: Mon, 22 Sep 2014 14:21:26 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Pratyush Anand <pratyush.anand@st.com>
Cc: mohit.kumar@st.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH V2] PCIe: SPEAr13XX: Pass config resource through reg
 property
Message-ID: <20140922202126.GD1880@google.com>
References: <c5feb916f14d19e4c636a5af89be48df5097b500.1409720201.git.pratyush.anand@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c5feb916f14d19e4c636a5af89be48df5097b500.1409720201.git.pratyush.anand@st.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 03, 2014 at 10:50:49AM +0530, Pratyush Anand wrote:
> PCIe configuration space should be passed through reg property, rather
> than through ranges property. This patch does the correction for
> SPEAr13XX SOCs.
> 
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>

Applied with Mohit's ack to pci/host-spear for v3.18, thanks!

> ---
>  arch/arm/boot/dts/spear1310.dtsi  | 18 +++++++++---------
>  arch/arm/boot/dts/spear1340.dtsi  |  6 +++---
>  drivers/pci/host/pcie-spear13xx.c |  2 +-
>  3 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/spear1310.dtsi b/arch/arm/boot/dts/spear1310.dtsi
> index fa5f2bb5f106..9d342920695a 100644
> --- a/arch/arm/boot/dts/spear1310.dtsi
> +++ b/arch/arm/boot/dts/spear1310.dtsi
> @@ -85,7 +85,8 @@
>  
>  		pcie0: pcie@b1000000 {
>  			compatible = "st,spear1340-pcie", "snps,dw-pcie";
> -			reg = <0xb1000000 0x4000>;
> +			reg = <0xb1000000 0x4000>, <0x80000000 0x20000>;
> +			reg-names = "dbi", "config";
>  			interrupts = <0 68 0x4>;
>  			interrupt-map-mask = <0 0 0 0>;
>  			interrupt-map = <0x0 0 &gic 0 68 0x4>;
> @@ -95,15 +96,15 @@
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> -			ranges = <0x00000800 0 0x80000000 0x80000000 0 0x00020000   /* configuration space */
> -				0x81000000 0 0	 0x80020000 0 0x00010000   /* downstream I/O */
> +			ranges = <0x81000000 0 0	 0x80020000 0 0x00010000   /* downstream I/O */
>  				0x82000000 0 0x80030000 0xc0030000 0 0x0ffd0000>; /* non-prefetchable memory */
>  			status = "disabled";
>  		};
>  
>  		pcie1: pcie@b1800000 {
>  			compatible = "st,spear1340-pcie", "snps,dw-pcie";
> -			reg = <0xb1800000 0x4000>;
> +			reg = <0xb1800000 0x4000>, <0x90000000 0x20000>;
> +			reg-names = "dbi", "config";
>  			interrupts = <0 69 0x4>;
>  			interrupt-map-mask = <0 0 0 0>;
>  			interrupt-map = <0x0 0 &gic 0 69 0x4>;
> @@ -113,15 +114,15 @@
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> -			ranges = <0x00000800 0 0x90000000 0x90000000 0 0x00020000   /* configuration space */
> -				0x81000000 0 0  0x90020000 0 0x00010000   /* downstream I/O */
> +			ranges = <0x81000000 0 0  0x90020000 0 0x00010000   /* downstream I/O */
>  				0x82000000 0 0x90030000 0x90030000 0 0x0ffd0000>; /* non-prefetchable memory */
>  			status = "disabled";
>  		};
>  
>  		pcie2: pcie@b4000000 {
>  			compatible = "st,spear1340-pcie", "snps,dw-pcie";
> -			reg = <0xb4000000 0x4000>;
> +			reg = <0xb4000000 0x4000>, <0xc0000000 0x20000>;
> +			reg-names = "dbi", "config";
>  			interrupts = <0 70 0x4>;
>  			interrupt-map-mask = <0 0 0 0>;
>  			interrupt-map = <0x0 0 &gic 0 70 0x4>;
> @@ -131,8 +132,7 @@
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> -			ranges = <0x00000800 0 0xc0000000 0xc0000000 0 0x00020000   /* configuration space */
> -				0x81000000 0 0	 0xc0020000 0 0x00010000   /* downstream I/O */
> +			ranges = <0x81000000 0 0	 0xc0020000 0 0x00010000   /* downstream I/O */
>  				0x82000000 0 0xc0030000 0xc0030000 0 0x0ffd0000>; /* non-prefetchable memory */
>  			status = "disabled";
>  		};
> diff --git a/arch/arm/boot/dts/spear1340.dtsi b/arch/arm/boot/dts/spear1340.dtsi
> index e71df0f2cb52..13e1aa33daa2 100644
> --- a/arch/arm/boot/dts/spear1340.dtsi
> +++ b/arch/arm/boot/dts/spear1340.dtsi
> @@ -50,7 +50,8 @@
>  
>  		pcie0: pcie@b1000000 {
>  			compatible = "st,spear1340-pcie", "snps,dw-pcie";
> -			reg = <0xb1000000 0x4000>;
> +			reg = <0xb1000000 0x4000>, <0x80000000 0x20000>;
> +			reg-names = "dbi", "config";
>  			interrupts = <0 68 0x4>;
>  			interrupt-map-mask = <0 0 0 0>;
>  			interrupt-map = <0x0 0 &gic 0 68 0x4>;
> @@ -60,8 +61,7 @@
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> -			ranges = <0x00000800 0 0x80000000 0x80000000 0 0x00020000   /* configuration space */
> -				0x81000000 0 0	 0x80020000 0 0x00010000   /* downstream I/O */
> +			ranges = <0x81000000 0 0	 0x80020000 0 0x00010000   /* downstream I/O */
>  				0x82000000 0 0x80030000 0xc0030000 0 0x0ffd0000>; /* non-prefetchable memory */
>  			status = "disabled";
>  		};
> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
> index 6dea9e43a75c..85f594e1708f 100644
> --- a/drivers/pci/host/pcie-spear13xx.c
> +++ b/drivers/pci/host/pcie-spear13xx.c
> @@ -340,7 +340,7 @@ static int __init spear13xx_pcie_probe(struct platform_device *pdev)
>  
>  	pp->dev = dev;
>  
> -	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
>  	pp->dbi_base = devm_ioremap_resource(dev, dbi_base);
>  	if (IS_ERR(pp->dbi_base)) {
>  		dev_err(dev, "couldn't remap dbi base %p\n", dbi_base);
> -- 
> 1.8.1.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
