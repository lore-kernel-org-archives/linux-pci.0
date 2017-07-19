Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 19 Jul 2017 18:48:11 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Oza Oza <oza.oza@broadcom.com>
Subject: Re: [RFT PATCH v2 02/42] drivers: pci: host: iproc: Convert link
 check to raw PCI config accessors
Message-ID: <20170719174811.GA22595@red-moon>
References: <20170608163614.GB2216@red-moon>
 <CAMSpPPe6bXfu=ntMedrt0w4UfqJLy1a9ZBu_kXy1j4B63x1Nww@mail.gmail.com>
 <20170612161358.GA32043@red-moon>
 <CAMSpPPc0uwV0JZYkegrCaemuoJ-wfWwkSXd7TMtFwENoLRXdBQ@mail.gmail.com>
 <403daa9b-c0f6-971d-9312-ef103460d738@broadcom.com>
 <CAMSpPPdDLjRURZowWAzSvagmmhmojwYFYoHVu3xYcH6i-guviQ@mail.gmail.com>
 <3d90daa1-7090-337a-b5c1-967b7eaeb2d9@broadcom.com>
 <20170614133938.GA30630@red-moon>
 <CAMSpPPe1fw7fuQMz969ZoRnuNYkaaDqdNnYugA=AvSUvufiKzQ@mail.gmail.com>
 <CAMSpPPdzmQBOvhz2Cx+TnnNoX-N-0cr92O07GTzWwp1TKidPcw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMSpPPdzmQBOvhz2Cx+TnnNoX-N-0cr92O07GTzWwp1TKidPcw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>, Ray Jui <ray.jui@broadcom.com>,
 Tanmay Inamdar <tinamdar@apm.com>, Matthew Minter <matt@masarand.com>,
 Rob Herring <robh@kernel.org>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Michal Simek <michal.simek@xilinx.com>, Jon Mason <jonmason@broadcom.com>,
 Murali Karicheri <m-karicheri2@ti.com>, Arnd Bergmann <arnd@arndb.de>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Ray Jui <rjui@broadcom.com>, Simon Horman <horms@verge.net.au>,
 Bjorn Helgaas <bhelgaas@google.com>, Mingkai Hu <mingkai.hu@freescale.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Scott Branden <sbranden@broadcom.com>, Jingoo Han <jingoohan1@gmail.com>,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 19, 2017 at 05:43:32PM +0530, Oza Oza wrote:
