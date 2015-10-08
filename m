Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:54647 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933786AbbJHPS2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2015 11:18:28 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	David Daney <david.daney@cavium.com>,
	Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	David Daney <ddaney.cavm@gmail.com>,
	Kumar Gala <galak@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4 4/5] PCI: generic: Correct, and avoid overflow, in bus_max calculation.
Date: Thu, 08 Oct 2015 17:18:15 +0200
Message-ID: <5178627.ufUfdomGdT@wuerfel>
In-Reply-To: <5230007.h2fkbnOlh5@wuerfel>
References: <1443811443-18878-1-git-send-email-ddaney.cavm@gmail.com> <20151008150243.GC3885@localhost> <5230007.h2fkbnOlh5@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 08 October 2015 17:11:32 Arnd Bergmann wrote:
> > > --- a/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> > > +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> > > @@ -34,7 +34,11 @@ Properties of the host controller node:
> > >  - #size-cells    : Must be 2.
> > >  
> > >  - reg            : The Configuration Space base address and size, as accessed
> > > -                   from the parent bus.
> > > +                   from the parent bus.  The base address corresponds to
> > > +                   bus zero, even though the "bus-range" property may specify
> > > +                   a different starting bus number.  The driver must only map
> > > +                   or access the portion of the Configuration Space that
> > > +                   corresponds to the "bus-range"
> 
> I thought we had reached an agreement that it is a bad idea to have a 'reg'
> property that lists registers belonging to a different device.
> 
> 

To further clarify: the argument was to make it mirror what ACPI does for
PCI. However, this is unlike what all other devices do with DT, where you
have non-overlapping register ranges (start, length) for each device.
ACPI as far as I understand it does not give a range for a PCIe host, but
instead provides a way to get the start address of the ECAM register area
for the domain that the host is part of, and that needs to be the same
address for each host in the domain.

	Arnd
