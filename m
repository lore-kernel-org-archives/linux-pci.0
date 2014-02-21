Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:53429 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932083AbaBUPVQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Feb 2014 10:21:16 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	"Longchamp, Valentin" <Valentin.Longchamp@keymile.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Gregory =?ISO-8859-1?Q?Cl=E9ment?=
	<gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: pci-mvebu driver on km_kirkwood
Date: Fri, 21 Feb 2014 16:20:45 +0100
Message-ID: <2344852.BKudsNuPXM@wuerfel>
In-Reply-To: <20140221161108.50a4c932@skate>
References: <53039894.10905@keymile.com> <2193926.ls2teBqnfK@wuerfel> <20140221161108.50a4c932@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 21 February 2014 16:11:08 Thomas Petazzoni wrote:
> On Fri, 21 Feb 2014 16:05:16 +0100, Arnd Bergmann wrote:
> 
> > >  *) I don't know if the algorithm to split the BAR into multiple
> > >     windows is going to be trivial.
> > 
> > The easiest solution would be to special case 'size is between
> > 128MB+1 and 192MB' if that turns out to be the most interesting
> > case. It's easy enough to make the second window smaller than 64MB
> > if we want.
> > 
> > If we want things to be a little fancier, we could use:
> > 
> >       switch (size) {
> >               case (SZ_32M+1) ... (SZ_32M+SZ_16M):
> >                       size2 = size - SZ_32M;
> >                       size -= SZ_32M;
> >                       break;
> >               case (SZ_64M+1) ... (SZ_64M+SZ_32M):
> >                       size2 = size - SZ_64M;
> >                       size -= SZ_64M;
> >                       break;
> >               case (SZ_128M+1) ... (SZ_128M+SZ_64M):
> >                       size2 = size - SZ_128M;
> >                       size -= SZ_128M;
> >                       break;
> >       };
> 
> What if the size of your BAR is 128 MB + 64 MB + 32 MB ? Then you need
> three windows, and your algorithm doesn't work 

I was hoping we could avoid using more than two windows.
With the algorithm above we would round up to 256MB and
fail if that doesn't fit, which is the same thing that
happens when you run out of space.

	Arnd
