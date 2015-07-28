Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:21121 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934AbbG1H3Z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jul 2015 03:29:25 -0400
Message-ID: <55B72F1A.50701@hisilicon.com>
Date: Tue, 28 Jul 2015 15:28:26 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: Zhou Wang <wangzhou1@hisilicon.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, <gabriele.paoloni@huawei.com>,
	<lorenzo.pieralisi@arm.com>, James Morse <james.morse@arm.com>,
	<Liviu.Dudau@arm.com>, <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>, <robh@kernel.org>,
	<linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <yuanzhichang@hisilicon.com>,
	<zhudacai@hisilicon.com>, <zhangjukuo@huawei.com>,
	<qiuzhenfa@hisilicon.com>, <liudongdong3@huawei.com>,
	<qiujiang@huawei.com>, <kangfenglong@huawei.com>,
	<liguozhu@hisilicon.com>
Subject: Re: [PATCH v5 4/5] Documentation: DT: Add HiSilicon PCIe host binding
References: <1437794486-21134-1-git-send-email-wangzhou1@hisilicon.com> <1437794486-21134-5-git-send-email-wangzhou1@hisilicon.com>
In-Reply-To: <1437794486-21134-5-git-send-email-wangzhou1@hisilicon.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/7/25 11:21, Zhou Wang wrote:
> This patch adds related DTS binding document for HiSilicon PCIe host driver.
> 
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>

Hi Arnd and Rob,

As Bjorn mentioned in v4 series, this patch need your ack.
Could you help to review this patch?

Thanks,
Zhou

> ---
>  .../devicetree/bindings/pci/hisilicon-pcie.txt     | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> new file mode 100644
> index 0000000..2afc9d1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> @@ -0,0 +1,46 @@
> +HiSilicon PCIe host bridge DT description
> +
> +HiSilicon PCIe host controller is based on Designware PCI core.
> +It shares common functions with PCIe Designware core driver and inherits
> +common properties defined in
> +Documentation/devicetree/bindings/pci/designware-pci.txt.
> +
> +Additional properties are described here:
> +
> +Required properties:
> +- compatible: Should contain "hisilicon,hip05-pcie".
> +- reg: Should contain rc_dbi, subctrl, config registers location and length.
> +- reg-names: Must include the following entries:
> +  "rc_dbi": controller configuration registers;
> +  "subctrl": whole PCIe hosts configuration registers;
> +  "config": PCIe configuration space registers.
> +- msi-parent: Should be its_pcie which is an ITS receiving MSI interrupts.
> +- port-id: Should be 0, 1, 2 or 3.
> +
> +Optional properties:
> +- status: Either "ok" or "disabled".
> +- dma-coherent: Present if DMA operations are coherent.
> +
> +Example:
> +	pcie@0xb0080000 {
> +		compatible = "hisilicon,hip05-pcie", "snps,dw-pcie";
> +		reg = <0 0xb0080000 0 0x10000>, <0 0xb0000000 0 0x10000>,
> +		      <0x220 0x00000000 0 0x2000>;
> +		reg-names = "rc_dbi", "subctrl", "config";
> +		bus-range = <0  15>;
> +		msi-parent = <&its_pcie>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		device_type = "pci";
> +		dma-coherent;
> +		ranges = <0x82000000 0 0x00000000 0x220 0x00000000 0 0x10000000>;
> +		num-lanes = <8>;
> +		port-id = <1>;
> +		#interrupts-cells = <1>;
> +		interrupts-map-mask = <0xf800 0 0 7>;
> +		interrupts-map = <0x0 0 0 1 &mbigen_pcie 1 10
> +				  0x0 0 0 2 &mbigen_pcie 2 11
> +				  0x0 0 0 3 &mbigen_pcie 3 12
> +				  0x0 0 0 4 &mbigen_pcie 4 13>;
> +		status = "ok";
> +	};
> 


