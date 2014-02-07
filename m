Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:51966 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752080AbaBGRyS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 7 Feb 2014 12:54:18 -0500
Date: Fri, 7 Feb 2014 10:54:10 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"mohit.kumar@st.com" <mohit.kumar@st.com>
Subject: Re: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
Message-ID: <20140207175410.GC16263@obsidianresearch.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
 <3460536.Sh23gjDa6X@wuerfel>
 <20140205190947.GA22297@mudshark.cambridge.arm.com>
 <3724624.kd9jZNUiTF@wuerfel>
 <20140207114607.GE5976@mudshark.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140207114607.GE5976@mudshark.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 07, 2014 at 11:46:07AM +0000, Will Deacon wrote:

> > In practice, there can be various ways that a system requires something
> > more complex:
> > 
> > * You can have a memory space range that puts PCI bus address zero
> >   at the start of the pci->mem resource. In this case, you have
> >   mem_offset = pci->mem.start. We should probably try not to do
> >   this, but there is existing hardware doing it.
> 
> If it's not the common case, then the generic driver might not need to care
> (at least, initially).

Something to think about, other people are going to reference this
driver when writing drivers for their own hardware, it would be nice
to see it perfect..

AFAIK, the job is fairly simple, when you call pci_add_resource_offset
for memory compute the offset from 
  of_pci_range.pci_addr - of_pci_range.cpu_addr

(or is it the other way around ?)

And when you do it for IO then you compute the offset between the
requested io mapping base to the pci_addr.

> > * You might have multiple sections of the PCI bus space mapped
> >   into CPU physical space. If you want to support legacy VGA
> >   console, you probably want to map the first 16MB of the bus
> >   space at an arbitrary location (with the mem_offset as above),
> >   plus a second, larger section of the bus space with an identity
> >   mapping (mem_offset_= 0) for all devices other than VGA.
> >   You'd also need to copy some VGA specific code from arm32 to
> >   arm64 to actually make this work.
> 
> Again, I'd rather cross that bridge (no pun intended) when we decide we want
> legacy VGA.

Fortuantely if you compute the offset directly from the DT then you
don't need to do anything more. If someone wants to use this
arrangement then they just have to setup the HW and write a proper DT
with two ranges lines for memory and everything should just work.

> Okey doke, is anybody working on that? (I see the follow up from
> Jason, but it's not clear whether that's going to be merged).

Nope, just a thought to stimulate discussion :)

Regards,
Jason
