Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:44855 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752Ab3BOQof (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 Feb 2013 11:44:35 -0500
Date: Fri, 15 Feb 2013 09:44:26 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Message-ID: <20130215164426.GA15819@obsidianresearch.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo6_6bYjo5XX5tzoBfMu5Htgpa__foNCyoCnCNEHocx67Q@mail.gmail.com>
 <20130215060635.43f06f71@skate>
 <CAErSpo6KPzXj6cN95YuTZGhq+RLp4vDLddbpz=RDtRBvy_Rujg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo6KPzXj6cN95YuTZGhq+RLp4vDLddbpz=RDtRBvy_Rujg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 15, 2013 at 09:26:09AM -0700, Bjorn Helgaas wrote:
> On Thu, Feb 14, 2013 at 10:06 PM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> 
> >> > +       case PCI_PREF_LIMIT_UPPER32:
> >> > +               bridge->preflimitupper = value;
> >> > +               break;
> >>
> >> You're relying on a subsequent PCI_COMMAND write to set PCI_COMMAND_IO
> >> and/or PCI_COMMAND_MEMORY, and you program the bridge windows at that
> >> time.
> >
> > Correct.
> >
> >>  It might be a good idea if the PCI core did clear those bits
> >> while updating the windows, but I'm not sure we do.  In any case,
> >> delaying the update is a difference from a standard P2P bridge that
> >> could cause issues later.
> >
> > When would you want the window assignment to occur? Directly when the
> > registers containing the base/limit are being written to? There are
> > multiple registers for base/limit, so I'll have to figure out a way to
> > validate when the base/limit informations are valid.
> 
> For a standard bridge, the window change occurs immediately upon
> writing the base/limit, so that would be the best time.

The standard says a window where limit <= base is invalid/disabled.

So the write mechanism from the PCI core should be

base = 0xFFFFFFFF
limit = true value
base = true value

In the driver the window should be synchronized after any base/limit
update where base < limit. The initial values (ignoring fixed bits)
should be

base = 0xFFFFFFFF
limit = 0

It would be optimal to use the resource framework to ensure the region
is available, but that is something for the mbus driver to take care
of, not PCI-E...

> drivers for A and B.  But I think it is possible to do some updates
> safely even with the window decoding enabled, without any effect on A
> and B, and these are the ones that would cause trouble with your
> current scheme.

A resize update should just write the true values in any order, the
bridge window will expand without interrupting existing traffic.

However the core code must ensure that at no time do two bridges
decode the same window. That could crash the machine..

Jason
