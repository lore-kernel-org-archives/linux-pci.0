Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52797 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbaCFRkE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Mar 2014 12:40:04 -0500
Message-ID: <1394127555.4582.1.camel@weser.hi.pengutronix.de>
Subject: Re: [PATCH v2 2/6] PCI: tegra: use new OF interrupt mapping when
 possible
From: Lucas Stach <l.stach@pengutronix.de>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Shawn Guo <shawn.guo@linaro.org>,
	Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, kernel@pengutronix.de
Date: Thu, 06 Mar 2014 18:39:15 +0100
In-Reply-To: <5318B232.2020507@wwwdotorg.org>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
	 <1394025951-32438-3-git-send-email-l.stach@pengutronix.de>
	 <5318B232.2020507@wwwdotorg.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Donnerstag, den 06.03.2014, 10:36 -0700 schrieb Stephen Warren:
> On 03/05/2014 06:25 AM, Lucas Stach wrote:
> > This is the recommended method of doing the IRQ
> > mapping. For old devicetrees we fall back to the
> > previous practice.
> 
> Tested-by: Stephen Warren <swarren@nvidia.com>
> 
> I tested both with and without patch 1/6, and the PCIe-based NIC on
> Beaver worked fine either way. Without patch 1/6, I do see:
> 
> pci 0000:00:01.0: of_irq_parse_pci() failed with rc=-22
> 
> ... but that seems reasonable given that the DT that of_irq_parse_pci()
> parses is missing, and did correctly trigger the fallback path, so
> everything still worked.

Yes, this should be normal. It spits this error for old DTs, but keeps
doing the right thing. I'm not sure if we should downgrade this to info
or dbg.

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

