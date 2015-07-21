Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34098 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102AbbGUXCL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2015 19:02:11 -0400
Received: by iebmu5 with SMTP id mu5so153986781ieb.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2015 16:02:10 -0700 (PDT)
Date: Tue, 21 Jul 2015 18:02:05 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, gabriele.paoloni@huawei.com,
	lorenzo.pieralisi@arm.com, James Morse <james.morse@arm.com>,
	Liviu.Dudau@arm.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	yuanzhichang@hisilicon.com, zhudacai@hisilicon.com,
	zhangjukuo@huawei.com, qiuzhenfa@hisilicon.com,
	liudongdong3@huawei.com, qiujiang@huawei.com,
	kangfenglong@huawei.com, liguozhu@hisilicon.com,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 4/5] Documentation: DT: Add Hisilicon PCIe host binding
Message-ID: <20150721230205.GN21967@google.com>
References: <1437461323-3531-1-git-send-email-wangzhou1@hisilicon.com>
 <1437461323-3531-5-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437461323-3531-5-git-send-email-wangzhou1@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rob]

On Tue, Jul 21, 2015 at 02:48:42PM +0800, Zhou Wang wrote:
> This patch adds related DTS binding document for Hisilicon PCIe host driver.
> 
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>

If I merge this via my tree, I'm looking for an ack from Arnd and/or Rob
here.

> ---
>  .../devicetree/bindings/pci/hisilicon-pcie.txt     | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> new file mode 100644
> index 0000000..6c9b827
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> @@ -0,0 +1,46 @@
> +Hisilicon PCIe host bridge DT description

Even the website at http://hisilicon.com isn't consistent, but there is
some indication that the correct capitalization would be "HiSilicon".
Since this is English text, feel free to capitalize it correctly here :)

Similarly, Synopsys seems to use "DesignWare," so I try to use that when
it makes sense.

> +Hisilicon PCIe host controller is based on Designware PCI core.
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
> +- msi-parent: Should be its_pcie which is an its receiving MSI interrupts.

I guess "its" here is an abbreviation for something; if so, this would read
better as "... which is an ITS receiving ..."

> +- port-id: Should be 0, 1, 2 or 3.
> +
> +Optional properties:
> +- status: Either "ok" or "disabled".
> +- dma-coherent: Present if dma operations are coherent.

"if DMA operations"

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
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
