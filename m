Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:38630 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbaAGS2C (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jan 2014 13:28:02 -0500
Received: by mail-ie0-f173.google.com with SMTP id to1so829984ieb.18
        for <linux-pci@vger.kernel.org>; Tue, 07 Jan 2014 10:28:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52CBC4D1.5080706@gmail.com>
References: <52CBC4D1.5080706@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 7 Jan 2014 11:27:40 -0700
Message-ID: <CAErSpo7bUchKT5WN+BBq6oKn+O62gWbH+gfaruePBAYrvP7Lmw@mail.gmail.com>
Subject: Re: pci->pcie bridge issue: kernel unable to find a free I/O port range.
To: "`VL" <vl.homutov@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Yinghai]

On Tue, Jan 7, 2014 at 2:11 AM, `VL <vl.homutov@gmail.com> wrote:
> Hello,
>
> I'm having an issue with my M-Audio Delta 44 soundcard installed into
> the PCI->PCIe adapter. When installed into PCI slot on my old computer,
> it works perfectly, but the new one lacks PCI slots, so I installed it using
> the adapter (http://www.espada-tech.ru/pr_-12351.shtml)
>
> lspci shows the audio card:
>
> 07:00.0 Multimedia audio controller: VIA Technologies Inc. ICE1712 [Envy24]
> PCI Multi-Channel I/O Controller (rev 02)
>
> but the driver won't load:
>
> snd_ice1712 0000:07:00.0: Refused to change power state, currently in D3
> ice1712: No matching model found for ID 0x6c6c6c6c
> invalid EEPROM (size = 108)
> snd_ice1712: probe of 0000:07:00.0 failed with error -5
>
> Unknown ID and EEPROM size may differ from boot to boot.
>
> Looking into message I see this:
>
> [    0.384542] pci 0000:05:01.0: BAR 7: can't assign io (size 0x1000)
> [    0.384714] pci 0000:06:00.0: BAR 7: can't assign io (size 0x1000)
> [    0.384885] pci 0000:07:00.0: BAR 3: can't assign io (size 0x40)
> [    0.385056] pci 0000:07:00.0: BAR 0: can't assign io (size 0x20)
> [    0.385227] pci 0000:07:00.0: BAR 1: can't assign io (size 0x10)
> [    0.385411] pci 0000:07:00.0: BAR 2: can't assign io (size 0x10)

Yep, this is the problem.  We ran out of I/O space.  We had 8K leading
to the switch, but 4K go to the Realtek NIC, and 4K go to SATA:

pci 0000:00:1c.3:   bridge window [io  0xb000-0xcfff]  to [bus 04-0d]
pci 0000:05:05.0:   bridge window [io  0xc000-0xcfff]  to [bus 09]
pci 0000:09:00.0: reg 0x10: [io  0xc000-0xc0ff]  Realtek NIC
pci 0000:05:09.0:   bridge window [io  0xb000-0xbfff]  to [bus 0d]
pci 0000:0d:00.0: reg 0x10: [io  0xb050-0xb057]  SATA

It seems like there *is* I/O space available in the system, so I'm not
sure why BIOS didn't assign enough here.  But it's still a bug that
Linux couldn't fix it.

> The bridge is based on PLX PEX 8112(?) chip and lspci shows:
>
> 04:00.0 PCI bridge: PLX Technology, Inc. PEX 8608 8-lane, 8-Port PCI Express
> Gen 2 (5.0 GT/s) Switch (rev ba)
> 05:01.0 PCI bridge: PLX Technology, Inc. PEX 8608 8-lane, 8-Port PCI Express
> Gen 2 (5.0 GT/s) Switch (rev ba)
> 05:04.0 PCI bridge: PLX Technology, Inc. PEX 8608 8-lane, 8-Port PCI Express
> Gen 2 (5.0 GT/s) Switch (rev ba)
> 05:05.0 PCI bridge: PLX Technology, Inc. PEX 8608 8-lane, 8-Port PCI Express
> Gen 2 (5.0 GT/s) Switch (rev ba)
> 05:06.0 PCI bridge: PLX Technology, Inc. PEX 8608 8-lane, 8-Port PCI Express
> Gen 2 (5.0 GT/s) Switch (rev ba)
> 05:07.0 PCI bridge: PLX Technology, Inc. PEX 8608 8-lane, 8-Port PCI Express
> Gen 2 (5.0 GT/s) Switch (rev ba)
> 05:08.0 PCI bridge: PLX Technology, Inc. PEX 8608 8-lane, 8-Port PCI Express
> Gen 2 (5.0 GT/s) Switch (rev ba)
> 05:09.0 PCI bridge: PLX Technology, Inc. PEX 8608 8-lane, 8-Port PCI Express
> Gen 2 (5.0 GT/s) Switch (rev ba)
> 06:00.0 PCI bridge: PLX Technology, Inc. PEX 8111 PCI Express-to-PCI Bridge
> (rev 21)
>
> my kernel is 3.11.10:
>
> lspci -vvv: http://dpaste.com/1539094/
> dmesg: http://dpaste.com/1539095/
>
> I've tried to boot with pci=realloc, but the system hangs in this case
> (looks like during initialization
> of sound card driver, but I'm not sure, since it hangs completely: no kernel
> panic, system just stopped
> in the middle of usual boot message)

Is there any way you can capture the output with a serial console or a
video camera?

Bjorn
