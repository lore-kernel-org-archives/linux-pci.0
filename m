Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:53530 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbaC3VCH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 30 Mar 2014 17:02:07 -0400
From: Marek Vasut <marex@denx.de>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 1/8] ARM: imx6q-clk: parent lvds_gate from lvds_sel
Date: Sun, 30 Mar 2014 19:29:29 +0200
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
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de> <1396025579-14344-2-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1396025579-14344-2-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201403301929.29351.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, March 28, 2014 at 05:52:52 PM, Lucas Stach wrote:
> Allows fror proper refcounting of the parent clocks
> when enabling the clock output on CLK1/2 pads.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Looks OK:

Reviewed-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
