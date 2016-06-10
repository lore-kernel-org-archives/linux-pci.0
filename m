Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:36745 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbcFJEAK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2016 00:00:10 -0400
Received: by mail-vk0-f45.google.com with SMTP id g67so82118651vkb.3
        for <linux-pci@vger.kernel.org>; Thu, 09 Jun 2016 21:00:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1465373154-882-1-git-send-email-shawn.lin@rock-chips.com>
References: <1465373154-882-1-git-send-email-shawn.lin@rock-chips.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 9 Jun 2016 21:00:08 -0700
Message-ID: <CAD=FV=U2fNgkNNLZbSAkt5LjfsSazjZnga=3h0MUi8AFMgjk_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: Rockchip: Add Rockchip PCIe controller support
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Shawn,

On Wed, Jun 8, 2016 at 1:05 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> This patch adds Rockchip PCIe controller support found
> on RK3399 Soc platform.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> ---
>
> Changes in v2:
> - remove phy related stuff and call phy API
> - add new head file and define lots of macro to make
>   the code more readable
> - remove lots msi related code suggested by Marc
> - add IO window address translation
> - init_port and parse_dt reconstruction suggested by Bharat
> - improve wr_own_conf suggested by Arnd
> - make pcie as an interrupt controller and fix wrong int handler
>   suggested by Marc
> - remove PCI_PROBE_ONLY suggested by Lorenzo
>
>  drivers/pci/host/Kconfig         |   11 +
>  drivers/pci/host/Makefile        |    1 +
>  drivers/pci/host/pcie-rockchip.c | 1049 ++++++++++++++++++++++++++++++++++++++
>  drivers/pci/host/pcie-rockchip.h |  209 ++++++++
>  4 files changed, 1270 insertions(+)

A few drive-by comments for things I ran into trying to get this
working.  I'm no PCI expert.


> +config PCIE_ROCKCHIP
> +       bool "Rockchip PCIe controller"
> +       depends on ARM64 && ARCH_ROCKCHIP
> +       depends on OF
> +       select MFD_SYSCON
> +       select PCI_MSI_IRQ_DOMAIN if PCI_MSI

Probably because I don't know what I'm doing, but when I had PCI_MSI
configured I had trouble getting interrupts.  Figured I'd mention it
even though it's probably user error.

