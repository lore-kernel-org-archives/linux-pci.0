Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49380 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932207AbcDTAs7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 19 Apr 2016 20:48:59 -0400
Date: Tue, 19 Apr 2016 19:48:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Russell King <linux@arm.linux.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Tim Harvey <tharvey@gateworks.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Fabio Estevam <festevam@gmail.com>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>, stefan@agner.ch
Subject: Re: [PATCH] ARM: imx6: Fix PCIe reset gpio polarity on Toradex Apalis
Message-ID: <20160420004855.GG17863@localhost>
References: <1459514508-8557-1-git-send-email-ynezz@true.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1459514508-8557-1-git-send-email-ynezz@true.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 01, 2016 at 02:41:46PM +0200, Petr Štetiar wrote:
> In commit 5c5fb40de8f14 "PCI: imx6: Add support for active-low reset GPIO"
> I've made GPIO reset polarity aware, which made the PCIe working on Apalis SoM
> (reset active-high), but it has broken PCIe on several other i.MX6 boards
> (reset active-low) due to wrong logic level. It has made the default reset
> logic active-high, but it was active-low since beginning due to the bug in the
> reset code:
> 
> 	gpio_set_value_cansleep(imx6_pcie->reset_gpio, 0);
> 	msleep(100);
> 	gpio_set_value_cansleep(imx6_pcie->reset_gpio, 1);
> 
> This breakage couldn't be fixed correctly by fixing the reset code snippet
> mentioned above and fixing the broken DTBs, as we can't touch the DTBs, so the
> 5c5fb40de8f14 commit is going to be reverted, making PCIe reset broken on
> Apalis modules again.
> 
> As suggested by Fabio, to fix this situation in backward compatible manner, we
> should introduce new boolean DT property reset-gpio-active-high, which would
> set PCIe reset GPIO polarity as needed. This patch series tries to do so.

I applied both of these (the original Toradex Apalis Ixora DTS fix and
the v3 "Add reset-gpio-active-high" change) to pci/host-imx6 for v4.7,
with Lucas' Reviewed-by, Rob's Acked-by, and Tim's Tested-by.  Thanks,
Petr!
