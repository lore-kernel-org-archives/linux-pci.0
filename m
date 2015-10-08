Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:61444 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933667AbbJHPLq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2015 11:11:46 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: David Daney <ddaney.cavm@gmail.com>, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v4 4/5] PCI: generic: Correct, and avoid overflow, in bus_max calculation.
Date: Thu, 08 Oct 2015 17:11:32 +0200
Message-ID: <5230007.h2fkbnOlh5@wuerfel>
In-Reply-To: <20151008150243.GC3885@localhost>
References: <1443811443-18878-1-git-send-email-ddaney.cavm@gmail.com> <1443811443-18878-5-git-send-email-ddaney.cavm@gmail.com> <20151008150243.GC3885@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 08 October 2015 10:02:43 Bjorn Helgaas wrote:
> [+cc Arnd]
> 
> And this one?

Not so good.

> > --- a/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> > @@ -34,7 +34,11 @@ Properties of the host controller node:
> >  - #size-cells    : Must be 2.
> >  
> >  - reg            : The Configuration Space base address and size, as accessed
> > -                   from the parent bus.
> > +                   from the parent bus.  The base address corresponds to
> > +                   bus zero, even though the "bus-range" property may specify
> > +                   a different starting bus number.  The driver must only map
> > +                   or access the portion of the Configuration Space that
> > +                   corresponds to the "bus-range"

I thought we had reached an agreement that it is a bad idea to have a 'reg'
property that lists registers belonging to a different device.

	Arnd
