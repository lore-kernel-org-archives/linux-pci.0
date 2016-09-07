Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH] pcie: qcom: add support to msm8996 PCIE controller
To: Robin Murphy <robin.murphy@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Stanimir Varbanov <svarbanov@mm-sol.com>, linux-pci@vger.kernel.org
References: <1473246412-24616-1-git-send-email-srinivas.kandagatla@linaro.org>
 <34872e94-9679-5572-e39b-e962842b074e@arm.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ad4307b7-c683-498e-7412-45ba76c819f0@linaro.org>
Date: Wed, 7 Sep 2016 13:53:11 +0100
MIME-Version: 1.0
In-Reply-To: <34872e94-9679-5572-e39b-e962842b074e@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Thanks for the comments,

On 07/09/16 12:57, Robin Murphy wrote:
> On 07/09/16 12:06, Srinivas Kandagatla wrote:
>> This patch adds support to msm8996/apq8096 pcie, MSM8996 supports
>> Gen 1/2, One lane, 3 pcie root-complex with support to MSI and
>> legacy interrupts and it conforms to PCI Express Base 2.1 specification.
>>
>> This patch adds post_init callback to qcom_pcie_ops, as this is pcie
>> pipe clocks and smmu configuration are only setup after the phy is
>> powered on. It also adds ltssm_enable callback as it is very much
>> different to other supported SOCs in the driver.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>
>> I tested this patch along with phy driver patch on DB820c based on
>> APQ8096 on port A and port B using sata and ethernet controllers.
>>
>> Thanks
>> srini
>>
>>  .../devicetree/bindings/pci/qcom,pcie.txt          |  88 +++++++-
>>  drivers/pci/host/pcie-qcom.c                       | 237 ++++++++++++++++++++-
>>  2 files changed, 318 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>> index 4059a6f..1ddfcb4 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>> @@ -92,6 +92,18 @@
>>  			- "aux"		Auxiliary (AUX) clock
>>  			- "bus_master"	Master AXI clock
>>  			- "bus_slave"	Slave AXI clock
>> +
>> +- clock-names:
>> +	Usage: required for msm8996/apq8096
>> +	Value type: <stringlist>
>> +	Definition: Should contain the following entries
>> +			- "aux"		Auxiliary (AUX) clock
>> +			- "bus_master"	Master AXI clock
>> +			- "bus_slave"	Slave AXI clock
>> +			- "pipe"	Pipe Clock driving internal logic.
>> +			- "cfg"		Configuration clk.
>> +			- "snoc_axi"	SNOC AXI clk
>> +			- "cnoc_ahb"	CNOC AHB clk
>>  - resets:
>>  	Usage: required
>>  	Value type: <prop-encoded-array>
>> @@ -114,8 +126,15 @@
>>  	Definition: Should contain the following entries
>>  			- "core" Core reset
>>
>> +- iommus:
>> +	Usage: required for msm8996/apq8096
>> +	Value type: <prop-encoded-array>
>> +	Definition: Should point to the respective IOMMU block with master port
>> +		    as argument, see Documentation/devicetree/bindings/iommu/
>> +		    mediatek,iommu.txt for details.
>
> Qualcomm have cross-licensed the M4U!? :P
Oops...Copy paste error!!
This is supposed to be Documentation/devicetree/bindings/iommu/arm,smmu.txt

