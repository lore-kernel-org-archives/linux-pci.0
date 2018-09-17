Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <5b9f3f71.1c69fb81.46bcf.b351@mx.google.com>
From: Rob Herring <robh@kernel.org>
To: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 1/5] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP SPI
 Controller
References: <20180910115935.163121-1-lkundrak@v3.sk>
 <20180910115935.163121-2-lkundrak@v3.sk>
MIME-Version: 1.0
In-Reply-To: <20180910115935.163121-2-lkundrak@v3.sk>
Date: Sun, 16 Sep 2018 22:00:14 -0500
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Eric Miao <eric.y.miao@gmail.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Daniel Mack <daniel@zonque.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 10, 2018 at 01:59:31PM +0200, Lubomir Rintel wrote:
> This is the SPI controller found on Marvel MMP2 and perhaps more
> platforms.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  .../devicetree/bindings/spi/spi-pxa2xx.txt    | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt b/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
> new file mode 100644
> index 000000000000..75be87cf9909
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
> @@ -0,0 +1,24 @@
> +PXA2xx SSP SPI Controller
> +
> +Required properties:
> +- compatible: Must be "marvell,mmp2-ssp".
> +- reg: Offset and length of the device's register set.
> +- interrupts: Should be the interrupt number.
> +- clocks: Should contain a single entry describing the clock input.
> +- #address-cells:  Number of cells required to define a chip select address.
> +- #size-cells: Should be zero.
> +
> +Optional properties:
> +- cs-gpios: list of GPIO chip selects. See the SPI bus bindings,
> +  Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Child nodes represent devices on the SPI bus
> +  See ../spi/spi-bus.txt
> +
> +Example:
> +	ssp1: ssp@d4035000 {

spi@...

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +		compatible = "marvell,mmp2-ssp";
> +		reg = <0xd4035000 0x1000>;
> +		clocks = <&soc_clocks MMP2_CLK_SSP0>;
> +		interrupts = <0>;
> +	};
> -- 
> 2.17.1
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
