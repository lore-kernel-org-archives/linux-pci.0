Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56042 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205AbcFVQRA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 22 Jun 2016 12:17:00 -0400
Date: Wed, 22 Jun 2016 11:16:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Hanna Hawa <hannah@marvell.com>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: add DT binding for the Aardvark PCIe
 controller
Message-ID: <20160622161656.GE25485@localhost>
References: <1465574056-8787-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1465574056-8787-2-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465574056-8787-2-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 10, 2016 at 05:54:14PM +0200, Thomas Petazzoni wrote:
> This commit adds the documentation for the Device Tree binding used to
> describe the Aardvark PCIe controller, found on Marvell Armada 3700
> ARM64 SoCs.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  .../devicetree/bindings/pci/aardvark-pci.txt       | 56 ++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/aardvark-pci.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/aardvark-pci.txt b/Documentation/devicetree/bindings/pci/aardvark-pci.txt
> new file mode 100644
> index 0000000..683830d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/aardvark-pci.txt
> @@ -0,0 +1,56 @@
> +Aardvark PCIe controller
> +
> +This PCIe controller is used on the Marvell Armada 3700 ARM64 SoC.
> +
> +The Device Tree node describing an Aardvark PCIe controller must
> +contain the following properties:
> +
> + - compatible: Should be "marvell,armada-3700-pcie"
> + - reg: range of registers for the PCIe controller
> + - interrupts: the interrupt line of the PCIe controller
> + - #address-cells: set to <3>
> + - #size-cells: set to <2>
> + - device_type: set to "pci"
> + - ranges: ranges for the PCI memory and I/O regions
> + - #interrupt-cells: set to <1>
> + - msi-controller: indicates that the PCIe controller can itself
> +   handled MSI interrupts

s/handled/handle/
