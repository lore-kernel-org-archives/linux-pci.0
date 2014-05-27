Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f180.google.com ([209.85.128.180]:39443 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbaE0OCc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 May 2014 10:02:32 -0400
MIME-Version: 1.0
In-Reply-To: <1399885183.5016.4.camel@weser.hi.pengutronix.de>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
	<20140424175844.GD29593@google.com>
	<1398421265.4657.25.camel@weser.hi.pengutronix.de>
	<CAErSpo7Boi8d+apAUC3TmmE33LuRMYJ6J+TEPLRbeyZyU3O8RQ@mail.gmail.com>
	<1398774686.4677.12.camel@weser.hi.pengutronix.de>
	<1399885183.5016.4.camel@weser.hi.pengutronix.de>
Date: Tue, 27 May 2014 11:02:31 -0300
Message-ID: <CAOMZO5BAcZi5dKvitPxqcWnB=J1LY7sDRxiDcxRAjZmSpGZBEA@mail.gmail.com>
Subject: Re: [PATCH 0/8] i.MX6 PCIe binding change and MSI support
From: Fabio Estevam <festevam@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Richard Zhu <r65037@freescale.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Marek Vasut <marex@denx.de>, Arnd Bergmann <arnd@arndb.de>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tim Harvey <tharvey@gateworks.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Rob Herring <robh+dt@kernel.org>,
	linux-samsung-soc@vger.kernel.org,
	Sascha Hauer <kernel@pengutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Sean Cross <xobs@kosagi.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Mon, May 12, 2014 at 5:59 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Hi Bjorn,
>
> just a friendly reminder. It would be nice if you could pull those in.
>
> Shawn already pulled the DT change and as it is a binding change this
> means PCIe on i.MX6 is broken in -next, as long as the remaining patches
> are missing.

We still have imx6q pcie broken in linux-next:

imx6q-pcie 1ffc000.pcie: lvds_gate clock select missing or invalid
imx6q-pcie: probe of 1ffc000.pcie failed with error -2


Could you please apply Lucas' series?
