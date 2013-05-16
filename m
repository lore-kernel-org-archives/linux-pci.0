Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38973 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423Ab3EPPHB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2013 11:07:01 -0400
Date: Thu, 16 May 2013 11:06:16 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Mike Turquette <mturquette@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Rob Herring <rob.herring@calxeda.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCHv9 5/9] clk: mvebu: create parent-child relation for
 PCIe clocks on Armada 370
Message-ID: <20130516150616.GD6563@titan.lakedaemon.net>
References: <1368624323-24311-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1368624323-24311-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130515214154.12127.73539@quantum>
 <20130516094417.24b1ca0d@skate>
 <51949830.70306@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51949830.70306@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Mike, Sebastian,

On Thu, May 16, 2013 at 10:26:24AM +0200, Sebastian Hesselbarth wrote:
> On 05/16/2013 09:44 AM, Thomas Petazzoni wrote:
> >Dear Mike Turquette,
> >
> >On Wed, 15 May 2013 14:41:54 -0700, Mike Turquette wrote:
> >>Quoting Thomas Petazzoni (2013-05-15 06:25:19)
> >>>The Armada 370 has two gatable clocks for each PCIe interface, and we
> >>>want both of them to be enabled. We therefore make one of the two
> >>>clocks a child of the other, as we did for the sataX and sataXlnk
> >>>clocks on Armada XP.
> >>
> >>Ack for patches #5 and #6.  Do you want me to take them?

Thanks for the Ack!

> >I don't know, I guess with your Ack, it would be easier to carry them
> >through the Marvell maintainers and then the arm-soc tree, so that we
> >can test arm-soc and have all the pieces needed in here.
> >
> >That said, Sebastian Hesselbarth has submitted a big rework of the
> >mvebu clock drivers, which would conflict with this patch, and
> >Sebastian's rework would most likely go through your tree. If that's
> >the case, I guess it would be better to let you take #5 and #6 in this
> >patch series.
> 
> I also requested to take the restructure patches through ARM tree. They
> are only touching files in drivers/clk/mvebu and by taking them through
> ARM, we can update PCIe clock patches easily. The dependency between
> Thomas' and my patches basically is that I renamed files that Thomas
> now commits to. (I switched clk/mvebu from per-function files to per-soc
> files).

I agree.  My heart jumped into my throat a little there :)  Mike, if
it's ok with you, I'd prefer to take these through arm-soc.  Any merge
conflicts should be minimal.  And at any rate, resolving the conflicts
are *much* easier to handle than having arm-soc depend on an outside
tree (then Linus has to take care in the order he merges them, no
rebasing for clk tree, dogs and cats living together, etc ;-) )

thx,

Jason.
