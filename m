Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1494382020-26790-2-git-send-email-ryder.lee@mediatek.com>
References: <1494382020-26790-1-git-send-email-ryder.lee@mediatek.com>
 <1494382020-26790-2-git-send-email-ryder.lee@mediatek.com>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Sat, 20 May 2017 15:46:14 -0400
Message-ID: <CAP=VYLrjeq57S+o0bBBH4oi8Bgwp=XgTsdO8RkWY8xuJyhLP9g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PCI: mediatek: Add Mediatek PCIe host controller
 support
To: Ryder Lee <ryder.lee@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Red Hung <red.hung@mediatek.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 9, 2017 at 10:06 PM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> Add support for the Mediatek PCIe Gen2 controller which can
> be found on MT7623 series SoCs.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pci/host/Kconfig         |  11 +
>  drivers/pci/host/Makefile        |   1 +
>  drivers/pci/host/pcie-mediatek.c | 563 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 575 insertions(+)
>  create mode 100644 drivers/pci/host/pcie-mediatek.c
>
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index f7c1d4d..aef0de9 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -174,6 +174,17 @@ config PCIE_ROCKCHIP
>           There is 1 internal PCIe port available to support GEN2 with
>           4 slots.
>
> +config PCIE_MEDIATEK
> +       bool "Mediatek PCIe controller"

You've got bool here and correctly use the builtin register
function, but you still have a couple stray references to
the module.h header and MODULE macros.  Can you
please also clean them up and resend with those gone?

Thanks,
Paul.
--

> +       depends on ARM && (ARCH_MEDIATEK || COMPILE_TEST)
> +       depends on OF
> +       depends on PCI
> +       select PCIEPORTBUS
> +       help
> +         Say Y here if you want to enable PCIe controller support on MT7623 series
> +         SoCs. There is one single root complex with 3 root ports available.
> +         Each port supports Gen2 lane x1.
> +
>  config VMD
>         depends on PCI_MSI && X86_64 && SRCU
>         tristate "Intel Volume Management Device Driver"
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 4d36866..265adff 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
>  obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
>  obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
>  obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
> +obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
>  obj-$(CONFIG_VMD) += vmd.o
>
>  # The following drivers are for devices that use the generic ACPI
> diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
> new file mode 100644
> index 0000000..5e8c1bf
> --- /dev/null
> +++ b/drivers/pci/host/pcie-mediatek.c
> @@ -0,0 +1,563 @@
> +/*
> + * Mediatek PCIe host controller driver.
> + *
> + * Copyright (c) 2017 MediaTek Inc.
> + * Author: Ryder Lee <ryder.lee@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>

[....]

> +};
> +MODULE_DEVICE_TABLE(of, mtk_pcie_ids);
> +
> +static struct platform_driver mtk_pcie_driver = {
> +       .probe = mtk_pcie_probe,
> +       .driver = {
> +               .name = "mtk-pcie",
> +               .of_match_table = mtk_pcie_ids,
> +               .suppress_bind_attrs = true,
> +       },
> +};
> +
> +builtin_platform_driver(mtk_pcie_driver);
> +
> +MODULE_DESCRIPTION("Mediatek PCIe host controller driver.");
> +MODULE_LICENSE("GPL v2");
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
