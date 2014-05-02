Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:55673 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbaEBT3g (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 May 2014 15:29:36 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Will Deacon <will.deacon@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [RESEND PATCH 2/3] PCI: ARM: add support for generic PCI host controller
Date: Fri, 02 May 2014 21:29:30 +0200
Message-ID: <12080862.flQZBvPba4@wuerfel>
In-Reply-To: <20140502190318.GE3179@obsidianresearch.com>
References: <1399048876-11862-1-git-send-email-will.deacon@arm.com> <20140502184421.GF14645@arm.com> <20140502190318.GE3179@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 02 May 2014 13:03:18 Jason Gunthorpe wrote:
> 
> > > Setup is called from probe, through pci_common_init_dev(), so that shouldn't
> > > make a difference.
> > 
> > Given that the idea was to separate setup() and probe(), I didn't want to
> > make the assumption that I was called in probe context.
> 
> IMHO, we need to have clear purposes for setup() and probe().
> 
> Probe is well defined already, it requests resources, claims the
> device, puts it in reset and then does some subsystem specific thing.
> The interaction with probe and devm is also already well specified.
> 
> It doesn't matter for this driver, but look at mvebu, you cannot move
> the interrupt, gpio and clock acquisitions from probe() to setup(), as
> they could all trigger a defered probe. Better to be consistent,
> especially if this is the golden reference driver we want everyone to
> follow (sorry Will)

Fair enough. It shouldn't be hard to move.

> To me setup() is more like netdev open(), so it should just do that
> final step to enable the links and bring up the PCI network and be
> ready to run PCI discovery. Consider, someday we might have an
> unsetup() for power mangement reasons, just like we have a close() in
> netdev.

I expect setup() to just go away in the long run for loadable host
controllers, and get merged into probe().

> If the long term plan is to keep probe() then I don't think it makes
> sense to move probe() duties into setup(). That just restricts what we
> can do with the setup() call if setup() is now required to always
> handle defered probe and so forth.

setup() makes sense for the traditional ARM32 PCI support with
nr_controllers > 1: dove, kirkwood, mv78xx0, orion5x and iop13xx
(most of these are gradually getting replace with pci-mvebu.c,
which doesn't do that, as you know). All other classic drivers only
support one host bridge anyway, and the loadable driver just
use one domain per host bridge, which means you lose all the
advantages of having pci_common_init_dev() assign the bus
numbers and call setup functions for each host bridge.

It should be fine to have a trivial setup function like this

static int gen_pci_setup(int nr, struct pci_sys_data *sys)
{
	struct gen_pci *pci = sys->private_data;
	list_splice_init(pci->resource, sys->resources);
	return 1;
}

and do everything in probe().

	Arnd
