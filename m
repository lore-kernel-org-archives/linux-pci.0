Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34569 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbbAEJkK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jan 2015 04:40:10 -0500
Message-ID: <1420450798.3024.3.camel@pengutronix.de>
Subject: Re: [PATCH] PCIe: Designware: Do not allow config space through
 ranges
From: Lucas Stach <l.stach@pengutronix.de>
To: Pratyush Anand <panand@redhat.com>
Cc: mohit.kumar@st.com, jg1.han@samsung.com, shawn.guo@freescale.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Date: Mon, 05 Jan 2015 10:39:58 +0100
In-Reply-To: <7dcdee69eb7db8336829e6085d736a3ac7e68ad4.1419229126.git.panand@redhat.com>
References: <7dcdee69eb7db8336829e6085d736a3ac7e68ad4.1419229126.git.panand@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 22.12.2014, 12:09 +0530 schrieb Pratyush Anand:
> Config space is need to be allocated using reg property. This patch
> removes possibility of config space allocation through ranges property.
> 
> To: Mohit Kumar <mohit.kumar@st.com>
> To: Jingo Han <jg1.han@samsung.com>
> To: Lucas Stach <l.stach@pengutronix.de>
> To: Shawn Guo <shawn.guo@freescale.com>
> Cc: linux-pci@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Pratyush Anand <panand@redhat.com>

This patch gets a clear NACK from me.

While removing the config space from the ranges in the relevant DTs is
ok you are breaking DT compatibility for the sake of it.
I don't see how this patch improves anything. We already warn loudly in
the designware driver if config space isn't available in the regs
property.

We already had a break in DT compatibility on imx6 to get the bindings
right and I will not allow another one to happen unless there is a clear
benefit.

Regards,
Lucas

> ---
>  arch/arm/boot/dts/imx6qdl.dtsi     |  3 +--
>  arch/arm/boot/dts/imx6sx.dtsi      |  8 ++++----
>  drivers/pci/host/pci-imx6.c        |  2 +-
>  drivers/pci/host/pcie-designware.c | 13 -------------
>  4 files changed, 6 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 4fc03b7f1cee..f21570847d08 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -143,8 +143,7 @@
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> -			ranges = <0x00000800 0 0x01f00000 0x01f00000 0 0x00080000 /* configuration space */
> -				  0x81000000 0 0          0x01f80000 0 0x00010000 /* downstream I/O */
> +			ranges = 0x81000000 0 0          0x01f80000 0 0x00010000 /* downstream I/O */
>  				  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
>  			num-lanes = <1>;
>  			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index 7a24fee1e7ae..72593a77455e 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -1197,14 +1197,14 @@
>  
>  		pcie: pcie@0x08000000 {
>  			compatible = "fsl,imx6sx-pcie", "snps,dw-pcie";
> -			reg = <0x08ffc000 0x4000>; /* DBI */
> +			reg = <0x08ffc000 0x4000>, /* DBI */
> +				<0x08f00000 0x80000>;
> +			reg-names = "dbi", "config";
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> -				  /* configuration space */
> -			ranges = <0x00000800 0 0x08f00000 0x08f00000 0 0x00080000
>  				  /* downstream I/O */
> -				  0x81000000 0 0          0x08f80000 0 0x00010000
> +			ranges =  0x81000000 0 0          0x08f80000 0 0x00010000
>  				  /* non-prefetchable memory */
>  				  0x82000000 0 0x08000000 0x08000000 0 0x00f00000>;
>  			num-lanes = <1>;
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index fdb95367721e..dae452984ed3 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -572,7 +572,7 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  	hook_fault_code(16 + 6, imx6q_pcie_abort_handler, SIGBUS, 0,
>  		"imprecise external abort");
>  
> -	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");

Additionally to the change below this is also breaking existing DTs.

>  	pp->dbi_base = devm_ioremap_resource(&pdev->dev, dbi_base);
>  	if (IS_ERR(pp->dbi_base))
>  		return PTR_ERR(pp->dbi_base);
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index df781cdf13c1..0b22b42e1ff9 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -409,19 +409,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>  			pp->mem_mod_base = of_read_number(parser.range -
>  							  parser.np + na, ns);
>  		}
> -		if (restype == 0) {
> -			of_pci_range_to_resource(&range, np, &pp->cfg);
> -			pp->cfg0_size = resource_size(&pp->cfg)/2;
> -			pp->cfg1_size = resource_size(&pp->cfg)/2;
> -			pp->cfg0_base = pp->cfg.start;
> -			pp->cfg1_base = pp->cfg.start + pp->cfg0_size;
> -
> -			/* Find the untranslated configuration space address */
> -			pp->cfg0_mod_base = of_read_number(parser.range -
> -							   parser.np + na, ns);
> -			pp->cfg1_mod_base = pp->cfg0_mod_base +
> -					    pp->cfg0_size;
> -		}
>  	}
>  
>  	ret = of_pci_parse_bus_range(np, &pp->busn);

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

