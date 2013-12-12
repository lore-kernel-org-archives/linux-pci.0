Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db8lp0188.outbound.messaging.microsoft.com ([213.199.154.188]:29423
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751640Ab3LLHA0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Dec 2013 02:00:26 -0500
Date: Thu, 12 Dec 2013 15:00:47 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<linux-samsung-soc@vger.kernel.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Thierry Reding <thierry.reding@gmail.com>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Wei Yongjun <weiyj.lk@gmail.com>,
	Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Richard Zhu <r65037@freescale.com>
Subject: Re: [PATCH] MAINTAINERS: Add DesignWare, i.MX6, Armada, R-Car PCI
 host maintainers
Message-ID: <20131212070045.GO18380@S2101-09.ap.freescale.net>
References: <20131211183237.GI4699@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20131211183237.GI4699@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Wed, Dec 11, 2013 at 11:32:37AM -0700, Bjorn Helgaas wrote:
> +PCI DRIVER FOR IMX6
> +M:	Shawn Guo <shawn.guo@linaro.org>

Thanks for the nomination.  But I think a better person for this
position would be Richard Zhu <r65037@freescale.com> (copied).  He knows
the driver and controller much better than myself, and most importantly
he is the driver owner for Freescale kernel and he has the contact to
Freescale PCIe hardware people.

Shawn

> +L:	linux-pci@vger.kernel.org
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	drivers/pci/host/*imx6*

