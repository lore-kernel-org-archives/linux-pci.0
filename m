Return-Path: <SRS0=VDEn=ED=free-electrons.com=thomas.petazzoni@kernel.org>
Return-Path: <SRS0=VDEn=ED=free-electrons.com=thomas.petazzoni@kernel.org>
Date: Mon, 8 Jan 2018 23:27:11 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, linux-sh@vger.kernel.org,
 linux-pci@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/8] SH7786 PCIe support fixes
Message-ID: <20180108232711.461a492d@windsurf>
In-Reply-To: <20180108221258.GA31640@bhelgaas-glaptop.roam.corp.google.com>
References: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
	<20180107160627.5a1231fa@windsurf>
	<20180108221258.GA31640@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Mon, 8 Jan 2018 16:12:58 -0600, Bjorn Helgaas wrote:

> > > Thomas Petazzoni (8):
> > >   arch/sh: add sh7786_mm_sel() function
> > >   arch/sh: make the DMA mapping operations observe dev->dma_pfn_offset
> > >   arch/sh: pci: don't use disabled resources
> > >   arch/sh: pcie-sh7786: mark unavailable PCI resource as disabled
> > >   arch/sh: pcie-sh7786: exclude unusable PCI MEM areas
> > >   arch/sh: pcie-sh7786: adjust PCI MEM and IO regions
> > >   arch/sh: pcie-sh7786: adjust the memory mapping
> > >   arch/sh: pcie-sh7786: handle non-zero DMA offset  
> > 
> > It's been a month. Any feedback on those patches ?  
> 
> I'm assuming Yoshinori and Rich will handle these.  Let me know if
> otherwise.

Yes, it's all in arch/sh, so I assume the SH maintainers will take care
of those patches. I mainly CC'ed the PCI maintainers + mailing list for
information, and to get additional feedback on PCI specific topics if
there's any.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
