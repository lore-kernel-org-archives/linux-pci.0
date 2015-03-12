Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:45152 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbbCLVOv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Mar 2015 17:14:51 -0400
Received: by oifu20 with SMTP id u20so17019598oif.12
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2015 14:14:51 -0700 (PDT)
Date: Thu, 12 Mar 2015 16:14:48 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Ray Jui <rjui@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Hauke Mehrtens <hauke@hauke-m.de>,
	Paul Bolle <pebolle@tiscali.nl>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Dmitry Torokhov <dtor@google.com>,
	Anatol Pomazau <anatol@google.com>,
	Scott Branden <sbranden@broadcom.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v6 2/4] pci: iProc: define iProc PCIe platform bus binding
Message-ID: <20150312211448.GG7346@google.com>
References: <1426097169-20805-1-git-send-email-rjui@broadcom.com>
 <1426097169-20805-3-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426097169-20805-3-git-send-email-rjui@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rob, Pawel, Mark, Ian, Kumar]

On Wed, Mar 11, 2015 at 11:06:07AM -0700, Ray Jui wrote:
> Document the Broadcom iProc PCIe platform interface device tree binding
> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>

I'd like to get an ack for this from Arnd, Rob, or other device tree folks
(CC'd).

> ---
>  .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |   63 ++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> new file mode 100644
> index 0000000..f7ce50e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> @@ -0,0 +1,63 @@
> +* Broadcom iProc PCIe controller with the platform bus interface
> +
> +Required properties:
> +- compatible: Must be "brcm,iproc-pcie"
> +- reg: base address and length of the PCIe controller I/O register space
> +- #interrupt-cells: set to <1>
> +- interrupt-map-mask and interrupt-map, standard PCI properties to define the
> +  mapping of the PCIe interface to interrupt numbers
> +- linux,pci-domain: PCI domain ID. Should be unique for each host controller
> +- bus-range: PCI bus numbers covered
> +- #address-cells: set to <3>
> +- #size-cells: set to <2>
> +- device_type: set to "pci"
> +- ranges: ranges for the PCI memory and I/O regions
> +
> +Optional properties:
> +- phys: phandle of the PCIe PHY device
> +- phy-names: must be "pcie-phy"
> +
> +Example:
> +	pcie0: pcie@18012000 {
> +		compatible = "brcm,iproc-pcie";
> +		reg = <0x18012000 0x1000>;
> +
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 0>;
> +		interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
> +
> +		linux,pci-domain = <0>;
> +
> +		bus-range = <0x00 0xff>;
> +
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		device_type = "pci";
> +		ranges = <0x81000000 0 0	  0x28000000 0 0x00010000
> +			  0x82000000 0 0x20000000 0x20000000 0 0x04000000>;
> +
> +		phys = <&phy 0 5>;
> +		phy-names = "pcie-phy";
> +	};
> +
> +	pcie1: pcie@18013000 {
> +		compatible = "brcm,iproc-pcie";
> +		reg = <0x18013000 0x1000>;
> +
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 0>;
> +		interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
> +
> +		linux,pci-domain = <1>;
> +
> +		bus-range = <0x00 0xff>;
> +
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		device_type = "pci";
> +		ranges = <0x81000000 0 0	  0x48000000 0 0x00010000
> +			  0x82000000 0 0x40000000 0x40000000 0 0x04000000>;
> +
> +		phys = <&phy 1 6>;
> +		phy-names = "pcie-phy";
> +	};
> -- 
> 1.7.9.5
> 
