Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33511 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752325AbcF1VFV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2016 17:05:21 -0400
Date: Tue, 28 Jun 2016 16:05:13 -0500
From: Rob Herring <robh@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-sh@vger.kernel.or, linux-kernel@vger.kernel.org,
	27@sa76r4.localdomain, Jun@sa76r4.localdomain,
	2016@sa76r4.localdomain, +0900@sa76r4.localdomain
Subject: Re: [PATCH v3 11/19] sh: Add PCI host bridge driver for SH7751
Message-ID: <20160628210513.GA8810@rob-hp-laptop>
References: <1467095795-5082-1-git-send-email-ysato@users.sourceforge.jp>
 <1467095795-5082-12-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467095795-5082-12-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 28, 2016 at 03:36:27PM +0900, Yoshinori Sato wrote:
> This is an alternative SH7751 PCI driver.
> Existing driver (arch/sh/drivers/pci/pci-sh7751) uses SH specific interface.
> But this driver uses common PCI interface. It is more modern and generic.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  .../devicetree/bindings/pci/sh7751-pci.txt         |  51 ++++
>  arch/sh/boards/Kconfig                             |   1 +
>  arch/sh/drivers/Makefile                           |   2 +
>  arch/sh/include/asm/io.h                           |   6 +
>  drivers/pci/host/Kconfig                           |   7 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pci-sh7751.c                      | 326 +++++++++++++++++++++
>  7 files changed, 394 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/sh7751-pci.txt
>  create mode 100644 drivers/pci/host/pci-sh7751.c
> 
> diff --git a/Documentation/devicetree/bindings/pci/sh7751-pci.txt b/Documentation/devicetree/bindings/pci/sh7751-pci.txt
> new file mode 100644
> index 0000000..c3ec71a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/sh7751-pci.txt
> @@ -0,0 +1,51 @@
> +* Renesas SH7751 PCI host interfaces
> +
> +Required properties:
> +  - compatible: "renesas,sh7751-pci" is required.
> +    And board specific compatible if fixup required.
> +
> +  - reg: base address and length of the PCI controller registers.

Need to define how many reg entries and the order.

> +  - #address-cells: set to <2>
> +  - #size-cells: set to <1>
> +  - bus-range: PCI bus numbers covered
> +  - device_type: set to "pci"
> +  - ranges: ranges for the PCI memory and I/O regions.
> +  - interrupt-map-mask and interrupt-map: standard PCI properties
> +	to define the mapping of the PCI interface to interrupt
> +	numbers.
> +
> +Example:
> +	pci: pci-controller@fe200000 {
> +		compatible = "renesas,sh7751-pci", "iodata,landisk";
> +		device_type = "pci";
> +		bus-range = <0 0>;
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges = <0x02000000 0x00000000 0xfd000000 0xfd000000 0x00000000 0x01000000>,
> +		         <0x01000000 0x00000000 0xfe240000 0x00000000 0x00000000 0x00040000>;
> +		reg = <0xfe200000 0x0400>,
> +		      <0x0c000000 0x04000000>,
> +		      <0xff800000 0x0030>;
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0x1800 0 7>;
> +		interrupt-map = <0x0000 0 1 &cpldintc evt2irq(0x2a0) 0
> +		                 0x0000 0 2 &cpldintc evt2irq(0x2c0) 0
> +		                 0x0000 0 3 &cpldintc evt2irq(0x2e0) 0
> +		                 0x0000 0 4 &cpldintc evt2irq(0x300) 0
> +
> +		                 0x0800 0 1 &cpldintc evt2irq(0x2c0) 0
> +		                 0x0800 0 2 &cpldintc evt2irq(0x2e0) 0
> +		                 0x0800 0 3 &cpldintc evt2irq(0x300) 0
> +		                 0x0800 0 4 &cpldintc evt2irq(0x2a0) 0
> +
> +		                 0x1000 0 1 &cpldintc evt2irq(0x2e0) 0
> +		                 0x1000 0 2 &cpldintc evt2irq(0x300) 0
> +		                 0x1000 0 3 &cpldintc evt2irq(0x2a0) 0
> +		                 0x1000 0 4 &cpldintc evt2irq(0x2c0) 0
> +
> +		                 0x1800 0 1 &cpldintc evt2irq(0x300) 0
> +		                 0x1800 0 2 &cpldintc evt2irq(0x2a0) 0
> +		                 0x1800 0 3 &cpldintc evt2irq(0x2c0) 0
> +		                 0x1800 0 4 &cpldintc evt2irq(0x2e0) 0>;
> +	};
> +};
