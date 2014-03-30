Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:36938 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbaC3VCH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 30 Mar 2014 17:02:07 -0400
From: Marek Vasut <marex@denx.de>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 2/8] PCI: designware: split Exynos and i.MX bindings
Date: Sun, 30 Mar 2014 19:36:49 +0200
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
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de> <1396025579-14344-3-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1396025579-14344-3-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201403301936.49692.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, March 28, 2014 at 05:52:53 PM, Lucas Stach wrote:
> The glue around the core designware IP is significantly
> different between the Exynos and i.MX implementation,
> which is reflected in the DT bindings.
> 
> This changes the i.MX6 binding to reuse as much as
> possible from the common designware binding and
> removes old cruft.
> 
> I removed the optional GPIOs with the following reasoning:
> - disable-gpio: endpoint specific GPIO, not currently
>   wired up in any code. Should be handled by the PCI device
>   driver, not the host controller driver.
> - wake-up-gpio: same as above.
> - power-on-gpio: No user in any upstream DT. This should
>   be handled by a regulator which shouldn't be controlled
>   by the host driver, but rather by the PCI device driver.

This power-on-gpio should indeed be handled by the regulator, but the regulator 
cannot be handled by the PCIe device driver. This power-on-gpio must be operated 
on per-slot basis if I understand it correctly, so it cannot be controlled by 
the host controller driver either.

The reason why this cannot be controlled by the device driver is that if the 
device is powered down, it won't be detected on the PCIe bus, thus it cannot 
enable the regulator which will power up the slot the device is sitting in.

[...]

btw. am I blind or do I just not see devicetree-discuss on CC ?

Best regards,
Marek Vasut
