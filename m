Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:60643 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934027AbcIOIXV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Sep 2016 04:23:21 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Yuanzhichang <yuanzhichang@hisilicon.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "minyard@acm.org" <minyard@acm.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        John Garry <john.garry@huawei.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuwei (O)" <xuwei5@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "zourongrong@gmail.com" <zourongrong@gmail.com>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
        "kantyzc@163.com" <kantyzc@163.com>,
        "zhichang.yuan02@gmail.com" <zhichang.yuan02@gmail.com>
Subject: Re: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
Date: Thu, 15 Sep 2016 10:22:23 +0200
Message-ID: <8360154.kzsE8V8pTW@wuerfel>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F871B01@lhreml507-mbx>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com> <5869118.UilSPY9Sai@wuerfel> <EE11001F9E5DDD47B7634E2F8A612F2E1F871B01@lhreml507-mbx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, September 15, 2016 8:02:27 AM CEST Gabriele Paoloni wrote:
> 
> From <<3.1.1. Open Firmware Properties for Bus Nodes>> in 
> http://www.firmware.org/1275/bindings/isa/isa0_4d.ps
> 
> I quote:
> "There shall be an entry in the "ranges" property for each
> of the Memory and/or I/O spaces if that address space is
> mapped through the bridge."
> 
> It seems to me that it is ok to have 1:1 address mapping and that
> therefore of_translate_address() should fail if "ranges" is not
> present.

The key here is the definition of "mapped through the bridge".
I can only understand this as "directly mapped", i.e. an I/O
port of the child bus corresponds directly to a memory address
on the parent bus, but this is not the case here.

The problem with adding the mapping here is that it looks
like it should be valid to create a page table entry for
the address returned from the translation and access it through
a pointer dereference, but that is clearly not possible.

> This is also explained quite well in
> http://lxr.free-electrons.com/source/drivers/of/address.c#L490
> 
> what do you think?

This is a separate issue, and only relevant for Apple Macintosh
machines as well as the PA-Semi sdc.

	Arnd
