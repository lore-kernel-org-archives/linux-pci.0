Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 24 Aug 2017 11:53:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v4 3/4] dt-bindings: PCI: rockchip: Add support for pcie
 wake irq
Message-ID: <20170824165353.GL31858@bhelgaas-glaptop.roam.corp.google.com>
References: <20170822031934.8675-1-jeffy.chen@rock-chips.com>
 <20170822031934.8675-4-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
In-Reply-To: <20170822031934.8675-4-jeffy.chen@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 shawn.lin@rock-chips.com, briannorris@chromium.org,
 linux-kernel@vger.kernel.org, dianders@chromium.org,
 linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
 bhelgaas@google.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 22, 2017 at 11:19:33AM +0800, Jeffy Chen wrote:
> Add an optional interrupt for PCIE_WAKE pin.

Rob?

> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  .../devicetree/bindings/pci/rockchip-pcie.txt        | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> index 5678be82530d..9f6504129e80 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> @@ -20,10 +20,13 @@ Required properties:
>  - msi-map: Maps a Requester ID to an MSI controller and associated
>  	msi-specifier data. See ./pci-msi.txt
>  - interrupts: Three interrupt entries must be specified.
> -- interrupt-names: Must include the following names
> -	- "sys"
> -	- "legacy"
> -	- "client"
> +- interrupt-names: Include the following names
> +	Required:
> +		- "sys"
> +		- "legacy"
> +		- "client"
> +	Optional:
> +		- "wake"

Why is there no other PCI binding that includes "wake" as an
interrupt-name?  This feels like something that should be fairly
common across host controllers.  I don't want a Rockport-specific
DT description if it could be made more general.

>  - resets: Must contain seven entries for each entry in reset-names.
>  	   See ../reset/reset.txt for details.
>  - reset-names: Must include the following names
> @@ -87,10 +90,11 @@ pcie0: pcie@f8000000 {
>  	clock-names = "aclk", "aclk-perf",
>  		      "hclk", "pm";
>  	bus-range = <0x0 0x1>;
> -	interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH 0>,
> -		     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH 0>,
> -		     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH 0>;
> -	interrupt-names = "sys", "legacy", "client";
> +	interrupts-extended = <&gic GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH 0>,
> +			      <&gic GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH 0>,
> +			      <&gic GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH 0>,
> +			      <&gpio0 8 IRQ_TYPE_LEVEL_LOW>;
> +	interrupt-names = "sys", "legacy", "client", "wake";
>  	assigned-clocks = <&cru SCLK_PCIEPHY_REF>;
>  	assigned-clock-parents = <&cru SCLK_PCIEPHY_REF100M>;
>  	assigned-clock-rates = <100000000>;
> -- 
> 2.11.0
> 
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
