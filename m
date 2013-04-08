Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:51195 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936173Ab3DHVbl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Apr 2013 17:31:41 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCHv7 08/17] pci: PCIe driver for Marvell Armada 370/XP systems
Date: Mon, 8 Apr 2013 23:31:30 +0200
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm" <linux-arm-kernel@lists.infradead.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
References: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com> <1364395234-11195-9-git-send-email-thomas.petazzoni@free-electrons.com> <CAErSpo7fGPe3wFha36kNMxeRP4gBpBWgfw85aTLey-DSz2ZYew@mail.gmail.com>
In-Reply-To: <CAErSpo7fGPe3wFha36kNMxeRP4gBpBWgfw85aTLey-DSz2ZYew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201304082331.30809.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 08 April 2013, Bjorn Helgaas wrote:
> On Wed, Mar 27, 2013 at 8:40 AM, Thomas Petazzoni
> 
> > diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> > new file mode 100644
> > index 0000000..3ad563f
> > --- /dev/null
> > +++ b/drivers/pci/host/Makefile
> > @@ -0,0 +1,4 @@
> > +obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
> > +CFLAGS_pci-mvebu.o += \
> > +       -I$(srctree)/arch/arm/plat-orion/include \
> > +       -I$(srctree)/arch/arm/mach-mvebu/include
> 
> Too bad to have to adjust CFLAGS here.  Seems like I remember earlier
> discussion, but I didn't pay much attention, and if this is the best
> we can do, I guess it's OK.

I'm pretty sure I NAK'ed this part. I'm surprised it's still there.


	Arnd
