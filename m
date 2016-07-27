Return-Path: <paul.gortmaker@gmail.com>
Return-Path: <paul.gortmaker@gmail.com>
MIME-Version: 1.0
Sender: paul.gortmaker@gmail.com
In-Reply-To: <20160727182233.GB8901@localhost>
References: <1468802533-17699-1-git-send-email-shawn.lin@rock-chips.com>
 <1468802533-17699-2-git-send-email-shawn.lin@rock-chips.com> <20160727182233.GB8901@localhost>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Wed, 27 Jul 2016 15:56:36 -0400
Message-ID: <CAP=VYLqPj=81Q_8kV1wi=FHP-CB6arrXFAC0ktJrLqR-1TSCjw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] PCI: Rockchip: Add Rockchip PCIe controller support
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
	linux-rockchip@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>,
	Doug Anderson <dianders@chromium.org>, Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 27, 2016 at 2:22 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> Hi Shawn,
>
> I have some relatively minor comments below.
>
> On Mon, Jul 18, 2016 at 08:42:13AM +0800, Shawn Lin wrote:
>> This patch adds Rockchip PCIe controller support found
>> on RK3399 Soc platform.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> ---
>>
>> Changes in v7:
>> - make it as a build-in driver

[...]

>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> index c917e2f..4d714d2 100644
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -264,4 +264,15 @@ config PCIE_ARTPEC6
>>         Say Y here to enable PCIe controller support on Axis ARTPEC-6
>>         SoCs.  This PCIe controller uses the DesignWare core.
>>
>> +config PCIE_ROCKCHIP
>> +     bool "Rockchip PCIe controller"
>> +     depends on ARM64 && ARCH_ROCKCHIP
>> +     depends on OF
>> +     depends on PCI_MSI_IRQ_DOMAIN
>> +     select MFD_SYSCON
>> +     help
>> +       Say Y here if you want internal PCI support on Rockchip SoC.
>> +       There is 1 internal PCIe port available to support GEN2 with
>> +       4 slots.
>> +
>>  endmenu
>> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
>> index 5bc0af2..695f716 100644
>> --- a/drivers/pci/host/Makefile
>> +++ b/drivers/pci/host/Makefile
>> @@ -30,3 +30,4 @@ obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
>>  obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
>>  obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>>  obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
>> +obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
>> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
>> new file mode 100644
>> index 0000000..8a1fef1
>> --- /dev/null
>> +++ b/drivers/pci/host/pcie-rockchip.c
>> @@ -0,0 +1,1233 @@
>> +/*
>> + * Rockchip AXI PCIe host controller driver
>> + *
>> + * Copyright (c) 2016 Rockchip, Inc.
>> + *
>> + * Author: Shawn Lin <shawn.lin@rock-chips.com>
>> + *         Wenrui Li <wenrui.li@rock-chips.com>
>> + *
>> + * Bits taken from Synopsys Designware Host controller driver and
>> + * ARM PCI Host generic driver.
>> + *
>> + * This program is free software: you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation, either version 2 of the License, or
>> + * (at your option) any later version.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/irqchip/chained_irq.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/module.h>

[...]

>> +static struct platform_driver rockchip_pcie_driver = {
>> +     .driver = {
>> +             .name = "rockchip-pcie",
>> +             .of_match_table = rockchip_pcie_of_match,
>> +     },
>> +     .probe = rockchip_pcie_probe,
>> +
>> +};
>> +module_platform_driver(rockchip_pcie_driver);
>> +
>> +MODULE_AUTHOR("Rockchip Inc");
>> +MODULE_DESCRIPTION("Rockchip AXI PCIe driver");
>> +MODULE_LICENSE("GPL v2");
>
> Per your Kconfig, this driver cannot be a module, so remove these MODULE_*
> annotations.  This is to follow Paul Gortmaker's recent "Make explicitly
> non-modular" work.  Also change the include of <linux/module.h> to
> <linux/init.h>.

Thanks!  You beat me to it.    I didn't see any EXPORT_SYMBOL so it doesn't
look like we need export.h  added here.   Also, at the risk of stating
the obvious,
the module_platform_driver becomes builtin_platform_driver.

Paul.
