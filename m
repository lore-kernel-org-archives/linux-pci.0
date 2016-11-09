Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
CC: Mark Rutland <mark.rutland@arm.com>,
        Yuanzhichang <yuanzhichang@hisilicon.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
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
        "xuwei (O)" <xuwei5@hisilicon.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>
Subject: RE: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for
 special ISA
Date: Wed, 9 Nov 2016 14:51:01 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F8F229A@lhreml507-mbx>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
        <1478576829-112707-3-git-send-email-yuanzhichang@hisilicon.com>
        <20161108114953.GB15297@leverpostej>    <2368890.jTbyGqYR0M@wuerfel>
 <20161109135453.2e5402bd@lxorguk.ukuu.org.uk>
In-Reply-To: <20161109135453.2e5402bd@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: One Thousand Gnomes [mailto:gnomes@lxorguk.ukuu.org.uk]
> Sent: 09 November 2016 13:55
> To: Arnd Bergmann
> Cc: Mark Rutland; Yuanzhichang; catalin.marinas@arm.com;
> will.deacon@arm.com; robh+dt@kernel.org; bhelgaas@google.com;
> olof@lixom.net; linux-arm-kernel@lists.infradead.org;
> lorenzo.pieralisi@arm.com; linux-kernel@vger.kernel.org; Linuxarm;
> devicetree@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> serial@vger.kernel.org; minyard@acm.org; benh@kernel.crashing.org;
> liviu.dudau@arm.com; zourongrong@gmail.com; John Garry; Gabriele
> Paoloni; zhichang.yuan02@gmail.com; kantyzc@163.com; xuwei (O);
> marc.zyngier@arm.com
> Subject: Re: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for
> special ISA
> 
> > I think it is a relatively safe assumption that there is only one
> > ISA bridge. A lot of old drivers hardcode PIO or memory addresses
> 
> It's not a safe assumption for x86 at least. There are a few systems
> with
> multiple ISA busses particularly older laptops with a docking station.

Mmmm right...now the point is that this kind of special devices appearing
as a special ISA bus will probably never appear on x86 platforms (I guess).

So maybe it is a safe assumption because of this...?

Thanks

Gab

> 
> > when talking to an ISA device, so having multiple instances is
> > already problematic.
> 
> PCMCIA devices handle it themselves so are ok. I'm not clear how the
> dual
> PIIX4 configuration used in the older IBM laptop docks actually worked
> so
> I assume the transaction went out of both bridges and providing one of
> them responded the other kept silent as you simply stuffed the card
> into
> the dock and it worked.
> 
> Alan
