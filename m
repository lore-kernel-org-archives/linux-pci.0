Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:43111 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757249Ab2BHC5H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2012 21:57:07 -0500
Received: by werb13 with SMTP id b13so52653wer.19
        for <linux-pci@vger.kernel.org>; Tue, 07 Feb 2012 18:57:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo7xUL++rqnJug7=Wd_nfvaUDOewGjz1C2Fp-oQrkxO2yg@mail.gmail.com>
References: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
 <20120130165805.3231.99160.stgit@bhelgaas.mtv.corp.google.com>
 <20120131114250.b0e6af10.yuasa@linux-mips.org> <CAErSpo7xUL++rqnJug7=Wd_nfvaUDOewGjz1C2Fp-oQrkxO2yg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 7 Feb 2012 18:56:46 -0800
Message-ID: <CAErSpo7ry8piDCTpgkdr01=Kd7=G6HTNwDAQAockPgXtyhJvuw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 11/18] mips/PCI: get rid of device resource fixups
To: Yoichi Yuasa <yuasa@linux-mips.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 30, 2012 at 7:54 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Mon, Jan 30, 2012 at 6:42 PM, Yoichi Yuasa <yuasa@linux-mips.org> wrote:
>> Hi,
>>
>> On Mon, 30 Jan 2012 09:58:05 -0700
>> Bjorn Helgaas <bhelgaas@google.com> wrote:
>>
>>> Tell the PCI core about host bridge address translation so it can take
>>> care of bus-to-resource conversion for us.
>>>
>>> N.B. cobalt_legacy_ide_fixup() does scary things with resources, but I
>>> *think* it will still work because we're still making the same adjustments,
>>> just in the opposite order.  Here are the legacy IDE resource.start
>>> values I expect:
>>>
>>>          current                                        new
>>>
>>>            0x1f0   (pci_setup_device)                 0x1f0
>>>                    (pci_bus_to_resource)       + 0xf0000000
>>>     - 0xf0000000   (cobalt_legacy_ide_fixup)   - 0xf0000000
>>>     + 0xf0000000   (pcibios_fixup_bus)
>>>     ------------                               ------------
>>>            0x1f0    final value                       0x1f0
>>
>> It seems to be unable to handle the offset correctly.
>>
>> failed on Cobalt:
>>
>> pata_via 0000:00:09.1: BAR 0: can't reserve [io  0x100001f0-0x100001f7]
>> pata_via 0000:00:09.1: failed to request/iomap BARs for port 0 (errno=-16)
>> pata_via 0000:00:09.1: BAR 2: can't reserve [io  0x10000170-0x10000177]
>> pata_via 0000:00:09.1: failed to request/iomap BARs for port 1 (errno=-16)
>> pata_via 0000:00:09.1: no available native port
>
> Thank you very much for testing this.  Could you collect the complete
> dmesg and /proc/ioport contents, before and after my patches?

Ping :)  I'll try to figure this out, but it would be easier if I had
the info mentioned above.  Thanks!

Bjorn
