Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:54102 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752843AbaBLWYU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 12 Feb 2014 17:24:20 -0500
Date: Wed, 12 Feb 2014 15:24:14 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
Message-ID: <20140212222414.GB17248@obsidianresearch.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
 <201402092130.25615.arnd@arndb.de>
 <20140210173450.GA5554@obsidianresearch.com>
 <2006726.HhIT01YuXY@wuerfel>
 <20140212194313.GA17248@obsidianresearch.com>
 <20140212221526.60fd7f8b@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140212221526.60fd7f8b@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 12, 2014 at 10:15:26PM +0100, Thomas Petazzoni wrote:

> > +#ifdef CONFIG_PCI_DOMAINS
> > +       domain = sys->domain;
> > +#endif
> > +
> > +       snprintf(pcie->mem_name, sizeof(pcie->mem_name), "PCI MEM %04x", domain);
> > +       pcie->mem.name = pcie->mem_name;
> > +
> > +       snprintf(pcie->io_name, sizeof(pcie->io_name), "PCI I/O %04x", domain);
> > +       pcie->realio.name = pcie->io_name;
> 
> I honestly don't know what PCI domains are, but this change looks
> fairly harmless to me. I would however use kasprintf() instead maybe. I
> can submit patches for those two changes if you want.

For this purpose imagine that each PCI host controller driver gets a
unique domain, and every domain has a unique
aperture. domain:bus:device:function is the full unique path to a PCI
device.

So when you look at the resource hierarchy it makes some logical
sense:

e0000000-efffffff : PCI MEM 0000
  e0000000-e00fffff : PCI Bus 0000:01
    e0000000-e001ffff : 0000:01:00.0

PCI Domain -> domain + subordinate bus # -> domain:bus:device:function, bar #

The ARM PCI BIOS code used bus number, and Will's version ended up
using the DT path to the PCI node. Would be nice to see an
agreement/common code :)
 
> > Still missing release_region..
> 
> To match which request_region?

Ah, sorry, Arnd added one:

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 13478ec..b55e9a6 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -680,9 +680,17 @@ static int mvebu_pcie_setup(int nr, struct pci_sys_data *sys)
        struct mvebu_pcie *pcie = sys_to_pcie(sys);
        int i;

-       if (resource_size(&pcie->realio) != 0)
+       if (request_resource(&iomem_resource, &pcie->mem))
+               return 0;
+
+       if (resource_size(&pcie->realio) != 0) {
+               if (request_resource(&ioport_resource, &pcie->realio)) {
+                       release_resource(&pcie->mem);
+                       return 0;
+               }
                pci_add_resource_offset(&sys->resources, &pcie->realio,
                                        sys->io_offset);
+       }
        pci_add_resource_offset(&sys->resources, &pcie->mem, sys->mem_offset);
        pci_add_resource(&sys->resources, &pcie->busn);


Which is why I didn't use kasprintf, that would complicate freeing
further.

Ideally we'd be able to use a devm_request_region someday.

Jason
