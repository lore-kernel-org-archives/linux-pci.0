Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:63723 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbaBIUay (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 9 Feb 2014 15:30:54 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
Date: Sun, 9 Feb 2014 21:30:25 +0100
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"mohit.kumar@st.com" <mohit.kumar@st.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com> <3724624.kd9jZNUiTF@wuerfel> <20140207114607.GE5976@mudshark.cambridge.arm.com>
In-Reply-To: <20140207114607.GE5976@mudshark.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201402092130.25615.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 07 February 2014, Will Deacon wrote:
> On Wed, Feb 05, 2014 at 08:26:17PM +0000, Arnd Bergmann wrote:
> > On Wednesday 05 February 2014 19:09:47 Will Deacon wrote:
> > > On Tue, Feb 04, 2014 at 07:13:49PM +0000, Arnd Bergmann wrote:
> > If you mandate that, your code is actually correct and you do not
> > require an io_offset or mem_offset.
> 
> Right, so that's what I've currently been relying on. If I mandate that,
> will I be making this driver significantly less useful?

After thinking about it some more, I think we should really try to
keep that logic completely out of the host controller driver and instead
make it generic enough to cover all possible cases.

Let's make sure that nobody ever has to call the range parser from
a PCI host driver again, no matter how weird their hardware setup is,
and put the necessary code in a common location. This will make your
driver even simpler.

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

Fair enough.

> 
> > > > This shows once more that the range parser code is suboptimal. So far
> > > > every single driver got the I/O space wrong here, because the obvious
> > > > way to write this function is also completely wrong.
> > > 
> > > I see you mentioned to Liviu that you should register a logical resource,
> > > rather than physical resource returned from the parser. It seems odd that
> > > I/O space appears to work with this code as-is (I've tested it on arm using
> > > kvmtool by removing the memory bars).
> > 
> > what do you see in /proc/ioports and /proc/iomem then?
> 
> bash-4.2# cat /proc/ioports
> 00006200-000065ff : virtio-pci
> 00006600-000069ff : virtio-pci
> 00006a00-00006dff : virtio-pci
> 00006e00-000071ff : virtio-pci
> 
> bash-4.2# cat /proc/iomem
> 40000000-40ffffff : /pci
> 41000400-410005ff : virtio-pci
> 41000c00-41000dff : virtio-pci
> 41001400-410015ff : virtio-pci
> 41001c00-41001dff : virtio-pci
> 80000000-93ffffff : System RAM
>   80008000-8053df0b : Kernel code
>   80570000-805c07fb : Kernel data

You should normally see a parent resource for the PCI bus and the virtio-pci
resources under that. For some reason, neither of the two appears to have
been registered correctly.

	Arnd
