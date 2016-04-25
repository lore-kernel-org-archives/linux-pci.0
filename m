Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 25 Apr 2016 15:57:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 06/59] PCI: Kill wrong quirk about M7101
Message-ID: <20160425205737.GC1759@localhost>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
 <1456366370-28995-7-git-send-email-yinghai@kernel.org>
 <20160310174030.GB17238@localhost>
 <CAE9FiQVAPfb-PYGQoRJzXdn3NAOK-X25M9pWvR2m7_9qT5qQ+w@mail.gmail.com>
 <alpine.LRH.2.20.1603120951320.32556@math.ut.ee>
 <CAE9FiQWeq=VssPtW86KcOuW5rLr+t5628Fid7e4RG_R_gZ+Aaw@mail.gmail.com>
 <alpine.LRH.2.20.1603121039020.32556@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.20.1603121039020.32556@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Yinghai & Meelis,

On Sat, Mar 12, 2016 at 10:39:15AM +0200, Meelis Roos wrote:
> > On Fri, Mar 11, 2016 at 11:52 PM, Meelis Roos <mroos@linux.ee> wrote:
> > >> On Thu, Mar 10, 2016 at 9:40 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >> > On Wed, Feb 24, 2016 at 06:11:57PM -0800, Yinghai Lu wrote:
> > >> >> Meelis reported that qla2000 driver does not get loaded on one sparc system.
> > >> >>
> > >> >> schizo f00732d0: PCI host bridge to bus 0001:00
> > >> >> pci_bus 0001:00: root bus resource [io  0x7fe01000000-0x7fe01ffffff] (bus address [0x0000-0xffffff])
> > >> >> pci 0001:00:06.0: quirk: [io  0x7fe01000800-0x7fe0100083f] claimed by ali7101 ACPI
> > >> >> pci 0001:00:06.0: quirk: [io  0x7fe01000600-0x7fe0100061f] claimed by ali7101 SMB
> > >> >> pci 0001:00:07.0: can't claim BAR 0 [io  0x7fe01000000-0x7fe0100ffff]: address conflict with 0001:00:06.0 [io  0x7fe01000600-0x7fe0100061f]
> > >> >>
> > >> >> So the quirk for M7101 claim the io range early.
> > >
> > > But why did it work until 4.2 and only with 4.3 the allocations broke?
> > >
> > 
> > My understanding is we really install the root bus resource and try to
> > do the sanitary checking
> > for device resource.
> > 
> > Or did you find exact commit between 4.2 and 4.3 cause the problem ?
> 
> No, I have not bisected that.

I'm confused again.

I opened https://bugzilla.kernel.org/show_bug.cgi?id=117191 and
attached dmesg logs and lspci output from Meelis' original bug report,
since you included URLs in the changelog (thank you for that), and I
don't want Meelis to have to worry about keeping the URLs alive.

I extracted the following from the v210 dmesg and lspci attached there
(I used these because they're the only matching pair of dmesg & lspci
I saw):

  PCI: Scanning PBM /pci@1e,600000
  schizo f00732d0: PCI host bridge to bus 0001:00
  pci_bus 0001:00: root bus resource [io  0x7fe01000000-0x7fe01ffffff] (bus address [0x0000-0xffffff])
  pci_bus 0001:00: root bus resource [mem 0x7ff00000000-0x7ffffffffff] (bus address [0x00000000-0xffffffff])
  pci_bus 0001:00: root bus resource [bus 00]
  pci 0001:00:06.0: quirk: [io  0x7fe01000800-0x7fe0100083f] claimed by ali7101 ACPI
  pci 0001:00:06.0: quirk: [io  0x7fe01000600-0x7fe0100061f] claimed by ali7101 SMB
  pci 0001:00:07.0: can't claim BAR 0 [io  0x7fe01000000-0x7fe0100ffff]: address conflict with 0001:00:06.0 [io  0x7fe01000600-0x7fe0100061f]
  pci 0001:00:07.0: can't claim BAR 1 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000bffff flags 0x80000000]
  pci 0001:00:07.0: can't claim BAR 2 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000bffff flags 0x80000000]

  0001:00:06.0 Non-VGA unclassified device: ULi Electronics Inc. M7101 Power Management Controller [PMU]
	  Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	  Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	  Region 0: [virtual] I/O ports at <unassigned> [size=16]
  00: b9 10 01 71 00 00 00 02 00 00 00 00 00 00 00 00
  10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

  0001:00:07.0 ISA bridge: ULi Electronics Inc. M1533/M1535/M1543 PCI to ISA Bridge [Aladdin IV/V/V+]
	  Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	  Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	  Latency: 0
	  Region 0: [virtual] I/O ports at 0000 [size=64K]
  00: b9 10 33 15 0f 00 10 02 00 00 01 06 00 00 00 00
  10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

The PCI core thinks 0001:00:07.0 BAR 0 is 64K of I/O space.  That
looks wrong (it's way too big), and it doesn't match the actual config
space, which says 0x10 is 0x00000000, which would be an unimplemented
BAR.

I suspect this is because PCI enumeration on sparc gets some
information from OBP instead of from config space.  I think we should
fix this enumeration problem instead of throwing away the quirk.

Bjorn
