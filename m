Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:42769 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751110AbeDPVn0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2018 17:43:26 -0400
Date: Mon, 16 Apr 2018 16:43:24 -0500
From: Rob Herring <robh@kernel.org>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        mark.rutland@arm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 04/10] bindings: PCI: designware: Add support for the
 EP in Designware driver
Message-ID: <20180416214324.wcyghdwejucoutki@rob-hp-laptop>
References: <cover.1523881182.git.gustavo.pimentel@synopsys.com>
 <7d3445e3f8bb15d27987e0d061275d7d69f2c519.1523881182.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7d3445e3f8bb15d27987e0d061275d7d69f2c519.1523881182.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 16, 2018 at 03:37:52PM +0100, Gustavo Pimentel wrote:
> Add device tree binding documentation for the Endpoint in PCIe Designware
> driver.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Change v1->v2:
>  - Add a missing log description.
>  - Add "snps,dw-pcie" compatible string following Kishon's suggestion.
> Change v2->v3:
> - Reverted pcie_ep name to pcie.
> Changes v3->v4:
> - Reverted "snps,dw-pcie-rc" compatible string requested by Rob Herring.
> 
>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> index 7f9804d..980fc9a 100644
> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> @@ -3,6 +3,7 @@
>  Required properties:
>  - compatible:
>  	"snps,dw-pcie" for RC mode;
> +	"snps,dw-pcie-ep" for EP mode;
>  - reg: Should contain the configuration address space.
>  - reg-names: Must be "config" for the PCIe configuration space.
>      (The old way of getting the configuration address space from "ranges"
> @@ -56,3 +57,15 @@ Example configuration:
>  		#interrupt-cells = <1>;
>  		num-lanes = <1>;
>  	};
> +or
> +	pcie: pcie@dfc00000 {
> +		compatible = "snps,dw-pcie-ep";
> +		reg = <0xdfc00000 0x0001000>, /* IP registers 1 */
> +		      <0xdfc01000 0x0001000>, /* IP registers 2 */
> +		      <0xd0000000 0x2000000>; /* Configuration space */
> +		reg-names = "dbi", "dbi2", "addr_space";
> +		device_type = "pci";

This should not be present for endpoints.

With that dropped,

Reviewed-by: Rob Herring <robh@kernel.org>


> +		num-ib-windows = <6>;
> +		num-ob-windows = <2>;
> +		num-lanes = <1>;
> +	};
> -- 
> 2.7.4
> 
> 
