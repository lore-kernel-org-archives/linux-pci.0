Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1blp0188.outbound.protection.outlook.com ([207.46.163.188]:44713
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751972AbaD3GC3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 30 Apr 2014 02:02:29 -0400
Date: Wed, 30 Apr 2014 14:02:10 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Lucas Stach <l.stach@pengutronix.de>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	Sean Cross <xobs@kosagi.com>, Marek Vasut <marex@denx.de>,
	Richard Zhu <r65037@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	"Mark Rutland" <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Tim Harvey <tharvey@gateworks.com>, <kernel@pengutronix.de>
Subject: Re: [PATCH 3/8] ARM: dts: imx6: update pcie to bring in line with
 new binding
Message-ID: <20140430060208.GA16727@dragon>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
 <1396025579-14344-4-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1396025579-14344-4-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 28, 2014 at 05:52:54PM +0100, Lucas Stach wrote:
> The new bindings drops one clock, renames the others and
> drops the old interrupt mapping.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

It does not apply on my branch, and I had to apply it manually.  Please
check my imx/dt branch to see if I did it right.

Shawn
