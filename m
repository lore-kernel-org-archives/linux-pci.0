Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:56488 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbaA2JRo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jan 2014 04:17:44 -0500
Received: by mail-lb0-f180.google.com with SMTP id n15so1259441lbi.11
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2014 01:17:41 -0800 (PST)
Message-ID: <52E8C733.30305@cogentembedded.com>
Date: Wed, 29 Jan 2014 13:17:39 +0400
From: Valentine <valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
To: Ben Dooks <ben.dooks@codethink.co.uk>
CC: linux-kernel@lists.codethink.co.uk, linux-sh@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: rcar: fix bridge logic configuration accesses
References: <1390903616-8073-1-git-send-email-ben.dooks@codethink.co.uk> <1390903616-8073-4-git-send-email-ben.dooks@codethink.co.uk> <52E807E9.8060900@cogentembedded.com> <52E8C622.5030603@codethink.co.uk>
In-Reply-To: <52E8C622.5030603@codethink.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/29/2014 01:13 PM, Ben Dooks wrote:
> On 28/01/14 19:41, Valentine wrote:
>> On 01/28/2014 02:06 PM, Ben Dooks wrote:
>>> The bridge logic at slot 0 only supports reads up to 0x40 and the
>>> rest of the PCI configuration space for this slot is marked as
>>> reserved in the manual.
>>>
>>> Trying a read from offset 0x100 is producing an error from the
>>> bridge. With error interrupts enabled, the following is printed:
>>
>> I don't think this is a critical error.
>> The bridge works fine after an attempt to access the unsupported
>> PCIe/PCI-X 2 area.
>>
>> If you want to prevent the access, I'm OK with it.
>> But I think it's better to do "if (where <= 0x100)"
>> and drop the slot check since all other slots do not support
>> access beyond 0x100 as well.
>
> The bridge specifically says that the registers end at 0x40 so
> that really should stay.

AFAIU, nothing is going to access the area beyond 0x40 if the device does not
expose any PCI capabilities. Otherwise we would probably need to fix the
generic PCI subsytem driver.

>
> We're seeing external aborts being generated from somewhere, and
> it seems that either the bridge or the USB drivers are responsible
> for generating them.

How often do you see them?
Do you see them if you use the approach I've proposed?

>
>> The PCI code attempts to access beyond 0x100 only once when probing PCI
>> bridges
>> to see if they support PCIe/PCI-X 2 area which is 4K.
>> The area beyond 0x40 is never accessed because the bridge does not
>> expose any PCI capabilities.
>>
>>>
>>> pci-rcar-gen2 ee0d0000.pci: error irq: status 00000014
>>
>> Did you experience any problems other than this message
>> printed by the IRQ handler introduced by the previous patch?
>>
>
>

Thanks,
Val.
