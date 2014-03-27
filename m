Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:40580 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755966AbaC0LID (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Mar 2014 07:08:03 -0400
Received: by mail-lb0-f170.google.com with SMTP id s7so2509506lbd.1
        for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2014 04:08:01 -0700 (PDT)
Message-ID: <53340690.20006@cogentembedded.com>
Date: Thu, 27 Mar 2014 15:08:00 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Phil Edworthy <phil.edworthy@renesas.com>,
	linux-pci@vger.kernel.org
CC: linux-sh@vger.kernel.org,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 05/10] dt-bindings: pci: rcar pcie device tree bindings
References: <1395912416-20087-1-git-send-email-phil.edworthy@renesas.com> <1395912416-20087-6-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1395912416-20087-6-git-send-email-phil.edworthy@renesas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello.

On 27-03-2014 13:26, Phil Edworthy wrote:

> This patch adds the bindings for the R-Car PCIe driver. The driver
> resides under drivers/pci/host/pcie-rcar.c

> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

> v6:
>   - Correct DT bindings description for reg and clocks

> v5:
>   - Add PCIe bus clock reference
>   - Add additional interrupt bindings
>   - Use dma-ranges property to specify inbound memory regions

    Put these under --- tear line, please.

> ---
>   Documentation/devicetree/bindings/pci/rcar-pci.txt | 45 ++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci.txt

> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> new file mode 100644
> index 0000000..a97ebe6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> @@ -0,0 +1,45 @@
> +* Renesas RCar PCIe interface
> +
> +Required properties:
> +- compatible: should contain one of the following
> +	"renesas,pcie-r8a7779", "renesas,pcie-r8a7790", "renesas,pcie-r8a7791"
> +- reg: base address and length of the pcie controller registers.
> +- #address-cells: set to <3>
> +- #size-cells: set to <2>
> +- device_type: set to "pci"
> +- ranges: ranges for the PCI memory and I/O regions.
> +- dma-ranges: ranges for the inbound memory regions.
> +- interrupts: two interrupt sources for MSI interrupts, followed by interrupt
> +	source for hardware related interrupts (e.g. link speed change).
> +- #interrupt-cells: set to <1>
> +- interrupt-map-mask and interrupt-map: standard PCI properties
> +	to define the mapping of the PCIe interface to interrupt
> +	numbers.
> +- clocks: from common clock binding: phandles to PCIe controller and PCIe bus
> +	clocks.

    I told it's not only phandles (e.g. &mstp3_clks) but the clock specifiers.

WBR, Sergei

