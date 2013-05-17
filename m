Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:36070 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750Ab3EQHIb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 May 2013 03:08:31 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc8so3038639pbc.32
        for <linux-pci@vger.kernel.org>; Fri, 17 May 2013 00:08:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <20130516150616.GD6563@titan.lakedaemon.net>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
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
References: <1368624323-24311-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1368624323-24311-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130515214154.12127.73539@quantum> <20130516094417.24b1ca0d@skate>
 <51949830.70306@gmail.com> <20130516150616.GD6563@titan.lakedaemon.net>
Message-ID: <20130517070826.12127.41382@quantum>
Subject: Re: [PATCHv9 5/9] clk: mvebu: create parent-child relation for PCIe clocks
 on Armada 370
Date: Fri, 17 May 2013 00:08:26 -0700
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Quoting Jason Cooper (2013-05-16 08:06:16)
> Mike, Sebastian,
> 
> On Thu, May 16, 2013 at 10:26:24AM +0200, Sebastian Hesselbarth wrote:
> > On 05/16/2013 09:44 AM, Thomas Petazzoni wrote:
> > >Dear Mike Turquette,
> > >
> > >On Wed, 15 May 2013 14:41:54 -0700, Mike Turquette wrote:
> > >>Quoting Thomas Petazzoni (2013-05-15 06:25:19)
> > >>>The Armada 370 has two gatable clocks for each PCIe interface, and we
> > >>>want both of them to be enabled. We therefore make one of the two
> > >>>clocks a child of the other, as we did for the sataX and sataXlnk
> > >>>clocks on Armada XP.
> > >>
> > >>Ack for patches #5 and #6.  Do you want me to take them?
> 
> Thanks for the Ack!
> 
> > >I don't know, I guess with your Ack, it would be easier to carry them
> > >through the Marvell maintainers and then the arm-soc tree, so that we
> > >can test arm-soc and have all the pieces needed in here.
> > >
> > >That said, Sebastian Hesselbarth has submitted a big rework of the
> > >mvebu clock drivers, which would conflict with this patch, and
> > >Sebastian's rework would most likely go through your tree. If that's
> > >the case, I guess it would be better to let you take #5 and #6 in this
> > >patch series.
> > 
> > I also requested to take the restructure patches through ARM tree. They
> > are only touching files in drivers/clk/mvebu and by taking them through
> > ARM, we can update PCIe clock patches easily. The dependency between
> > Thomas' and my patches basically is that I renamed files that Thomas
> > now commits to. (I switched clk/mvebu from per-function files to per-soc
> > files).
> 
> I agree.  My heart jumped into my throat a little there :)  Mike, if
> it's ok with you, I'd prefer to take these through arm-soc.  Any merge
> conflicts should be minimal.  And at any rate, resolving the conflicts
> are *much* easier to handle than having arm-soc depend on an outside
> tree (then Linus has to take care in the order he merges them, no
> rebasing for clk tree, dogs and cats living together, etc ;-) )
> 

Yeah that all sounds good to me.  I'll review the restructure patches
shortly.

Regards,
Mike

> thx,
> 
> Jason.
