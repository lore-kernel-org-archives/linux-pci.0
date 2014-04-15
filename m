Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:62969 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbaDOSaw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Apr 2014 14:30:52 -0400
Received: by mail-ig0-f179.google.com with SMTP id hl10so103593igb.12
        for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2014 11:30:51 -0700 (PDT)
Date: Tue, 15 Apr 2014 12:30:48 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Lucas Stach <l.stach@pengutronix.de>
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
Subject: Re: [PATCH v2 2/6] PCI: tegra: use new OF interrupt mapping when
 possible
Message-ID: <20140415182651.GA17721@google.com>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
 <1394025951-32438-3-git-send-email-l.stach@pengutronix.de>
 <20140404165559.GE9007@google.com>
 <1397556454.4574.13.camel@weser.hi.pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1397556454.4574.13.camel@weser.hi.pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 15, 2014 at 12:07:34PM +0200, Lucas Stach wrote:
> Hi Bjorn,
> 
> Am Freitag, den 04.04.2014, 10:55 -0600 schrieb Bjorn Helgaas:
> > On Wed, Mar 05, 2014 at 02:25:47PM +0100, Lucas Stach wrote:
> > > This is the recommended method of doing the IRQ
> > > mapping. For old devicetrees we fall back to the
> > > previous practice.
> > > 
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Applied with Stephen's Tested-by to my pending/host-tegra branch.  I'll
> > rebase and rename it after v3.15-rc1, and I think we can squeeze it into
> > v3.15 shortly after that.  Thanks.
> > 
> 
> Are you still planning to push this into 3.15, or has this slipped to
> 3.16?

Yes, I'm hoping to put them in v3.15.  I assume these actually
fix something, e.g., we need these changes to boot with new devicetrees, or
something?

The changelogs don't make it clear that these are fixes, and I want to heed
Linus' guidance: "Anyway, because -rc1 is already pretty darn big, I do
*not* want to hear about 'sorry this missed the window, can I still sneak
in'.  Fixes only."

I should have applied these sooner to make the merge window; I apologize
for that.  Anyway, if you outline what these fix, I'll update the
changelogs in my tree.

Bjorn
