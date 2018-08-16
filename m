Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: meson: add DT bindings for Amlogic
 Meson PCIe controller
To: Jerome Brunet <jbrunet@baylibre.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <1534227522-186798-1-git-send-email-hanjie.lin@amlogic.com>
 <1534227522-186798-2-git-send-email-hanjie.lin@amlogic.com>
 <fd6b76f0c6f5b4dfd1527440b0f6275417e434c1.camel@baylibre.com>
From: Hanjie Lin <hanjie.lin@amlogic.com>
Message-ID: <e83998fa-a4d2-5593-1a41-70bd232b4123@amlogic.com>
Date: Thu, 16 Aug 2018 11:11:26 +0800
MIME-Version: 1.0
In-Reply-To: <fd6b76f0c6f5b4dfd1527440b0f6275417e434c1.camel@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 Yue Wang <yue.wang@amlogic.com>, linux-pci@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



On 2018/8/14 18:41, Jerome Brunet wrote:
> On Tue, 2018-08-14 at 02:18 -0400, Hanjie Lin wrote:
>> From: Yue Wang <yue.wang@amlogic.com>
>>
>> The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
>> PCI core. This patch adds documentation for the DT bindings in Meson PCIe
>> controller.
>>
>> Signed-off-by: Yue Wang <hanjie.lin@amlogic.com>
>> Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
>> ---
>>  .../devicetree/bindings/pci/amlogic,meson-pcie.txt | 57 ++++++++++++++++++++++
>>  1 file changed, 57 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
>> new file mode 100644
>> index 0000000..48233e4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
>> @@ -0,0 +1,57 @@
>> +Amlogic Meson AXG DWC PCIE SoC controller
>> +
>> +Amlogic Meson PCIe host controller is based on the Synopsys DesignWare PCI core.
>> +It shares common functions with the PCIe DesignWare core driver and
>> +inherits common properties defined in
>> +Documentation/devicetree/bindings/pci/designware-pci.txt.
>> +
>> +Additional properties are described here:
>> +
>> +Required properties:
>> +- compatible:
>> +	should contain "amlogic,axg-pcie" to identify the core.
>> +- reg:
>> +	Should contain the configuration address space.
>> +- reg-names: Must be
>> +	- "elbi"	External local bus interface registers
>> +	- "cfg"		Meson specific registers
>> +	- "config"	PCIe configuration space
>> +- clocks: Must contain an entry for each entry in clock-names.
>> +- clock-names: Must include the following entries:
>> +	- "pcie"
>> +	- "pcie_bus"
>> +	- "pcie_general"
>> +	- "pcie_mipi_en"
> 
> Could you briefly describe what each clock is needed for ?
> 

Yes, is this more clear?

- clock-names:  Amlogic Meson AXG
Usage: required for  
Value type: <stringlist>
Definition: Should contain the following entries
- "pclk"       PCIe GEN 100M PLL clock
- "port"       PCIe_x(A 0r B) RC clock gate 
- "general"    PCIe Phy clock 
- "mipi"       PCIe_x(A or B) 100M ref clock gate

>> +
>> +Example configuration:
>> +
>> +	pcie: pcie@dffff000 {
>> +			compatible = "amlogic,axg-pcie", "snps,dw-pcie";
>> +			reg = <0x0 0xf9800000 0x0 0x400000
>> +					0x0 0xff646000 0x0 0x2000
>> +					0x0 0xf9f00000 0x0 0x100000>;
>> +			reg-names = "elbi", "cfg", "config";
>> +			reset-gpio = <&gpio GPIOX_19 GPIO_ACTIVE_HIGH>;
>> +			interrupts = <0 177 IRQ_TYPE_EDGE_RISING>;
> 
> replace 0 with GIC_SPI please

Right, I will fix it.

> 
>> +			#interrupt-cells = <1>;
>> +			interrupt-map-mask = <0 0 0 0>;
>> +			interrupt-map = <0 0 0 0 &gic GIC_SPI 179 IRQ_TYPE_EDGE_RISING>;
>> +			bus-range = <0x0 0xff>;
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +			device_type = "pci";
>> +			phys = <&pcie_phy>;
>> +			ranges = <0x82000000 0 0 0x0 0xf9c00000 0 0x00300000>;
>> +			num-lanes = <1>;
>> +			pcie-num = <1>;
>> +
>> +			clocks = <&clkc CLKID_USB
>> +					&clkc CLKID_MIPI_ENABLE
>> +					&clkc CLKID_PCIE_A
>> +					&clkc CLKID_PCIE_CML_EN0>;
>> +			clock-names = "pcie_general",
>> +					"pcie_refpll",
>> +					"pcie_mipi_en",
>> +					"pcie",
>> +					"port";
> 
> Several things are disturbing above:
> * pcie_general is provided by the USB clock gate ???
> * pcie_refpll: I suppose this is a copy/paste error, not used in your driver
> (and shouldn't be need BTW)
> 
> suggested names:
> * pcie_general -> general
> * pcie_mipi_en -> mipi
> * pcie -> pclk
> * port (OK)
> 

Thanks, we will follow your suggestion.

>> +	};
> 
> 
> .
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
