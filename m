Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:59316 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752815Ab2DPKyC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2012 06:54:02 -0400
Message-ID: <4F8BFA45.5020000@fold.natur.cuni.cz>
Date: Mon, 16 Apr 2012 12:53:57 +0200
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: linux-pci@vger.kernel.org
Subject: Re: 3.2.11: PCI Express card cannot be re-detected withing cca 60sec
 timeframe
References: <4F6A483D.50702@fold.natur.cuni.cz> <CAE9FiQVnErU-cska4gpinyj-LOup-U+3vsEG2z_-7h6kyREYtw@mail.gmail.com> <4F6A5A53.305@fold.natur.cuni.cz> <CAE9FiQXP7fO9OGN557jdofFFiFj96wL--ZA8X3UPEJ6o9JLvBw@mail.gmail.com> <4F8BEB1D.9080903@fold.natur.cuni.cz>
In-Reply-To: <4F8BEB1D.9080903@fold.natur.cuni.cz>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Martin Mokrejs wrote:
> Hi Yinghai,
> 
> Yinghai Lu wrote:
>> On Wed, Mar 21, 2012 at 3:46 PM, Martin Mokrejs
>> <mmokrejs@fold.natur.cuni.cz> wrote:
>>> Hi Yinghai,
>>>  please find attached current dmesg output (not showing the bootup of the
>>> system anymore). at the end of the file you will see what happened when I
>>> inserted the card. I removed the card after some 10secs so that you can all.
>>> Sorry for the heavy USB debug messages. ;)
>>>  In another file a record of the previous boot (new.dmesg2.txt).
>>>
>>>  So shall I try the patch you sent me? ;-)
>>
>> that may only help on some case like just booting up.
>>
>> You may need to check.
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/jbarnes/pci.git linux-next
>>
>> there is one patch there that is going to power down the link.
>> http://git.kernel.org/?p=linux/kernel/git/jbarnes/pci.git;a=patch;h=2debd9289997fc5d1c0043b41201a8b40d5e11d0
> 
>    I had some Ooopses with 3.4-rc2 but now I have tested 3.4-rc3. Still, linux
> does NOT realize that I have removed an ExpressCard from the slot. It realizes
> that only when I pluging the card back again. Actually, this is a case of a
> NEC chipset base USB3.0 card.
> 
>   In contrast, kernel DOES recognize that I unplugged a FireWire card from the
> same slot.
> 
>   This is a Dell Vostro 3550 laptop. Below is what syslog logged with my comment.
> Empty lines between the log entries are inserted whe I either inserted or removed
> a card. Probably a bit more will be in the attached dmesg file.

[cut]

> REMOVED CARD
> 
> Apr 16 11:30:02 vostro kernel: [  361.001326] pciehp 0000:00:1c.7:pcie04: Card not present on Slot(7)
> Apr 16 11:30:02 vostro kernel: [  361.001745] firewire_ohci 0000:11:00.0: removed fw-ohci device
> 
> RE-INSERTED CARD
> 
> Apr 16 11:30:05 vostro kernel: [  364.150093] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)
> Apr 16 11:30:06 vostro kernel: [  364.279552] pci 0000:11:00.0: BAR 0: assigned [mem 0xf6c00000-0xf6c007ff 64bit]
> Apr 16 11:30:06 vostro kernel: [  364.279578] pci 0000:11:00.0: BAR 2: assigned [io  0xc000-0xc0ff]
> Apr 16 11:30:06 vostro kernel: [  364.279593] pcieport 0000:00:1c.7: PCI bridge to [bus 11-16]
> Apr 16 11:30:06 vostro kernel: [  364.279609] pcieport 0000:00:1c.7:   bridge window [io  0xc000-0xdfff]
> Apr 16 11:30:06 vostro kernel: [  364.279614] pcieport 0000:00:1c.7:   bridge window [mem 0xf6c00000-0xf7cfffff]
> Apr 16 11:30:06 vostro kernel: [  364.279618] pcieport 0000:00:1c.7:   bridge window [mem 0xf0000000-0xf10fffff 64bit pref]
> Apr 16 11:30:06 vostro kernel: [  364.279747] firewire_ohci 0000:11:00.0: enabling device (0100 -> 0103)
> Apr 16 11:30:06 vostro kernel: [  364.359449] firewire_ohci 0000:11:00.0: added OHCI v1.10 device as card 1, 4 IR + 8 IT contexts, quirks 0x11
> Apr 16 11:30:06 vostro kernel: [  364.858580] firewire_core 0000:11:00.0: created device fw0: GUID 0011066600000003, S400
> 
> REMOVED CARD
> 
> Apr 16 11:30:13 vostro kernel: [  371.820798] pciehp 0000:00:1c.7:pcie04: Card not present on Slot(7)
> Apr 16 11:30:13 vostro kernel: [  371.821220] firewire_ohci 0000:11:00.0: removed fw-ohci device


