Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:55779 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbaGIGsC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jul 2014 02:48:02 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v8 8/9] pci: Add support for creating a generic host_bridge from device tree
Date: Wed, 9 Jul 2014 08:47:40 +0200
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci" <linux-pci@vger.kernel.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linaro-kernel" <linaro-kernel@lists.linaro.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Sinan Kaya <okaya@codeaurora.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Suravee Suthikulanit <suravee.suthikulpanit@amd.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Device Tree ML <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>
References: <1404240214-9804-1-git-send-email-Liviu.Dudau@arm.com> <20140708223737.GA19512@google.com> <20140708225755.GE4980@e106497-lin.cambridge.arm.com>
In-Reply-To: <20140708225755.GE4980@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201407090847.41303.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 09 July 2014, Liviu Dudau wrote:
> On Tue, Jul 08, 2014 at 11:37:37PM +0100, Bjorn Helgaas wrote:
> > On Tue, Jul 08, 2014 at 11:27:38PM +0100, Liviu Dudau wrote:
> > > > > > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > > > > > index 7e7b939..556dc5f 100644
> > > > > > > --- a/include/linux/pci.h
> > > > > > > +++ b/include/linux/pci.h
> > > > > > > @@ -402,6 +402,7 @@ struct pci_host_bridge {
> > > > > > >       struct device dev;
> > > > > > >       struct pci_bus *bus;            /* root bus */
> > > > > > >       int domain_nr;
> > > > > > > +     resource_size_t io_base;        /* physical address for the start of I/O area */
> > > > > > 
> > > > > > I don't see where this is used yet.
> > > > > 
> > > > > It's used in pci_host_bridge_of_get_ranges() (earlier in this patch).
> > > > 
> > > > of_create_pci_host_bridge() fills in bridge->io_base, but I don't see
> > > > anything that ever reads bridge->io_base.
> > > 
> > > Ah, understood. It is used by the host bridge drivers to set their ATR registers to the
> > > correct CPU address values.

Actually, as we just discovered with one of the pci_dw drivers, it may
be the wrong number: what you program in the ATR registers is not
necessarily the same as the address visible to the CPU. What you need
instead is the address at the bus immediately above the PCI host bridge.

I think for now we can leave out this part from common code and add
the infrastructure later. Host drivers can have their own loop
around the ranges if they need to set up these registers. Ideally
at least on arm64, they should be set up by the firmware already.

	Arnd
