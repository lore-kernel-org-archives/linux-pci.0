Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:59707 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbaKFLmr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Nov 2014 06:42:47 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: add missing DT binding for linux,pci-domain property
Date: Thu, 06 Nov 2014 12:42:41 +0100
Message-ID: <3491668.yjzKoIEZd4@wuerfel>
In-Reply-To: <20141106100518.GI8916@e106497-lin.cambridge.arm.com>
References: <1415101660-26450-1-git-send-email-l.stach@pengutronix.de> <20141105231743.GI6168@google.com> <20141106100518.GI8916@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 06 November 2014 10:05:18 Liviu Dudau wrote:
> On Wed, Nov 05, 2014 at 11:17:43PM +0000, Bjorn Helgaas wrote:
> > On Tue, Nov 04, 2014 at 12:47:40PM +0100, Lucas Stach wrote:
> > > This property was added by 41e5c0f81d3e
> > > (of/pci: Add pci_get_new_domain_nr() and of_get_pci_domain_nr())
> > > without the required binding documentation. As this property
> > > will be supported by a number of host bridge drivers going forward,
> > > add it to the common PCI binding doc.
> > > 
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > 
> > I merged 41e5c0f81d3e through my tree, and I could merge something like
> > this if a consensus develops with some acks.  But I'll just let you guys
> > handle it unless you poke me again.
> 
> While I think the "linux,pci-domain" property *must* be documented, I
> would like to get a consensus first on the usage. If we agree that
> the property is mandatory to all host bridge drivers that use OF then
> we need to patch existing drivers (partially done through Lorenzo's
> patches, but other arches are ignoring it). If we say all *new* drivers
> need to use it then we also need to come up with a strategy on how to
> deal with old vs new school drivers.
> 
> My preferred approach is the 3rd way: "linux,pci-domain" becomes part of
> the core PCI infrastructure (and we find the common ground with ACPI).
> That way the host bridge drivers don't have to do anything, but the DT
> creators have to specify a value.
> 
> Pinging Rob to try to get a peek on this thoughts.

Parsing "linux,pci-domain" from the PCI core code seems like the best
solution to me, but we still have to support dtbs that don't contain
it. Lorenzo's patch gets this right I think.

ACPI is easy here, because it already requires the domain to be
explicit.

	Arnd
