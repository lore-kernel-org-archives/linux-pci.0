Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:11479 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab3LLJMV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Dec 2013 04:12:21 -0500
From: Jingoo Han <jg1.han@samsung.com>
To: 'Gregory CLEMENT' <gregory.clement@free-electrons.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: 'Kuninori Morimoto' <kuninori.morimoto.gx@renesas.com>,
	linux-samsung-soc@vger.kernel.org,
	'Wei Yongjun' <weiyj.lk@gmail.com>,
	'Jason Cooper' <jason@lakedaemon.net>,
	'Simon Horman' <horms@verge.net.au>, linux-sh@vger.kernel.org,
	'Magnus Damm' <magnus.damm@gmail.com>,
	linux-kernel@vger.kernel.org,
	'Valentine Barshak' <valentine.barshak@cogentembedded.com>,
	'Wei Yongjun' <yongjun_wei@trendmicro.com.cn>,
	'Thierry Reding' <thierry.reding@gmail.com>,
	linux-tegra@vger.kernel.org, 'Shawn Guo' <shawn.guo@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <20131211183237.GI4699@google.com>
 <52A96877.90902@free-electrons.com>
In-reply-to: <52A96877.90902@free-electrons.com>
Subject: Re: [PATCH] MAINTAINERS: Add DesignWare, i.MX6, Armada,
 R-Car PCI host maintainers
Date: Thu, 12 Dec 2013 18:12:18 +0900
Message-id: <001901cef71a$41f3a520$c5daef60$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, December 12, 2013 4:41 PM, Gregory CLEMENT wrote:
> On 11/12/2013 19:32, Bjorn Helgaas wrote:
> > If this looks reasonable, I'll merge it via the PCI tree for v3.13.
> >
> > Bjorn

[.....]

> > +PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
> > +M:	Jason Cooper <jason@lakedaemon.net>
> > +L:	linux-pci@vger.kernel.org
> > +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > +S:	Maintained
> > +F:	drivers/pci/host/*mvebu*
> 
> I think that Thomas Petazzoni would be more appropriate, he worked
> on the mvebu PCIe since 6 moths and now know very well the
> subject. Until now all the mvebu PCIe related questions were
> managed by Thomas.

I think so, too. :-)

Thomas Petazzoni is the author of the  mvebu PCIe. Also, he did
The basic foundation of PCIe Host with Thierry Reding.  I think
That he is the best person for the Maintainer of the mvebu PCIe.

Best regards,
Jingoo Han

