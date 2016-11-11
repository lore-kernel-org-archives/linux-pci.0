Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752576AbcKKKs7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Nov 2016 05:48:59 -0500
Date: Fri, 11 Nov 2016 10:48:57 +0000
From: "liviu.dudau@arm.com" <liviu.dudau@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Yuanzhichang <yuanzhichang@hisilicon.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
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
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "zhichang.yuan02@gmail.com" <zhichang.yuan02@gmail.com>
Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
Message-ID: <20161111104857.GI10219@e106497-lin.cambridge.arm.com>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <17821285.aIcTyCGn5n@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F8F5D75@lhreml507-mbx>
 <10334260.ztLXZ2Oynd@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <10334260.ztLXZ2Oynd@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On Thu, Nov 10, 2016 at 05:07:21PM +0100, Arnd Bergmann wrote:
> On Thursday, November 10, 2016 3:36:49 PM CET Gabriele Paoloni wrote:
> > 
> > Where should we get the range from? For LPC we know that it is going
> > Work on anything that is not used by PCI I/O space, and this is 
> > why we use [0, PCIBIOS_MIN_IO]
> 
> It should be allocated the same way we allocate PCI config space
> segments. This is currently done with the io_range list in
> drivers/pci/pci.c, which isn't perfect but could be extended
> if necessary. Based on what others commented here, I'd rather
> make the differences between ISA/LPC and PCI I/O ranges smaller
> than larger.
> 
> > > Your current version has
> > > 
> > >         if (arm64_extio_ops->pfout)                             \
> > >                 arm64_extio_ops->pfout(arm64_extio_ops->devpara,\
> > >                        addr, value, sizeof(type));             \
> > > 
> > > Instead, just subtract the start of the range from the logical
> > > port number to transform it back into a bus-local port number:
> > 
> > These accessors do not operate on IO tokens:
> > 
> > If (arm64_extio_ops->start > addr || arm64_extio_ops->end < addr)
> > addr is not going to be an I/O token; in fact patch 2/3 imposes that
> > the I/O tokens will start at PCIBIOS_MIN_IO. So from 0 to PCIBIOS_MIN_IO
> > we have free physical addresses that the accessors can operate on.
> 
> Ah, I missed that part. I'd rather not use PCIBIOS_MIN_IO to refer to
> the logical I/O tokens, the purpose of that macro is really meant
> for allocating PCI I/O port numbers within the address space of
> one bus.
> 
> Note that it's equally likely that whichever next platform needs
> non-mapped I/O access like this actually needs them for PCI I/O space,
> and that will use it on addresses registered to a PCI host bridge.
> 
> If we separate the two steps:
> 
> a) assign a range of logical I/O port numbers to a bus

Except that currently when we add ranges to io_range_list we don't have
a bus number yet, because the parsing happens before the host bridge
has been created. Maybe register_io_range() can take a bus number as an
argument, but I'm not sure how we are going to use that in pci_pio_to_address()
or pci_address_to_pio().

Best regards,
Liviu

> b) register a set of helpers for redirecting logical I/O
>    port to a helper function
> 
> then I think the code will get cleaner and more flexible.
> It should actually then be able to replace the powerpc
> specific implementation.
> 
> 	Arnd

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
