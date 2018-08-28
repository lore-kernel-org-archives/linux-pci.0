Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-11-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a1Vdy-VsLWJMer-Z96E4Trhi0WJXJ3fTzyOGny2Mn6RAA@mail.gmail.com>
In-Reply-To: <CAK8P3a1Vdy-VsLWJMer-Z96E4Trhi0WJXJ3fTzyOGny2Mn6RAA@mail.gmail.com>
From: Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date: Tue, 28 Aug 2018 18:12:10 +0530
Message-ID: <CA+sq2Cf2BLKsV=gY-MPnygV1ufpvmnw6ETh90JX_uKQBk3Sduw@mail.gmail.com>
Subject: Re: [PATCH 10/15] soc: octeontx2: Reconfig MSIX base with IOVA
To: Arnd Bergmann <arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: jason@lakedaemon.net, Marc Zyngier <marc.zyngier@arm.com>,
 linux-pci <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 LAKML <linux-arm-kernel@lists.infradead.org>, olof@lixom.net,
 tglx@linutronix.de, linux-soc@vger.kernel.org,
 Geetha sowjanya <gakula@marvell.com>, Sunil Goutham <sgoutham@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 28, 2018 at 5:39 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Aug 28, 2018 at 12:58 PM <sunil.kovvuri@gmail.com> wrote:
> >
> > From: Geetha sowjanya <gakula@marvell.com>
> >
> > HW interprets RVU_AF_MSIXTR_BASE address as an IOVA, hence
> > create a IOMMU mapping for the physcial address configured by
> > firmware and reconfig RVU_AF_MSIXTR_BASE with IOVA.
> >
> > Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> > Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
>
> I think this needs some more explanation. What is the difference between
> the MSI-X support in this driver and every other one? Are you working
> around a hardware bug, or is there something odd in the implementation
> of your irqchip driver? Do you use a GIC to handle the MSI interrupts
> or something else?
>
>        Arnd

This admin function is a PCI device which is capable of provisioning
HW blocks to other PCIe SRIOV devices in the system. Each HW block
(eg memory buffer pools, NIC dewscriptors, crypto engines e.t.c) needs
certain no of MSIX vectors. Admin function has a set of 32K MSIX vectors
in memory (not on-chip) which based on HW block provisioning to a PCI device
attaches the required number of vectors to that device. Some part of this
configuration is done by low level firmware.

RVU_AF_MSIXTR_BASE points to the memory region allocated for 32K MSIX
vectors. If kernel is booted with IOMMU enabled and admin function device
is attached to SMMU, HW will go through translation to access this MSIX
vector memory region. Hence the mapping done in this patch.

Thanks,
Sunil.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
