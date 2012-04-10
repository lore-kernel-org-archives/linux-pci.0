Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:53448 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758193Ab2DJKnW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2012 06:43:22 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 3/3] arch/tile: tilegx PCI root complex support
Date: Tue, 10 Apr 2012 09:15:49 +0000
Cc: Chris Metcalf <cmetcalf@tilera.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Myron Stowe <myron.stowe@redhat.com>,
	Jiri Kosina <jkosina@suse.cz>, Joe Perches <joe@perches.com>,
	David Howells <dhowells@redhat.com>
References: <201204072316.q37NGv8d019280@farm-0023.internal.tilera.com> <201204072319.q37NJlNp019384@farm-0023.internal.tilera.com> <CAErSpo6_gV1XKJ1jsDSvHo+BEORL_5wLC2YRyVG+OjVNDYbHgw@mail.gmail.com>
In-Reply-To: <CAErSpo6_gV1XKJ1jsDSvHo+BEORL_5wLC2YRyVG+OjVNDYbHgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201204100915.49742.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 10 April 2012, Bjorn Helgaas wrote:
> > +       if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE) {
> > +               /*
> > +                * For bridges, we enable both memory and I/O decoding
> > +                * in call cases.
> > +                */
> > +               cmd |= PCI_COMMAND_IO;
> > +               cmd |= PCI_COMMAND_MEMORY;
> > +       } else {
> > +               /*
> > +                * For endpoints, we enable memory and/or I/O decoding
> > +                * only if they have a memory resource of that type.
> > +                */
> > +               for (i = 0; i < 6; i++) {
> > +                       r = &dev->resource[i];
> > +                       if (r->flags & IORESOURCE_UNSET) {
> > +                               pr_err("PCI: Device %s not available "
> > +                                      "because of resource collisions\n",
> > +                                      pci_name(dev));
> > +                               return -EINVAL;
> > +                       }
> > +                       if (r->flags & IORESOURCE_IO)
> > +                               cmd |= PCI_COMMAND_IO;
> > +                       if (r->flags & IORESOURCE_MEM)
> > +                               cmd |= PCI_COMMAND_MEMORY;
> > +               }
> 
> It would be nice if you could use pci_enable_resources() here, though
> you use IORESOURCE_UNSET here, while pci_enable_resources() does not.
> But you could at least use PCI_NUM_RESOURCES and "mask."  There's
> nothing fundamentally architecture-dependent here, so I'd like to move
> toward a generic implementation.

Note that if tile does not support I/O space as indicated, it should
never enable PCI_COMMAND_IO.

	Arnd

