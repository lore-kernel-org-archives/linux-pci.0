Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:58493 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753087AbaBGLqq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Feb 2014 06:46:46 -0500
Date: Fri, 7 Feb 2014 11:46:07 +0000
From: Will Deacon <will.deacon@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"mohit.kumar@st.com" <mohit.kumar@st.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
Message-ID: <20140207114607.GE5976@mudshark.cambridge.arm.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
 <3460536.Sh23gjDa6X@wuerfel>
 <20140205190947.GA22297@mudshark.cambridge.arm.com>
 <3724624.kd9jZNUiTF@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3724624.kd9jZNUiTF@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd, Jason,

First of all, thanks for the really helpful feedback. I'll take it on-board
for v2.

On Wed, Feb 05, 2014 at 08:26:17PM +0000, Arnd Bergmann wrote:
> On Wednesday 05 February 2014 19:09:47 Will Deacon wrote:
> > On Tue, Feb 04, 2014 at 07:13:49PM +0000, Arnd Bergmann wrote:
> > > This should really compute an io_offset.
> > > 
> > > > +	if (resource_type(&pci->mem))
> > > > +		pci_add_resource(&sys->resources, &pci->mem);
> > > 
> > > and also a mem_offset, which is something different.
> > 
> > As somebody new to PCI, I'm afraid you've lost me here. Are you referring to
> > using pci_add_resource_offset instead, then removing my restriction on
> > having a single resource from the parsing code?
> 
> I mean pci_add_resource_offset, but I don't understand what the
> restriction is that you are talking about. To elaborate on the offsets,
> the common case is that the PCI memory space is the same as the
> host physical address space for both MMIO and DMA, while you have
> only one PCI host with a single I/O space range from port 0 to 65536.
> 
> If you mandate that, your code is actually correct and you do not
> require an io_offset or mem_offset.

Right, so that's what I've currently been relying on. If I mandate that,
will I be making this driver significantly less useful?

> In practice, there can be various ways that a system requires something
> more complex:
> 
> * You can have a memory space range that puts PCI bus address zero
>   at the start of the pci->mem resource. In this case, you have
>   mem_offset = pci->mem.start. We should probably try not to do
>   this, but there is existing hardware doing it.

If it's not the common case, then the generic driver might not need to care
(at least, initially).

> * You might have multiple sections of the PCI bus space mapped
>   into CPU physical space. If you want to support legacy VGA
>   console, you probably want to map the first 16MB of the bus
>   space at an arbitrary location (with the mem_offset as above),
>   plus a second, larger section of the bus space with an identity
>   mapping (mem_offset_= 0) for all devices other than VGA.
>   You'd also need to copy some VGA specific code from arm32 to
>   arm64 to actually make this work.

Again, I'd rather cross that bridge (no pun intended) when we decide we want
legacy VGA.

> * If you have two PCI host bridges and each of them comes with
>   its own I/O space range starting between 0x0-0xffff, you have
>   to map one of them into logical I/O space address 0x10000-0x1ffff
>   and set io_offset = 0x10000 for that bus.

Right, this sounds a lot more plausible from the perspective of a generic
driver. Since the current code only allows exactly one I/O space region, we
avoid the issue but I can remove that restriction (that I mentioned earlier)
and offset the region based on the bridge.

> > > This shows once more that the range parser code is suboptimal. So far
> > > every single driver got the I/O space wrong here, because the obvious
> > > way to write this function is also completely wrong.
> > 
> > I see you mentioned to Liviu that you should register a logical resource,
> > rather than physical resource returned from the parser. It seems odd that
> > I/O space appears to work with this code as-is (I've tested it on arm using
> > kvmtool by removing the memory bars).
> 
> what do you see in /proc/ioports and /proc/iomem then?

bash-4.2# cat /proc/ioports
00006200-000065ff : virtio-pci
00006600-000069ff : virtio-pci
00006a00-00006dff : virtio-pci
00006e00-000071ff : virtio-pci

bash-4.2# cat /proc/iomem
40000000-40ffffff : /pci
41000400-410005ff : virtio-pci
41000c00-41000dff : virtio-pci
41001400-410015ff : virtio-pci
41001c00-41001dff : virtio-pci
80000000-93ffffff : System RAM
  80008000-8053df0b : Kernel code
  80570000-805c07fb : Kernel data

> > > What you get out of "of_pci_range_to_resource(&range, np, &pci->io)"
> > > is not the resource you want to pass into pci_add_resource()
> > > later.
> > 
> > Do I need to open-code the resource translation from phys -> logical?
> 
> I think we should have some common infrastructure that lets you
> get this right more easily.

Okey doke, is anybody working on that? (I see the follow up from Jason, but
it's not clear whether that's going to be merged).

Cheers,

Will
