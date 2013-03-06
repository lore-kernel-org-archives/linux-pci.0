Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:41446 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686Ab3CFIsi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Mar 2013 03:48:38 -0500
Date: Wed, 6 Mar 2013 08:48:34 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Kukjin Kim' <kgene.kim@samsung.com>,
	"linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	'Surendranath Gurivireddy Balla' <suren.reddy@samsung.com>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	thomas.petazzoni@free-electrons.com,
	thierry.reding@avionic-design.de
Subject: Re: [PATCH 1/2] ARM: EXYNOS: Add PCIe driver support
Message-ID: <20130306084834.GA9721@arm.com>
References: <016b01ce18c2$2c366f10$84a34d30$%han@samsung.com>
MIME-Version: 1.0
In-Reply-To: <016b01ce18c2$2c366f10$84a34d30$%han@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 04, 2013 at 10:22:28AM +0000, Jingoo Han wrote:
> Exynos5440 has two PCIe controllers which can be used as Root Complex.
> This driver supports the PCIe controllers as Root Complex mode.
> 
> Signed-off-by: Surendranath Gurivireddy Balla <suren.reddy@samsung.com>
> Signed-off-by: Siva Reddy Kallam <siva.kallam@samsung.com>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  .../devicetree/bindings/pci/exynos-pcie.txt        |   58 ++
>  arch/arm/Kconfig                                   |    2 +
>  arch/arm/mach-exynos/Kconfig                       |    8 +
>  arch/arm/mach-exynos/Makefile                      |    2 +
>  arch/arm/mach-exynos/include/mach/pcie.h           |  146 +++
>  arch/arm/mach-exynos/pcie.c                        | 1009 ++++++++++++++++++++
>  6 files changed, 1225 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/exynos-pcie.txt
>  create mode 100644 arch/arm/mach-exynos/include/mach/pcie.h
>  create mode 100644 arch/arm/mach-exynos/pcie.c
> 
> diff --git a/Documentation/devicetree/bindings/pci/exynos-pcie.txt b/Documentation/devicetree/bindings/pci/exynos-pcie.txt
> new file mode 100644
> index 0000000..4fe05b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/exynos-pcie.txt
> @@ -0,0 +1,58 @@
> +* Samsung Exynos PCIe interface
> +
> +Required properties:
> +-compatible: should be "samsung,pcie-host"
> +-reg: base addresses and lengths of the pcie conteroller,
> +       additional register for the pcie controller,
> +       the phy controller,
> +       additional register for the phy controller.
> +- interrupts: interrupt values for level interrupt,
> +       pulse interrupt, special interrupt.
> +- pcie-host,io_size: memory size for IO
> +- pcie-host,cfg0_size: memory size for CFG0
> +- pcie-host,cfg1_size: memory size for CFG1
> +- pcie-host,mem_size: memory size for MEM
> +- pcie-host,in_mem_size: memory size for Inbound MEM
> +- reset-gpio: gpio pin number of power good signal
> +
> +Example:
> +
> +SoC specific DT Entry:
> +
> +       pcie0@40000000 {
> +               compatible = "samsung,pcie-host";
> +               reg = <0x40000000 0x4000
> +                       0x290000 0x1000
> +                       0x270000 0x1000
> +                       0x271000 0x40>;
> +               interrupts = <0 20 0>, <0 21 0>, <0 22 0>;
> +               pcie-host,io_size = <0x4000>;
> +               pcie-host,cfg0_size = <0x100000>;
> +               pcie-host,cfg1_size = <0x100000>;
> +               pcie-host,mem_size = <0x10000000>;
> +               pcie-host,in_mem_size = <0x8000000>;
> +       };
> +

It's quite common for information such as mem_size and io_size to be represented
with the defacto binding ranges  - see
http://devicetree.org/Device_Tree_Usage#PCI_Address_Translation. Thomas Petazzoni
and Thierry Reding have recent patch sets that use this representation.

The ranges property is used across many architectures of the kernel, however
each architecture has its own way of parsing this binding. There isn't an
accepted version for ARM yet but efforts are underway to add one that doesn't
duplicate code.

It would probably make sense for all these new PCIe host drivers to be
consistent where possible.

Andrew Murray

