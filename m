Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33012 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936327AbcJZW1D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2016 18:27:03 -0400
Date: Wed, 26 Oct 2016 17:27:01 -0500
From: Rob Herring <robh@kernel.org>
To: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, bhelgaas@google.com,
        mark.rutland@arm.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-serial@vger.kernel.org, minyard@acm.org,
        benh@kernel.crashing.org, liviu.dudau@arm.com,
        zourongrong@gmail.com, john.garry@huawei.com,
        gabriele.paoloni@huawei.com, zhichang.yuan02@gmail.com,
        kantyzc@163.com, xuwei5@hisilicon.com
Subject: Re: [PATCH V4 3/3] ARM64 LPC: LPC driver implementation on Hip06
Message-ID: <20161026222701.pptd33e5uaokhvce@rob-hp-laptop>
References: <1476954940-242159-1-git-send-email-yuanzhichang@hisilicon.com>
 <1476954940-242159-4-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476954940-242159-4-git-send-email-yuanzhichang@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 20, 2016 at 05:15:40PM +0800, zhichang.yuan wrote:
> On Hip06, the accesses to LPC peripherals work in an indirect way. A
> corresponding LPC driver configure some registers in LPC master at first, then
> the real accesses on LPC slave devices are finished by the LPC master, which
> is transparent to LPC driver.
> This patch implement the relevant driver for Hip06 LPC. Cooperating with
> indirect-IO, ipmi messages is in service without any changes on ipmi driver.
> 
> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> ---
>  .../arm/hisilicon/hisilicon-low-pin-count.txt      |  31 ++
>  MAINTAINERS                                        |   8 +
>  drivers/bus/Kconfig                                |   8 +
>  drivers/bus/Makefile                               |   1 +
>  drivers/bus/hisi_lpc.c                             | 501 +++++++++++++++++++++
>  5 files changed, 549 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
>  create mode 100644 drivers/bus/hisi_lpc.c
> 
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
> new file mode 100644
> index 0000000..e681419
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
> @@ -0,0 +1,31 @@
> +Hisilicon Hip06 low-pin-count device
> +  Usually LPC controller is part of PCI host bridge, so the legacy ISA ports
> +  locate on LPC bus can be accessed direclty. But some SoCs have independent
> +  LPC controller, and access the legacy ports by triggering LPC I/O cycles.
> +  Hisilicon Hip06 implements this LPC device.
> +
> +Required properties:
> +- compatible: should be "hisilicon,low-pin-count"

This should be an SoC specific compatible string.

> +- #address-cells: must be 2 which stick to the ISA/EISA binding doc.
> +- #size-cells: must be 1 which stick to the ISA/EISA binding doc.
> +- reg: base memory range where the register set for this device is mapped.
> +
> +Note:
> +  The node name before '@' must be "isa" to represent the binding stick to the
> +  ISA/EISA binding specification.
> +
> +Example:
> +
> +isa@a01b0000 {
> +	compatible = "hisilicom,low-pin-count";
> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +	reg = <0x0 0xa01b0000 0x0 0x1000>;
> +
> +	ipmi0: bt@e4 {
> +		compatible = "ipmi-bt";
> +		device_type = "ipmi";
> +		reg = <0x01 0xe4 0x04>;
> +		status = "disabled";
> +	};
> +};
