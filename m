Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37895 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbaDOKIk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Apr 2014 06:08:40 -0400
Message-ID: <1397556454.4574.13.camel@weser.hi.pengutronix.de>
Subject: Re: [PATCH v2 2/6] PCI: tegra: use new OF interrupt mapping when
 possible
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	Jingoo Han <jg1.han@samsung.com>,
	Simon Horman <horms@verge.net.au>,
	Shawn Guo <shawn.guo@linaro.org>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, kernel@pengutronix.de
Date: Tue, 15 Apr 2014 12:07:34 +0200
In-Reply-To: <20140404165559.GE9007@google.com>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
	 <1394025951-32438-3-git-send-email-l.stach@pengutronix.de>
	 <20140404165559.GE9007@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Am Freitag, den 04.04.2014, 10:55 -0600 schrieb Bjorn Helgaas:
> On Wed, Mar 05, 2014 at 02:25:47PM +0100, Lucas Stach wrote:
> > This is the recommended method of doing the IRQ
> > mapping. For old devicetrees we fall back to the
> > previous practice.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Applied with Stephen's Tested-by to my pending/host-tegra branch.  I'll
> rebase and rename it after v3.15-rc1, and I think we can squeeze it into
> v3.15 shortly after that.  Thanks.
> 

Are you still planning to push this into 3.15, or has this slipped to
3.16?

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

