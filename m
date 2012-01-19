Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from server1.meinberg.de ([85.10.202.66]:38483 "EHLO
	server1.meinberg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768Ab2ASLea (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2012 06:34:30 -0500
Message-ID: <4F17FFC1.9020502@meinberg.de>
Date: Thu, 19 Jan 2012 12:34:25 +0100
From: Martin Burnicki <martin.burnicki@meinberg.de>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org
Subject: Re: PCI card not accessible; I/O ports at <ignored>
References: <4F16EA07.4000607@meinberg.de> <CAErSpo6Ei=XgWTXp6f=UgY90QA78fSVMaJ8Gf7NvF5fMiPX12w@mail.gmail.com>
In-Reply-To: <CAErSpo6Ei=XgWTXp6f=UgY90QA78fSVMaJ8Gf7NvF5fMiPX12w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas schrieb:
> On Wed, Jan 18, 2012 at 8:49 AM, Martin Burnicki
> <martin.burnicki@meinberg.de>  wrote:
>> Hi folks,
>>
>> I'm maintaining the driver software for the PCI cards manufactured by our
>> company, Meinberg Funkuhren in Germany. Basically our Linux driver supports
>> all our PCI cards on all Linux kernels 2.6.x and 3.x. The PCI cards are e.g.
>> GPS receivers, radio clocks, or IRIG time code receivers.
>>
>> Recently I've run into a problem with our PCI Express cards in a certain
>> server PC: There are 8 PCI Express slots on the mainboard, and in some of
>> the slots the cards work properly, but in some other slots on the same
>> machine they don't work since the cards are not accessible by the kernel
>> driver.
>>
>> In cases where the cards are not accessible lspci -v reports
>> for the I/O base address 0:
>>
>>   Region 0: I/O ports at<ignored>
>
>  From the lspci source (http://mj.ucw.cz/sw/pciutils/), it looks like
> this happens when the BAR contains zero.

This must be the BAR value saved inside the kernel's device structure. 
The confguration space dump of lspci -x shows that even in this case a 
usual I/O address has been assigned to BAR0 on the card.

>> Finally I tried different Linux distributions with different kernel versions
>> and found that the same card in the same slot with the same driver works
>> properly under kernel 2.6.32 and earlier, but doesn't work anymore under
>> kernel 2.6.36 and later, including kernel 3.1.4. So there must have been
>> some code changes in the newer kernel versions which prevent the card from
>> being accessed via I/O, and let lspci say "I/O ports at<ignored>".
>
> Please open a bug report at http://bugzilla.kernel.org, category
> Drivers/PCI, mark it as a regression, add me to the CC: list, and
> attach complete dmesg logs from 2.6.32 and 3.1.4 with the card in the
> slot that no longer works.

Done:
https://bugzilla.kernel.org/show_bug.cgi?id=42606

Thanks again!


Martin
-- 
Martin Burnicki

Meinberg Funkuhren
Bad Pyrmont
Germany
