Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:56125 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932304Ab3CLJ5e (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Mar 2013 05:57:34 -0400
Message-ID: <513EFC08.7040904@fold.natur.cuni.cz>
Date: Tue, 12 Mar 2013 10:57:28 +0100
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Yijing Wang <wangyijing@huawei.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>
Subject: Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI
References: <513E7E1E.80508@fold.natur.cuni.cz> <513E983E.6050400@huawei.com>
In-Reply-To: <513E983E.6050400@huawei.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Yijing Wang wrote:
> On 2013/3/12 9:00, Martin Mokrejs wrote:
>> Hi,
>>   I cold-booted a computer with the card inserted before power-on and collected
>> lspci output and express card slot status every second. Then I tried eject and
>> hotplug inserts and it appearts the card is not detected, actually maybe pciehp
>> is not even suppoosed to work in this case as the slot was occupied during boot.
>> But let me come to it later.
>>
>> I noted the following on the very first eject of the so far cold-plugged card
>> that lspci properly reports PresDet change on the Changed: line. The only time
>> I ever saw it. ;-)
> 
> Hi Martin,
>    PresDet change bit will be cleaned as soon as pciehp driver received the
> inturrupt from hardware, so it's difficult to capture the change.

Why? What is the purpose of having PresDet+ on the Status: line and PresDet- on
the Changed: line? Why isn't LinkState+ cleared on the Changed: line as well
at least? Sometimes I was even thinking that maybe some broken code in hotplug
changes LinkState instead of the PresDet on the Changed: line.

> 
>>
>>
>> I re-plugged the card and ejected several times while the while loops
>> collecting lspci and slot_status via the setpci shell command harvested
>> data. Still, in dmesg there was nothing logged regarding card insert/eject.
>> Eventually, I tried rmmod sata_sil24 (did NOT need 'rmmod -f') and that
>> did log something new.
> 
> No new dmesg info when insert/eject maybe indicate the pciehp driver never received the
> interrupt or there is no bit set about Presence Detect Changed here.

But it seems it is received - per the Status: line. What the driver does with
the PresDet value on the Changed: line should not matter in this regard, right?

> Or there is debug info like :
> pcie_isr: intr_loc %x at least.

Sorry, this does not help me. Would you please modify the setpci shell command
to print more values in the while loop? Or even better, provide me with a debug
patch showing whenever a value in those registers and additionally derived variables
is changed (0000, 0040, 0100, 0108, 0140, 0148)?



In the "Dell Vostro 3550: pci_hotplug+acpiphp require 'pcie_aspm=force' on kernel command-line for hotplug to work"
thread I already reported how pciehp hotplug under same 3.9-rc1 like here works for the eSATA card:

pciehp hotplug:
    [  211.879397] sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)
coldplug+(unnoticed ejects+inserts)+rmmod sata_sil24:
    [  605.818923] sata_sil24 0000:11:00.0: enabling device (0000 -> 0003)

The cold-plugged eSATA card gave somewhat different output during coldboot
compared to those lines when hotplug happens, so I am not able to compare the
output directly. In the mentioned tar.bz2 archive you could have found yourself
in dmesg_after_rmmod_and_modprobe_sata_sil24.txt file:

[    9.662550] sata_sil24 0000:11:00.0: version 1.1
[    9.665780] scsi6 : sata_sil24
[    9.667526] scsi7 : sata_sil24
[    9.668028] ata7: SATA max UDMA/100 host m128@0xf6c84000 port 0xf6c80000 irq 19
[    9.668032] ata8: SATA max UDMA/100 host m128@0xf6c84000 port 0xf6c82000 irq 19

Not much verbose on coldboot, isn't it?


> 
> eSATA card SiI 3132, no XHCI, hotplug only got problem with 3.9-rc1? or both at 3.7 3.8?

In earlier times I never fiddled xhci disabled under 3.7 nor 3.8. Second, I had to use
acpiphp instead due to the breakage around 3.5. But you might compare with locks
held by sata_sil24 in dmesg files in 
"3.7.10: acpiphp with pcie_aspm=off and eSATA card Sil 3132" thread. That could give
you a clue. Maybe. ;-)

Martin
