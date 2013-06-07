Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:58916 "EHLO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333Ab3FGPzi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jun 2013 11:55:38 -0400
Message-ID: <51B20278.8090808@fold.natur.cuni.cz>
Date: Fri, 07 Jun 2013 17:55:36 +0200
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Yinghai Lu <yinghai@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: 3.8.2: stale pci device info for a previously inserted express
 card
References: <513E002C.40805@fold.natur.cuni.cz> <CAErSpo5594KNtZz9Gpdw_j5NZX_sGpzKB9CT2-SCB2bCASfrSQ@mail.gmail.com> <51B1C1F3.3070804@fold.natur.cuni.cz> <51B1C3B6.30809@fold.natur.cuni.cz>
In-Reply-To: <51B1C3B6.30809@fold.natur.cuni.cz>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



Martin Mokrejs wrote:
> Martin Mokrejs wrote:
>> Hi everybody,
>>
>> Bjorn Helgaas wrote:
>>> [+cc linux-pci, Sarah, Alan]
>>>
>>> On Mon, Mar 11, 2013 at 10:02 AM, Martin Mokrejs
>>> <mmokrejs@fold.natur.cuni.cz> wrote:
>>>> [re-sending to you all three directly, looks the original email did not make it into linux-pci
>>>> through some filters]
>>>>
>>>>   I use for my daily work acpiphp to manage express cards in Dell Vostro 3550.
>>>> I have never seen something like this before and believe this is some new regression
>>>> in 3.8 series. I had in teh a USB3 card and ejected it. Then I inserted a
>>>> SATA Sil3132 card but it is not detected and dmesg still ends with last lines
>>>> added when the USB card was being removed. The funny thing is that lspci reports
>>>> a mixture of USB-card properties with NEC chips along with Silicon Image eSATA card.
>>>
>>> I don't know anything about the kmemleaks mentioned elsewhere in this
>>> thread, but the idea of "stale PCI device info" seems possibly related
>>> to some acpiphp issues we've been working on recently.
>>>
>>> Starting with v3.9, we don't handle ACPI Bus Check notifications to
>>> host bridges correctly, and the result is that when we're using
>>> acpiphp, we don't notice when PCI devices are added or removed. There
>>> are more details in https://bugzilla.kernel.org/show_bug.cgi?id=57961
>>
>> Looks to me it is already in 3.10-rc4 which I tested now. No, I still do see
>> same problem like before: a hotremoval of NEC-based xHCI express card is detected
>> on every second eject. But, sometimes it seems it is only delayed by some 25-30
>> seconds. Would have to do more testing. However, there are some *new* kmemleaks
>> reported by kernel related to acpiphpp bu xhci_hcd. That could a hint why
>> the hotremoval sometimes proceeds delayed but sometimes maybe not at all or at
>> least not *immediately* like for any other device?
>>
>> However, the stale sysfs entries for partially removed device SiI3132 (sata_sil24
>> driver) are NOT appearing anymore, good. That used to be associated with
>> 'sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?' line.
>> Now, I see under 3.10-rc4 the extra message about 'ACPI: Device does not support D3cold'.
>> would be nice if it said what device is it talking about? About upstream root port
>> or about my end device (express card)? Is it related by pcie_aspm= kernel
>> commandline option? If yes, please include the relevant info the message text.
>> referring to this being affected by the particular value. At the moment I used:
>> pcie_aspm=off
>>
>> --- dmesg_initial__inserted_eSATA__ejected__inserted__ejected__inserted.txt     2013-06-07 02:53:56.000000000 +0200
>> +++ dmesg_initial__inserted_eSATA__ejected__inserted__ejected__inserted__ejected.txt    2013-06-07 02:54:09.000000000 +0200
>> @@ -1439,3 +1439,5 @@
>>  [  254.317365] ata12: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c02000 irq 19
>>  [  256.400454] ata11: SATA link down (SStatus 0 SControl 0)
>>  [  258.493027] ata12: SATA link down (SStatus 0 SControl 0)
>> +[  267.116723] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
>> +[  267.117779] ACPI: Device does not support D3cold
>>
>>
>> So, in my eyes the "stale pci info" issue is fixed in 3.10-rc4 at least under acpiphp and pcie_aspm=off.

No, it is not. :(

> 
> And to be even more exact, I had CONFIG_HOTPLUG_PCI_ACPI=y as I see now an updated
> v2 patch from Yinghai:
> [PATCH v3.9 stable] PCI: acpiphp: Re-enumerate devices when host bridge receives Bus Check
> 
> Please make sure that whatever I tested in plain 3.10-rc4 is what you had in those bugzilla patches
> under https://bugzilla.kernel.org/show_bug.cgi?id=57961 or what Yinghai posted as an update.
> Just in case are tested a different version.


Sorry, I was "able" to plugin a firewire card into express card slot faster
than xhci_hcd released resource of the to be yet hotremoved NEC-based xHCI
card. So, like in older kernels, lspci reports chimeric entry 11:00 of the
NEC card and of the VIA-based firewire card. Upon eject of the VIA card
xhci_hcd released resources with usual messages, including the complaint
that 'xhci_hcd 0000:11:00.0: Host not halted after 16000 microseconds.'
Nothing new in dmesg, I would just say that whatever makes xhci_hcd or pcieport
slow in turning PME# to disabled is efectively blocked if I plugin some card back
into the express slot. It seems to me the "conclusion" in the past in Jan-April
was that pcieport is to blame and not xhci_hcd, and it always seemed to proceed
smoothly once 'PME# disabled' appeared in dmesg.



> 
> Martin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