>
> In seriousness, though, it seems a bit odd to list "iommus" as a
> required property - unless the IOMMU is actually an integral part of the
> PCIe root complex being described (in which case it wants its own
> binding documenting as well), then the relationship is merely a
> circumstance of integration of those particular SoCs.
>
>> +
>>  - power-domains:
>> -	Usage: required for apq8084
>> +	Usage: required for apq8084 and msm8996/apq8096
>>  	Value type: <prop-encoded-array>
>>  	Definition: A phandle and power domain specifier pair to the
>>  		    power domain which is responsible for collapsing
>> @@ -137,6 +156,11 @@
>>  	Definition: A phandle to the analog power supply for IC which generates
>>  		    reference clock
>>
>> +- vdda_1p8-supply:
>> +	Usage: required for msm8996/apq8096
>> +	Value type: <phandle>
>> +	Definition: A phandle to the analog power supply for PCIE_1P8
>> +
>>  - phys:
>>  	Usage: required for apq8084
>>  	Value type: <phandle>
>> @@ -231,3 +255,65 @@
>>  		pinctrl-0 = <&pcie0_pins_default>;
>>  		pinctrl-names = "default";
>>  	};
>> +
>> +* Example for apq8096:
>> +	pcie1: qcom,pcie@00608000 {
>> +		compatible = "qcom,pcie-msm8996", "snps,dw-pcie";
>> +		power-domains = <&gcc PCIE1_GDSC>;
>> +		bus-range = <0x00 0xff>;
>> +		num-lanes = <1>;
>> +
>> +		status  = "disabled";
>> +
>> +		reg = <0x00608000 0x2000>,
>> +		      <0x0d000000 0xf1d>,
>> +		      <0x0d000f20 0xa8>,
>> +		      <0x0d100000 0x100000>;
>> +
>> +		reg-names = "parf", "dbi", "elbi","config";
>> +
>> +		phys = <&pcie_phy 1>;
>> +		phy-names = "pciephy";
>> +
>> +		#address-cells = <3>;
>> +		#size-cells = <2>;
>> +		ranges = <0x01000000 0x0 0x0d200000 0x0d200000 0x0 0x100000>,
>> +			<0x02000000 0x0 0x0d300000 0x0d300000 0x0 0xd00000>;
>> +
>> +		interrupts = <GIC_SPI 413 IRQ_TYPE_NONE>;
>> +		interrupt-names = "msi";
>> +		#interrupt-cells = <1>;
>> +		interrupt-map-mask = <0 0 0 0x7>;
>> +		interrupt-map = <0 0 0 1 &intc 0 272 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>> +				<0 0 0 2 &intc 0 273 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
>> +				<0 0 0 3 &intc 0 274 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
>> +				<0 0 0 4 &intc 0 275 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
>> +
>> +		pinctrl-names = "default", "sleep";
>> +		pinctrl-0 = <&pcie1_clkreq_default &pcie1_perst_default &pcie1_wake_default>;
>> +		pinctrl-1 = <&pcie1_clkreq_sleep &pcie1_perst_default &pcie1_wake_sleep>;
>> +
>> +
>> +		vreg-1.8-supply = <&pm8994_l12>;
>> +		vreg-0.9-supply = <&pm8994_l28>;
>> +		iommus = <&anoc0_smmu>;
>
> Furthermore, the exact meaning of "iommus" is defined by the relevant
> IOMMU's binding itself - at face value here, you're missing the LARB
> port number :P - but more generally a bare phandle with no arguments for
> something as busy as a root complex smells a bit off.

This is arm smmu v2, the smmu instance in this case had #iommu-cells = 
<0>, so no arguments were not used. However I will dig in more details 
on why this smmu instance does not accept arguments/stream-ids.

>
>> +
>> +		linux,pci-domain = <1>;
>> +
>> +		clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
>> +			<&gcc GCC_PCIE_1_AUX_CLK>,
>> +			<&gcc GCC_PCIE_1_CFG_AHB_CLK>,
>> +			<&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
>> +			<&gcc GCC_PCIE_1_SLV_AXI_CLK>,
>> +			<&gcc GCC_AGGRE0_SNOC_AXI_CLK>,
>> +			<&gcc GCC_AGGRE0_CNOC_AHB_CLK>;
>> +
>> +		clock-names =  "pipe",
>> +				"aux",
>> +				"cfg",
>> +				"bus_master",
>> +				"bus_slave",
>> +				"snoc_axi",
>> +				"cnoc_ahb";
>> +
>> +	};
>> diff --git a/drivers/pci/host/pcie-qcom.c b/drivers/pci/host/pcie-qcom.c
>> index f2f90c5..7748c11 100644
>> --- a/drivers/pci/host/pcie-qcom.c
>> +++ b/drivers/pci/host/pcie-qcom.c
> [...]
>> +static int qcom_pcie_post_init_msm8996(struct qcom_pcie *pcie)
>> +{
>> +	struct qcom_pcie_resources_msm8996 *res = &pcie->res.msm8996;
>> +	struct device *dev = pcie->dev;
>> +	int ret;
>> +
>> +	ret = clk_prepare_enable(res->pipe_clk);
>> +	if (ret) {
>> +		dev_err(dev, "cannot prepare/enable pipe clock\n");
>> +		return ret;
>> +	}
>> +	/* SMMU specific registers */
>> +	writel(0, pcie->parf + PCIE20_PARF_BDF_TRANSLATE_CFG);
>> +	writel(0, pcie->parf +	PCIE20_PARF_SID_OFFSET);
>
> Ah, so it's another of these RID->SID lookup-table-type things. That
> would be more appropriately described with "iommu-map"[1], particularly
> if you want things to actually work as expected[2]. There is of course a
> fun circular dependency there in that the DT becomes more of a promise
> than an actual description of the hardware state, since the latter
> doesn't necessarily exist until the driver programs it here. It might
> ultimately be cleaner to have the firmware program this and repaint the
> DT accordingly, so that things do look fixed from Linux's perspective.

Thanks for the hints, I will read thru the thread and give it a try.

--srini

>
> Robin.
>
> [1]:http://www.mail-archive.com/iommu@lists.linux-foundation.org/msg14165.html
> [2]:http://www.mail-archive.com/iommu@lists.linux-foundation.org/msg14162.html
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
