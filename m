Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36652 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751447AbaICGTr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 3 Sep 2014 02:19:47 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx08-00178001.pphosted.com (8.14.5/8.14.5) with SMTP id s836J7mW032445
	for <linux-pci@vger.kernel.org>; Wed, 3 Sep 2014 08:19:45 +0200
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx08-00178001.pphosted.com with ESMTP id 1p59xfdpte-1
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 03 Sep 2014 08:19:45 +0200
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 229C821
	for <linux-pci@vger.kernel.org>; Wed,  3 Sep 2014 06:19:41 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas2.st.com [10.80.176.10])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1A279ABE
	for <linux-pci@vger.kernel.org>; Wed,  3 Sep 2014 06:19:41 +0000 (GMT)
From: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
To: Pratyush ANAND <pratyush.anand@st.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Wed, 3 Sep 2014 14:19:38 +0800
Subject: RE: [PATCH V2] PCIe: SPEAr13XX: Pass config resource through reg
 property
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB661A70E51E4BE@EAPEX1MAIL1.st.com>
References: <c5feb916f14d19e4c636a5af89be48df5097b500.1409720201.git.pratyush.anand@st.com>
In-Reply-To: <c5feb916f14d19e4c636a5af89be48df5097b500.1409720201.git.pratyush.anand@st.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Pratyush ANAND
> Sent: Wednesday, September 03, 2014 10:51 AM
> To: Mohit KUMAR DCG
> Cc: linux-pci@vger.kernel.org; Pratyush ANAND
> Subject: [PATCH V2] PCIe: SPEAr13XX: Pass config resource through reg
> property
> 
> PCIe configuration space should be passed through reg property, rather than
> through ranges property. This patch does the correction for SPEAr13XX SOCs.
> 
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> ---
>  arch/arm/boot/dts/spear1310.dtsi  | 18 +++++++++---------
> arch/arm/boot/dts/spear1340.dtsi  |  6 +++---  drivers/pci/host/pcie-
> spear13xx.c |  2 +-
>  3 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/spear1310.dtsi
> b/arch/arm/boot/dts/spear1310.dtsi
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
>  			interrupt-map = <0x0 0 &gic 0 68 0x4>; @@ -95,15
> +96,15 @@
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> -			ranges = <0x00000800 0 0x80000000 0x80000000 0
> 0x00020000   /* configuration space */
> -				0x81000000 0 0	 0x80020000 0 0x00010000   /*
> downstream I/O */
> +			ranges = <0x81000000 0 0	 0x80020000 0
> 0x00010000   /* downstream I/O */
>  				0x82000000 0 0x80030000 0xc0030000 0
> 0x0ffd0000>; /* non-prefetchable memory */
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
>  			interrupt-map = <0x0 0 &gic 0 69 0x4>; @@ -113,15
> +114,15 @@
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> -			ranges = <0x00000800 0 0x90000000 0x90000000 0
> 0x00020000   /* configuration space */
> -				0x81000000 0 0  0x90020000 0 0x00010000   /*
> downstream I/O */
> +			ranges = <0x81000000 0 0  0x90020000 0 0x00010000
> /* downstream I/O */
>  				0x82000000 0 0x90030000 0x90030000 0
> 0x0ffd0000>; /* non-prefetchable memory */
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
>  			interrupt-map = <0x0 0 &gic 0 70 0x4>; @@ -131,8
> +132,7 @@
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> -			ranges = <0x00000800 0 0xc0000000 0xc0000000 0
> 0x00020000   /* configuration space */
> -				0x81000000 0 0	 0xc0020000 0 0x00010000   /*
> downstream I/O */
> +			ranges = <0x81000000 0 0	 0xc0020000 0
> 0x00010000   /* downstream I/O */
>  				0x82000000 0 0xc0030000 0xc0030000 0
> 0x0ffd0000>; /* non-prefetchable memory */
>  			status = "disabled";
>  		};
> diff --git a/arch/arm/boot/dts/spear1340.dtsi
> b/arch/arm/boot/dts/spear1340.dtsi
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
>  			interrupt-map = <0x0 0 &gic 0 68 0x4>; @@ -60,8
> +61,7 @@
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> -			ranges = <0x00000800 0 0x80000000 0x80000000 0
> 0x00020000   /* configuration space */
> -				0x81000000 0 0	 0x80020000 0 0x00010000   /*
> downstream I/O */
> +			ranges = <0x81000000 0 0	 0x80020000 0
> 0x00010000   /* downstream I/O */
>  				0x82000000 0 0x80030000 0xc0030000 0
> 0x0ffd0000>; /* non-prefetchable memory */
>  			status = "disabled";
>  		};
> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-
> spear13xx.c
> index 6dea9e43a75c..85f594e1708f 100644
> --- a/drivers/pci/host/pcie-spear13xx.c
> +++ b/drivers/pci/host/pcie-spear13xx.c
> @@ -340,7 +340,7 @@ static int __init spear13xx_pcie_probe(struct
> platform_device *pdev)
> 
>  	pp->dev = dev;
> 
> -	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	dbi_base = platform_get_resource_byname(pdev,
> IORESOURCE_MEM, "dbi");
>  	pp->dbi_base = devm_ioremap_resource(dev, dbi_base);
>  	if (IS_ERR(pp->dbi_base)) {
>  		dev_err(dev, "couldn't remap dbi base %p\n", dbi_base);

Acked-by: Mohit Kumar <mohit.kumar@st.com>

Regards
Mohit

