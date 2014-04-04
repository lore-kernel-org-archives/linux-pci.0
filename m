Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:57045 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651AbaDDRFX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Apr 2014 13:05:23 -0400
Received: by mail-pd0-f169.google.com with SMTP id fp1so3608278pdb.28
        for <linux-pci@vger.kernel.org>; Fri, 04 Apr 2014 10:05:22 -0700 (PDT)
Date: Fri, 4 Apr 2014 11:05:17 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
	Jingoo Han <jg1.han@samsung.com>,
	Simon Horman <horms@verge.net.au>,
	Thierry Reding <thierry.reding@gmail.com>,
	Ben Dooks <ben-linux@fluff.org>, linux-tegra@vger.kernel.org,
	Kukjin Kim <kgene.kim@samsung.com>,
	Shawn Guo <shawn.guo@linaro.org>, kernel@pengutronix.de
Subject: Re: [PATCH v2 6/6] PCI: designware: use new OF interrupt mapping
 when possible
Message-ID: <20140404170517.GH9007@google.com>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
 <1394025951-32438-7-git-send-email-l.stach@pengutronix.de>
 <20140305184219.GA29903@obsidianresearch.com>
 <20140404170341.GG9007@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140404170341.GG9007@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 04, 2014 at 11:03:41AM -0600, Bjorn Helgaas wrote:
> On Wed, Mar 05, 2014 at 11:42:19AM -0700, Jason Gunthorpe wrote:
> > On Wed, Mar 05, 2014 at 02:25:51PM +0100, Lucas Stach wrote:
> > > -	return pp->irq;
> > > +	irq = of_irq_parse_and_map_pci(dev, slot, pin);
> > > +	if (!irq)
> > > +		irq = pp->irq;
> > 
> > In light of the two bugs that Tim found, it might be wise to throw a
> > 'dev_warn(FW_BUG "Missing DT interrupt mapping")' in the fall back
> > path, so it doesn't continue to silently cover up errors on the OF/DT
> > side..
> 
> This sounds like a reasonable thing to do, but I didn't see a response to
> this comment.  Should I merge it as-is, or do you want to add the message?

Oh, and I suppose the same question applies to the other host drivers in
this series (tegra, rcar)?
