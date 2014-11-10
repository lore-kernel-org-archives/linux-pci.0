Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35701 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbaKJO6n (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Nov 2014 09:58:43 -0500
Message-ID: <1415631509.20340.5.camel@pengutronix.de>
Subject: Re: [PATCH v2] PCI: add missing DT binding for linux,pci-domain
 property
From: Lucas Stach <l.stach@pengutronix.de>
To: Rob Herring <robherring2@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Arnd Bergmann <arnd@arndb.de>
Date: Mon, 10 Nov 2014 15:58:29 +0100
In-Reply-To: <CAL_JsqKfV3aPuYxK2E8tS1fDjhpJFknqv1nHP+9NYHAfs_owYg@mail.gmail.com>
References: <1415287400-30426-1-git-send-email-l.stach@pengutronix.de>
	 <CAL_JsqKfV3aPuYxK2E8tS1fDjhpJFknqv1nHP+9NYHAfs_owYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Donnerstag, den 06.11.2014, 13:49 -0600 schrieb Rob Herring:
> On Thu, Nov 6, 2014 at 9:23 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> > This property was added by 41e5c0f81d3e
> > (of/pci: Add pci_get_new_domain_nr() and of_get_pci_domain_nr())
> > without the required binding documentation. As this property
> > will be supported by a number of host bridge drivers going forward,
> > add it to the common PCI binding doc.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> > This is a non-critical fix, but may still qualify for 3.18-rc as
> > the property was added in this release cycle.
> 
> Agreed.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 

So how should we proceed here? Are you going to pick it up or should
Bjorn route this through the PCI tree?

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

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

