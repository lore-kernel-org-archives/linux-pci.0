Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:42219 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204Ab2FVQUH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 12:20:07 -0400
Message-ID: <4FE49B30.8040806@wwwdotorg.org>
Date: Fri, 22 Jun 2012 10:20:00 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: Mitch Bradley <wmb@firmworks.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
References: <4FD849CF.4030009@firmworks.com> <20120613081910.GB6528@avionic-0098.mockup.avionic-design.de> <4FD85127.8050301@firmworks.com> <20120614091905.GA9081@avionic-0098.mockup.avionic-design.de> <4FDA2DDA.1030704@wwwdotorg.org> <20120614192903.GA2212@avionic-0098.mockup.avionic-design.de> <4FDA40A0.4030206@wwwdotorg.org> <20120615061236.GA4081@avionic-0098.mockup.avionic-design.de> <20120619133001.GB24138@avionic-0098.mockup.avionic-design.de> <4FE0EFBB.6090206@firmworks.com> <20120621064722.GA1122@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20120621064722.GA1122@avionic-0098.mockup.avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/21/2012 12:47 AM, Thierry Reding wrote:
...
> Everybody seems to be happy with this approach, so I'll give it a
> shot. There is one thing I'm still unsure about, though. What if
> somebody uses the above scheme and maps the registers to the wrong
> port. The same goes for the nvidia,ctrl-offset property. It needs
> to match the register offset because they are directly related. I
> suppose we could leave that property away and look up the register
> via the port index (which, as Stephen already said, we'll have to
> do in other places anyway, unless we list all bit positions in the
> DT).
> 
> Can we safely ignore such issues and assume the device tree to
> always be right? Should we just not care if somebody uses it
> wrongly?

I think that's pretty much the same thing as plain putting the wrong
reg property into any node - the value is wrong, so it doesn't work.
There's not too much you can do about it.

I'd be happy to remove the nvidia,ctrl-offset property to avoid the
need to specify basically the same information multiple times though;
nothing wrong with making it easier to write the correct DT content.
