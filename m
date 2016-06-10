Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36110 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbcFJEBD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2016 00:01:03 -0400
Received: by mail-vk0-f46.google.com with SMTP id g67so82139507vkb.3
        for <linux-pci@vger.kernel.org>; Thu, 09 Jun 2016 21:01:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1465373117-823-1-git-send-email-shawn.lin@rock-chips.com>
References: <1465373117-823-1-git-send-email-shawn.lin@rock-chips.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 9 Jun 2016 21:01:01 -0700
Message-ID: <CAD=FV=XiRgjAU2STck4mcWAERqZDvNSsCUytHDnWD+SHL2sRrQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Documentation: bindings: add dt doc for Rockchip
 PCIe controller
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
> +pcie0: pcie@f8000000 {
> +       compatible = "rockchip,rk3399-pcie";
> +       #address-cells = <3>;
> +       #size-cells = <2>;
> +       clocks = <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
> +                <&cru PCLK_PCIE>;
> +       clock-names = "aclk", "aclk-perf",
> +                     "hclk";

Code also requires a "pm" clock.

> +       bus-range = <0x0 0x1>;
> +       interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
> +                    <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> +       interrupt-names: "sys", "legacy", "client";

Shouldn't be ":", should be "=".


> +       assigned-clocks = <&cru SCLK_PCIEPHY_REF>;
> +       assigned-clock-parents = <&cru SCLK_PCIEPHY_REF100M>;
> +       assigned-clock-rates = <100000000>;
> +       ep-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
> +       ranges = < 0x82000000 0 0xfa000000 0x0 0xfa000000 0 0x600000
> +                  0x81000000 0 0xfa600000 0x0 0xfa600000 0 0x100000 >;

nit: I don't thin it's common to have spaces before/after the ">" and "<".
nit: Be consistent about 0 vs. 0x0 in ranges.


> +       num-lanes = <4>;
> +       reg = < 0x0 0xf8000000 0x0 0x2000000 >, < 0x0 0xfd000000 0x0 0x1000000 >;
> +       reg-name = "axi-base", "apb-base";

Should be "reg-names" (with an "s")


> +       resets = <&cru SRST_PCIEPHY>, <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
> +                <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE>;
> +       reset-names = "core", "mgmt", "mgmt-sticky", "pipe";

You have 5 resets but 4 reset names.  That doesn't seem right.  Code
shows you only getting 4, so presumably you need to remove the
SRST_PCIEPHY one.


-Doug
