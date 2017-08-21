Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38038 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753551AbdHUPTY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2017 11:19:24 -0400
Received: by mail-qk0-f195.google.com with SMTP id 130so6850916qkg.5
        for <linux-pci@vger.kernel.org>; Mon, 21 Aug 2017 08:19:24 -0700 (PDT)
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Ard Biesheuvel'" <ard.biesheuvel@linaro.org>,
        <linux-pci@vger.kernel.org>
Cc: <leif.lindholm@linaro.org>, <graeme.gregory@linaro.org>,
        <mw@semihalf.com>, "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Joao Pinto'" <Joao.Pinto@synopsys.com>, <arnd@arndb.de>
References: <20170818225638.31563-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20170818225638.31563-1-ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH] pci: designware: add driver for DWC controller in ECAM shift mode
Date: Mon, 21 Aug 2017 11:19:21 -0400
Message-ID: <000201d31a90$ddf52640$99df72c0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, August 18, 2017 6:57 PM, Ard Biesheuvel wrote:
> 
> Some implementations of the Synopsys Designware PCIe controller implement
> a so-called ECAM shift mode, which allows a static memory window to be
> configured that covers the configuration space of the entire bus range.
> 
> If the firmware performs all the low level configuration that is required
> to expose this controller in a fully ECAM compatible manner, we can
> simply describe it as "pci-host-ecam-generic" and be done with it.
> However, it appears that in some cases (one of which is the Armada 80x0),
> the IP is synthesized with an ATU window size that does not allow the
> first bus to be mapped in a way that prevents the device on the
> downstream port from appearing more than once.
> 
> So implement a driver that relies on the firmware to perform all low
> level initialization, and drives the controller in ECAM mode, but
> overrides the config space accessors to take the above quirk into
> account.
> 
> Note that, unlike most drivers for this IP, this driver does not expose
> a fake bridge device at B/D/F 00:00.0. There is no point in doing so,
> given that this is not a true bridge, and does not require any windows
> to be configured in order for the downstream device to operate correctly.
> Omitting it also prevents the PCI resource allocation routines from
> handing out BAR space to it unnecessarily.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Joao Pinto <Joao.Pinto@synopsys.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> Posted as RFC for discussion. We have systems booting with UEFI firmware

