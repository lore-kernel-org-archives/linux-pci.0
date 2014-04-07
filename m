Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:13114 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790AbaDGJNW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Apr 2014 05:13:22 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Lucas Stach' <l.stach@pengutronix.de>,
	'Bjorn Helgaas' <bhelgaas@google.com>
Cc: 'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	kernel@pengutronix.de, 'Arnd Bergmann' <arnd@arndb.de>,
	'Stephen Warren' <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-tegra@vger.kernel.org, 'Simon Horman' <horms@verge.net.au>,
	'Thierry Reding' <thierry.reding@gmail.com>,
	'Ben Dooks' <ben-linux@fluff.org>,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Shawn Guo' <shawn.guo@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
 <1394025951-32438-7-git-send-email-l.stach@pengutronix.de>
 <20140305184219.GA29903@obsidianresearch.com>
 <20140404170341.GG9007@google.com> <20140404170517.GH9007@google.com>
 <1396859929.4553.2.camel@weser.hi.pengutronix.de>
In-reply-to: <1396859929.4553.2.camel@weser.hi.pengutronix.de>
Subject: Re: [PATCH v2 6/6] PCI: designware: use new OF interrupt mapping when
 possible
Date: Mon, 07 Apr 2014 18:13:20 +0900
Message-id: <002601cf5241$9e819cc0$db84d640$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, April 07, 2014 5:39 PM, Lucas Stach wrote:
> Am Freitag, den 04.04.2014, 11:05 -0600 schrieb Bjorn Helgaas:
> > On Fri, Apr 04, 2014 at 11:03:41AM -0600, Bjorn Helgaas wrote:
> > > On Wed, Mar 05, 2014 at 11:42:19AM -0700, Jason Gunthorpe wrote:
> > > > On Wed, Mar 05, 2014 at 02:25:51PM +0100, Lucas Stach wrote:
> > > > > -	return pp->irq;
> > > > > +	irq = of_irq_parse_and_map_pci(dev, slot, pin);
> > > > > +	if (!irq)
> > > > > +		irq = pp->irq;
> > > >
> > > > In light of the two bugs that Tim found, it might be wise to throw a
> > > > 'dev_warn(FW_BUG "Missing DT interrupt mapping")' in the fall back
> > > > path, so it doesn't continue to silently cover up errors on the OF/DT
> > > > side..
> > >
> > > This sounds like a reasonable thing to do, but I didn't see a response to
> > > this comment.  Should I merge it as-is, or do you want to add the message?
> >
> > Oh, and I suppose the same question applies to the other host drivers in
> > this series (tegra, rcar)?
> 
> Please apply as-is. of_irq_parse_and_map_pci() already prints an error
> message if it isn't able to establish the mapping, thus right before we
> fall into the fallback path. So any the warning would be redundant.

+1

I agree with Lucas Stach's opinion. of_irq_parse_and_map_pci() already
prints an error as below. So, additional warning message of host controller
looks superfluous.

	ret = of_irq_parse_pci(dev, &oirq);
	if (ret) {
		dev_err(&dev->dev, "of_irq_parse_pci() failed with rc=%d\n", ret);
		return 0; /* Proper return code 0 == NO_IRQ */


Best regards,
Jingoo Han

