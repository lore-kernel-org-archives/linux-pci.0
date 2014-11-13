Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:38631 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933512AbaKMReJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Nov 2014 12:34:09 -0500
Received: by mail-pd0-f173.google.com with SMTP id v10so14965869pde.32
        for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2014 09:34:09 -0800 (PST)
Date: Thu, 13 Nov 2014 10:34:04 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Liviu Dudau <Liviu.Dudau@arm.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] PCI: add missing DT binding for linux,pci-domain
 property
Message-ID: <20141113173404.GJ5064@google.com>
References: <1415287400-30426-1-git-send-email-l.stach@pengutronix.de>
 <20141113170921.GG5064@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141113170921.GG5064@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 13, 2014 at 10:09:21AM -0700, Bjorn Helgaas wrote:
> On Thu, Nov 06, 2014 at 04:23:20PM +0100, Lucas Stach wrote:
> > This property was added by 41e5c0f81d3e
> > (of/pci: Add pci_get_new_domain_nr() and of_get_pci_domain_nr())
> > without the required binding documentation. As this property
> > will be supported by a number of host bridge drivers going forward,
> > add it to the common PCI binding doc.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> 
> Applied with acks from Liviu and Rob to for-linus for v3.18, thanks a lot
> for working this out!

Arnd, I just noticed your concern about this being linux-only.  Are you
happy with this one?  If not, I can drop this.

> > ---
> > This is a non-critical fix, but may still qualify for 3.18-rc as
> > the property was added in this release cycle.
> > 
> > v2:
> > - emphasize that the property must be present and unique systemwide
> >   if used
> > ---
> >  Documentation/devicetree/bindings/pci/pci.txt | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> > index 41aeed38926d..68c364e2f5e5 100644
> > --- a/Documentation/devicetree/bindings/pci/pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/pci.txt
> > @@ -7,3 +7,14 @@ And for the interrupt mapping part:
> >  
> >  Open Firmware Recommended Practice: Interrupt Mapping
> >  http://www.openfirmware.org/1275/practice/imap/imap0_9d.pdf
> > +
> > +Additionally to the properties specified in the above standards a host bridge
> > +driver implementation may support the following properties:
> > +
> > +- linux,pci-domain:
> > +   If present this property assigns a fixed PCI domain number to a host bridge,
> > +   otherwise an unstable (across boots) unique number will be assigned.
> > +   It is required to either not set this property at all or set it for all
> > +   host bridges in the system, otherwise potentially conflicting domain numbers
> > +   may be assigned to root buses behind different host bridges. The domain
> > +   number for each host bridge in the system must be unique.
> > -- 
> > 2.1.1
> > 
