Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 3/6] arm: dts: Change PCIe INTx mapping for Cygnus
To: Ray Jui <ray.jui@broadcom.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
 <1527631130-20045-4-git-send-email-ray.jui@broadcom.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f5aa804e-3174-affd-1117-31b0a5b59fc5@gmail.com>
Date: Mon, 11 Jun 2018 15:36:43 -0700
MIME-Version: 1.0
In-Reply-To: <1527631130-20045-4-git-send-email-ray.jui@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 05/29/2018 02:58 PM, Ray Jui wrote:
> Change the PCIe INTx mapping to model the 4 INTx interrupts in the
> IRQ domain of the iProc PCIe controller itself
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  arch/arm/boot/dts/bcm-cygnus.dtsi | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index 699fdf9..6de21ef 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -254,9 +254,14 @@
>  			compatible = "brcm,iproc-pcie";
>  			reg = <0x18012000 0x1000>;
>  
> +			interrupt-controller;
>  			#interrupt-cells = <1>;
> -			interrupt-map-mask = <0 0 0 0>;
> -			interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0 0 0 1 &pcie0 1>,
> +					<0 0 0 2 &pcie0 2>,
> +					<0 0 0 3 &pcie0 3>,
> +					<0 0 0 4 &pcie0 4>;
> +			interrupts = <GIC_SPI 100 IRQ_TYPE_NONE>;

You would want to fix those IRQ_TYPE_NONE values as well because since
commit 83a86fbb5b56b5eed8a476cc3fe214077d7c4f49 ("irqchip/gic: Loudly
complain about the use of IRQ_TYPE_NONE") this is going to create some
nice warnings on boot.

I am about to send fixes for NSP and HR2 since that's what I have access
to at the moment, but it would be good if you could send updates to the
Cygnus and NS2 DTS files?

Thanks

>  
>  			linux,pci-domain = <0>;
>  
> @@ -289,9 +294,14 @@
>  			compatible = "brcm,iproc-pcie";
>  			reg = <0x18013000 0x1000>;
>  
> +			interrupt-controller;
>  			#interrupt-cells = <1>;
> -			interrupt-map-mask = <0 0 0 0>;
> -			interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0 0 0 1 &pcie1 1>,
> +					<0 0 0 2 &pcie1 2>,
> +					<0 0 0 3 &pcie1 3>,
> +					<0 0 0 4 &pcie1 4>;
> +			interrupts = <GIC_SPI 106 IRQ_TYPE_NONE>;
>  
>  			linux,pci-domain = <1>;
>  
> 


-- 
Florian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
