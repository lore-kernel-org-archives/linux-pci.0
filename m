Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:50699 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755032AbaCMS0g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 13 Mar 2014 14:26:36 -0400
Date: Thu, 13 Mar 2014 12:25:54 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Tim Harvey <tharvey@gateworks.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jingoo Han <jg1.han@samsung.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Thierry Reding <thierry.reding@gmail.com>,
	Ben Dooks <ben-linux@fluff.org>,
	linux-tegra <linux-tegra@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH 1/2] ARM: DT: fix gic interrupt controller documentation
Message-ID: <20140313182554.GA15990@obsidianresearch.com>
References: <1394732405-2260-1-git-send-email-tharvey@gateworks.com>
 <1394732405-2260-2-git-send-email-tharvey@gateworks.com>
 <5321EE81.1030207@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5321EE81.1030207@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 13, 2014 at 11:44:33AM -0600, Stephen Warren wrote:
> On 03/13/2014 11:40 AM, Tim Harvey wrote:
> > When using interrupt-maps, the size of a map entry is #address-cells +
> >  #interrupt-cells for the parent interrupt controller.  For the ARM GIC
> > address-cells should be 0 as this is not used.
> > 
> > This patch fixes the example by correctly specifying #address-cells = 0.
> 
> If the #address-cells property is required (well, or even optional...)
> in the node, shouldn't it be included in the list of required/optional
> properties above, and not solely included in the example?

AFAIK, #address-cells = 0 is the same as not including a
#address-cells at all.

Omitting entirely is what other interrupt-controller bindings are
doing, so I'd just drop mention of #address-cells completely.

Jason
