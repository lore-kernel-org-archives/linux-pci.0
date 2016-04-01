Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ibawizard.net ([82.208.49.253]:56490 "EHLO
	mengele.ibawizard.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043AbcDAMux (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Apr 2016 08:50:53 -0400
From: =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
To: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
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
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
	Fabio Estevam <festevam@gmail.com>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>, stefan@agner.ch
Subject: [PATCH] ARM: imx6: Fix PCIe reset gpio polarity on Toradex Apalis
Date: Fri,  1 Apr 2016 14:41:46 +0200
Message-Id: <1459514508-8557-1-git-send-email-ynezz@true.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In commit 5c5fb40de8f14 "PCI: imx6: Add support for active-low reset GPIO"
I've made GPIO reset polarity aware, which made the PCIe working on Apalis SoM
(reset active-high), but it has broken PCIe on several other i.MX6 boards
(reset active-low) due to wrong logic level. It has made the default reset
logic active-high, but it was active-low since beginning due to the bug in the
reset code:

	gpio_set_value_cansleep(imx6_pcie->reset_gpio, 0);
	msleep(100);
	gpio_set_value_cansleep(imx6_pcie->reset_gpio, 1);

This breakage couldn't be fixed correctly by fixing the reset code snippet
mentioned above and fixing the broken DTBs, as we can't touch the DTBs, so the
5c5fb40de8f14 commit is going to be reverted, making PCIe reset broken on
Apalis modules again.

As suggested by Fabio, to fix this situation in backward compatible manner, we
should introduce new boolean DT property reset-gpio-active-high, which would
set PCIe reset GPIO polarity as needed. This patch series tries to do so.
