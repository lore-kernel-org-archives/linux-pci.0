Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:56379 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753776AbaBLUIR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2014 15:08:17 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: linux-arm-kernel@lists.infradead.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
Date: Wed, 12 Feb 2014 21:07:40 +0100
Message-ID: <1545472.qN7M5OiOyA@wuerfel>
In-Reply-To: <20140212194313.GA17248@obsidianresearch.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com> <2006726.HhIT01YuXY@wuerfel> <20140212194313.GA17248@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 12 February 2014 12:43:13 Jason Gunthorpe wrote:
> On Tue, Feb 11, 2014 at 11:42:52AM +0100, Arnd Bergmann wrote:
> 
> 
> Still missing release_region..
> 
> Thoughts on upstreamining these bits?

Upstreaming them would be great. Patches look correct by inspection as well.

> > Since the mvebu_pcie_setup() function seems very generic at this,
> > we should probably try to factor out that code into a common
> > helper, at least for arm64, but ideally shared with arm32
> > as well.
> 
> Yah, especially since people are not getting it completely right..
> 
> But some of the trouble here is a lack of a generic pci host driver
> structure, eg I have to pull the domain number out of the ARM32
> specific structure ..

I'm sure that Bjorn also has some plans of his own, but I think
we should have a generic host driver structure and gradually move
stuff into it from the architecture specific structs.

Now there is a 'struct pci_host_bridge' that is used on some
architectures already but not on ARM. It also contains a list
of resource windows plus offsets, and there is a set of functions
associated with it:

pci_create_root_bus()
pcibios_root_bridge_prepare()

etc.

Maybe all that's needed is to actually start using those on arm32?

	Arnd
