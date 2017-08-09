Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 8 Aug 2017 22:02:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Casey Leedom <leedom@chelsio.com>
Subject: Re: [PATCH v9 1/4] PCI: Add new PCIe Fabric End Node flag,
 PCI_DEV_FLAGS_NO_RELAXED_ORDERING
Message-ID: <20170809030236.GA7191@bhelgaas-glaptop.roam.corp.google.com>
References: <1501917313-9812-1-git-send-email-dingtianhong@huawei.com>
 <1501917313-9812-2-git-send-email-dingtianhong@huawei.com>
 <20170808232200.GO16580@bhelgaas-glaptop.roam.corp.google.com>
 <MWHPR12MB1600249E96C320D5472F77ADC88B0@MWHPR12MB1600.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <MWHPR12MB1600249E96C320D5472F77ADC88B0@MWHPR12MB1600.namprd12.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
 "asit.k.mallick@intel.com" <asit.k.mallick@intel.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>,
 "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
 Ding Tianhong <dingtianhong@huawei.com>, Ganesh GR <ganeshgr@chelsio.com>,
 "Bob.Shaw@amd.com" <Bob.Shaw@amd.com>,
 "patrick.j.cramer@intel.com" <patrick.j.cramer@intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 Michael Werner <werner@chelsio.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "amira@mellanox.com" <amira@mellanox.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "David.Laight@aculab.com" <David.Laight@aculab.com>,
 "Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 09, 2017 at 01:40:01AM +0000, Casey Leedom wrote:
> | From: Bjorn Helgaas <helgaas@kernel.org>
> | Sent: Tuesday, August 8, 2017 4:22 PM
> | 
> | This needs to include a link to the Intel spec
> | (https://software.intel.com/sites/default/files/managed/9e/bc/64-ia-32-architectures-optimization-manual.pdf,
> | sec 3.9.1).
> 
>   In the commit message or as a comment?  Regardless, I agree.  It's always
> nice to be able to go back and see what the official documentation says.
> However, that said, links on the internet are ... fragile as time goes by,
> so we might want to simply quote section 3.9.1 in the commit message since
> it's relatively short:
> 
>     3.9.1 Optimizing PCIe Performance for Accesses Toward Coherent Memory
>           and Toward MMIO Regions (P2P)
> 
>     In order to maximize performance for PCIe devices in the processors
>     listed in Table 3-6 below, the soft- ware should determine whether the
>     accesses are toward coherent memory (system memory) or toward MMIO
>     regions (P2P access to other devices). If the access is toward MMIO
>     region, then software can command HW to set the RO bit in the TLP
>     header, as this would allow hardware to achieve maximum throughput for
>     these types of accesses. For accesses toward coherent memory, software
>     can command HW to clear the RO bit in the TLP header (no RO), as this
>     would allow hardware to achieve maximum throughput for these types of
>     accesses.
> 
>     Table 3-6. Intel Processor CPU RP Device IDs for Processors Optimizing
>                PCIe Performance
> 
>     Processor                            CPU RP Device IDs
> 
>     Intel Xeon processors based on       6F01H-6F0EH
>     Broadwell microarchitecture
> 
>     Intel Xeon processors based on       2F01H-2F0EH
>     Haswell microarchitecture

Agreed, links are prone to being broken.  I would include in the
changelog the complete title and order number, along with the link as
a footnote.  Wouldn't hurt to quote the section too, since it's short.

> | It should also include a pointer to the AMD erratum, if available, or
> | at least some reference to how we know it doesn't obey the rules.
> 
>   Getting an ACK from AMD seems like a forlorn cause at this point.  My
> contact was Bob Shaw <Bob.Shaw@amd.com> and he stopped responding to me
> messages almost a year ago saying that all of AMD's energies were being
> redirected towards upcoming x86 products (likely Ryzen as we now know).  As
> far as I can tell AMD has walked away from their A1100 (AKA "Seattle") ARM
> SoC.
> 
>   On the specific issue, I can certainly write up somthing even more
> extensive than I wrote up for the comment in drivers/pci/quirks.c.  Please
> review the comment I wrote up and tell me if you'd like something even more
> detailed -- I'm usually acused of writing comments which are too long, so
> this would be a new one on me ... :-)

If you have any bug reports with info about how you debugged it and
concluded that Seattle is broken, you could include a link (probably
in the changelog).  But if there isn't anything, there isn't anything.

I might reorganize those patches as:

  1) Add a PCI_DEV_FLAGS_RELAXED_ORDERING_BROKEN flag, the quirk that
  sets it, and the current patch [2/4] that uses it.

  2) Add the Intel DECLARE_PCI_FIXUP_CLASS_EARLY()s with the Intel
  details.

  3) Add the AMD DECLARE_PCI_FIXUP_CLASS_EARLY()s with the AMD
  details.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
