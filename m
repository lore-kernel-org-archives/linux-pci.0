Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:4127 "EHLO
        lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbcKIMLq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2016 07:11:46 -0500
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Yuanzhichang <yuanzhichang@hisilicon.com>
CC: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "minyard@acm.org" <minyard@acm.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
        "zourongrong@gmail.com" <zourongrong@gmail.com>,
        John Garry <john.garry@huawei.com>,
        "zhichang.yuan02@gmail.com" <zhichang.yuan02@gmail.com>,
        "kantyzc@163.com" <kantyzc@163.com>,
        "xuwei (O)" <xuwei5@hisilicon.com>
Subject: RE: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
Date: Wed, 9 Nov 2016 12:10:43 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F8F1A7A@lhreml507-mbx>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-4-git-send-email-yuanzhichang@hisilicon.com>
 <1555494.4IFvGxvsfe@wuerfel>
In-Reply-To: <1555494.4IFvGxvsfe@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: 08 November 2016 16:25
> To: Yuanzhichang
> Cc: catalin.marinas@arm.com; will.deacon@arm.com; robh+dt@kernel.org;
> bhelgaas@google.com; mark.rutland@arm.com; olof@lixom.net; linux-arm-
> kernel@lists.infradead.org; lorenzo.pieralisi@arm.com; linux-
> kernel@vger.kernel.org; Linuxarm; devicetree@vger.kernel.org; linux-
> pci@vger.kernel.org; linux-serial@vger.kernel.org; minyard@acm.org;
> benh@kernel.crashing.org; liviu.dudau@arm.com; zourongrong@gmail.com;
> John Garry; Gabriele Paoloni; zhichang.yuan02@gmail.com;
> kantyzc@163.com; xuwei (O)
> Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on
> Hip06
> 
> On Tuesday, November 8, 2016 11:47:09 AM CET zhichang.yuan wrote:
> > +       /*
> > +        * The first PCIBIOS_MIN_IO is reserved specifically for
> indirectIO.
> > +        * It will separate indirectIO range from pci host bridge to
> > +        * avoid the possible PIO conflict.
> > +        * Set the indirectIO range directly here.
> > +        */
> > +       lpcdev->io_ops.start = 0;
> > +       lpcdev->io_ops.end = PCIBIOS_MIN_IO - 1;
> > +       lpcdev->io_ops.devpara = lpcdev;
> > +       lpcdev->io_ops.pfin = hisilpc_comm_in;
> > +       lpcdev->io_ops.pfout = hisilpc_comm_out;
> > +       lpcdev->io_ops.pfins = hisilpc_comm_ins;
> > +       lpcdev->io_ops.pfouts = hisilpc_comm_outs;
> 
> I have to look at patch 2 in more detail again, after missing a few
> review
> rounds. I'm still a bit skeptical about hardcoding a logical I/O port
> range here, and would hope that we can just go through the same
> assignment of logical port ranges that we have for PCI buses,
> decoupling
> the bus addresses from the linux-internal ones.

The point here is that we want to avoid any conflict/overlap between
the LPC I/O space and the PCI I/O space. With the assignment above
we make sure that LPC never interfere with PCI I/O space.

Thanks

Gab

> 
> 	Arnd
