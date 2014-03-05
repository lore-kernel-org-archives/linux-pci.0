Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:51987 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752791AbaCESmo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 5 Mar 2014 13:42:44 -0500
Date: Wed, 5 Mar 2014 11:42:19 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
	Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Thierry Reding <thierry.reding@gmail.com>,
	Ben Dooks <ben-linux@fluff.org>, linux-tegra@vger.kernel.org,
	Kukjin Kim <kgene.kim@samsung.com>,
	Shawn Guo <shawn.guo@linaro.org>, kernel@pengutronix.de
Subject: Re: [PATCH v2 6/6] PCI: designware: use new OF interrupt mapping
 when possible
Message-ID: <20140305184219.GA29903@obsidianresearch.com>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
 <1394025951-32438-7-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394025951-32438-7-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 05, 2014 at 02:25:51PM +0100, Lucas Stach wrote:
> -	return pp->irq;
> +	irq = of_irq_parse_and_map_pci(dev, slot, pin);
> +	if (!irq)
> +		irq = pp->irq;

In light of the two bugs that Tim found, it might be wise to throw a
'dev_warn(FW_BUG "Missing DT interrupt mapping")' in the fall back
path, so it doesn't continue to silently cover up errors on the OF/DT
side..

Regards,
Jason
