Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 23 Nov 2015 10:13:29 -0800
From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
CC: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: Re: [PATCH v3 3/6] DT: PCI: qcom: Document PCIe devicetree bindings
Message-ID: <20151123181329.GN30882@usrtlx11787.corpusers.net>
References: <cover.1448270813.git.stanimir.varbanov@linaro.org>
 <8fd3e7d1662f37abe549127d179c315dff3210d8.1448270813.git.stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <8fd3e7d1662f37abe549127d179c315dff3210d8.1448270813.git.stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon 23 Nov 01:29 PST 2015, Stanimir Varbanov wrote:

> From: Stanimir Varbanov <svarbanov@mm-sol.com>
> 
> Document Qualcomm PCIe driver devicetree bindings.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.txt          |  231 ++++++++++++++++++++
>  1 file changed, 231 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> new file mode 100644
> index 000000000000..d7640d45fa31
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> @@ -0,0 +1,231 @@
> +* Qualcomm PCI express root complex
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: Value shall include
> +		    - "qcom,pcie-v0" for apq/ipq8064
> +		    - "qcom,pcie-v1" for apq8084

Do you know if we have the same v1 of this block in 8994?

[..]
> +- clock-names:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: Should contain the following entries
> +		    * should be populated for v0 and v1
> +		    	- "iface"      Configuration AHB clock
> +
> +		    * should be populated for v0
> +		    	- "core"       Clocks the pcie hw block
> +		    	- "phy"        Clocks the pcie PHY block
> +
> +		    * should be populated for v1
> +			- "aux"        Auxiliary (AUX) clock
> +		    	- "bus_master" Master AXI clock
> +		    	- "bus_slave"  Slave AXI clock

You have white spaces among your tabs here.

[..]
> +- <name>-supply:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: List of phandles to the power supply regulator(s)
> +		    * should be populated for v0 and v1
> +			- "vdda"        core analog power supply
> +
> +		    * should be populated for v0
> +			- "vdda_phy"    analog power supply for PHY
> +			- "vdda_refclk" analog power supply for IC which generate
> +					reference clock

Exploding these into 3 different property descriptions would make it
easier to read, and you can say "required for v0" for the latter
two and simply "required" on the vdda.

[..]
> +- <name>-gpio:
> +	Usage: optional
> +	Value type: <prop-encoded-array>
> +	Definition: List of phandle and gpio specifier pairs. Should contain
> +		    - "perst"  PCIe endpoint reset signal line
> +		    - "pewake" PCIe endpoint wake signal line

This property should be pluralized, i.e. it's <name>-gpios.

Are these identifiers coming from some data sheet? Or could we simply
name them "reset" and "wakeup"?

> +
> +- pinctrl-0:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: List of phandles pointing at a pin(s) configuration

This is not required and as it's a property applicable to all devices we
normally don't mention them.

> +
> +- pinctrl-names
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: List of names of pinctrl-0 state
> +

dito

Regards,
Bjorn
