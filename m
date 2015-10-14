Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:36304 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164AbbJNVpd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Oct 2015 17:45:33 -0400
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.20.1510140816090.14105@math.ut.ee>
References: <alpine.LRH.2.20.1510071147520.8345@math.ut.ee>
	<CAE9FiQXM9YxRwcbG577Pcqmj7YbOa0yk6hYELb2FpTtct5u2jg@mail.gmail.com>
	<alpine.LRH.2.20.1510120808240.3251@math.ut.ee>
	<CAE9FiQXHsgYaTgF2rsWFJXSYJ=kH3j63ageJ2H8F5wnzbFgxRg@mail.gmail.com>
	<alpine.LRH.2.20.1510130800380.3972@math.ut.ee>
	<CAE9FiQVAtPGgzwwMaHjGjyzOD8wKb0TqCd1wynF6-ZmFqZzEaQ@mail.gmail.com>
	<alpine.LRH.2.20.1510131020140.9747@math.ut.ee>
	<CAE9FiQWhE=-FtZjuC5-fTzuTq0tm9Zt1MiD8J0a_Q_jiB5RLNg@mail.gmail.com>
	<alpine.LRH.2.20.1510132338510.14105@math.ut.ee>
	<CAE9FiQXDCtL9nqQOVNspNc87=eY98NW=nrSZczbKVNYsPQuVJA@mail.gmail.com>
	<alpine.LRH.2.20.1510140816090.14105@math.ut.ee>
Date: Wed, 14 Oct 2015 14:45:32 -0700
Message-ID: <CAE9FiQUf1KBr_05R61F8CHJcBLV3LxW-jJvNCHNSqMYd6CS0QQ@mail.gmail.com>
Subject: Re: 4.3-rc3 BAR allocation problems on multiple machines
From: Yinghai Lu <yinghai@kernel.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 14, 2015 at 12:34 AM, Meelis Roos <mroos@linux.ee> wrote:
>> > 0001:00:07.0 ISA bridge: ULi Electronics Inc. M1533/M1535/M1543 PCI to ISA Bridge [Aladdin IV/V/V+]
>> >         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>> >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>> >         Latency: 0
>> >         Region 0: [virtual] I/O ports at 0000 [size=64K]
>> >         Region 1: Memory at <unassigned> (32-bit, non-prefetchable) [size=1M]
>> >         Region 2: Memory at <unassigned> (32-bit, non-prefetchable) [size=1M]
>> >         Region 3: [virtual] Memory at fffff80100000000 (32-bit, non-prefetchable)
>> >         Region 4: [virtual] Memory at fffff80100000000 (32-bit, non-prefetchable)
>> >         Region 5: [virtual] Memory at fffff80100000000 (32-bit, non-prefetchable)
>> >         [virtual] Expansion ROM at fffff80100000000 [disabled]
>> >         Capabilities: [a0] Power Management version 1
>> >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>> >                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>> > 00: b9 10 33 15 0f 00 10 02 00 00 01 06 00 00 00 00
>> > 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> > 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> > 30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
>> > 40: 03 13 4b 80 83 09 00 47 00 00 06 00 00 00 eb 31
>> > 50: 00 00 00 20 90 02 20 03 66 03 00 00 00 00 00 08
>> > 60: 40 00 00 00 00 00 00 00 00 00 00 00 80 20 00 00
>> > 70: 00 00 0a 00 47 00 00 db 04 02 00 04 00 80 01 90
>> > 80: a5 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> > 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> > a0: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
>> > b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> > c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> > d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> > e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> > f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>
>> Please check attached patch.
>
> Thank you, it seems to work. First, the following lines are gone:
> PCI: Claiming 0001:00:07.0: Resource 0: 000007fe01000000..000007fe0100ffff [101]
> PCI: Claiming 0001:00:07.0: Resource 1: 000007ff00000000..000007ff000fffff [200]
> PCI: Claiming 0001:00:07.0: Resource 2: 000007ff00000000..000007ff000fffff [200]
>
> And then all following PCI: Claiming... lines succeed, with no address
> conflicts.
>
> Now, how can I be sure that removing the ULi ISA bridge allocations does
> not break anything? It seems I did not have I2C enabled in kernel conf -
> I emabled it now, recompiled, got this but it seems to be for another
> PCI device so not related?
> ali15x3_smbus 0001:00:06.0: ALI15X3_smb region uninitialized - upgrade BIOS or use force_addr=0xaddr
> ali15x3_smbus 0001:00:06.0: ALI15X3 not detected, module not inserted.

code segment:
        /* Determine the address of the SMBus area */
        pci_read_config_word(ALI15X3_dev, SMBBA, &ali15x3_smba);
        ali15x3_smba &= (0xffff & ~(ALI15X3_SMB_IOSIZE - 1));
        if (ali15x3_smba == 0 && force_addr == 0) {
                dev_err(&ALI15X3_dev->dev, "ALI15X3_smb region uninitialized "
                        "- upgrade BIOS or use force_addr=0xaddr\n");
                return -ENODEV;
        }

SMBBA is 0x14

from lspci:

0001:00:06.0 Non-VGA unclassified device: ULi Electronics Inc. M7101
Power Management Controller [PMU]
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Region 0: [virtual] I/O ports at <unassigned> [size=16]
        [virtual] Expansion ROM at fffff80100000000 [disabled]
00: b9 10 01 71 00 00 00 02 00 00 00 00 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0x14 BAR has 0 really.

>
> Additionally, another driver (i2c-ali1535) claimed 0001:00:06.0 and was
> happy but did not find anything (but I do not know what it sahould find
> so I can see no problem at the moment).

it should complain too:

        /* Determine the address of the SMBus area */
        pci_read_config_word(dev, SMBBA, &ali1535_offset);
        dev_dbg(&dev->dev, "ALI1535_smb is at offset 0x%04x\n", ali1535_offset);
        ali1535_offset &= (0xffff & ~(ALI1535_SMB_IOSIZE - 1));
        if (ali1535_offset == 0) {
                dev_warn(&dev->dev,
                        "ALI1535_smb region uninitialized - upgrade BIOS?\n");
                retval = -ENODEV;
                goto exit;
        }


>
> I also applied the patch on Sun Blade 100 where i2c was working for me.
> It was still working with this ali quirk patch applied, and no BAR
> errors.

Good.

assume v210 does use those for i2c.

>
> What about other arches - does this patch affect other arches where the
> firmware has configured some addresses for this ULi bridge?

According to data sheet, those BAR on 00:07.0 are all 0, and read only.
Not sure how are those to to use them.

Thanks

Yinghai
