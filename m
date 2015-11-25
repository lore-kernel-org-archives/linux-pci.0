Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:59182 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbbKYTxa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2015 14:53:30 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	David Daney <ddaney.cavm@gmail.com>,
	David Daney <david.daney@cavium.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org,
	"Sean O. Stalley" <sean.stalley@intel.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH] PCI/pci-host-generic: Add support for Cavium Thunder fixed BARs.
Date: Wed, 25 Nov 2015 20:52:48 +0100
Message-ID: <2789794.TBZL2yW2b6@wuerfel>
In-Reply-To: <20151125170652.GC1380@localhost>
References: <1443488184-12633-1-git-send-email-ddaney.cavm@gmail.com> <20151125170652.GC1380@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 25 November 2015 11:06:52 Bjorn Helgaas wrote:
> 
> On Mon, Sep 28, 2015 at 05:56:24PM -0700, David Daney wrote:
> > From: David Daney <david.daney@cavium.com>
> > 
> > Early versions of the Cavium Thunder CN88XX processor are missing
> > Enhanced Allocation (EA) capabilities for the fixed BAR addresses used
> > by the on-SoC hardware blocks.
> > 
> > Add config access functions that synthesize the missing EA
> > capabilities for versions that are missing that information.  Since
> > this is a little hacky, gate the inclusion of the code with a new
> > Kconfig variable.
> > 
> > Signed-off-by: David Daney <david.daney@cavium.com>
> 
> What about this one?  Do we still need it?  This version looks like it
> still has some debug code and it feels like a lot of hard-coding of
> config offsets; it'd be nice if it could be more table-driven.  But
> maybe this isn't needed anymore anyway.

I still think it doesn't belong into the generic driver. We have the
abstraction for drivers based on the compatible string to handle
nonstandard PCI host bridges, and the generic driver should really
just handle the generic code.

It's easy enough to split out the common parts if we want to reuse
some of this, or to move them into drivers/pci/*.c for others to
reuse too.

	Arnd
