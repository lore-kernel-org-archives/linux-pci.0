Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:32844 "EHLO
        lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbcKNLMO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2016 06:12:14 -0500
Date: Mon, 14 Nov 2016 11:11:11 +0000
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
        "zhichang.yuan" <yuanzhichang@hisilicon.com>,
        catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        bhelgaas@google.com, olof@lixom.net,
        linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-serial@vger.kernel.org, minyard@acm.org,
        benh@kernel.crashing.org, liviu.dudau@arm.com,
        zourongrong@gmail.com, john.garry@huawei.com,
        gabriele.paoloni@huawei.com, zhichang.yuan02@gmail.com,
        kantyzc@163.com, xuwei5@hisilicon.com, marc.zyngier@arm.com
Subject: Re: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for
 special ISA
Message-ID: <20161114111111.1b753dc3@lxorguk.ukuu.org.uk>
In-Reply-To: <5900275.i4NZvtxTcC@wuerfel>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
        <2368890.jTbyGqYR0M@wuerfel>
        <20161109135453.2e5402bd@lxorguk.ukuu.org.uk>
        <5900275.i4NZvtxTcC@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > It's not a safe assumption for x86 at least. There are a few systems with
> > multiple ISA busses particularly older laptops with a docking station.  
> 
> But do they have multiple ISA domains? There is no real harm in supporting
> it, the (small) downsides I can think of are:

I don't believe they x86 class ones have multiple ISA domains. But as
I've said I don't know how the electronics in the older ThinkPad worked
when it used two PIIX4s with some LPC or ISA stuff on each.

It works in DOS and unmodified Linux so I'm pretty sure there are no
additional domains. Likewise the various x86 schemes that route some bits
of ISA bus off into strange places work in DOS and don't have any
overlaps.

yenta_socket handles PCI/PCMCIA bridging and routes a range of that flat
ISA space appropriately to the card.

Alan
