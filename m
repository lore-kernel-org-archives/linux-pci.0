Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35170 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S947365AbcJaWEU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2016 18:04:20 -0400
MIME-Version: 1.0
In-Reply-To: <18db27c7-1055-ff3c-0b0b-eeeaf5f3f5e0@gmail.com>
References: <20161029111229.26875-1-zajec5@gmail.com> <a491509e-5cfc-fc7d-0011-dfcab3c884ea@broadcom.com>
 <6e252703-0010-83ae-fa14-57352add007a@hauke-m.de> <fb2c36cb-6f85-1a6d-160a-c50e22d6c46b@gmail.com>
 <dcb21fe4-672f-4545-5b47-d764f390e741@broadcom.com> <18db27c7-1055-ff3c-0b0b-eeeaf5f3f5e0@gmail.com>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date: Mon, 31 Oct 2016 23:04:18 +0100
Message-ID: <CACna6rxZHY53Tj0yr_TtNAEmibq=3=Ea7DexqDFiSiY_NXJebg@mail.gmail.com>
Subject: Re: [PATCH] ARM: BCM5301X: Add back handler ignoring external
 imprecise aborts
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Scott Branden <scott.branden@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jon Mason <jonmason@broadcom.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 31 October 2016 at 22:56, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 10/31/2016 02:46 PM, Scott Branden wrote:
>> A problem with reintroducing this change is that all imprecise data
>> aborts are ignored, not just PCI.  So if you don't actually use PCI in
>> your system and want to debug other aborts you are unable to.  I don't
>> know if we care about such situation.
>
> Considering that any abort is pretty much fatal, the options are:
>
> - update the freaking bootloader to a version where there are no such
> aborts generated, not an option on consumer devices, unclear which
> version (if any) fixes that
>
> - fixups the aborts externally, via a boot wrapper, which is going to
> take some time to develop, causes additional burden on the distributors
> to provide instructions/build images on how to do it

In practice updating bootloader is not possible (as you noticed) but I
don't think it's even possible to fix this problem at bootloader /
extra loader level. If this was a matter of hardware setup, we could
handle it in kernel as well I believe. Ray actually verified it's
controller limitation on Northstar platform.
It sounds a bit like you're thinking about MMU and Dcache Northstar
problem when writing that e-mail.


> - fixups the aborts in the kernel, irrespective of where they come from,
> simple and easy
>
> - fixups the aborts in the kernel, look where they come from, by using
> some bit of magic, looking at PCIe registers and whatnot (provided that
> is even possible), not too hard, but can take a while, and is error prone
>
> I can certainly advocate that option 3 is the one that gives a working
> device, and this is what matters from a distribution perspective like
> LEDE/OpenWrt.

--=20
Rafa=C5=82
