Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 2/2] pci: Add PCIe driver for Rockchip Soc
To: Heiko Stuebner <heiko@sntech.de>
References: <1463740105-7061-1-git-send-email-shawn.lin@rock-chips.com>
 <1463740156-7148-1-git-send-email-shawn.lin@rock-chips.com>
 <3647622.McCjKUuZmz@phil>
 <d0d2648a-a2d7-b57c-a434-490aab8d7958@rock-chips.com>
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <ba4bc10c-a757-81ff-713d-5aa85012c64f@rock-chips.com>
Date: Mon, 23 May 2016 11:27:57 +0800
MIME-Version: 1.0
In-Reply-To: <d0d2648a-a2d7-b57c-a434-490aab8d7958@rock-chips.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/5/23 8:48, Shawn Lin wrote:
> On 2016/5/21 5:13, Heiko Stuebner wrote:
>> Hi Shawn,
>>
>> I haven't had any contact with PCI yet, so my comments below will likely
>> address more generic findings only.
>>
>> As you might've guessed from the binding comments, to me it looks like
>> the
>> phy handling should be in a separate phy driver and looking below all phy
>> accesses seem very separate from the actual pci controller interactions -
>> they are even in port_init only as well.
>>
>
> yes, the main reason for not to seperate a new pcie-phy driver for this
> prototype design is that I just wonder whether it's worth to create a
> new driver for just a small piece of code. And a bit more forward is
> that I think phy api is no so scalable for just init/power_on in
> case of too much interactions between controller and phy from which I
> suffer a bit for emmc.
>
> Should I really need to seperate the phy part into pcie-phy? ;)

Currently, We still need some more interactions between phy and 
controller here, not just what you point out in the comments. so if we
need a seperate phy driver, could it allows me to export some functions
for pcie driver?


