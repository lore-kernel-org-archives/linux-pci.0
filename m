Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36117 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756505AbbJUWz3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 21 Oct 2015 18:55:29 -0400
MIME-Version: 1.0
In-Reply-To: <1445432201-16007-2-git-send-email-w-kwok2@ti.com>
References: <1445432201-16007-1-git-send-email-w-kwok2@ti.com> <1445432201-16007-2-git-send-email-w-kwok2@ti.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 21 Oct 2015 17:55:07 -0500
Message-ID: <CAL_JsqKSteJnz53YuBbgR1K9GWQDddkaqFo1aVxd8RsDam5jSw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] phy: keystone: serdes driver for gbe 10gbe and pcie
To: WingMan Kwok <w-kwok2@ti.com>
Cc: Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Roger Quadros <rogerq@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 21, 2015 at 7:56 AM, WingMan Kwok <w-kwok2@ti.com> wrote:
> On TI's Keystone platforms, several peripherals such as the
> gbe ethernet switch, 10gbe ethernet switch and PCIe controller
> require the use of a SerDes for converting SoC parallel data into
> serialized data that can be output over a high-speed electrical
> interface, and also converting high-speed serial input data
> into parallel data that can be processed by the SoC.  The
> SerDeses used by those peripherals, though they may be different,
> are largely similar in functionality and setup.
>
> This patch provides a SerDes phy driver implementation that can be
> used by the above mentioned peripheral drivers to configure their
> respective SerDeses.
>
> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
> ---
>  Documentation/devicetree/bindings/phy/ti-phy.txt |  239 +++

For the binding:

Acked-by: Rob Herring <robh@kernel.org>


One other comment:

> +       if (of_device_is_compatible(np, "ti,keystone-serdes-gbe")) {
> +               sc->phy_type = KSERDES_PHY_SGMII;
> +       } else if (of_device_is_compatible(np, "ti,keystone-serdes-xgbe")) {
> +               sc->phy_type = KSERDES_PHY_XGE;
> +       } else if (of_device_is_compatible(np, "ti,keystone-serdes-pcie")) {
> +               sc->phy_type = KSERDES_PHY_PCIE;
> +       } else {
> +               dev_err(dev, "unknown phy type\n");
> +               return -EINVAL;
> +       }

Use the match data to set the type:

> +static const struct of_device_id kserdes_of_match[] = {
> +       { .compatible = "ti,keystone-serdes-gbe" },
> +       { .compatible = "ti,keystone-serdes-pcie" },
> +       { .compatible = "ti,keystone-serdes-xgbe" },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, kserdes_of_match);

Rob
