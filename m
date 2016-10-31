Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33521 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S947311AbcJaV44 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2016 17:56:56 -0400
Subject: Re: [PATCH] ARM: BCM5301X: Add back handler ignoring external
 imprecise aborts
To: Scott Branden <scott.branden@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20161029111229.26875-1-zajec5@gmail.com>
 <a491509e-5cfc-fc7d-0011-dfcab3c884ea@broadcom.com>
 <6e252703-0010-83ae-fa14-57352add007a@hauke-m.de>
 <fb2c36cb-6f85-1a6d-160a-c50e22d6c46b@gmail.com>
 <dcb21fe4-672f-4545-5b47-d764f390e741@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jon Mason <jonmason@broadcom.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <18db27c7-1055-ff3c-0b0b-eeeaf5f3f5e0@gmail.com>
Date: Mon, 31 Oct 2016 14:56:51 -0700
MIME-Version: 1.0
In-Reply-To: <dcb21fe4-672f-4545-5b47-d764f390e741@broadcom.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/31/2016 02:46 PM, Scott Branden wrote:
> 
> 
> On 16-10-31 02:01 PM, Florian Fainelli wrote:
>> On 10/31/2016 01:59 PM, Hauke Mehrtens wrote:
>>>
>>>
>>> On 10/31/2016 07:08 PM, Scott Branden wrote:
>>>> Hi Rafal,
>>>>
>>>>
>>>> On 16-10-29 04:12 AM, Rafał Miłecki wrote:
>>>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>>>
>>>>> Since early BCM5301X days we got abort handler that was removed by
>>>>> commit 937b12306ea79 ("ARM: BCM5301X: remove workaround imprecise
>>>>> abort
>>>>> fault handler"). It assumed we need to deal only with pending aborts
>>>>> left by the bootloader. Unfortunately this isn't true for BCM5301X.
>>>>>
>>>>> When probing PCI config space (device enumeration) it is expected to
>>>>> have master aborts on the PCI bus. Most bridges don't forward (or they
>>>>> allow disabling it) these errors onto the AXI/AMBA bus but not the
>>>>> Northstar (BCM5301X) one.
>>>> Should we only add this workaround code if CONFIG_PCI is on then?
>>>
>>> I think all the supported northstar devices have a PCIe controller. We
>>> could add such a CONFIG_PCI check, but I do not see a big advantage.
>>
>> Actually, I do see a couple disadvantages if we gate this with
>> CONFIG_PCI: if this problem shows up irrespective of your kernel
>> configuration, you want the error handler to clear it, not rely on
>> CONFIG_PCI to be enabled for the error to go away and also, without an
>> additional ifdef, additional compiler coverage.
>>
> A problem with reintroducing this change is that all imprecise data
> aborts are ignored, not just PCI.  So if you don't actually use PCI in
> your system and want to debug other aborts you are unable to.  I don't
> know if we care about such situation.

Considering that any abort is pretty much fatal, the options are:

- update the freaking bootloader to a version where there are no such
aborts generated, not an option on consumer devices, unclear which
version (if any) fixes that

- fixups the aborts externally, via a boot wrapper, which is going to
take some time to develop, causes additional burden on the distributors
to provide instructions/build images on how to do it

- fixups the aborts in the kernel, irrespective of where they come from,
simple and easy

- fixups the aborts in the kernel, look where they come from, by using
some bit of magic, looking at PCIe registers and whatnot (provided that
is even possible), not too hard, but can take a while, and is error prone

I can certainly advocate that option 3 is the one that gives a working
device, and this is what matters from a distribution perspective like
LEDE/OpenWrt.
-- 
Florian
