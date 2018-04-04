Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43550 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750915AbeDDLt2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Apr 2018 07:49:28 -0400
Date: Wed, 4 Apr 2018 12:50:14 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: bhelgaas@google.com, Joao.Pinto@synopsys.com, jingoohan1@gmail.com,
        kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/8] bindings: PCI: designware: Add support for the EP in
 designware driver
Message-ID: <20180404115014.GC24669@red-moon>
References: <cover.1522235224.git.gustavo.pimentel@synopsys.com>
 <dd582bfc2780679b7a092d23547c316234a84c34.1522235224.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dd582bfc2780679b7a092d23547c316234a84c34.1522235224.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 28, 2018 at 12:38:33PM +0100, Gustavo Pimentel wrote:

Please always write a commit log even if it is trivial.

Thanks,
Lorenzo

> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> index 6300762..4bb2e08 100644
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
> +	pcie_ep: pcie_ep@dfc00000 {
> +		compatible = "snps,dw-pcie-ep";
> +		reg = <0xdfc00000 0x0001000>, /* IP registers 1 */
> +		      <0xdfc01000 0x0001000>, /* IP registers 2 */
> +		      <0xd0000000 0x2000000>; /* Configuration space */
> +		reg-names = "dbi", "dbi2", "addr_space";
> +		device_type = "pci";
> +		num-ib-windows = <6>;
> +		num-ob-windows = <2>;
> +		num-lanes = <1>;
> +	};
> -- 
> 2.7.4
> 
> 
