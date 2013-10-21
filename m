Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db9lp0251.outbound.messaging.microsoft.com ([213.199.154.251]:55488
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752052Ab3JUAy6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 20 Oct 2013 20:54:58 -0400
Date: Mon, 21 Oct 2013 08:56:14 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Marek Vasut <marex@denx.de>
CC: Tim Harvey <tharvey@gateworks.com>, <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Richard Zhu <r65037@freescale.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH] PCI: imx6: fix imprecise abort handler
Message-ID: <20131021005612.GC17165@S2101-09.ap.freescale.net>
References: <1382056042-7299-1-git-send-email-tharvey@gateworks.com>
 <201310190333.52772.marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <201310190333.52772.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Oct 19, 2013 at 03:33:52AM +0200, Marek Vasut wrote:
> Dear Tim Harvey,
> 
> > An imprecise abort is triggered when a port behind a switch is accessed
> > and no device is present.  At enumeration, imprecise aborts are not enabled
> > thus this ends up getting deferred until the kernel has completed init.  At
> > that point we must not adjust PC - the handler must do nothing, but a
> > handler must exist.
> > 
> > This fixes random crashes that occur right after freeing init.
> > This is against linux-pci/host-imx6.
> > 
> > Acked-by: Marek Vasut <marex@denx.de>
> > Tested-by: Marek Vasut <marex@denx.de>
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> 
> Expanding CC a bit, let's have more eyes on this.
> 

Acked-by: Shawn Guo <shawn.guo@linaro.org>

