Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729990AbeHNQqC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Aug 2018 12:46:02 -0400
Date: Tue, 14 Aug 2018 08:58:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        linux-pci@vger.kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: Re: sb_edac.c lacks PCI domain support?
Message-ID: <20180814135843.GA149076@bhelgaas-glaptop.roam.corp.google.com>
References: <20180808200747.GA219159@bhelgaas-glaptop.roam.corp.google.com>
 <3908561D78D1C84285E8C5FCA982C28F7D3A370D@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7D3A370D@ORSMSX110.amr.corp.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Mizuma-san, linux-pci]

On Wed, Aug 08, 2018 at 08:18:03PM +0000, Luck, Tony wrote:
> > I think sb_edac.c (and probably other EDAC stuff) lacks PCI domain
> > support
> 
> There's a patch queued to fix this.
> 
>   https://marc.info/?l=linux-edac&m=153256485215534&w=2

That's excellent, thank you!

i7core_edac.c also looks suspicious because it manages things based on
"socket", which is computed from a PCI bus number, and doesn't
reference the PCI domain at all:

  bus = pdev->bus->number;
  socket = last_bus - bus;
  alloc_i7core_dev(socket, ...);

> > It looks like 88ae80aa609c ("EDAC, skx_edac: Handle systems with
> > segmented PCI busses") fixes a similar problem; maybe that should
> > be applied elsewhere in EDAC as well?
> >
> > Why doesn't EDAC use the standard pci_register_driver() interface?
> > That would avoid issues like this.  It would also avoid the potential
> > conflict of another driver operating on the device at the same time.
> 
> EDAC drivers get information to translate system physical addresses
> to DIMM addresses from a whole bundle of different PCIe devices config
> space.  Connections between different parts of the translation algorithm
> depend on finding the devices that belong to the same memory controller
> by matching up bus numbers (actually <segment,busnumber> tuples as
> we are now finding).
> 
> Can pci_register_driver() cope with this odd usage?

pci_register_driver() can bind a driver to as many devices as desired.
It would be up to the driver to keep track of all its devices and
match them up by <segment,busnumber>.  But I think the drivers keep
track of all that already.

The biggest problem would probably be the fact that it couldn't depend
on being bound to devices in any given order.  It might have to check
to see whether it has found all the devices it expects, or maybe
become a little resilient to having errors reported when it doesn't
have all the information it needs to decode them.

Bjorn