> +/**
> + * rockchip_pcie_parse_dt - Parse Device tree
> + * @port: PCIe port information
> + *
> + * Return: '0' on success and error value on failure
> + */
> +static int rockchip_pcie_parse_dt(struct rockchip_pcie_port *port)
> +{
> +       struct device *dev = port->dev;
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct device_node *node = dev->of_node;
> +       struct resource *regs;
> +       int irq;
> +       int err;
> +
> +       regs = platform_get_resource_byname(pdev,
> +                                           IORESOURCE_MEM,
> +                                           "axi-base");
> +       if (!regs) {
> +               dev_err(dev, "missing axi-base property\n");
> +               return err;

Won't "err" be uninitialized?

> +       }
> +
> +       port->reg_base = devm_ioremap_resource(dev, regs);
> +       if (IS_ERR(port->reg_base))
> +               return PTR_ERR(port->reg_base);
> +
> +       regs = platform_get_resource_byname(pdev,
> +                                           IORESOURCE_MEM,
> +                                           "apb-base");
> +       if (!regs) {
> +               dev_err(dev, "missing apb-base property\n");
> +               return err;

Here too.

> +       }
> +
> +       port->apb_base = devm_ioremap_resource(dev, regs);
> +       if (IS_ERR(port->apb_base))
> +               return PTR_ERR(port->apb_base);
> +
> +       port->phy = devm_phy_get(dev, "pcie-phy");
> +       if (IS_ERR_OR_NULL(port->phy)) {
> +               if (PTR_ERR_OR_ZERO(port->phy) != -EPROBE_DEFER)
> +                       dev_err(dev, "Missing pcie-phy\n");
> +               return PTR_ERR(port->phy);
> +       }
> +
> +       port->lanes = 1;
> +       err = of_property_read_u32(node, "num-lanes", &port->lanes);
> +       if (!err && ((port->lanes == 0) ||
> +                    (port->lanes == 3) ||
> +                    (port->lanes > 4))) {
> +               dev_warn(dev, "invalid num-lanes, default use one lane\n");
> +               port->lanes = 1;
> +       }
> +
> +       port->core_rst = devm_reset_control_get(dev, "core");
> +       if (IS_ERR(port->core_rst)) {
> +               if (PTR_ERR(port->core_rst) != -EPROBE_DEFER)
> +                       dev_err(dev, "missing core rst property in node %s\n",
> +                               node->name);
> +               return PTR_ERR(port->core_rst);
> +       }
> +
> +       port->mgmt_rst = devm_reset_control_get(dev, "mgmt");
> +       if (IS_ERR(port->mgmt_rst)) {
> +               if (PTR_ERR(port->mgmt_rst) != -EPROBE_DEFER)
> +                       dev_err(dev, "missing mgmt rst property in node %s\n",
> +                               node->name);
> +               return PTR_ERR(port->mgmt_rst);
> +       }
> +
> +       port->mgmt_sticky_rst = devm_reset_control_get(dev, "mgmt-sticky");
> +       if (IS_ERR(port->mgmt_sticky_rst)) {
> +               if (PTR_ERR(port->mgmt_sticky_rst) != -EPROBE_DEFER)
> +                       dev_err(dev, "missing mgmt-sticky rst property in node %s\n",
> +                               node->name);
> +               return PTR_ERR(port->mgmt_sticky_rst);
> +       }
> +
> +       port->pipe_rst = devm_reset_control_get(dev, "pipe");
> +       if (IS_ERR(port->pipe_rst)) {
> +               if (PTR_ERR(port->pipe_rst) != -EPROBE_DEFER)
> +                       dev_err(dev, "missing pipe rst property in node %s\n",
> +                               node->name);
> +               return PTR_ERR(port->pipe_rst);
> +       }
> +
> +       port->ep_gpio = gpiod_get(dev, "ep", GPIOD_OUT_HIGH);

Please use devm_gpiod_get().  Without that the GPIO won't be released
properly.  I ran into this when I had a deferral in probe.


> +       if (IS_ERR(port->ep_gpio)) {
> +               dev_err(dev, "missing ep-gpios property in node %s\n",
> +                       node->name);
> +               return PTR_ERR(port->ep_gpio);
> +       }
> +
> +       port->aclk_pcie = devm_clk_get(dev, "aclk");
> +       if (IS_ERR(port->aclk_pcie)) {
> +               dev_err(dev, "aclk clock not found.\n");
> +               return PTR_ERR(port->aclk_pcie);
> +       }
> +
> +       port->aclk_perf_pcie = devm_clk_get(dev, "aclk-perf");
> +       if (IS_ERR(port->aclk_perf_pcie)) {
> +               dev_err(dev, "aclk_perf clock not found.\n");
> +               return PTR_ERR(port->aclk_perf_pcie);
> +       }
> +
> +       port->hclk_pcie = devm_clk_get(dev, "hclk");
> +       if (IS_ERR(port->hclk_pcie)) {
> +               dev_err(dev, "hclk clock not found.\n");
> +               return PTR_ERR(port->hclk_pcie);
> +       }
> +
> +       port->clk_pcie_pm = devm_clk_get(dev, "pm");
> +       if (IS_ERR(port->clk_pcie_pm)) {
> +               dev_err(dev, "pm clock not found.\n");
> +               return PTR_ERR(port->clk_pcie_pm);
> +       }
> +
> +       irq = platform_get_irq_byname(pdev, "sys");
> +       if (irq < 0) {
> +               dev_err(dev, "missing pcie_sys IRQ resource\n");
> +               return -EINVAL;
> +       }
> +
> +       err = devm_request_irq(dev, irq, rockchip_pcie_subsys_irq_handler,
> +                              IRQF_SHARED, "pcie-sys", port);
> +       if (err) {
> +               dev_err(dev, "failed to request pcie subsystem irq\n");
> +               return err;
> +       }
> +
> +       port->irq = platform_get_irq_byname(pdev, "legacy");
> +       if (port->irq < 0) {
> +               dev_err(dev, "missing pcie_legacy IRQ resource\n");
> +               return -EINVAL;
> +       }
> +
> +       irq_set_chained_handler_and_data(port->irq,
> +                                        rockchip_pcie_legacy_int_handler,
> +                                        port);
> +
> +       irq = platform_get_irq_byname(pdev, "client");
> +       if (irq < 0) {
> +               dev_err(dev, "missing pcie-client IRQ resource\n");
> +               return -EINVAL;
> +       }
> +
> +       err = devm_request_irq(dev, irq, rockchip_pcie_client_irq_handler,
> +                              IRQF_SHARED, "pcie-client", port);
> +       if (err) {
> +               dev_err(dev, "failed to request pcie client irq\n");
> +               return err;
> +       }
> +
> +       port->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
> +       if (IS_ERR(port->vpcie3v3)) {
> +               if (PTR_ERR(port->vpcie3v3) == -EPROBE_DEFER)
> +                       return -EPROBE_DEFER;
> +               dev_info(dev, "No vpcie3v3 regulator found.\n");
> +       }
> +
> +       port->vpcie1v8 = devm_regulator_get_optional(dev, "vpcie1v8");
> +       if (IS_ERR(port->vpcie1v8)) {
> +               if (PTR_ERR(port->vpcie1v8) == -EPROBE_DEFER)
> +                       return -EPROBE_DEFER;
> +               dev_info(dev, "No vpcie1v8 regulator found.\n");
> +       }
> +
> +       port->vpcie0v9 = devm_regulator_get_optional(dev, "vpcie0v9");
> +       if (IS_ERR(port->vpcie0v9)) {
> +               if (PTR_ERR(port->vpcie0v9) == -EPROBE_DEFER)
> +                       return -EPROBE_DEFER;
> +               dev_info(dev, "No vpcie0v9 regulator found.\n");
> +       }

I think it would be cleaner to just use regulator_get() and just get a
dummy if the user didn't specify a regulator.  That simplifies code a
lot.


> +
> +       return 0;
> +}
> +
> +static int rockchip_pcie_set_vpcie(struct rockchip_pcie_port *port)
> +{
> +       int err;
> +
> +       if (!IS_ERR(port->vpcie3v3)) {
> +               err = regulator_enable(port->vpcie3v3);
> +               if (err) {
> +                       dev_err(port->dev, "Fail to enable vpcie3v3 regulator.\n");
> +                       goto err_out;
> +               }
> +
> +               /* Check if supported first to avoid errors. */
> +               if (!regulator_is_supported_voltage(port->vpcie3v3,
> +                                                   VPCIE_3V3, VPCIE_3V3)) {
> +                       dev_err(port->dev, "3v3 voltage ranges isn't supported.\n");
> +                       err = -EINVAL;
> +                       goto err_disable_3v3;
> +               }
> +
> +               err = regulator_set_voltage_triplet(port->vpcie3v3, VPCIE_3V3,
> +                                                   VPCIE_3V3, VPCIE_3V3);
> +               if (err)
> +                       goto err_disable_3v3;
> +       }
> +
> +       if (!IS_ERR(port->vpcie1v8)) {
> +               err = regulator_enable(port->vpcie1v8);
> +               if (err) {
> +                       dev_err(port->dev, "Fail to enable vpcie1v8 regulator.\n");
> +                       goto err_disable_3v3;
> +               }
> +
> +               /* Check if supported first to avoid errors. */
> +               if (!regulator_is_supported_voltage(port->vpcie1v8,
> +                                                   VPCIE_1V8, VPCIE_1V8)) {
> +                       dev_err(port->dev, "1v8 voltage ranges isn't supported.\n");
> +                       err = -EINVAL;
> +                       goto err_disable_1v8;
> +               }
> +
> +               err = regulator_set_voltage_triplet(port->vpcie1v8, VPCIE_1V8,
> +                                                   VPCIE_1V8, VPCIE_1V8);
> +               if (err)
> +                       goto err_disable_1v8;
> +       }
> +
> +       if (!IS_ERR(port->vpcie0v9)) {
> +               err = regulator_enable(port->vpcie0v9);
> +               if (err) {
> +                       dev_err(port->dev, "Fail to enable vpcie0v9 regulator.\n");
> +                       goto err_disable_1v8;
> +               }
> +
> +               /* Check if supported first to avoid errors. */
> +               if (!regulator_is_supported_voltage(port->vpcie0v9,
> +                                                   VPCIE_0V9, VPCIE_0V9)) {
> +                       dev_err(port->dev, "0v9 voltage ranges isn't supported.\n");
> +                       err = -EINVAL;
> +                       goto err_disable_0v9;
> +               }
> +
> +               err = regulator_set_voltage_triplet(port->vpcie0v9, VPCIE_0V9,
> +                                                   VPCIE_0V9, VPCIE_0V9);
> +               if (err)
> +                       goto err_disable_0v9;
> +       }

IMHO I don't think you need to worry about setting voltages here.
Just let the regulator constraints do their jobs.  That means if you
use devm_regulator_get() above (and thus get dummy regulators if none
are specified), then this should just be:

  int err;

  err = regulator_enable(port->vpcie3v3);
  if (err)
    return err;

  err = regulator_enable(port->vpcie1v8);
  if (err)
    goto err_3v3_enabled;

  err = regulator_enable(port->vpcie0v9);
  if (!err)
    return 0;

  regulator_disable(port->vpcie1v8);
err_3v3_enabled:
  regulator_disable(port->vpcie3v3);

  return err;
