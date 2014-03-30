Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:38672 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbaC3U2w (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 30 Mar 2014 16:28:52 -0400
Received: by mail-lb0-f171.google.com with SMTP id w7so5121153lbi.2
        for <linux-pci@vger.kernel.org>; Sun, 30 Mar 2014 13:28:51 -0700 (PDT)
Message-ID: <53387E85.8000207@cogentembedded.com>
Date: Mon, 31 Mar 2014 00:28:53 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Ben Dooks <ben.dooks@codethink.co.uk>, linux-sh@vger.kernel.org,
	linux-usb@vger.kernel.org
CC: linux-kernel@lists.codethink.co.uk, magnus.damn@opensource.se,
	horms@verge.net.au, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/9] pci-rcar-gen2: add devicetree support
References: <1394128887-4197-1-git-send-email-ben.dooks@codethink.co.uk> <1394128887-4197-2-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394128887-4197-2-git-send-email-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/06/2014 09:01 PM, Ben Dooks wrote:

> Add OF match table for pci-rcar-gen2 driver for device tree support.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Updates since v1:
> 	- moved documentation into patch
> 	- moved to using bus-range parsing
> 	- ensured usb phy can be linked to usb devices

> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> ---
>   .../bindings/pci/renessas,pci-rcar-gen2.txt        | 52 ++++++++++++++++++++++
>   drivers/pci/host/pci-rcar-gen2.c                   | 33 +++++++++++++-
>   2 files changed, 83 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/pci/renessas,pci-rcar-gen2.txt

> diff --git a/Documentation/devicetree/bindings/pci/renessas,pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/renessas,pci-rcar-gen2.txt
> new file mode 100644
> index 0000000..bd6d291
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/renessas,pci-rcar-gen2.txt
> @@ -0,0 +1,52 @@
> +Renesas AHB to PCI bridge
> +-------------------------

    Perhaps it makes sense to describe PCIe bindings in the same file...

[...]

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
> +	};
> +
> +Example board setup:
> +
> +&pci1 {
> +	status = "okay";
> +	pinctrl-0 = <&usb1_pins>;
> +	pinctrl-names = "default";
> +
> +	pci@0,1 {
> +		reg = <0x800 0 0 0 0>;
> +		device_type = "pci";
> +		usb-phy = <&usbphy>;
> +	};
> +
> +	pci@0,2 {
> +		reg = <0x1000 0 0 0 0>;
> +		device_type = "pci";
> +		usb-phy = <&usbphy>;
> +	};
> +};

    As I said, these PCI sub-nodes belong to the SoC file.

> diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
> index fd3e3ab..1216784 100644
> --- a/drivers/pci/host/pci-rcar-gen2.c
> +++ b/drivers/pci/host/pci-rcar-gen2.c
[...]
> @@ -377,11 +396,21 @@ static int rcar_pci_probe(struct platform_device *pdev)
>   	return 0;
>   }
>
> +#ifdef CONFIG_OF

    I don't think it's really worth it.

> +static struct of_device_id rcar_pci_of_match[] = {
> +	{ .compatible = "renesas,pci-r8a7790", },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, rcar_pci_of_match);
> +#endif
> +
>   static struct platform_driver rcar_pci_driver = {
>   	.driver = {
>   		.name = "pci-rcar-gen2",
>   		.owner = THIS_MODULE,
>   		.suppress_bind_attrs = true,
> +		.of_match_table = of_match_ptr(rcar_pci_of_match),

    And so, of_match_ptr() is not needed.

WBR, Sergei

