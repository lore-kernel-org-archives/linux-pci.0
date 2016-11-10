Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: "zhichang.yuan" <yuanzhichang@hisilicon.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "minyard@acm.org" <minyard@acm.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        John Garry <john.garry@huawei.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuwei (O)" <xuwei5@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
        "zourongrong@gmail.com" <zourongrong@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kantyzc@163.com" <kantyzc@163.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "zhichang.yuan02@gmail.com" <zhichang.yuan02@gmail.com>
Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
Date: Thu, 10 Nov 2016 10:12:21 +0100
Message-ID: <17821285.aIcTyCGn5n@wuerfel>
In-Reply-To: <5824165A.4040303@hisilicon.com>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com> <2825537.ADCNsGqGxn@wuerfel> <5824165A.4040303@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, November 10, 2016 2:40:26 PM CET zhichang.yuan wrote:
> On 2016/11/10 5:34, Arnd Bergmann wrote:
> > On Wednesday, November 9, 2016 12:10:43 PM CET Gabriele Paoloni wrote:
> >>> On Tuesday, November 8, 2016 11:47:09 AM CET zhichang.yuan wrote:
> >>>> +       /*
> >>>> +        * The first PCIBIOS_MIN_IO is reserved specifically for
> >>> indirectIO.
> >>>> +        * It will separate indirectIO range from pci host bridge to
> >>>> +        * avoid the possible PIO conflict.
> >>>> +        * Set the indirectIO range directly here.
> >>>> +        */
> >>>> +       lpcdev->io_ops.start = 0;
> >>>> +       lpcdev->io_ops.end = PCIBIOS_MIN_IO - 1;
> >>>> +       lpcdev->io_ops.devpara = lpcdev;
> >>>> +       lpcdev->io_ops.pfin = hisilpc_comm_in;
> >>>> +       lpcdev->io_ops.pfout = hisilpc_comm_out;
> >>>> +       lpcdev->io_ops.pfins = hisilpc_comm_ins;
> >>>> +       lpcdev->io_ops.pfouts = hisilpc_comm_outs;
> >>>
> >>> I have to look at patch 2 in more detail again, after missing a few
> >>> review
> >>> rounds. I'm still a bit skeptical about hardcoding a logical I/O port
> >>> range here, and would hope that we can just go through the same
> >>> assignment of logical port ranges that we have for PCI buses,
> >>> decoupling
> >>> the bus addresses from the linux-internal ones.
> >>
> >> The point here is that we want to avoid any conflict/overlap between
> >> the LPC I/O space and the PCI I/O space. With the assignment above
> >> we make sure that LPC never interfere with PCI I/O space.
> > 
> > But we already abstract the PCI I/O space using dynamic registration.
> > There is no need to hardcode the logical address for ISA, though
> > I think we can hardcode the bus address to start at zero here.
> 
> Do you means that we can pick up the maximal I/O address from all children's
> device resources??

The driver should not look at the resources of its children, just
register a range of addresses dynamically, as I suggested in an
earlier review.


Your current version has

        if (arm64_extio_ops->pfout)                             \
                arm64_extio_ops->pfout(arm64_extio_ops->devpara,\
                       addr, value, sizeof(type));             \

Instead, just subtract the start of the range from the logical
port number to transform it back into a bus-local port number:

        if (arm64_extio_ops->pfout)                             \
                arm64_extio_ops->pfout(arm64_extio_ops->devpara,\
                       addr - arm64_extio_ops->start, value, sizeof(type)); \

We know that the ISA/LPC bus can only have up to 65536 ports,
so you can register all of those, or possibly limit it further to
1024 or 4096 ports, whichever matches the bus implementation.

	Arnd
