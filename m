Return-Path: <SRS0=xQ/V=H4=huawei.com=chenyao11@kernel.org>
Return-Path: <SRS0=xQ/V=H4=huawei.com=chenyao11@kernel.org>
Subject: Re: [PATCH] Kirin-PCIe: Add kirin pcie msi feature.
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
	<lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>, <xuwei5@hisilicon.com>,
	<robh+dt@kernel.org>, <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
	<will.deacon@arm.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <dimitrysh@google.com>,
	<guodong.xu@linaro.org>, Stanimir Varbanov <svarbanov@mm-sol.com>, "Jianguo
 Sun" <sunjianguo1@huawei.com>, Shawn Guo <shawn.guo@linaro.org>,
	<suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>
References: <1525763028-107417-1-git-send-email-chenyao11@huawei.com>
 <20180508125658.GK161390@bhelgaas-glaptop.roam.corp.google.com>
From: Yao Chen <chenyao11@huawei.com>
Message-ID: <a9f05f3d-9c5c-472b-73be-f37c41bd71be@huawei.com>
Date: Wed, 9 May 2018 14:28:52 +0800
MIME-Version: 1.0
In-Reply-To: <20180508125658.GK161390@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>



On 2018/5/8 20:56, Bjorn Helgaas wrote:
> [+cc Stanimir, Jianguo, Shawn for qcom, histb comments below]
> 
> On Tue, May 08, 2018 at 03:03:48PM +0800, Yao Chen wrote:
>> This patch adds kirin pcie msi feature.
> 
> Thanks for the patch!  Please update your subject and changelog like this:
> 
>   PCI: kirin: Add MSI support
> 
>   Add support for MSI.
> 
> You can figure out what style to use for the subject by running:
> 
>   git log --oneline drivers/pci/dwc/pcie-kirin.c
> 
> Then follow the existing style.
> 

Ok, I will update the style of subject and changelog.

>> Signed-off-by: Yao Chen <chenyao11@huawei.com>
>> ---
>>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi |  2 ++
>>  drivers/pci/dwc/pcie-kirin.c              | 38 +++++++++++++++++++++++++++++++
>>  2 files changed, 40 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> index ec3eb8e..4ef684f 100644
>> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> @@ -872,6 +872,8 @@
>>  				  0x0 0x02000000>;
>>  			num-lanes = <1>;
>>  			#interrupt-cells = <1>;
>> +			interrupts = <0 283 4>;
>> +			interrupts-names = "msi";
>>  			interrupt-map-mask = <0xf800 0 0 7>;
>>  			interrupt-map = <0x0 0 0 1
>>  					 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
>> diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c
>> index d2970a0..2319c9c 100644
>> --- a/drivers/pci/dwc/pcie-kirin.c
>> +++ b/drivers/pci/dwc/pcie-kirin.c
>> @@ -426,9 +426,28 @@ static int kirin_pcie_establish_link(struct pcie_port *pp)
>>  	return 0;
>>  }
>>  
>> +static irqreturn_t kirin_pcie_msi_irq_handler(int irq, void *arg)
>> +{
>> +	struct pcie_port *pp = arg;
>> +
>> +	return dw_handle_msi_irq(pp);
>> +}
>> +
>> +static void kirin_pcie_msi_init(struct pcie_port *pp)
>> +{
>> +	dw_pcie_msi_init(pp);
>> +}
>> +
>> +static void kirin_pcie_enable_interrupts(struct pcie_port *pp)
>> +{
>> +	if (IS_ENABLED(CONFIG_PCI_MSI))
>> +		kirin_pcie_msi_init(pp);
>> +}
>> +
>>  static int kirin_pcie_host_init(struct pcie_port *pp)
>>  {
>>  	kirin_pcie_establish_link(pp);
>> +	kirin_pcie_enable_interrupts(pp);
>>  
>>  	return 0;
>>  }
>> @@ -448,6 +467,25 @@ static int kirin_pcie_host_init(struct pcie_port *pp)
>>  static int __init kirin_add_pcie_port(struct dw_pcie *pci,
>>  				      struct platform_device *pdev)
>>  {
>> +	int ret;
>> +
>> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>> +		pci->pp.msi_irq = platform_get_irq(pdev, 0);
>> +		if (!pci->pp.msi_irq) {
>> +			dev_err(&pdev->dev, "failed to get msi irq\n");
> 
> s/msi irq/MSI IRQ/
> 
>> +			return -ENODEV;
>> +		}
>> +		ret = devm_request_irq(&pdev->dev, pci->pp.msi_irq,
>> +				       kirin_pcie_msi_irq_handler,
>> +				       IRQF_SHARED | IRQF_NO_THREAD,
>> +				       "kirin_pcie_msi", &pci->pp);
>> +		if (ret) {
>> +			dev_err(&pdev->dev, "failed to request msi irq\n");
> 
> s/msi irq/MSI IRQ/
> Also, please include the IRQ number (pci->pp.msi_irq) in the message.
> 
Ok, I will add msi_irq message.

>> +			return ret;
>> +		}
>> +	}
>> +
>> +	pci->pp.root_bus_nr = -1;
> 
> Setting root_bus_nr looks like an unrelated change that should be in a
> separate patch.
> 
> But I'm not sure why you need to set root_bus_nr at all, since
> dw_pcie_host_init() always sets it.
> 
> Some other callers of dw_pcie_host_init() do set it:
> 
>   exynos_add_pcie_port()
>   imx6_add_pcie_port()
>   armada8k_add_pcie_port()
>   artpec6_add_pcie_port()
>   dw_plat_add_pcie_port()
>   histb_pcie_probe()
>   qcom_pcie_probe()
>   spear13xx_add_pcie_port()
> 
> But I don't see *why* any of these need to set it.  If they don't need to
> set it, they shouldn't.
> 
> And it would be nice if histb and qcom followed the structure and naming
> conventions of the other drivers, i.e., they should have
> histb_add_pcie_port() and qcom_add_pcie_port().
> 

You're right, "pci->pp.root_bus_nr = -1;" is truly unnecessary. I will delete it.

>>  	pci->pp.ops = &kirin_pcie_host_ops;
>>  
>>  	return dw_pcie_host_init(&pci->pp);
>> -- 
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> .
> 
Thanks,
Yao