> On Wed, Jun 21, 2017 at 8:09 PM, Oza Oza <oza.oza@broadcom.com> wrote:
> > On Wed, Jun 14, 2017 at 7:09 PM, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> >> On Tue, Jun 13, 2017 at 10:18:14AM -0700, Ray Jui wrote:
> >>> Hi Oza/Lorenzo,
> >>>
> >>> On 6/13/17 1:22 AM, Oza Oza wrote:
> >>> > On Tue, Jun 13, 2017 at 12:22 AM, Ray Jui <ray.jui@broadcom.com> wrote:
> >>> >>
> >>> >>
> >>> >> On 6/12/17 10:40 AM, Oza Oza wrote:
> >>> >>> On Mon, Jun 12, 2017 at 9:43 PM, Lorenzo Pieralisi
> >>> >>> <lorenzo.pieralisi@arm.com> wrote:
> >>> >>>> On Sun, Jun 11, 2017 at 09:42:34AM +0530, Oza Oza wrote:
> >>> >>>>> On Thu, Jun 8, 2017 at 10:06 PM, Lorenzo Pieralisi
> >>> >>>>> <lorenzo.pieralisi@arm.com> wrote:
> >>> >>>>>> [dropped rock-chips maintainers, email bounces]
> >>> >>>>>>
> >>> >>>>>> On Thu, Jun 08, 2017 at 08:56:05AM -0700, Ray Jui wrote:
> >>> >>>>>>> Hi Lorenzo,
> >>> >>>>>>>
> >>> >>>>>>> Thanks, I'll try my best to find time to test this along 15/42 and
> >>> >>>>>>> 33/42 patches. Hopefully I can get to that some time next week.
> >>> >>>>>>>
> >>> >>>>>>> I have not yet reviewed these patches in details. Do they have
> >>> >>>>>>> dependency on other patches to the generic framework code you
> >>> >>>>>>> changed?
> >>> >>>>>>>
> >>> >>>>>>> If so, is there a repo I can pull them?
> >>> >>>>>>
> >>> >>>>>> I added it in the cover letter but anyway here it is:
> >>> >>>>>>
> >>> >>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git pci/pci-fixup-irqs-removal-v2
> >>> >>>>>
> >>> >>>>> Hi Lorenzo,
> >>> >>>>>
> >>> >>>>> I picked up your changes, and tested on iproc based SOC,
> >>> >>>>> and ran basic fio data transfer.. and it looks okay.
> >>> >>>>
> >>> >>>> Thank you. If you could also check it is all OK from a legacy
> >>> >>>> IRQ allocation (ie same as before applying series) I'd be grateful.
> >>> >>>>
> >>> >>>
> >>> >>> I disabled msi and it should default to legacy IRQ, looks like there
> >>> >>> is a problem, if I missed any change !
> >>> >>>
> >>> >>> before applying series:  cat /proc/interrupts
> >>> >>> 377:        168          0          0          0          0          0
> >>> >>>          0          0     dummy   1 Edge      nvme0q0, nvme0q1
> >>> >>>
> >>> >>> after applying series:
> >>> >>> root@bcm958742k:~# dmesg | grep nvme
> >>> >>> [    3.855466] nvme 0000:01:00.0: assign irq: got 0
> >>> >>> [    3.855469] nvme 0000:01:00.0: assigning IRQ 00
> >>> >>> [    3.855515] nvme nvme0: pci function 0000:01:00.0
> >>> >>> [    4.270850] nvme 0000:01:00.0: enabling device (0000 -> 0002)
> >>> >>> [    4.276787] nvme 0000:01:00.0: enabling bus mastering
> >>> >>> [    4.276817] nvme nvme0: Removing after probe failure status: -22
> >>> >>>
> >>> >>> here is my git status of your series, let me know if I am missing any
> >>> >>> change with respect to legacy IRQ ?
> >>> >>>
> >>> >>>  modified:   arch/arm/include/asm/mach/pci.h
> >>> >>>         modified:   arch/arm/kernel/bios32.c
> >>> >>>         modified:   arch/arm/mach-dove/pcie.c
> >>> >>>         modified:   arch/arm/mach-iop13xx/pci.c
> >>> >>>         modified:   arch/arm/mach-iop13xx/pci.h
> >>> >>>         modified:   arch/arm/mach-mv78xx0/pcie.c
> >>> >>>         modified:   arch/arm/mach-orion5x/common.h
> >>> >>>         modified:   arch/arm/mach-orion5x/pci.c
> >>> >>>         modified:   arch/arm64/kernel/pci.c
> >>> >>>         modified:   drivers/of/of_pci_irq.c
> >>> >>>         modified:   drivers/pci/Makefile
> >>> >>>         modified:   drivers/pci/host/pci-aardvark.c
> >>> >>>         modified:   drivers/pci/host/pci-ftpci100.c
> >>> >>>         modified:   drivers/pci/host/pci-host-common.c
> >>> >>>         modified:   drivers/pci/host/pci-tegra.c
> >>> >>>         modified:   drivers/pci/host/pci-versatile.c
> >>> >>>         modified:   drivers/pci/host/pci-xgene.c
> >>> >>>         modified:   drivers/pci/host/pcie-altera.c
> >>> >>>         modified:   drivers/pci/host/pcie-iproc-bcma.c
> >>> >>>         modified:   drivers/pci/host/pcie-iproc-platform.c
> >>> >>>         modified:   drivers/pci/host/pcie-iproc.c
> >>> >>>         modified:   drivers/pci/host/pcie-iproc.h
> >>> >>>         modified:   drivers/pci/host/pcie-rcar.c
> >>> >>>         modified:   drivers/pci/host/pcie-rockchip.c
> >>> >>>         modified:   drivers/pci/host/pcie-xilinx-nwl.c
> >>> >>>         modified:   drivers/pci/host/pcie-xilinx.c
> >>> >>>         modified:   drivers/pci/pci-driver.c
> >>> >>>         modified:   drivers/pci/probe.c
> >>> >>>         modified:   drivers/pci/setup-irq.c
> >>> >>>         modified:   include/linux/pci.h
> >>> >>>
> >>> >>
> >>> >> Did you test with or without my change in bcm/master to emulate legacy
> >>> >> interrupt through dummy IRQ domain?
> >>> >>
> >>> >> Thanks,
> >>> >>
> >>> >> Ray
> >>> >>
> >>> >>
> >>> >
> >>> > Hi Ray,
> >>> > yes irqdomain was missing, and with that legacy IRQ are fine now.
> >>> > please mainline those changes.
> >>> >
> >>> > Hi Lorenzo,
> >>> >
> >>> > Legacy IRQ is working fine as well wiht your patches.
> >>> >
> >>> > cat /proc/interrupts
> >>> > 122:        160          0          0          0          0          0
> >>> >          0          0     dummy   1 Edge      nvme0q0, nvme0q1
> >>> >
> >>> > NVMe data transfer is also fine.
> >>> >
> >>> > Regards,
> >>> > Oza.
> >>> >
> >>>
> >>> Okay, so I take this as Lorenzo's changes on iProc PCIe driver have been
> >>> sanity tested for link detection and legacy interrupt support. No
> >>> regression is seen. Thanks, Oza.
> >>
> >> Yes, that's how I take it too, I did not understand what was triggering
> >> the first regression reported - my series should work on top of mainline
> >> if the current code works and should not depend on any other patch
> >> being merged - please make sure that's the case to prevent unwanted
> >> regressions in case other patches do not make it into the mainline.
> >>
> >> Thank you very much for your help in testing it.
> >
> >
> > Hi Lorenzo,
> >
> > I have ported and tested my inbound memory patches on top of your
> > patches and that work fine as well.
> > This is mainly to do with IOVA reservations.
> >
> > Regards,
> > Oza.
> >
> >>
> >> Lorenzo
> >>
> >>>
> >>> I'll send out the INTx irqdomain support patch when I have time.
> >>>
> >>> Ray
> >>>
> >>>
> >>>
> >>>
> 
> Hi Bjorn,
> 
> I have made v8 for inbound memory patches as you suggested, on top of
> Lorenzo's patches.
> but I can not post them since Lorenzo's patches have not made in.

It depends on what kernel you are pulling. If you pulled v4.13-rc1
this series would be there.

Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
