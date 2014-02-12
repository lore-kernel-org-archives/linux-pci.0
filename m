Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:50656 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752782AbaBLSK7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2014 13:10:59 -0500
Date: Wed, 12 Feb 2014 18:10:15 +0000
From: Will Deacon <will.deacon@arm.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"mohit.kumar@st.com" <mohit.kumar@st.com>
Subject: Re: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
Message-ID: <20140212181015.GJ29132@mudshark.cambridge.arm.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
 <3460536.Sh23gjDa6X@wuerfel>
 <20140205190947.GA22297@mudshark.cambridge.arm.com>
 <3724624.kd9jZNUiTF@wuerfel>
 <20140207114607.GE5976@mudshark.cambridge.arm.com>
 <20140207175410.GC16263@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140207175410.GC16263@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 07, 2014 at 05:54:10PM +0000, Jason Gunthorpe wrote:
> On Fri, Feb 07, 2014 at 11:46:07AM +0000, Will Deacon wrote:
> 
> > > In practice, there can be various ways that a system requires something
> > > more complex:
> > > 
> > > * You can have a memory space range that puts PCI bus address zero
> > >   at the start of the pci->mem resource. In this case, you have
> > >   mem_offset = pci->mem.start. We should probably try not to do
> > >   this, but there is existing hardware doing it.
> > 
> > If it's not the common case, then the generic driver might not need to care
> > (at least, initially).
> 
> Something to think about, other people are going to reference this
> driver when writing drivers for their own hardware, it would be nice
> to see it perfect..
> 
> AFAIK, the job is fairly simple, when you call pci_add_resource_offset
> for memory compute the offset from 
>   of_pci_range.pci_addr - of_pci_range.cpu_addr
> 
> (or is it the other way around ?)

I think it's the other way round: bus = cpu - offset, then Arnd's example of
PCI bus 0 works out as: 0 = cpu - pci->mem_start.

I added that to my driver, but I get some weird looking bus addresses in
dmesg:

[    0.307585] pci-arm-generic 40000000.pci: PCI host bridge to bus 0000:00
[    0.307601] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.307615] pci_bus 0000:00: root bus resource [mem 0x00000000-0x3effffff] (bus address [0xffffffffbf000000-0xfffffffffdffffff])

Looking at drivers/pci/probe.c, it seems to think that res->start - offset
gives a bus address, which implies that the resources are indeed *CPU*
addresses.

Are you sure pci_add_resource_offset wants bus addresses?

Will
