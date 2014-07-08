Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v8 3/9] pci: Introduce pci_register_io_range() helper function.
Date: Tue, 8 Jul 2014 16:14:17 +0200
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
References: <1404240214-9804-1-git-send-email-Liviu.Dudau@arm.com> <20140708001418.GB22939@google.com> <20140708104050.GA6501@e106497-lin.cambridge.arm.com>
In-Reply-To: <20140708104050.GA6501@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201407081614.18304.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 08 July 2014, Liviu Dudau wrote:
> > Here's what these look like in /proc/iomem and /proc/ioports (note that
> > there are two resource structs for each memory-mapped IO port space: one
> > IORESOURCE_MEM for the memory-mapped area (used only by the host bridge
> > driver), and one IORESOURCE_IO for the I/O port space (this becomes the
> > parent of a region used by a regular device driver):
> > 
> >   /proc/iomem:
> >     PCI Bus 0000:00 I/O Ports 00000000-00000fff
> >     PCI Bus 0001:00 I/O Ports 01000000-01000fff
> > 
> >   /proc/ioports:
> >     00000000-00000fff : PCI Bus 0000:00
> >     01000000-01000fff : PCI Bus 0001:00
> 
> OK, I have a question that might be ovbious to you but I have missed the answer
> so far: how does the IORESOURCE_MEM area gets created? Is it the host bridge
> driver's job to do it? Is it something that the framework should do when it
> notices that the IORESOURCE_IO is memory mapped?

The host bridge driver should either register the IORESOURCE_MEM resource
itself from its probe or setup function, or it should get registered behind
the covers in drivers using of_create_pci_host_bridge().

Your new pci_host_bridge_of_get_ranges already loops over all the 
resources, so it would be a good place to put that.

	Arnd
