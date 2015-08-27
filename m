Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36381 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbbH0Rsj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Aug 2015 13:48:39 -0400
MIME-Version: 1.0
In-Reply-To: <1440678857-27118-4-git-send-email-gabriel.fernandez@linaro.org>
References: <1440678857-27118-1-git-send-email-gabriel.fernandez@linaro.org>
	<1440678857-27118-4-git-send-email-gabriel.fernandez@linaro.org>
Date: Thu, 27 Aug 2015 23:01:16 +0530
Message-ID: <CAHM4w1=g=UFoz=R-6hxJC0=fSieN1WDvZT97ykL1b3_YPhBjZg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] PCI: st: Provide support for the sti PCIe controller
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Gabriel Fernandez <gabriel.fernandez@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Russell King <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Joe Perches <joe@perches.com>, Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, kernel@stlinux.com,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gabriel,

Looks good to me.

On Thu, Aug 27, 2015 at 6:04 PM, Gabriel Fernandez
<gabriel.fernandez@linaro.org> wrote:
> sti pcie is built around a Synopsis Designware PCIe IP.
>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>


> +static int st_pcie_link_up(struct pcie_port *pp)
> +{
> +       u32 status;
> +       int link_up;

nit: why not bool

> +       int count = 0;

[...]

> +static void st_pcie_board_reset(struct pcie_port *pp)
> +{
> +       struct st_pcie *pcie = to_st_pcie(pp);
> +
> +       if (!gpio_is_valid(pcie->reset_gpio))
> +               return;
> +
> +       if (gpio_direction_output(pcie->reset_gpio, 0)) {
> +               dev_err(pp->dev, "Cannot set PERST# (gpio %u) to output\n",
> +                       pcie->reset_gpio);
> +               return;
> +       }
> +
> +       /* From PCIe spec */
> +       msleep(2);
> +       gpio_direction_output(pcie->reset_gpio, 1);
> +
> +       /*
> +        * PCIe specification states that you should not issue any config
> +        * requests until 100ms after asserting reset, so we enforce that here
> +        */
> +       msleep(100);

IIRC, specification says to wait after link training completes. So
shouldn't it be after st_pcie_enable_ltssm. Moreover, I wonder why
others do not need it.

Reviewed-by: Pratyush Anand <pratyush.anand@gmail.com>
