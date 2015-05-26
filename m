Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50056 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932188AbbEZOOJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 May 2015 10:14:09 -0400
Date: Tue, 26 May 2015 10:59:24 +0100
From: Will Deacon <will.deacon@arm.com>
To: "Jayachandran C." <jchandra@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH v2 1/2] PCI: generic: remove dependency on hw_pci
Message-ID: <20150526095924.GF1565@arm.com>
References: <1430791333-26013-1-git-send-email-jchandra@broadcom.com>
 <20150505155346.GJ1550@arm.com>
 <20150512000746.GA31418@jayachandranc.netlogicmicro.com>
 <20150519230918.GW31666@google.com>
 <20150520172903.GJ11498@arm.com>
 <20150521063729.GB31418@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150521063729.GB31418@jayachandranc.netlogicmicro.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 21, 2015 at 07:37:30AM +0100, Jayachandran C. wrote:
> On Wed, May 20, 2015 at 06:29:03PM +0100, Will Deacon wrote:
> > On Wed, May 20, 2015 at 12:09:18AM +0100, Bjorn Helgaas wrote:
> > > On Tue, May 12, 2015 at 05:37:47AM +0530, Jayachandran C. wrote:
> > > > On Tue, May 05, 2015 at 04:53:46PM +0100, Will Deacon wrote:
> > > > > On Tue, May 05, 2015 at 03:02:12AM +0100, Jayachandran C wrote:
> > > > > > The current code in pci-host-generic.c uses pci_common_init_dev()
> > > > > > from the arch/arm/ to do a part of the PCI initialization, and this
> > > > > > prevents it from being used on arm64.
> > > > > > 
> > > > > > The initialization done by pci_common_init_dev() that is really
> > > > > > needed by pci-host-generic.c can be done in the same file without
> > > > > > using the hw_pci API of ARM.
> > > > > > 
> > > > > > The ARM platform requires a pci_sys_data as sysdata for the PCI bus,
> > > > > > this is be handled by setting up 'struct gen_pci' to embed a
> > > > > > pci_sys_data variable as the first element on the ARM platform.
> > > > > > 
> > > > > > Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> > > > > > ---
> > > > > > Here's v2 of the patches, this enables use of pci-host-generic on
> > > > > > arm64.
> > > > > > 
> > > > > > This has been tested on both qemu and fast model for arm64, and on
> > > > > > qemu for arm32.
> > > > > > 
> > > > > > v1->v2
> > > > > >  - Address comments from Arnd Bergmann and Lorenzo Pieralisi
> > > > > >     - move contents of gen_pci_init to gen_pci_probe
> > > > > >     - assign resources only when !probe_only
> > > > > >  - tested on ARM32 with qemu option -M virt
> > > > > 
> > > > > I tried this with an arm64 kernel running under kvmtool, but I get the
> > > > > following errors (a 32-bit ARM kernel does seem to work):
> > > > > 
> > > > >   PCI host bridge /pci ranges:
> > > > >      IO 0x00000000..0x0000ffff -> 0x00000000
> > > > >     MEM 0x41000000..0x7fffffff -> 0x41000000
> > > > >   pci-host-generic 40000000.pci: PCI host bridge to bus 0000:00
> > > > >   pci_bus 0000:00: root bus resource [bus 00-01]
> > > > >   pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> > > > >   pci_bus 0000:00: root bus resource [mem 0x41000000-0x7fffffff]
> > > > >   pci_bus 0000:00: scanning bus
> > > > >   pci 0000:00:00.0: [1af4:1009] type 00 class 0xff0000
> > > > >   pci 0000:00:00.0: reg 0x10: [mem 0x41000000-0x410003ff]
> > > > >   pci 0000:00:00.0: reg 0x14: [io  0x6200-0x65ff]
> > > > >   pci 0000:00:00.0: reg 0x18: [mem 0x41000400-0x410005ff]
> > > > >   pci 0000:00:01.0: [1af4:1009] type 00 class 0xff0000
> > > > >   pci 0000:00:01.0: reg 0x10: [mem 0x41000800-0x41000bff]
> > > > >   pci 0000:00:01.0: reg 0x14: [io  0x6600-0x69ff]
> > > > >   pci 0000:00:01.0: reg 0x18: [mem 0x41000c00-0x41000dff]
> > > > >   pci_bus 0000:00: fixups for bus
> > > > >   pci_bus 0000:00: bus scan returning with max=00
> > > > >   pci 0000:00:00.0: fixup irq: got 10
> > > > >   pci 0000:00:00.0: assigning IRQ 10
> > > > >   pci 0000:00:01.0: fixup irq: got 11
> > > > >   pci 0000:00:01.0: assigning IRQ 11
> > > > >   virtio-pci 0000:00:00.0: can't enable device: BAR 0 [mem 0x41000000-0x410003ff] not claimed
> > > > >   virtio-pci: probe of 0000:00:00.0 failed with error -22
> > > > >   virtio-pci 0000:00:01.0: can't enable device: BAR 0 [mem 0x41000800-0x41000bff] not claimed
> > > > >   virtio-pci: probe of 0000:00:01.0 failed with error -22
> > > > 
> > > > PCI_PROBE_ONLY does not work yet for arm64, this will need further changes
> > > > in either arm64 or pci as noted by Lorenzo. This is not due to a problem with
> > > > this patch per se.
> > > > 
> > > > More importantly, this does not change the current arm32 behavior and adds
> > > > support for arm64 for two very useful cases
> > > >  - we can use "pci-host-ecam-generic" for a host bridge controller that is
> > > >    initialized by firmware, without adding a custom driver.
> > > >  - qemu virt platform works on arm64
> > > > 
> > > > If you think there are any furhter changes needed in this patchset please
> > > > let me know.
> > > 
> > > I'm waiting for at least an ack from Will.
> > 
> > I'm not too keen on the current state of this patch. Firstly, I'd really
> > like to see the PROBE_ONLY case addressed at the same time as this port
> > (Lorenzo and Suravee are working on this).
> 
> Fixing the PROBE-ONLY for arm64 is probably unrelated to the scope of this
> patch - so I would hope that we don't NACK this patch due to that issue. This
> patch is very useful without PROBE-ONLY like I noted above.

I'm not NACKing anything, I just don't see the benefit of merging half a
solution when the other half is in active development. Perhaps you could
review Lorenzo's patches to help things along?

> > Secondly, the hack to put pci_sys_data as the first member of gen_pci is ugly
> > at best
> 
> On balance, it removes the problem of using hw_pci interface which has its own
> ugliness (Arnd's mail on this http://www.spinics.net/lists/linux-pci/msg40703.html)

To me, that sounds like we should be disposing of the hw_pci interface
altogether and moving arch/arm/ over to the new architecture-independent
interface.

> > and probably makes it difficult to support MSIs on ARM.
> 
> Adding parsing of msi-parent and setting it up for arm32 and arm64 can be
> added fairly easily to the current code, I can post an RFC patch for this.

I think that would be a good addition to the series.

Will
