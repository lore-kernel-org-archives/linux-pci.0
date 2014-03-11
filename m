Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Liviu Dudau <Liviu.Dudau@arm.com>, Liviu Dudau <liviu@dudau.co.uk>,
	linaro-kernel <linaro-kernel@lists.linaro.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Will Deacon <Will.Deacon@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 6/6] pci: Add support for creating a generic host_bridge from device tree
Date: Tue, 11 Mar 2014 11:43:39 +0100
Message-ID: <2664356.LLPHGvlG5M@wuerfel>
In-Reply-To: <20140311094641.GA27064@e106497-lin.cambridge.arm.com>
References: <1394020137-1830-1-git-send-email-Liviu.Dudau@arm.com> <4254618.BlpDUOctDb@wuerfel> <20140311094641.GA27064@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 11 March 2014 09:46:41 Liviu Dudau wrote:
> On Tue, Mar 11, 2014 at 06:50:24AM +0000, Arnd Bergmann wrote:
> > On Monday 10 March 2014 21:56:00 Liviu Dudau wrote:
> > > 
> > > PCI_IOBASE is always defined. See the discussion with Russell on this subject.
> > > 
> > > include/asm-generic/io.h has at line 118:
> > > 
> > > #ifndef PCI_IOBASE
> > > #define PCI_IOBASE ((void __iomem *) 0)
> > > #endif
> > 
> > That is only defined for those that use asm-generic/pci.h, which most architectures
> > don't.
> 
> I think it is defined for anyone that #includes <asm-generic/io.h>. There is no other
> #ifdef around that.
> 

My mistake, I meant to write asm-generic/io.h.

On a related note, I would actually prefer to get rid of this PCI_IOBASE
default and move it into the architectures that really want it like this.
The default when PCI_IOBASE is not set IMHO should be to also not provide
inb/outb and ioport_map() helpers, but we need a little more infrastructure
to actually make the kernel build in all valid configuration when we remove them.

	Arnd