>
>> While I already added some comments about that below, the driver seems
>> full
>> of raw register bit handling (including wild shifts). Please abstract
>> that
>> using contants, so that stuff stays readable for the future.
>
> okay, let me migrate these magic number and raw reg bit handling into a
> new header file.
>
>>
>>
>> Am Freitag, 20. Mai 2016, 18:29:16 schrieb Shawn Lin:
>>> RK3399 has a PCIe controller which can be used as Root Complex.
>>> This driver supports a PCIe controller as Root Complex mode.
>>>
>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>> ---
>>
>> [...]
>>
>>> diff --git a/drivers/pci/host/pcie-rockchip.c
>>> b/drivers/pci/host/pcie-rockchip.c new file mode 100644
>>> index 0000000..4063fd3
>>> --- /dev/null
>>> +++ b/drivers/pci/host/pcie-rockchip.c
>>> @@ -0,0 +1,1181 @@
>>> +/*
>>> + * Rockchip AXI PCIe host controller driver
>>> + *
>>> + * Copyright (c) 2016 Rockchip, Inc.
>>> + *
>>> + * Author: Shawn Lin <shawn.lin@rock-chips.com>
>>> + *         Wenrui Li <wenrui.li@rock-chips.com>
>>> + * Bits taken from Synopsys Designware Host controller driver and
>>> + * ARM PCI Host generic driver.
>>> + *
>>> + * This program is free software: you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation, either version 2 of the License, or
>>> + * (at your option) any later version.
>>> + */
>>> +#include <linux/clk.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/gpio/consumer.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/irq.h>
>>> +#include <linux/irqdomain.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/mfd/syscon.h>
>>> +#include <linux/module.h>
>>> +#include <linux/msi.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/of_pci.h>
>>> +#include <linux/of_platform.h>
>>> +#include <linux/of_irq.h>
>>> +#include <linux/pci.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/reset.h>
>>> +#include <linux/regmap.h>
>>> +
>>> +#define REF_CLK_100MHZ            (100 * 1000 * 1000)
>>
>> seems unused
>
> will be removed.
>
>>
>>> +#define PCIE_CLIENT_BASE        0x0
>>> +#define PCIE_RC_CONFIG_BASE        0xa00000
>>> +#define PCIE_CORE_CTRL_MGMT_BASE    0x900000
>>> +#define PCIE_CORE_AXI_CONF_BASE        0xc00000
>>> +#define PCIE_CORE_AXI_INBOUND_BASE    0xc00800
>>> +
>>> +#define PCIE_CLIENT_BASIC_STATUS0    0x44
>>> +#define PCIE_CLIENT_BASIC_STATUS1    0x48
>>> +#define PCIE_CLIENT_INT_MASK        0x4c
>>> +#define PCIE_CLIENT_INT_STATUS        0x50
>>> +#define PCIE_CORE_INT_MASK        0x900210
>>> +#define PCIE_CORE_INT_STATUS        0x90020c
>>> +
>>> +/** Size of one AXI Region (not Region 0) */
>>> +#define    AXI_REGION_SIZE            (0x1 << 20)
>>
>> for those generic (1 << x) things please use BIT(x) instead
>> Also constants intertwined with constants is hard to read,
>> so ideally add a blank line above each comment and comment style for
>> single
>> line comments only has one * in the beginning
>
> Ahh yep.
>
>>     /* foo */
>>
>>> +/** Overall size of AXI area */
>>> +#define    AXI_OVERALL_SIZE        (64 * (0x1 << 20))
>>> +/** Size of Region 0, equal to sum of sizes of other regions */
>>> +#define    AXI_REGION_0_SIZE        (32 * (0x1 << 20))
>>> +#define OB_REG_SIZE_SHIFT        5
>>> +#define IB_ROOT_PORT_REG_SIZE_SHIFT    3
>>> +
>>> +#define AXI_WRAPPER_IO_WRITE        0x6
>>> +#define AXI_WRAPPER_MEM_WRITE        0x2
>>> +#define MAX_AXI_IB_ROOTPORT_REGION_NUM    3
>>> +#define    MIN_AXI_ADDR_BITS_PASSED    8
>>
>> strange spacing after #define
>
> Generally I use one space after #define, but I donnot somehow...
> I will check it twice.
>
>>
>> [...]
>>
>>> +/**
>>> + * rockchip_pcie_init_port - Initialize hardware
>>> + * @port: PCIe port information
>>> + */
>>> +static int rockchip_pcie_init_port(struct rockchip_pcie_port *port)
>>> +{
>>> +    int err;
>>> +    u32 status;
>>> +    unsigned long timeout = jiffies + msecs_to_jiffies(1000);
>>
>> this timeout only seems to be initialized once here but used for multiple
>> loops below resulting in all waitloops combined together being allowed to
>> take 1 second ... is this intended?
>
> a big timeout value to make sure we leave enough margin. No any data
> is provided about how long should we wait for pll lock/re-lock/tainning
> finish stuff. As it also related to the Socs/devices. Currently I
> test pci-ethernet/wifi/SATA-bridge/USB-bridge, and it seems can be
> reduced. But as you know, I cannot guarantee not to augment it once we
> find some SSD/GPU in the failure state of trainning in the future.
> Anyway I think here we use loop-break method, so it should be not
> harmful?
>
>>
>>> +    gpiod_set_value(port->ep_gpio, 0);
>>> +
>>> +    /* Make sure PCIe relate block is in reset state */
>>> +    err = reset_control_assert(port->phy_rst);
>>> +    if (err) {
>>> +        dev_err(port->dev, "assert phy_rst err %d\n", err);
>>> +        return err;
>>> +    }
>>
>> should move to phy driver probe or so
>>
>>> +    err = reset_control_assert(port->core_rst);
>>> +    if (err) {
>>> +        dev_err(port->dev, "assert core_rst err %d\n", err);
>>> +        return err;
>>> +    }
>>
>> blank line
>>
>>> +    err = reset_control_assert(port->mgmt_rst);
>>> +    if (err) {
>>> +        dev_err(port->dev, "assert mgmt_rst err %d\n", err);
>>> +        return err;
>>> +    }
>>
>> blank line
>>
>>> +    err = reset_control_assert(port->mgmt_sticky_rst);
>>> +    if (err) {
>>> +        dev_err(port->dev, "assert mgmt_sticky_rst err %d\n", err);
>>> +        return err;
>>> +    }
>>
>> blank line
>>
>>> +    err = reset_control_assert(port->pipe_rst);
>>> +    if (err) {
>>> +        dev_err(port->dev, "assert pipe_rst err %d\n", err);
>>> +        return err;
>>> +    }
>>> +
>>> +    pcie_write(port, (0xf << 20) | (0x1 << 16) |
>>> PCIE_CLIENT_GEN_SEL_2 |
>>> +              (0x1 << 19) | (0x1 << 3) |
>>> +              PCIE_CLIENT_MODE_RC |
>>> +              PCIE_CLIENT_CONF_LANE_NUM(port->lanes) |
>>> +              PCIE_CLIENT_CONF_ENABLE, PCIE_CLIENT_BASE);
>>> +
>>
>> ------ phy_enable begin ------
>>
>> As mentioned above, the whole phy handling seems pretty separate, so
>> should
>> be easily being able to live in a real phy driver?
>>
>> This of course also needs to handle the phy clock in it.
>>
>>> +    err = reset_control_deassert(port->phy_rst);
>>> +    if (err) {
>>> +        dev_err(port->dev, "deassert phy_rst err %d\n", err);
>>> +        return err;
>>> +    }
>>> +    regmap_write(port->grf, port->pcie_conf,
>>> +             (0x3f << 17) | (0x10 << 1));
>>
>> the bits above should use some sort of constant / description. Also see
>> HIWORD_UPDATE in other drivers for the write-enable mask
>>
>> also add blank line here
>>
>>> +    err = -EINVAL;
>>> +    while (time_before(jiffies, timeout)) {
>>> +        regmap_read(port->grf, port->pcie_status, &status);
>>> +        if ((status & (1 << 9))) {
>>
>> use a constant for the (1 << 9) [aka BIT(9)] please
>>
>>> +            dev_info(port->dev, "pll locked!\n");
>>
>> dev_dbg instead?
>
> yep
>
>>
>>> +            err = 0;
>>> +            break;
>>> +        }
>>> +    }
>>> +    if (err) {
>>> +        dev_err(port->dev, "pll lock timeout!\n");
>>> +        return err;
>>> +    }
>>> +    pcie_pb_wr_cfg(port, 0x10, 0x8);
>>> +    pcie_pb_wr_cfg(port, 0x12, 0x8);
>>> +
>>> +    err = -ETIMEDOUT;
>>> +    while (time_before(jiffies, timeout)) {
>>> +        regmap_read(port->grf, port->pcie_status, &status);
>>> +        if (!(status & (1 << 10))) {
>>
>> constant again
>>
>>> +            dev_info(port->dev, "pll output enable done!\n");
>>
>> dev_dbg or leave it out
>
> dev_dbg should be fine.
>
>>
>>> +            err = 0;
>>> +            break;
>>> +        }
>>> +    }
>>> +
>>> +    if (err) {
>>> +        dev_err(port->dev, "pll output enable timeout!\n");
>>> +        return err;
>>> +    }
>>> +
>>> +    regmap_write(port->grf, port->pcie_conf,
>>> +             (0x3f << 17) | (0x10 << 1));
>>> +    err = -EINVAL;
>>> +    while (time_before(jiffies, timeout)) {
>>> +        regmap_read(port->grf, port->pcie_status, &status);
>>> +        if ((status & (1 << 9))) {
>>> +            dev_info(port->dev, "pll relocked!\n");
>>> +            err = 0;
>>> +            break;
>>> +        }
>>> +    }
>>> +    if (err) {
>>> +        dev_err(port->dev, "pll relock timeout!\n");
>>> +        return err;
>>> +    }
>>
>> ------ phy_enable end ------
>>
>>
>>> +    err = reset_control_deassert(port->core_rst);
>>> +    if (err) {
>>> +        dev_err(port->dev, "deassert core_rst err %d\n", err);
>>> +        return err;
>>> +    }
>>> +    err = reset_control_deassert(port->mgmt_rst);
>>> +    if (err) {
>>> +        dev_err(port->dev, "deassert mgmt_rst err %d\n", err);
>>> +        return err;
>>> +    }
>>> +    err = reset_control_deassert(port->mgmt_sticky_rst);
>>> +    if (err) {
>>> +        dev_err(port->dev, "deassert mgmt_sticky_rst err %d\n", err);
>>> +        return err;
>>> +    }
>>> +    err = reset_control_deassert(port->pipe_rst);
>>> +    if (err) {
>>> +        dev_err(port->dev, "deassert pipe_rst err %d\n", err);
>>> +        return err;
>>> +    }
>>> +
>>> +    pcie_write(port, 1 << 17 | 1 << 1, PCIE_CLIENT_BASE);
>>> +
>>> +    gpiod_set_value(port->ep_gpio, 1);
>>> +    err = -ETIMEDOUT;
>>> +    while (time_before(jiffies, timeout)) {
>>> +        status = pcie_read(port, PCIE_CLIENT_BASIC_STATUS1);
>>> +        if (((status >> 20) & 0x3) == 0x3) {
>>> +            dev_info(port->dev, "pcie link training gen1 pass!\n");
>>> +            err = 0;
>>> +            break;
>>> +        }
>>> +    }
>>> +    if (err) {
>>> +        dev_err(port->dev, "pcie link training gen1 timeout!\n");
>>> +        return err;
>>> +    }
>>> +
>>> +    status = pcie_read(port, 0x9000d0);
>>> +    status |= 0x20;
>>> +    pcie_write(port, status, 0x9000d0);
>>
>> just to mention it again, bit handling as descriptive constant please and
>> also please give that register a name :-)
>
> will address this magic number all above using a new header file :)
>
>>
>> [...]
>>
>>> +static int rockchip_pcie_parse_dt(struct rockchip_pcie_port *port)
>>> +{
>>
>> [...]
>>
>>> +    port->lanes = 1;
>>> +    err = of_property_read_u32(node, "num-lanes", &port->lanes);
>>> +    if (!err && ((port->lanes == 0) ||
>>> +             (port->lanes == 3) ||
>>> +             (port->lanes > 4))) {
>>> +        dev_info(dev, "invalid num-lanes, default use one lane\n");
>>
>> dev_warn might be more appropriate
>
> sure.
>
>>
>>> +        port->lanes = 1;
>>> +    }
>>
>> [...]
>>
>>> +static void rockchip_pcie_msi_enable(struct rockchip_pcie_port *pp)
>>> +{
>>> +    struct device_node *msi_node;
>>> +
>>> +    msi_node = of_parse_phandle(pp->dev->of_node,
>>> +                    "msi-parent", 0);
>>
>> I would assume this should live in the general parse_dt function?
>> Also is that MSI enablement really allow to fail silently without any
>> affect
>> on the PCI functionality?
>
> yes, we should check this as well as CONFIG_PCI_MSI.
> Will fix it.
>
>
>>
>>> +    if (!msi_node)
>>> +        return;
>>> +
>>> +    pp->msi = of_pci_find_msi_chip_by_node(msi_node);
>>> +    of_node_put(msi_node);
>>> +
>>> +    if (pp->msi)
>>> +        pp->msi->dev = pp->dev;
>>> +}
>>
>> [...]
>>
>>> +static int rockchip_pcie_probe(struct platform_device *pdev)
>>> +{
>>> +    struct rockchip_pcie_port *port;
>>> +    struct device *dev = &pdev->dev;
>>> +    struct pci_bus *bus, *child;
>>> +    struct resource_entry *win;
>>> +    int reg_no;
>>> +    int err = 0;
>>> +    int irq;
>>> +    LIST_HEAD(res);
>>> +
>>> +    if (!dev->of_node)
>>> +        return -ENODEV;
>>> +
>>> +    port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
>>> +    if (!port)
>>> +        return -ENOMEM;
>>> +
>>> +    irq = platform_get_irq_byname(pdev, "pcie-sys");
>>> +    if (irq < 0) {
>>> +        dev_err(dev, "missing pcie_sys IRQ resource\n");
>>> +        return -EINVAL;
>>> +    }
>>
>> blank line
>>
>>> +    err = devm_request_irq(dev, irq, rockchip_pcie_subsys_irq_handler,
>>> +                   IRQF_SHARED, "pcie-sys", port);
>>> +    if (err) {
>>> +        dev_err(dev, "failed to request pcie subsystem irq\n");
>>> +        return err;
>>> +    }
>>> +
>>> +    port->irq = platform_get_irq_byname(pdev, "pcie-legacy");
>>> +    if (port->irq < 0) {
>>> +        dev_err(dev, "missing pcie_legacy IRQ resource\n");
>>> +        return -EINVAL;
>>> +    }
>>
>> blank line
>>
>>> +    err = devm_request_irq(dev, port->irq,
>>> +                   rockchip_pcie_legacy_int_handler,
>>> +                   IRQF_SHARED,
>>> +                   "pcie-legacy",
>>> +                   port);
>>> +    if (err) {
>>> +        dev_err(&pdev->dev, "failed to request pcie-legacy irq\n");
>>> +        return err;
>>> +    }
>>> +
>>> +    irq = platform_get_irq_byname(pdev, "pcie-client");
>>> +    if (irq < 0) {
>>> +        dev_err(dev, "missing pcie-client IRQ resource\n");
>>> +        return -EINVAL;
>>> +    }
>>
>> blank line
>>
>>> +    err = devm_request_irq(dev, irq, rockchip_pcie_client_irq_handler,
>>> +                   IRQF_SHARED, "pcie-client", port);
>>> +    if (err) {
>>> +        dev_err(dev, "failed to request pcie client irq\n");
>>> +        return err;
>>> +    }
>>> +
>>> +    port->dev = dev;
>>> +    err = rockchip_pcie_parse_dt(port);
>>> +    if (err) {
>>> +        dev_err(dev, "Parsing DT failed\n");
>>> +        return err;
>>> +    }
>>
>> rockchip_pcie_parse_dt already emits error messages that are a lot more
>> specific to the actual problem, so you don't need another error
>> message here
>> and can just return the error code.
>>
>
> okay.
>
>>
>>> +    err = rockchip_pcie_init_port(port);
>>> +    if (err)
>>> +        return err;
>>> +
>>> +    platform_set_drvdata(pdev, port);
>>> +
>>> +    rockchip_pcie_enable_interrupts(port);
>>> +    if (!IS_ENABLED(CONFIG_PCI_MSI)) {
>>> +        err = rockchip_pcie_init_irq_domain(port);
>>> +        if (err < 0)
>>> +            return err;
>>> +    }
>>> +
>>> +    err = of_pci_get_host_bridge_resources(dev->of_node, 0, 0xff,
>>> +                           &res, &port->io_base);
>>> +    if (err)
>>> +        return err;
>>
>> add blank line
>>
>>
>> Heiko
>>
>>
>>
>
>


-- 
Best Regards
Shawn Lin
