Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:46391 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932669AbbFWXPJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Jun 2015 19:15:09 -0400
Message-ID: <1435101283.3996.17.camel@kernel.crashing.org>
Subject: Re: [PATCH] PCI: Only enable IO window if supported
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Guenter Roeck <linux@roeck-us.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Will Deacon <Will.Deacon@arm.com>
Date: Wed, 24 Jun 2015 09:14:43 +1000
In-Reply-To: <CAErSpo6AziA5GXEi6AizW2WP6oLVMd1p57pWunDNBQeVXxp1nw@mail.gmail.com>
References: <1432342336-25832-1-git-send-email-linux@roeck-us.net>
	 <20150527210447.GY32152@google.com> <20150602145510.GE23650@red-moon>
	 <1435099588.3996.14.camel@kernel.crashing.org>
	 <CAErSpo6AziA5GXEi6AizW2WP6oLVMd1p57pWunDNBQeVXxp1nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2015-06-23 at 18:02 -0500, Bjorn Helgaas wrote:
> On Tue, Jun 23, 2015 at 5:46 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Tue, 2015-06-02 at 15:55 +0100, Lorenzo Pieralisi wrote:
> >> While at it, do you think it is reasonable to also claim the bridge
> >> windows (resources) in the respective pci_read_bridge_* calls ?
> >
> > No, don't claim in read. There's a clear distinction between gathering
> > resources and claiming them, and we need to keep that.
> >
> > Some fixups might happen in between the two for example.
> 
> Are there any existing fixups like that?  Concrete examples would help
> figure out the best way forward.

Not off the top of my mind, it's been a long time since I wrote the
resource claiming stuff in arch/powerpc but it does make me nervous. We
collect resources when probing and we claim in the survey, those have
been historically very distinct steps.

> Most arches call pci_read_bridge_bases() from pcibios_fixup_bus().  I
> think that's a poor place to do it because it's code that normally
> doesn't have to be arch-specific.  Resource claiming is also usually
> done from arch code, and it shouldn't be arch-specific either.

Claiming as in putting in the resource tree etc... is different from
actually reading the values from the HW and is traditionally done much
later, no ?

> If we move both the read and claim into generic code, then we might
> need to make sure there's a fixup phase in between or something.

Well, then there's a more general argument to be made as to whether we
want the claiming to be "merged" as part of the probing/reading I
suppose...

Then there's also the case where everything gets fully reassigned, like
powernv, where the "read" phase is really only about sizing device
BARs...

Cheers,
Ben.


