Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39757 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbaCFJeI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Mar 2014 04:34:08 -0500
Message-ID: <1394098396.4535.1.camel@weser.hi.pengutronix.de>
Subject: Re: [PATCH v2 1/6] ARM: dts: tegra: add PCIe interrupt mapping
 properties
From: Lucas Stach <l.stach@pengutronix.de>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, devicetree@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, kernel@pengutronix.de,
	Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org,
	linux-pci@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>,
	Simon Horman <horms@verge.net.au>,
	Thierry Reding <thierry.reding@gmail.com>,
	Ben Dooks <ben-linux@fluff.org>, linux-tegra@vger.kernel.org,
	Kukjin Kim <kgene.kim@samsung.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Date: Thu, 06 Mar 2014 10:33:16 +0100
In-Reply-To: <53179D5D.4070303@wwwdotorg.org>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
	 <1394025951-32438-2-git-send-email-l.stach@pengutronix.de>
	 <53179D5D.4070303@wwwdotorg.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Mittwoch, den 05.03.2014, 14:55 -0700 schrieb Stephen Warren:
> On 03/05/2014 06:25 AM, Lucas Stach wrote:
> > Those are defined by the common PCI binding.
> 
> It sounds like there's no dependency between pathces 1/6 and 2/6, so I
> should apply 1/6 to the Tegra tree, and Bjorn apply 2/6 to the PCI tree?

Right, that's why I split the patches between driver and DT changes. As
this change should be fully backward compatible to old DTs there
shouldn't be any harm.

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

