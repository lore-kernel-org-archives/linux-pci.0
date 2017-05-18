Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Song Xiaowei'" <songxiaowei@hisilicon.com>,
        <bhelgaas@google.com>, <kishon@ti.com>, <arnd@arndb.de>,
        <tn@semihalf.com>, <keith.busch@intel.com>,
        <niklas.cassel@axis.com>, <dhdang@apm.com>,
        <liudongdong3@huawei.com>
Cc: <puck.chen@hisilicon.com>, <guodong.xu@linaro.org>,
        <wangbinghui@hisilicon.com>, <suzhuangluan@hisilicon.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20170515115523.126970-1-songxiaowei@hisilicon.com>
In-Reply-To: <20170515115523.126970-1-songxiaowei@hisilicon.com>
Subject: Re: [PATCH 2/3] PCI: dwc: kirin: add PCIe Driver for HiSilicon Kirin SoC
Date: Thu, 18 May 2017 14:28:57 -0400
Message-ID: <001801d2d004$9dfa7850$d9ef68f0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, May 15, 2017 7:55 AM, Song Xiaowei wrote
> 
> Hisilicon PCIe Driver shares the common functions fo PCIe dw-host
> 
> The poweron functions is developed on hi3660 SoC, while Others Functions
> are common for Kirin series SoCs.
> 
> Lowpower(L1ss and SR), hotplug and MSI feature are not supported

How about 'Low power mode', instead of 'Lowpower'?

'L1ss' is L1 sub state. Then, what is 'SR'?

> currently.
> 
> Cc: Guodong Xu <guodong.xu@linaro.org>
> Signed-off-by: Song Xiaowei <songxiaowei@hisilicon.com>
> ---
>  drivers/pci/dwc/Kconfig      |  10 +
>  drivers/pci/dwc/Makefile     |   1 +
>  drivers/pci/dwc/pcie-kirin.c | 522
> +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 533 insertions(+)
>  create mode 100644 drivers/pci/dwc/pcie-kirin.c
> 
> diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
> index d2d2ba5b8a68..13e617b78430 100644
> --- a/drivers/pci/dwc/Kconfig
> +++ b/drivers/pci/dwc/Kconfig
> @@ -130,4 +130,14 @@ config PCIE_ARTPEC6
>  	  Say Y here to enable PCIe controller support on Axis ARTPEC-6
>  	  SoCs.  This PCIe controller uses the DesignWare core.
> 
> +config PCIE_KIRIN
> +	depends on OF && ARM64
> +	bool "HiSilicon Kirin series SoCs PCIe controllers"
> +	depends on PCI
> +	select PCIEPORTBUS
> +	select PCIE_DW_HOST
> +	help
> +	  Say Y here if you want PCIe controller support on HiSilicon Kirin
> series SoCs
> +	  kirin960 SoC
> +
>  endmenu
> diff --git a/drivers/pci/dwc/Makefile b/drivers/pci/dwc/Makefile
> index a2df13c28798..4bd69bacd4ab 100644
> --- a/drivers/pci/dwc/Makefile
> +++ b/drivers/pci/dwc/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
>  obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
>  obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>  obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
> +obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
> 
>  # The following drivers are for devices that use the generic ACPI
>  # pci_root.c driver but don't support standard ECAM config access.
> diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c
> new file mode 100644
> index 000000000000..739f72dae16d
> --- /dev/null
> +++ b/drivers/pci/dwc/pcie-kirin.c
> @@ -0,0 +1,522 @@
> +/*
> + * PCIe host controller driver for Kirin Phone SoCs
> + *
> + * Copyright (C) 2015 Hilisicon Electronics Co., Ltd.

You sent this patch to mailing list in '2017'.
So, please use 2017, instead of 2015.

> + *		http://www.huawei.com
> + *
> + * Author: Xiaowei Song <songxiaowei@huawei.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <asm/compiler.h>
> +#include <linux/compiler.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_gpio.h>
> +#include <linux/pci.h>
> +#include <linux/of_pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +#include <linux/types.h>
> +#include <linux/of_address.h>
> +#include <linux/pci_regs.h>
> +#include "pcie-designware.h"

Please re-order these header files in alphabetical order for 'readability'.

Best regards,
Jingoo Han

[....]
