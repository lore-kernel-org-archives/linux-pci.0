Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45832 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574AbaCaJ3X (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 31 Mar 2014 05:29:23 -0400
Message-ID: <1396258109.5533.11.camel@weser.hi.pengutronix.de>
Subject: Re: [PATCH 2/8] PCI: designware: split Exynos and i.MX bindings
From: Lucas Stach <l.stach@pengutronix.de>
To: Marek Vasut <marex@denx.de>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	Sean Cross <xobs@kosagi.com>,
	Richard Zhu <r65037@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Tim Harvey <tharvey@gateworks.com>, kernel@pengutronix.de
Date: Mon, 31 Mar 2014 11:28:29 +0200
In-Reply-To: <201403301936.49692.marex@denx.de>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
	 <1396025579-14344-3-git-send-email-l.stach@pengutronix.de>
	 <201403301936.49692.marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Sonntag, den 30.03.2014, 19:36 +0200 schrieb Marek Vasut:
> On Friday, March 28, 2014 at 05:52:53 PM, Lucas Stach wrote:
> > The glue around the core designware IP is significantly
> > different between the Exynos and i.MX implementation,
> > which is reflected in the DT bindings.
> > 
> > This changes the i.MX6 binding to reuse as much as
> > possible from the common designware binding and
> > removes old cruft.
> > 
> > I removed the optional GPIOs with the following reasoning:
> > - disable-gpio: endpoint specific GPIO, not currently
> >   wired up in any code. Should be handled by the PCI device
> >   driver, not the host controller driver.
> > - wake-up-gpio: same as above.
> > - power-on-gpio: No user in any upstream DT. This should
> >   be handled by a regulator which shouldn't be controlled
> >   by the host driver, but rather by the PCI device driver.
> 
> This power-on-gpio should indeed be handled by the regulator, but the regulator 
> cannot be handled by the PCIe device driver. This power-on-gpio must be operated 
> on per-slot basis if I understand it correctly, so it cannot be controlled by 
> the host controller driver either.
> 
> The reason why this cannot be controlled by the device driver is that if the 
> device is powered down, it won't be detected on the PCIe bus, thus it cannot 
> enable the regulator which will power up the slot the device is sitting in.
> 
So we are on the same page with regard to a GPIO being the wrong
abstraction for this, I think.

For the regulator part I would argue that PCI is a bus that is built
around the ability to inspect the bus and detect devices on the bus at
probe time, so any regulator that's powering a PCI device should be
boot-on.

Only after the device driver is loaded it should be able to fetch the
regulator to power down/up the device as it wishes. In the x86 world
this is AFAIK done using ACPI methods.

I think the host controller driver has no business in controlling the
device power, more so as there possibly could be a lot of devices on the
bus even with a single host lane.

> 
> btw. am I blind or do I just not see devicetree-discuss on CC ?
> 
Hm, there is devicetree@vger.kernel.org on CC, which MAINTAINER says is
the right list for this stuff.

Regards,
Lucas

-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