Bah. A follow-up. I just connected my SATA disk via eSATA port to the laptop (into it's USB2.0/eSATA port)
and funny what I got:

Apr 16 11:44:15 vostro kernel: [ 1212.112999] pci 0000:11:00.0: BAR 2: assigned [io  0xc000-0xc0ff]
Apr 16 11:44:15 vostro kernel: [ 1212.113014] pcieport 0000:00:1c.7: PCI bridge to [bus 11-16]
Apr 16 11:44:15 vostro kernel: [ 1212.113023] pcieport 0000:00:1c.7:   bridge window [io  0xc000-0xdfff]
Apr 16 11:44:15 vostro kernel: [ 1212.113039] pcieport 0000:00:1c.7:   bridge window [mem 0xf6c00000-0xf7cfffff]
Apr 16 11:44:15 vostro kernel: [ 1212.113043] pcieport 0000:00:1c.7:   bridge window [mem 0xf0000000-0xf10fffff 64bit pref]
Apr 16 11:44:15 vostro kernel: [ 1212.113166] firewire_ohci 0000:11:00.0: enabling device (0100 -> 0103)
Apr 16 11:44:15 vostro kernel: [ 1212.192863] firewire_ohci 0000:11:00.0: added OHCI v1.10 device as card 2, 4 IR + 8 IT contexts, quirks 0x11
Apr 16 11:44:16 vostro kernel: [ 1212.692011] firewire_core 0000:11:00.0: created device fw0: GUID 0011066600000003, S400
Apr 16 11:44:34 vostro kernel: [ 1230.851362] pciehp 0000:00:1c.7:pcie04: Card not present on Slot(7)
Apr 16 11:44:34 vostro kernel: [ 1230.851789] firewire_ohci 0000:11:00.0: removed fw-ohci device
Apr 16 12:49:12 vostro kernel: [ 5100.792787] ata6: hard resetting link
Apr 16 12:49:12 vostro kernel: [ 5101.535862] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Apr 16 12:49:12 vostro kernel: [ 5101.536675] ata6.00: ATA-8: ST3000DM001-9YN166, CC4C, max UDMA/133
Apr 16 12:49:12 vostro kernel: [ 5101.536687] ata6.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
Apr 16 12:49:12 vostro kernel: [ 5101.537505] ata6.00: configured for UDMA/133
Apr 16 12:49:12 vostro kernel: [ 5101.555791] ata6: EH complete
Apr 16 12:49:12 vostro kernel: [ 5101.555943] scsi 5:0:0:0: Direct-Access     ATA      ST3000DM001-9YN1 CC4C PQ: 0 ANSI: 5
Apr 16 12:49:12 vostro kernel: [ 5101.556096] sd 5:0:0:0: [sdc] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
Apr 16 12:49:12 vostro kernel: [ 5101.556099] sd 5:0:0:0: [sdc] 4096-byte physical blocks
Apr 16 12:49:12 vostro kernel: [ 5101.556108] sd 5:0:0:0: Attached scsi generic sg3 type 0
Apr 16 12:49:12 vostro kernel: [ 5101.556154] sd 5:0:0:0: [sdc] Write Protect is off
Apr 16 12:49:12 vostro kernel: [ 5101.556178] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Apr 16 12:49:12 vostro kernel: [ 5101.594983]  sdc: sdc1
Apr 16 12:49:12 vostro kernel: [ 5101.595334] sd 5:0:0:0: [sdc] Attached SCSI disk


Martin