(CC'ed Arnd Bergmann)

Thank you for sharing this patch.
I have no objection about this patch.

I think that this driver is required for ARM-based server system.
But, as you wrote above, UEFI should support low-level code for this
DesignWare
Controller if we want to use this DWC-ECAM driver. So, can we get the UEFI
code
for this controller?

If not, can you share your plan about that?

Best regards,
Jingoo Han

> that don't require yet another variation of the driver with all its
> low-level initialization code, given that the firmware takes care of that
> already for its own needs. However, it seems we cannot drive these
> controllers in a fully ECAM compliant mode either, and so all we need
> is ECAM with a quirk for the config space accessors.
> 
> Kernel log capture after the patch, of a SoC with two of these puppies,
> one with a Realtek 8169 and one with a Renesas uPD720200.
> 
> If having a patch such as this one is considered acceptable, I will
> create a DT binding to go with it as well.
> 
>  drivers/pci/dwc/Kconfig                | 11 +++
>  drivers/pci/dwc/Makefile               |  1 +
>  drivers/pci/dwc/pcie-designware-ecam.c | 88 ++++++++++++++++++++
>  3 files changed, 100 insertions(+)
> 
> diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
> index d275aadc47ee..f2afa2c519c1 100644
> --- a/drivers/pci/dwc/Kconfig
> +++ b/drivers/pci/dwc/Kconfig
> @@ -169,4 +169,15 @@ config PCIE_KIRIN
>  	  Say Y here if you want PCIe controller support
>  	  on HiSilicon Kirin series SoCs.
> 
> +config PCIE_DW_HOST_ECAM
> +	bool "Synopsys DesignWare PCIe controller in ECAM mode"
> +	depends on OF
> +	select PCI_HOST_COMMON
> +	select IRQ_DOMAIN
> +	help
> +	  Add support for Synopsys DesignWare PCIe controllers configured
> +	  by the firmware into ECAM shift mode. In some cases, these are
> +	  fully ECAM compliant, in which case the pci-host-generic driver
> +	  may be used instead.
> +
>  endmenu
> diff --git a/drivers/pci/dwc/Makefile b/drivers/pci/dwc/Makefile
> index c61be9738cce..7d5a23e5b767 100644
> --- a/drivers/pci/dwc/Makefile
> +++ b/drivers/pci/dwc/Makefile
> @@ -1,5 +1,6 @@
>  obj-$(CONFIG_PCIE_DW) += pcie-designware.o
>  obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
> +obj-$(CONFIG_PCIE_DW_HOST_ECAM) += pcie-designware-ecam.o
>  obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
>  obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
>  ifneq ($(filter y,$(CONFIG_PCI_DRA7XX_HOST) $(CONFIG_PCI_DRA7XX_EP)),)
> diff --git a/drivers/pci/dwc/pcie-designware-ecam.c
> b/drivers/pci/dwc/pcie-designware-ecam.c
> new file mode 100644
> index 000000000000..3ab3f88b2592
> --- /dev/null
> +++ b/drivers/pci/dwc/pcie-designware-ecam.c
> @@ -0,0 +1,88 @@
> +/*
> + * Driver for mostly ECAM compatible Synopsys dw PCIe controllers
> + * configured by the firmware into RC mode
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Copyright (C) 2014 ARM Limited
> + * Copyright (C) 2017 Linaro Limited
> + *
> + * Authors: Will Deacon <will.deacon@arm.com>
> + *          Ard Biesheuvel <ard.biesheuvel@linaro.org>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/of_address.h>
> +#include <linux/of_pci.h>
> +#include <linux/pci-ecam.h>
> +#include <linux/platform_device.h>
> +
> +static int pci_dw_ecam_config_read(struct pci_bus *bus, u32 devfn, int
> where,
> +				   int size, u32 *val)
> +{
> +	struct pci_config_window *cfg = bus->sysdata;
> +
> +	/*
> +	 * The Synopsys dw PCIe controller in RC mode will not filter type
> 0
> +	 * config TLPs sent to devices 1 and up on its downstream port,
> +	 * resulting in devices appearing multiple times on bus 0 unless we
> +	 * filter them here.
> +	 */
> +	if (bus->number == cfg->busr.start && PCI_SLOT(devfn) > 0) {
> +		*val = 0xffffffff;
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	}
> +
> +	return pci_generic_config_read(bus, devfn, where, size, val);
> +}
> +
> +static int pci_dw_ecam_config_write(struct pci_bus *bus, u32 devfn, int
> where,
> +				    int size, u32 val)
> +{
> +	struct pci_config_window *cfg = bus->sysdata;
> +
> +	if (bus->number == cfg->busr.start && PCI_SLOT(devfn) > 0)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	return pci_generic_config_write(bus, devfn, where, size, val);
> +}
> +
> +static struct pci_ecam_ops pci_dw_ecam_bus_ops = {
> +	.bus_shift	= 20,
> +	.pci_ops	= {
> +		.map_bus	= pci_ecam_map_bus,
> +		.read		= pci_dw_ecam_config_read,
> +		.write		= pci_dw_ecam_config_write,
> +	}
> +};
> +
> +static const struct of_device_id pci_dw_ecam_of_match[] = {
> +	{ .compatible = "snps,dw-pcie-ecam",
> +	  .data = &pci_dw_ecam_bus_ops },
> +
> +	{ },
> +};
> +
> +static int pci_dw_ecam_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *of_id;
> +	struct pci_ecam_ops *ops;
> +
> +	of_id = of_match_node(pci_dw_ecam_of_match, pdev->dev.of_node);
> +	ops = (struct pci_ecam_ops *)of_id->data;
> +
> +	return pci_host_common_probe(pdev, ops);
> +}
> +
> +static struct platform_driver pci_dw_ecam_driver = {
> +	.driver = {
> +		.name = "pci-synopsys-dw-ecam",
> +		.of_match_table = pci_dw_ecam_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe = pci_dw_ecam_probe,
> +};
> +builtin_platform_driver(pci_dw_ecam_driver);
> --
> 2.11.0
> 
> Note that this is not the final configuration. Most notably, there is no
> 32-bit addressable MMIO space yet.
> 
> OF: PCI: host bridge /pcie@3f00000000 ranges:
> OF: PCI:    IO 0x3f01000000..0x3f0100ffff -> 0x00000000
> OF: PCI:   MEM 0x3f40000000..0x3f7fffffff -> 0x3f40000000
> pci-synopsys-dw-ecam 3f00000000.pcie: ECAM at [mem 0x3f00000000-
> 0x3f03ffffff] for [bus 00-3f]
> pci-synopsys-dw-ecam 3f00000000.pcie: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [bus 00-3f]
> pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> pci_bus 0000:00: root bus resource [mem 0x3f40000000-0x3f7fffffff]
> pci 0000:00:00.0: [10ec:8168] type 00 class 0x020000
> pci 0000:00:00.0: reg 0x10: [io  0x0000-0x00ff]
> pci 0000:00:00.0: reg 0x18: [mem 0x3f40004000-0x3f40004fff 64bit]
> pci 0000:00:00.0: reg 0x20: [mem 0x3f40000000-0x3f40003fff 64bit pref]
> pci 0000:00:00.0: supports D1 D2
> pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:00:00.0: BAR 4: assigned [mem 0x3f40000000-0x3f40003fff 64bit
> pref]
> pci 0000:00:00.0: BAR 2: assigned [mem 0x3f40004000-0x3f40004fff 64bit]
> pci 0000:00:00.0: BAR 0: assigned [io  0x1000-0x10ff]
> OF: PCI: host bridge /pcie@3f80000000 ranges:
> OF: PCI:    IO 0x3f81000000..0x3f8100ffff -> 0x00010000
> OF: PCI:   MEM 0x3fc0000000..0x3fffffffff -> 0x3fc0000000
> pci-synopsys-dw-ecam 3f80000000.pcie: ECAM at [mem 0x3f80000000-
> 0x3f83ffffff] for [bus 00-3f]
> pci-synopsys-dw-ecam 3f80000000.pcie: PCI host bridge to bus 0001:00
> pci_bus 0001:00: root bus resource [bus 00-3f]
> pci_bus 0001:00: root bus resource [io  0x10000-0x1ffff]
> pci_bus 0001:00: root bus resource [mem 0x3fc0000000-0x3fffffffff]
> pci 0001:00:00.0: [1033:0194] type 00 class 0x0c0330
> pci 0001:00:00.0: reg 0x10: [mem 0x3fc0000000-0x3fc0001fff 64bit]
> pci 0001:00:00.0: PME# supported from D0 D3hot
> pci 0001:00:00.0: BAR 0: assigned [mem 0x3fc0000000-0x3fc0001fff 64bit]
> pci 0001:00:00.0: enabling device (0000 -> 0002)
