Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-11-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a1Vdy-VsLWJMer-Z96E4Trhi0WJXJ3fTzyOGny2Mn6RAA@mail.gmail.com>
 <CA+sq2Cf2BLKsV=gY-MPnygV1ufpvmnw6ETh90JX_uKQBk3Sduw@mail.gmail.com>
 <CAK8P3a0+zJRxEYWZpYShRJo-3oqMaC9TJADugaRTiBnjw7ssPA@mail.gmail.com>
 <CA+sq2Cfd_jk=JzcLmPYiW1iGqKrJRrv5vrsmeZfY4W+qi5GLgw@mail.gmail.com>
In-Reply-To: <CA+sq2Cfd_jk=JzcLmPYiW1iGqKrJRrv5vrsmeZfY4W+qi5GLgw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 30 Aug 2018 15:53:25 +0200
Message-ID: <CAK8P3a1BRvhQ9iQWP2hTrJOu+Z+vmmek-Uobw6zX0dM4zFe_gQ@mail.gmail.com>
Subject: Re: [PATCH 10/15] soc: octeontx2: Reconfig MSIX base with IOVA
To: Sunil Kovvuri <sunil.kovvuri@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Olof Johansson <olof@lixom.net>, Thomas Gleixner <tglx@linutronix.de>,
 linux-soc@vger.kernel.org, gakula@marvell.com, sgoutham@marvell.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 28, 2018 at 3:17 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> On Tue, Aug 28, 2018 at 6:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Aug 28, 2018 at 2:42 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> > > On Tue, Aug 28, 2018 at 5:39 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Tue, Aug 28, 2018 at 12:58 PM <sunil.kovvuri@gmail.com> wrote:
> > >
> > > This admin function is a PCI device which is capable of provisioning
> > > HW blocks to other PCIe SRIOV devices in the system. Each HW block
> > > (eg memory buffer pools, NIC dewscriptors, crypto engines e.t.c) needs
> > > certain no of MSIX vectors. Admin function has a set of 32K MSIX vectors
> > > in memory (not on-chip) which based on HW block provisioning to a PCI device
> > > attaches the required number of vectors to that device. Some part of this
> > > configuration is done by low level firmware.
> > >
> > > RVU_AF_MSIXTR_BASE points to the memory region allocated for 32K MSIX
> > > vectors. If kernel is booted with IOMMU enabled and admin function device
> > > is attached to SMMU, HW will go through translation to access this MSIX
> > > vector memory region. Hence the mapping done in this patch.
> >
> > Do you mean this is not a regular PCIe MSI-X interrupt to the GIC, but
> > something internal to your device that gets routed through the IOMMU
> > back into the device?
> >
>
> This is a regular PCIe MSI-X interrupt, the difference is that the
> bunch of PCI devices
> here doesn't have a fixed set of MSIX vectors. Admin function has a
> memory region with
> 32K MSIX vectors which it provisions to PCI devices based on the HW
> functional blocks
> attached to them. A PCI device which works as a ethernet device needs
> X number of vectors
> and a crypto device needs Y number of vectors.
>
> Since the admin function owns the whole MSIX vector region, HW uses
> this device's stream ID
> to access the vectors. Hence the IOMMU mapping. Once MSIX vectors are
> provisioned to
> a PCI device they work as normal MSIX interrupt like any other device.

Ok, I think I got it now, just to confirm: the MSIX vectors you allocate
in the admin device refer to memory backing the BAR that contains
the MSI-X entries of the other functions, right?

I was a bit confused here and assumed that you were mapping
the MMIO area of an interrupt controller that receives the interupt
transactions.

         Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
