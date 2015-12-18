Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40160 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932129AbbLRNij (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 18 Dec 2015 08:38:39 -0500
Date: Fri, 18 Dec 2015 13:38:21 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: helgaas@kernel.org, Vineet.Gupta1@synopsys.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	CARLOS.PALMINHA@synopsys.com, Alexey.Brodkin@synopsys.com,
	robh+dt@kernel.org, pawel.moll@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Subject: Re: [PATCH v2 2/2] add new platform driver for PCI RC
Message-ID: <20151218133820.GA30229@leverpostej>
References: <cover.1450274797.git.jpinto@synopsys.com>
 <33586809f80ef3104608a4e49390e382edfc3347.1450274797.git.jpinto@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <33586809f80ef3104608a4e49390e382edfc3347.1450274797.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 16, 2015 at 02:14:56PM +0000, Joao Pinto wrote:
> This patch adds a new driver that will be the reference platform driver for all
> PCI RC IP Protoyping Kits based on ARC SDP. This patch is composed by:
> 
> -Changes to pcie-designware driver add a function that enables the feature of
> starting the LTSSM (Link Train Status State) used by the new driver
> -MAINTAINERS file was updated to include the new driver
> -Documentation/devicetree/bindings/pci was updated to include the new driver
> documentation
> -New driver called pcie-snpsdev
> 
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> ---
> Changes v1 -> v2 (Bjorn Helgaas):
> - Fixups snpsdev_pcie_fixup_bridge() and snpsdev_pcie_fixup_res() were removed
> from the driver (these functions were for specific tests only and not usefull
> in mainline)
> - Driver' comments were reviewed (fix Typos and excessive comments removal)
> - Removed unnecessary definitions in the driver source (PCIE_PHY_CTRL and
> PCIE_PHY_STAT)
> 
>  .../devicetree/bindings/pci/pcie-snpsdev.txt       |  28 ++
>  MAINTAINERS                                        |   7 +
>  drivers/pci/host/Kconfig                           |   5 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pcie-designware.c                 |  15 ++
>  drivers/pci/host/pcie-designware.h                 |   1 +
>  drivers/pci/host/pcie-snpsdev.c                    | 288 +++++++++++++++++++++
>  7 files changed, 345 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/pcie-snpsdev.txt
>  create mode 100644 drivers/pci/host/pcie-snpsdev.c
> 
> diff --git a/Documentation/devicetree/bindings/pci/pcie-snpsdev.txt b/Documentation/devicetree/bindings/pci/pcie-snpsdev.txt
> new file mode 100644
> index 0000000..b833c8f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/pcie-snpsdev.txt
> @@ -0,0 +1,28 @@
> +Synopsys PCI RC IP Prototyping Kit
> +----------------------------------
> +
> +This is the reference platform driver to be used in the Synopsys PCI RC IP
> +Prototyping Kits.
> +
> +Required properties:
> +- compatible: "snps,pcie-snpsdev";

Is there not a momre specific name for this RC IP?

> +- reg:	A list of physical regions to access the device.

How many, in which order?

> +- interrupts: interrupt for the device.

How many, in which order?

> +Example configuration:
> +
> +	pcie: pcie@0xdffff000 {
> +		#interrupt-cells = <1>;
> +		compatible = "snps,pcie-snpsdev";
> +		reg = <0xdffff000 0x1000>;
> +		interrupts = <25>, <24>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		device_type = "pci";
> +		ranges = <0x00000800 0 0xd0000000 0xd0000000 0 0x00002000
> +			  0x81000000 0 0x00000000 0xde000000 0 0x00010000
> +			  0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;

Nit: please bracket list entries individually.

> +		num-lanes = <1>;
> +	};

Please refer to more generic bindings for properties you have not defined here
(e.g. device_type, ranges, num-lanes).

[...]

> +#define SIZE_1GB 0x40000000

Use SZ_1G from linux/sizes.h.

Thanks,
Mark.
