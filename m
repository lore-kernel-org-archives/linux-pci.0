Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:43092 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbaKFPa5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Nov 2014 10:30:57 -0500
Date: Thu, 6 Nov 2014 15:30:51 +0000
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Rob Herring <robherring2@gmail.com>
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
Message-ID: <20141106153051.GU8916@e106497-lin.cambridge.arm.com>
References: <1415101660-26450-1-git-send-email-l.stach@pengutronix.de>
 <20141105231743.GI6168@google.com>
 <20141106100518.GI8916@e106497-lin.cambridge.arm.com>
 <CAL_JsqK-g2qW12jatyZBLeBEtpr80o=WWZVet5+OgMtzAAXHJQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqK-g2qW12jatyZBLeBEtpr80o=WWZVet5+OgMtzAAXHJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 06, 2014 at 02:57:35PM +0000, Rob Herring wrote:
> On Thu, Nov 6, 2014 at 4:05 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> > On Wed, Nov 05, 2014 at 11:17:43PM +0000, Bjorn Helgaas wrote:
> >> On Tue, Nov 04, 2014 at 12:47:40PM +0100, Lucas Stach wrote:
> >> > This property was added by 41e5c0f81d3e
> >> > (of/pci: Add pci_get_new_domain_nr() and of_get_pci_domain_nr())
> >> > without the required binding documentation. As this property
> >> > will be supported by a number of host bridge drivers going forward,
> >> > add it to the common PCI binding doc.
> >> >
> >> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> >>
> >> I merged 41e5c0f81d3e through my tree, and I could merge something like
> >> this if a consensus develops with some acks.  But I'll just let you guys
> >> handle it unless you poke me again.
> >
> > While I think the "linux,pci-domain" property *must* be documented, I
> > would like to get a consensus first on the usage. If we agree that
> > the property is mandatory to all host bridge drivers that use OF then
> > we need to patch existing drivers (partially done through Lorenzo's
> > patches, but other arches are ignoring it). If we say all *new* drivers
> > need to use it then we also need to come up with a strategy on how to
> > deal with old vs new school drivers.
> >
> > My preferred approach is the 3rd way: "linux,pci-domain" becomes part of
> > the core PCI infrastructure (and we find the common ground with ACPI).
> > That way the host bridge drivers don't have to do anything, but the DT
> > creators have to specify a value.
> 
> I'm okay with it being in the core. It was the mixture of using the
> property and automatic numbering that I had issues with. Any mixture
> whether in DT or in drivers should be an error. Also, I think having a
> mixture of root bus host drivers would be rare, so I'm not too
> concerned about some drivers supporting the property and others not.
> In any case, these issues are all with the kernel and not really the
> concern for the binding. For the binding, simply all hosts set the
> domain or none of them do.

Repeating what you've said to verify my understanding: you are OK with
the "linux,pci-domain" being handled in the PCI framework and mandatory
to all OF-based host bridges and architectures. Failure to include
the property should be an error and no host bridge driver should default
to the auto-generation of domain numbers.

Is that correct?

Thanks,
Liviu

> 
> Rob
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

