Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:61186 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbaDYRpl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Apr 2014 13:45:41 -0400
Received: by mail-pa0-f44.google.com with SMTP id ey11so1575762pad.3
        for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2014 10:45:41 -0700 (PDT)
Date: Fri, 25 Apr 2014 11:45:35 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: horms@verge.net.au, devicetree@vger.kernel.org, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	magnus.damm@gmail.com, linux@arm.linux.org.uk,
	linux-arm-kernel@lists.infradead.org, ben.dooks@codethink.co.uk,
	linux-doc@vger.kernel.org, rob@landley.net, grant.likely@linaro.org
Subject: Re: [PATCH] pci-rcar-gen2: add device tree support
Message-ID: <20140425174535.GF32246@google.com>
References: <201404080141.21605.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201404080141.21605.sergei.shtylyov@cogentembedded.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 08, 2014 at 01:41:20AM +0400, Sergei Shtylyov wrote:
> From: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> Add device tree probing support to the 'pci-rcar-gen2' driver.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> [Sergei: numerous fixes/cleanups]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

I'm OK with this, but it needs an ack from Simon.

> ---
> The patch is against the 'next' branch of Bjorn Helgaas' 'pci.git' repo.
> 
> Changes in version 3:
> - added "renesas,pci-r8a7791" to the possible "compatible" property values;
> - removed '#ifdef CONFIG_OF' around rcar_pci_of_match[] and hence of_match_ptr()
>   invocation too;
> - fixed trailing whitespace in the DT parsing code;
> - removed the wrong "renessas," prefix from the binding document's file name;
> - moved the PCI device sub-nodes from the board example to the SoC example;
> - fixed labels in the board example;
> - fixed grammar and punctuation in the binding document;
> - reworded the changelog, fixed the subject.
> 
> Changes in version 2:
> - merged the binding document from a separate patch;
> - moved to the "bus-range" property parsing;
> - added example to the binding document.
> 
>  Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt |   54 ++++++++++++++++
>  drivers/pci/host/pci-rcar-gen2.c                        |   32 ++++++++-
>  2 files changed, 84 insertions(+), 2 deletions(-)
> 
> Index: pci/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> ===================================================================
> --- /dev/null
> +++ pci/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> @@ -0,0 +1,54 @@
> +Renesas AHB to PCI bridge
> +-------------------------
> +
> +This is the bridge used internally to connect the USB controllers to the
> +AHB. There is one bridge instance per USB port connected to the internal
> +OHCI and EHCI controllers.
> +
> +Required properties:
> +- compatible: "renesas,pci-r8a7790" for the R8A7790 SoC;
> +	      "renesas,pci-r8a7791" for the R8A7791 SoC.
> +- reg:	A list of physical regions to access the device: the first is
> +	the operational registers for the OHCI/EHCI controllers and the
> +	second is for the bridge configuration and control registers.
> +- interrupts: interrupt for the device.
> +- clocks: The reference to the device clock.
> +- bus-range: The PCI bus number range; as this is a single bus, the range
> +	      should be specified as the same value twice.
> +
> +Example SoC configuration:
> +
> +	pci0: pci@ee090000  {
> +		compatible = "renesas,pci-r8a7790";
> +		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
> +		reg = <0x0 0xee090000 0x0 0xc00>,
> +		      <0x0 0xee080000 0x0 0x1100>;
> +		interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
> +		status = "disabled";
> +
> +		bus-range = <0 0>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +
> +		pci@0,1 {
> +			reg = <0x800 0 0 0 0>;
> +			device_type = "pci";
> +			phys = <&usbphy 0 0>;
> +			phy-names = "usb";
> +		};
> +
> +		pci@0,2 {
> +			reg = <0x1000 0 0 0 0>;
> +			device_type = "pci";
> +			phys = <&usbphy 0 0>;
> +			phy-names = "usb";
> +		};
> +	};
> +
> +Example board setup:
> +
> +&pci0 {
> +	status = "okay";
> +	pinctrl-0 = <&usb0_pins>;
> +	pinctrl-names = "default";
> +};
> Index: pci/drivers/pci/host/pci-rcar-gen2.c
> ===================================================================
> --- pci.orig/drivers/pci/host/pci-rcar-gen2.c
> +++ pci/drivers/pci/host/pci-rcar-gen2.c
> @@ -16,6 +16,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/of_pci.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/sizes.h>
> @@ -98,6 +99,7 @@ struct rcar_pci_priv {
>  	struct resource io_res;
>  	struct resource mem_res;
>  	struct resource *cfg_res;
> +	unsigned busnr;
>  	int irq;
>  	unsigned long window_size;
>  };
> @@ -312,8 +314,8 @@ static int rcar_pci_setup(int nr, struct
>  	pci_add_resource(&sys->resources, &priv->io_res);
>  	pci_add_resource(&sys->resources, &priv->mem_res);
>  
> -	/* Setup bus number based on platform device id */
> -	sys->busnr = to_platform_device(priv->dev)->id;
> +	/* Setup bus number based on platform device id / of bus-range */
> +	sys->busnr = priv->busnr;
>  	return 1;
>  }
>  
> @@ -366,6 +368,23 @@ static int rcar_pci_probe(struct platfor
>  
>  	priv->window_size = SZ_1G;
>  
> +	if (pdev->dev.of_node) {
> +		struct resource busnr;
> +		int ret;
> +
> +		ret = of_pci_parse_bus_range(pdev->dev.of_node, &busnr);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "failed to parse bus-range\n");
> +			return ret;
> +		}
> +
> +		priv->busnr = busnr.start;
> +		if (busnr.end != busnr.start)
> +			dev_warn(&pdev->dev, "only one bus number supported\n");
> +	} else {
> +		priv->busnr = pdev->id;
> +	}
> +
>  	hw_private[0] = priv;
>  	memset(&hw, 0, sizeof(hw));
>  	hw.nr_controllers = ARRAY_SIZE(hw_private);
> @@ -377,11 +396,20 @@ static int rcar_pci_probe(struct platfor
>  	return 0;
>  }
>  
> +static struct of_device_id rcar_pci_of_match[] = {
> +	{ .compatible = "renesas,pci-r8a7790", },
> +	{ .compatible = "renesas,pci-r8a7791", },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, rcar_pci_of_match);
> +
>  static struct platform_driver rcar_pci_driver = {
>  	.driver = {
>  		.name = "pci-rcar-gen2",
>  		.owner = THIS_MODULE,
>  		.suppress_bind_attrs = true,
> +		.of_match_table = rcar_pci_of_match,
>  	},
>  	.probe = rcar_pci_probe,
>  };
