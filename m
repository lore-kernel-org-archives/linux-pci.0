Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55585 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758570AbaD3KTG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Apr 2014 06:19:06 -0400
Message-ID: <1398853076.4653.5.camel@weser.hi.pengutronix.de>
Subject: Re: [PATCH 3/8] ARM: dts: imx6: update pcie to bring in line with
 new binding
From: Lucas Stach <l.stach@pengutronix.de>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	Sean Cross <xobs@kosagi.com>, Marek Vasut <marex@denx.de>,
	Richard Zhu <r65037@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Tim Harvey <tharvey@gateworks.com>, kernel@pengutronix.de
Date: Wed, 30 Apr 2014 12:17:56 +0200
In-Reply-To: <20140430060208.GA16727@dragon>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
	 <1396025579-14344-4-git-send-email-l.stach@pengutronix.de>
	 <20140430060208.GA16727@dragon>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Mittwoch, den 30.04.2014, 14:02 +0800 schrieb Shawn Guo:
> On Fri, Mar 28, 2014 at 05:52:54PM +0100, Lucas Stach wrote:
> > The new bindings drops one clock, renames the others and
> > drops the old interrupt mapping.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> 
> It does not apply on my branch, and I had to apply it manually.  Please
> check my imx/dt branch to see if I did it right.
> 
The diff as applied in your imx/dt looks good to me.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

