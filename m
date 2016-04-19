Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:36430 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbcDSXk5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2016 19:40:57 -0400
Received: by mail-io0-f177.google.com with SMTP id u185so35889858iod.3
        for <linux-pci@vger.kernel.org>; Tue, 19 Apr 2016 16:40:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAH=XD59itHexRZ2YPetXB0D6hFZrJ3+vquZh74gf8YOpjDqt+g@mail.gmail.com>
References: <dad5ef4a3ace4c2e8a73dafc24df6c7f@XCGVAG27.northgrum.com>
	<CAH=XD59xbiXxLTZd-__j2oLfWLR4S=wQ3kb0cjTpfH6oDFXszw@mail.gmail.com>
	<CAH=XD59itHexRZ2YPetXB0D6hFZrJ3+vquZh74gf8YOpjDqt+g@mail.gmail.com>
Date: Tue, 19 Apr 2016 16:40:53 -0700
Message-ID: <CAH=XD5_n=ZvZaJrVM=7hnW_GoTk_Yz_tFgyBp=FzSQBbipSW_g@mail.gmail.com>
Subject: Re: PCI Hot Plug: OS can not program BARs for new devices
From: Kallol Biswas <kallol@nucleodyne.com>
To: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Looking at boot time dmesg I see pci resource assignment happens two
times. In the first pass, everything looks normal, 2nd pass does not
look good. Why would OS go for 2nd pass?

1st pass:

ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus ff])
pci 0000:ff:0b.0: [8086:2f81] type 0 class 0x000880
pci 0000:ff:0b.1: [8086:2f36] type 0 class 0x001101
pci 0000:ff:0b.2: [8086:2f37] type 0 class 0x001101
pci 0000:ff:0c.0: [8086:2fe0] type 0 class 0x000880
pci 0000:ff:0c.1: [8086:2fe1] type 0 class 0x000880
pci 0000:ff:0c.2: [8086:2fe2] type 0 class 0x000880
pci 0000:ff:0c.3: [8086:2fe3] type 0 class 0x000880
pci 0000:ff:0f.0: [8086:2ff8] type 0 class 0x000880
pci 0000:ff:0f.1: [8086:2ff9] type 0 class 0x000880
pci 0000:ff:0f.4: [8086:2ffc] type 0 class 0x000880
pci 0000:ff:0f.5: [8086:2ffd] type 0 class 0x000880
pci 0000:ff:0f.6: [8086:2ffe] type 0 class 0x000880
pci 0000:ff:10.0: [8086:2f1d] type 0 class 0x000880
pci 0000:ff:10.1: [8086:2f34] type 0 class 0x001101
pci 0000:ff:10.5: [8086:2f1e] type 0 class 0x000880
pci 0000:ff:10.6: [8086:2f7d] type 0 class 0x001101
pci 0000:ff:10.7: [8086:2f1f] type 0 class 0x000880
pci 0000:ff:12.0: [8086:2fa0] type 0 class 0x000880
pci 0000:ff:12.1: [8086:2f30] type 0 class 0x001101
pci 0000:ff:13.0: [8086:2fa8] type 0 class 0x000880
pci 0000:ff:13.1: [8086:2f71] type 0 class 0x000880
pci 0000:ff:13.2: [8086:2faa] type 0 class 0x000880
pci 0000:ff:13.3: [8086:2fab] type 0 class 0x000880
pci 0000:ff:13.4: [8086:2fac] type 0 class 0x000880
pci 0000:ff:13.5: [8086:2fad] type 0 class 0x000880
pci 0000:ff:13.6: [8086:2fae] type 0 class 0x000880
pci 0000:ff:13.7: [8086:2faf] type 0 class 0x000880
pci 0000:ff:14.0: [8086:2fb0] type 0 class 0x000880
pci 0000:ff:14.1: [8086:2fb1] type 0 class 0x000880
pci 0000:ff:14.2: [8086:2fb2] type 0 class 0x000880
pci 0000:ff:14.3: [8086:2fb3] type 0 class 0x000880
pci 0000:ff:14.6: [8086:2fbe] type 0 class 0x000880
pci 0000:ff:14.7: [8086:2fbf] type 0 class 0x000880
pci 0000:ff:15.0: [8086:2fb4] type 0 class 0x000880
pci 0000:ff:15.1: [8086:2fb5] type 0 class 0x000880
pci 0000:ff:15.2: [8086:2fb6] type 0 class 0x000880
pci 0000:ff:15.3: [8086:2fb7] type 0 class 0x000880
pci 0000:ff:16.0: [8086:2f68] type 0 class 0x000880
pci 0000:ff:16.6: [8086:2f6e] type 0 class 0x000880
pci 0000:ff:16.7: [8086:2f6f] type 0 class 0x000880
pci 0000:ff:17.0: [8086:2fd0] type 0 class 0x000880
pci 0000:ff:17.4: [8086:2fb8] type 0 class 0x000880
pci 0000:ff:17.5: [8086:2fb9] type 0 class 0x000880
pci 0000:ff:17.6: [8086:2fba] type 0 class 0x000880
pci 0000:ff:17.7: [8086:2fbb] type 0 class 0x000880
pci 0000:ff:1e.0: [8086:2f98] type 0 class 0x000880
pci 0000:ff:1e.1: [8086:2f99] type 0 class 0x000880
pci 0000:ff:1e.2: [8086:2f9a] type 0 class 0x000880
pci 0000:ff:1e.3: [8086:2fc0] type 0 class 0x000880
pci 0000:ff:1e.3: reg 10: [io  0x0020-0x003f]
pci 0000:ff:1e.4: [8086:2f9c] type 0 class 0x000880
pci 0000:ff:1f.0: [8086:2f88] type 0 class 0x000880
pci 0000:ff:1f.2: [8086:2f8a] type 0 class 0x000880
ACPI: PCI Interrupt Routing Table [\_SB_.UNC0._PRT]
 pci0000:ff: Requesting ACPI _OSC control (0x1d)
 pci0000:ff: ACPI _OSC control (0x15) granted
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
pci_root PNP0A08:00: host bridge window [io  0x0000-0x03af]
pci_root PNP0A08:00: host bridge window [io  0x03e0-0x0cf7]
pci_root PNP0A08:00: host bridge window [io  0x03b0-0x03df]
pci_root PNP0A08:00: host bridge window [io  0x1000-0xffff]
pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
pci_root PNP0A08:00: host bridge window [mem 0xfedb0000-0xfedb000f]
pci_root PNP0A08:00: host bridge window [mem 0xfedc0000-0xfedc000f]
pci_root PNP0A08:00: host bridge window [mem 0x90000000-0xfbffbfff]
pci_root PNP0A08:00: host bridge window [mem 0x380000000000-0x38ffffffffff]
pci 0000:00:00.0: [8086:2f00] type 0 class 0x000600
pci 0000:00:01.0: [8086:2f02] type 1 class 0x000604
pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
pci 0000:00:01.0: PME# disabled
pci 0000:00:02.0: [8086:2f04] type 1 class 0x000604
pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
pci 0000:00:02.0: PME# disabled
pci 0000:00:02.2: [8086:2f06] type 1 class 0x000604
pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
pci 0000:00:02.2: PME# disabled
pci 0000:00:03.0: [8086:2f08] type 1 class 0x000604
pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
pci 0000:00:03.0: PME# disabled
pci 0000:00:04.0: [8086:2f20] type 0 class 0x000880
pci 0000:00:04.0: reg 10: [mem 0x38fffff2c000-0x38fffff2ffff 64bit]
pci 0000:00:04.1: [8086:2f21] type 0 class 0x000880
pci 0000:00:04.1: reg 10: [mem 0x38fffff28000-0x38fffff2bfff 64bit]
pci 0000:00:04.2: [8086:2f22] type 0 class 0x000880
pci 0000:00:04.2: reg 10: [mem 0x38fffff24000-0x38fffff27fff 64bit]
pci 0000:00:04.3: [8086:2f23] type 0 class 0x000880
pci 0000:00:04.3: reg 10: [mem 0x38fffff20000-0x38fffff23fff 64bit]
pci 0000:00:04.4: [8086:2f24] type 0 class 0x000880
pci 0000:00:04.4: reg 10: [mem 0x38fffff1c000-0x38fffff1ffff 64bit]
pci 0000:00:04.5: [8086:2f25] type 0 class 0x000880
pci 0000:00:04.5: reg 10: [mem 0x38fffff18000-0x38fffff1bfff 64bit]
pci 0000:00:04.6: [8086:2f26] type 0 class 0x000880
pci 0000:00:04.6: reg 10: [mem 0x38fffff14000-0x38fffff17fff 64bit]
pci 0000:00:04.7: [8086:2f27] type 0 class 0x000880
pci 0000:00:04.7: reg 10: [mem 0x38fffff10000-0x38fffff13fff 64bit]
pci 0000:00:05.0: [8086:2f28] type 0 class 0x000880
pci 0000:00:05.1: [8086:2f29] type 0 class 0x000880
pci 0000:00:05.2: [8086:2f2a] type 0 class 0x000880
pci 0000:00:05.4: [8086:2f2c] type 0 class 0x000800
pci 0000:00:05.4: reg 10: [mem 0xfa107000-0xfa107fff]
pci 0000:00:11.0: [8086:8d7c] type 0 class 0x00ff00
pci 0000:00:11.4: [8086:8d62] type 0 class 0x000106
pci 0000:00:11.4: reg 10: [io  0xf110-0xf117]
pci 0000:00:11.4: reg 14: [io  0xf100-0xf103]
pci 0000:00:11.4: reg 18: [io  0xf0f0-0xf0f7]
pci 0000:00:11.4: reg 1c: [io  0xf0e0-0xf0e3]
pci 0000:00:11.4: reg 20: [io  0xf020-0xf03f]
pci 0000:00:11.4: reg 24: [mem 0xfa106000-0xfa1067ff]
pci 0000:00:11.4: PME# supported from D3hot
pci 0000:00:11.4: PME# disabled
pci 0000:00:14.0: [8086:8d31] type 0 class 0x000c03
pci 0000:00:14.0: reg 10: [mem 0x38fffff00000-0x38fffff0ffff 64bit]
pci 0000:00:14.0: PME# supported from D3hot D3cold
pci 0000:00:14.0: PME# disabled
pci 0000:00:16.0: [8086:8d3a] type 0 class 0x000780
pci 0000:00:16.0: reg 10: [mem 0xfa105000-0xfa10500f 64bit]
pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
pci 0000:00:16.0: PME# disabled
pci 0000:00:16.1: [8086:8d3b] type 0 class 0x000780
pci 0000:00:16.1: reg 10: [mem 0xfa104000-0xfa10400f 64bit]
pci 0000:00:16.1: PME# supported from D0 D3hot D3cold
pci 0000:00:16.1: PME# disabled
pci 0000:00:1a.0: [8086:8d2d] type 0 class 0x000c03
pci 0000:00:1a.0: reg 10: [mem 0xfa102000-0xfa1023ff]
pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1a.0: PME# disabled
pci 0000:00:1c.0: [8086:8d10] type 1 class 0x000604
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.0: PME# disabled
pci 0000:00:1c.2: [8086:8d14] type 1 class 0x000604
pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.2: PME# disabled
pci 0000:00:1c.3: [8086:8d16] type 1 class 0x000604
pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.3: PME# disabled
pci 0000:00:1d.0: [8086:8d26] type 0 class 0x000c03
pci 0000:00:1d.0: reg 10: [mem 0xfa101000-0xfa1013ff]
pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.0: PME# disabled
pci 0000:00:1f.0: [8086:8d44] type 0 class 0x000601
pci 0000:00:1f.2: [8086:8d02] type 0 class 0x000106
pci 0000:00:1f.2: reg 10: [io  0xf070-0xf077]
pci 0000:00:1f.2: reg 14: [io  0xf060-0xf063]
pci 0000:00:1f.2: reg 18: [io  0xf050-0xf057]
pci 0000:00:1f.2: reg 1c: [io  0xf040-0xf043]
pci 0000:00:1f.2: reg 20: [io  0xf000-0xf01f]
pci 0000:00:1f.2: reg 24: [mem 0xfa100000-0xfa1007ff]
pci 0000:00:1f.2: PME# supported from D3hot
pci 0000:00:1f.2: PME# disabled
pci 0000:00:1f.3: [8086:8d22] type 0 class 0x000c05
pci 0000:00:1f.3: reg 10: [mem 0x38fffff31000-0x38fffff310ff 64bit]
pci 0000:00:1f.3: reg 20: [io  0x0580-0x059f]
pci 0000:00:1f.6: [8086:8d24] type 0 class 0x001180
pci 0000:00:1f.6: reg 10: [mem 0x38fffff30000-0x38fffff30fff 64bit]
pci 0000:00:01.0: PCI bridge to [bus 01-ff]
pci 0000:00:01.0:   bridge window [io  0xf000-0x0000] (disabled)
pci 0000:00:01.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
pci 0000:00:01.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:00:02.0: PCI bridge to [bus 02-ff]
pci 0000:00:02.0:   bridge window [io  0xf000-0x0000] (disabled)
pci 0000:00:02.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
pci 0000:00:02.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:00:02.2: PCI bridge to [bus 03-ff]
pci 0000:00:02.2:   bridge window [io  0xf000-0x0000] (disabled)
pci 0000:00:02.2:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
pci 0000:00:02.2:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:04:00.0: [10b5:8732] type 1 class 0x000604
pci 0000:04:00.0: reg 10: [mem 0xfb100000-0xfb13ffff]
pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
pci 0000:04:00.0: PME# disabled
pci 0000:00:03.0: PCI bridge to [bus 04-ff]
pci 0000:00:03.0:   bridge window [io  0xf000-0x0000] (disabled)
pci 0000:00:03.0:   bridge window [mem 0xfa800000-0xfb1fffff]
pci 0000:00:03.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:05:08.0: [10b5:8732] type 1 class 0x000604
pci 0000:05:08.0: PME# supported from D0 D3hot D3cold
pci 0000:05:08.0: PME# disabled
pci 0000:04:00.0: PCI bridge to [bus 05-ff]
pci 0000:04:00.0:   bridge window [io  0xfff000-0x0000] (disabled)
pci 0000:04:00.0:   bridge window [mem 0xfa800000-0xfb0fffff]
pci 0000:04:00.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:06:00.0: [10b5:8732] type 1 class 0x000604
pci 0000:06:00.0: reg 10: [mem 0xfb000000-0xfb03ffff]
pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
pci 0000:06:00.0: PME# disabled
pci 0000:05:08.0: PCI bridge to [bus 06-ff]
pci 0000:05:08.0:   bridge window [io  0xfff000-0x0000] (disabled)
pci 0000:05:08.0:   bridge window [mem 0xfa800000-0xfb0fffff]
pci 0000:05:08.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:07:00.0: [10b5:8732] type 1 class 0x000604
pci 0000:07:00.0: PME# supported from D0 D3hot D3cold
pci 0000:07:00.0: PME# disabled
pci 0000:06:00.0: PCI bridge to [bus 07-ff]
pci 0000:06:00.0:   bridge window [io  0xfff000-0x0000] (disabled)
pci 0000:06:00.0:   bridge window [mem 0xfa800000-0xfaffffff]
pci 0000:06:00.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:08:00.0: [10b5:9797] type 1 class 0x000604
pci 0000:08:00.0: PME# supported from D0 D3hot D3cold
pci 0000:08:00.0: PME# disabled
pci 0000:07:00.0: PCI bridge to [bus 08-ff]
pci 0000:07:00.0:   bridge window [io  0xfff000-0x0000] (disabled)
pci 0000:07:00.0:   bridge window [mem 0xfa800000-0xfaffffff]
pci 0000:07:00.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:09:04.0: [10b5:9797] type 1 class 0x000604
pci 0000:09:04.0: PME# supported from D0 D3hot D3cold
pci 0000:09:04.0: PME# disabled
pci 0000:09:08.0: [10b5:9797] type 1 class 0x000604
pci 0000:09:08.0: PME# supported from D0 D3hot D3cold
pci 0000:09:08.0: PME# disabled
pci 0000:09:09.0: [10b5:9797] type 1 class 0x000604
pci 0000:09:09.0: PME# supported from D0 D3hot D3cold
pci 0000:09:09.0: PME# disabled
pci 0000:09:0c.0: [10b5:9797] type 1 class 0x000604
pci 0000:09:0c.0: PME# supported from D0 D3hot D3cold
pci 0000:09:0c.0: PME# disabled
pci 0000:09:0d.0: [10b5:9797] type 1 class 0x000604
pci 0000:09:0d.0: PME# supported from D0 D3hot D3cold
pci 0000:09:0d.0: PME# disabled
pci 0000:09:0e.0: [10b5:9797] type 1 class 0x000604
pci 0000:09:0e.0: PME# supported from D0 D3hot D3cold
pci 0000:09:0e.0: PME# disabled
pci 0000:09:0f.0: [10b5:9797] type 1 class 0x000604
pci 0000:09:0f.0: PME# supported from D0 D3hot D3cold
pci 0000:09:0f.0: PME# disabled
pci 0000:09:10.0: [10b5:9797] type 1 class 0x000604
pci 0000:09:10.0: PME# supported from D0 D3hot D3cold
pci 0000:09:10.0: PME# disabled
pci 0000:09:11.0: [10b5:9797] type 1 class 0x000604
pci 0000:09:11.0: PME# supported from D0 D3hot D3cold
pci 0000:09:11.0: PME# disabled
pci 0000:09:14.0: [10b5:9797] type 1 class 0x000604
pci 0000:09:14.0: PME# supported from D0 D3hot D3cold
pci 0000:09:14.0: PME# disabled
pci 0000:09:19.0: [10b5:9797] type 1 class 0x000604
pci 0000:09:19.0: PME# supported from D0 D3hot D3cold
pci 0000:09:19.0: PME# disabled
pci 0000:08:00.0: PCI bridge to [bus 09-ff]
pci 0000:08:00.0:   bridge window [io  0xfff000-0x0000] (disabled)
pci 0000:08:00.0:   bridge window [mem 0xfa800000-0xfaffffff]
pci 0000:08:00.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:09:04.0: PCI bridge to [bus 0a-ff]
pci 0000:09:04.0:   bridge window [io  0xfff000-0x0000] (disabled)
pci 0000:09:04.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
pci 0000:09:04.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:09:08.0: PCI bridge to [bus 0b-ff]
pci 0000:09:08.0:   bridge window [io  0xfff000-0x0000] (disabled)
pci 0000:09:08.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
pci 0000:09:08.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:09:09.0: PCI bridge to [bus 0c-ff]
pci 0000:09:09.0:   bridge window [io  0xfff000-0x0000] (disabled)
pci 0000:09:09.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
pci 0000:09:09.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:09:0c.0: PCI bridge to [bus 0d-ff]
pci 0000:09:0c.0:   bridge window [io  0xfff000-0x0000] (disabled)
pci 0000:09:0c.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
pci 0000:09:0c.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:09:0d.0: PCI bridge to [bus 0e-ff]
pci 0000:09:0d.0:   bridge window [io  0xfff000-0x0000] (disabled)
pci 0000:09:0d.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
pci 0000:09:0d.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:09:0e.0: PCI bridge to [bus 0f-ff]
pci 0000:09:0e.0:   bridge window [io  0xfff000-0x0000] (disabled)
pci 0000:09:0e.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
pci 0000:09:0e.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:09:0f.0: PCI bridge to [bus 10-ff]
pci 0000:09:0f.0:   bridge window [io  0xfff000-0x0000] (disabled)
pci 0000:09:0f.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
pci 0000:09:0f.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:09:10.0: PCI bridge to [bus 11-ff]
pci 0000:09:10.0:   bridge window [io  0xfff000-0x0000] (disabled)
pci 0000:09:10.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
pci 0000:09:10.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:09:11.0: PCI bridge to [bus 12-ff]
pci 0000:09:11.0:   bridge window [io  0xfff000-0x0000] (disabled)
pci 0000:09:11.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
pci 0000:09:11.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:09:14.0: PCI bridge to [bus 13-ff]
pci 0000:09:14.0:   bridge window [io  0xfff000-0x0000] (disabled)
pci 0000:09:14.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
pci 0000:09:14.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:14:00.0: [10b5:1009] type 0 class 0x000880
pci 0000:14:00.0: reg 10: [mem 0xfa800000-0xfaffffff]
pci 0000:09:19.0: PCI bridge to [bus 14-ff]
pci 0000:09:19.0:   bridge window [io  0xfff000-0x0000] (disabled)
pci 0000:09:19.0:   bridge window [mem 0xfa800000-0xfaffffff]
pci 0000:09:19.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:16:00.0: [1a03:1150] type 1 class 0x000604
pci 0000:16:00.0: supports D1 D2
pci 0000:16:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:16:00.0: PME# disabled
pci 0000:16:00.0: disabling ASPM on pre-1.1 PCIe device.  You can
enable it with 'pcie_aspm=force'
pci 0000:00:1c.0: PCI bridge to [bus 16-ff]
pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
pci 0000:00:1c.0:   bridge window [mem 0xf9000000-0xfa0fffff]
pci 0000:00:1c.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:17:00.0: [1a03:2000] type 0 class 0x000300
pci 0000:17:00.0: reg 10: [mem 0xf9000000-0xf9ffffff]
pci 0000:17:00.0: reg 14: [mem 0xfa000000-0xfa01ffff]
pci 0000:17:00.0: reg 18: [io  0xe000-0xe07f]
pci 0000:17:00.0: supports D1 D2
pci 0000:17:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:17:00.0: PME# disabled
pci 0000:16:00.0: PCI bridge to [bus 17-ff]
pci 0000:16:00.0:   bridge window [io  0xe000-0xefff]
pci 0000:16:00.0:   bridge window [mem 0xf9000000-0xfa0fffff]
pci 0000:16:00.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:18:00.0: [8086:1533] type 0 class 0x000200
pci 0000:18:00.0: reg 10: [mem 0xfb400000-0xfb47ffff]
pci 0000:18:00.0: reg 18: [io  0xd000-0xd01f]
pci 0000:18:00.0: reg 1c: [mem 0xfb480000-0xfb483fff]
pci 0000:18:00.0: PME# supported from D0 D3hot D3cold
pci 0000:18:00.0: PME# disabled
pci 0000:00:1c.2: PCI bridge to [bus 18-ff]
pci 0000:00:1c.2:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.2:   bridge window [mem 0xfb400000-0xfb4fffff]
pci 0000:00:1c.2:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:19:00.0: [8086:1533] type 0 class 0x000200
pci 0000:19:00.0: reg 10: [mem 0xfb300000-0xfb37ffff]
pci 0000:19:00.0: reg 18: [io  0xc000-0xc01f]
pci 0000:19:00.0: reg 1c: [mem 0xfb380000-0xfb383fff]
pci 0000:19:00.0: PME# supported from D0 D3hot D3cold
pci 0000:19:00.0: PME# disabled
pci 0000:00:1c.3: PCI bridge to [bus 19-ff]
pci 0000:00:1c.3:   bridge window [io  0xc000-0xcfff]
pci 0000:00:1c.3:   bridge window [mem 0xfb300000-0xfb3fffff]
pci 0000:00:1c.3:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci_bus 0000:00: on NUMA node 0 (pxm 0)


2nd pass:

pci 0000:ff:1e.3: BAR 0: trying firmware assignment [io  0x0020-0x003f]
pci 0000:ff:1e.3: BAR 0: [io  0x0020-0x003f] conflicts with PCI Bus
0000:00 [io  0x0000-0x03af]
pci 0000:ff:1e.3: BAR 0: can't assign io (size 0x20)
pci 0000:00:03.0: BAR 15: assigned [mem 0x90000000-0xdfffffff 64bit pref]
pci 0000:00:03.0: BAR 13: assigned [io  0x1000-0x5fff]
pci 0000:00:01.0: PCI bridge to [bus 01-01]
pci 0000:00:01.0:   bridge window [io  disabled]
pci 0000:00:01.0:   bridge window [mem disabled]
pci 0000:00:01.0:   bridge window [mem pref disabled]
pci 0000:00:02.0: PCI bridge to [bus 02-02]
pci 0000:00:02.0:   bridge window [io  disabled]
pci 0000:00:02.0:   bridge window [mem disabled]
pci 0000:00:02.0:   bridge window [mem pref disabled]
pci 0000:00:02.2: PCI bridge to [bus 03-03]
pci 0000:00:02.2:   bridge window [io  disabled]
pci 0000:00:02.2:   bridge window [mem disabled]
pci 0000:00:02.2:   bridge window [mem pref disabled]
pci 0000:04:00.0: BAR 15: assigned [mem 0x90000000-0xdfffffff 64bit pref]
pci 0000:04:00.0: BAR 13: assigned [io  0x1000-0x5fff]
pci 0000:05:08.0: BAR 15: assigned [mem 0x90000000-0xdfffffff 64bit pref]
pci 0000:05:08.0: BAR 13: assigned [io  0x1000-0x5fff]
pci 0000:06:00.0: BAR 15: assigned [mem 0x90000000-0xdfffffff 64bit pref]
pci 0000:06:00.0: BAR 13: assigned [io  0x1000-0x5fff]
pci 0000:07:00.0: BAR 15: assigned [mem 0x90000000-0xdfffffff 64bit pref]
pci 0000:07:00.0: BAR 13: assigned [io  0x1000-0x5fff]
pci 0000:08:00.0: BAR 15: assigned [mem 0x90000000-0xdfffffff 64bit pref]
pci 0000:08:00.0: BAR 13: assigned [io  0x1000-0x5fff]
pci 0000:09:04.0: BAR 14: can't assign mem (size 0x10000000)
pci 0000:09:04.0: BAR 15: assigned [mem 0x90000000-0x9fffffff 64bit pref]
pci 0000:09:09.0: BAR 14: can't assign mem (size 0x10000000)
pci 0000:09:09.0: BAR 15: assigned [mem 0xa0000000-0xafffffff 64bit pref]
pci 0000:09:0d.0: BAR 14: can't assign mem (size 0x10000000)
pci 0000:09:0d.0: BAR 15: assigned [mem 0xb0000000-0xbfffffff 64bit pref]
pci 0000:09:11.0: BAR 14: can't assign mem (size 0x10000000)
pci 0000:09:11.0: BAR 15: assigned [mem 0xc0000000-0xcfffffff 64bit pref]
pci 0000:09:14.0: BAR 14: can't assign mem (size 0x10000000)
pci 0000:09:14.0: BAR 15: assigned [mem 0xd0000000-0xdfffffff 64bit pref]
pci 0000:09:04.0: BAR 13: assigned [io  0x1000-0x1fff]
pci 0000:09:09.0: BAR 13: assigned [io  0x2000-0x2fff]
pci 0000:09:0d.0: BAR 13: assigned [io  0x3000-0x3fff]
pci 0000:09:11.0: BAR 13: assigned [io  0x4000-0x4fff]
pci 0000:09:14.0: BAR 13: assigned [io  0x5000-0x5fff]
pci 0000:09:04.0: PCI bridge to [bus 0a-0a]
pci 0000:09:04.0:   bridge window [io  0x1000-0x1fff]
pci 0000:09:04.0:   bridge window [mem disabled]
pci 0000:09:04.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
pci 0000:09:08.0: PCI bridge to [bus 0b-0b]
pci 0000:09:08.0:   bridge window [io  disabled]
pci 0000:09:08.0:   bridge window [mem disabled]
pci 0000:09:08.0:   bridge window [mem pref disabled]
pci 0000:09:09.0: PCI bridge to [bus 0c-0c]
pci 0000:09:09.0:   bridge window [io  0x2000-0x2fff]
pci 0000:09:09.0:   bridge window [mem disabled]
pci 0000:09:09.0:   bridge window [mem 0xa0000000-0xafffffff 64bit pref]
pci 0000:09:0c.0: PCI bridge to [bus 0d-0d]
pci 0000:09:0c.0:   bridge window [io  disabled]
pci 0000:09:0c.0:   bridge window [mem disabled]
pci 0000:09:0c.0:   bridge window [mem pref disabled]
pci 0000:09:0d.0: PCI bridge to [bus 0e-0e]
pci 0000:09:0d.0:   bridge window [io  0x3000-0x3fff]
pci 0000:09:0d.0:   bridge window [mem disabled]
pci 0000:09:0d.0:   bridge window [mem 0xb0000000-0xbfffffff 64bit pref]
pci 0000:09:0e.0: PCI bridge to [bus 0f-0f]
pci 0000:09:0e.0:   bridge window [io  disabled]
pci 0000:09:0e.0:   bridge window [mem disabled]
pci 0000:09:0e.0:   bridge window [mem pref disabled]
pci 0000:09:0f.0: PCI bridge to [bus 10-10]
pci 0000:09:0f.0:   bridge window [io  disabled]
pci 0000:09:0f.0:   bridge window [mem disabled]
pci 0000:09:0f.0:   bridge window [mem pref disabled]
pci 0000:09:10.0: PCI bridge to [bus 11-11]
pci 0000:09:10.0:   bridge window [io  disabled]
pci 0000:09:10.0:   bridge window [mem disabled]
pci 0000:09:10.0:   bridge window [mem pref disabled]
pci 0000:09:11.0: PCI bridge to [bus 12-12]
pci 0000:09:11.0:   bridge window [io  0x4000-0x4fff]
pci 0000:09:11.0:   bridge window [mem disabled]
pci 0000:09:11.0:   bridge window [mem 0xc0000000-0xcfffffff 64bit pref]
pci 0000:09:14.0: PCI bridge to [bus 13-13]
pci 0000:09:14.0:   bridge window [io  0x5000-0x5fff]
pci 0000:09:14.0:   bridge window [mem disabled]
pci 0000:09:14.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
pci 0000:09:19.0: PCI bridge to [bus 14-15]
pci 0000:09:19.0:   bridge window [io  disabled]
pci 0000:09:19.0:   bridge window [mem 0xfa800000-0xfaffffff]
pci 0000:09:19.0:   bridge window [mem pref disabled]
pci 0000:08:00.0: PCI bridge to [bus 09-15]
pci 0000:08:00.0:   bridge window [io  0x1000-0x5fff]
pci 0000:08:00.0:   bridge window [mem 0xfa800000-0xfaffffff]
pci 0000:08:00.0:   bridge window [mem 0x90000000-0xdfffffff 64bit pref]
pci 0000:07:00.0: PCI bridge to [bus 08-15]
pci 0000:07:00.0:   bridge window [io  0x1000-0x5fff]
pci 0000:07:00.0:   bridge window [mem 0xfa800000-0xfaffffff]
pci 0000:07:00.0:   bridge window [mem 0x90000000-0xdfffffff 64bit pref]
pci 0000:06:00.0: PCI bridge to [bus 07-15]
pci 0000:06:00.0:   bridge window [io  0x1000-0x5fff]
pci 0000:06:00.0:   bridge window [mem 0xfa800000-0xfaffffff]
pci 0000:06:00.0:   bridge window [mem 0x90000000-0xdfffffff 64bit pref]
pci 0000:05:08.0: PCI bridge to [bus 06-15]
pci 0000:05:08.0:   bridge window [io  0x1000-0x5fff]
pci 0000:05:08.0:   bridge window [mem 0xfa800000-0xfb0fffff]
pci 0000:05:08.0:   bridge window [mem 0x90000000-0xdfffffff 64bit pref]
pci 0000:04:00.0: PCI bridge to [bus 05-15]
pci 0000:04:00.0:   bridge window [io  0x1000-0x5fff]
pci 0000:04:00.0:   bridge window [mem 0xfa800000-0xfb0fffff]
pci 0000:04:00.0:   bridge window [mem 0x90000000-0xdfffffff 64bit pref]
pci 0000:00:03.0: PCI bridge to [bus 04-15]
pci 0000:00:03.0:   bridge window [io  0x1000-0x5fff]
pci 0000:00:03.0:   bridge window [mem 0xfa800000-0xfb1fffff]
pci 0000:00:03.0:   bridge window [mem 0x90000000-0xdfffffff 64bit pref]
pci 0000:16:00.0: PCI bridge to [bus 17-17]
pci 0000:16:00.0:   bridge window [io  0xe000-0xefff]
pci 0000:16:00.0:   bridge window [mem 0xf9000000-0xfa0fffff]
pci 0000:16:00.0:   bridge window [mem pref disabled]
pci 0000:00:1c.0: PCI bridge to [bus 16-17]
pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
pci 0000:00:1c.0:   bridge window [mem 0xf9000000-0xfa0fffff]
pci 0000:00:1c.0:   bridge window [mem pref disabled]
pci 0000:00:1c.2: PCI bridge to [bus 18-18]
pci 0000:00:1c.2:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.2:   bridge window [mem 0xfb400000-0xfb4fffff]
pci 0000:00:1c.2:   bridge window [mem pref disabled]
pci 0000:00:1c.3: PCI bridge to [bus 19-19]
pci 0000:00:1c.3:   bridge window [io  0xc000-0xcfff]
pci 0000:00:1c.3:   bridge window [mem 0xfb300000-0xfb3fffff]
pci 0000:00:1c.3:   bridge window [mem pref disabled]
pci 0000:00:01.0: PCI INT A -> GSI 26 (level, low) -> IRQ 26
pci 0000:00:01.0: setting latency timer to 64
pci 0000:00:02.0: PCI INT A -> GSI 32 (level, low) -> IRQ 32
pci 0000:00:02.0: setting latency timer to 64
pci 0000:00:02.2: PCI INT A -> GSI 32 (level, low) -> IRQ 32
pci 0000:00:02.2: setting latency timer to 64
pci 0000:00:03.0: PCI INT A -> GSI 40 (level, low) -> IRQ 40
pci 0000:00:03.0: setting latency timer to 64
pci 0000:04:00.0: PCI INT A -> GSI 40 (level, low) -> IRQ 40
pci 0000:04:00.0: setting latency timer to 64
pci 0000:05:08.0: PCI INT A -> GSI 40 (level, low) -> IRQ 40
pci 0000:05:08.0: setting latency timer to 64
pci 0000:06:00.0: PCI INT A -> GSI 40 (level, low) -> IRQ 40
pci 0000:06:00.0: setting latency timer to 64
pci 0000:07:00.0: PCI INT A -> GSI 40 (level, low) -> IRQ 40
pci 0000:07:00.0: setting latency timer to 64
pci 0000:08:00.0: PCI INT A -> GSI 40 (level, low) -> IRQ 40
pci 0000:08:00.0: setting latency timer to 64
pci 0000:09:04.0: PCI INT A -> GSI 40 (level, low) -> IRQ 40
pci 0000:09:04.0: setting latency timer to 64
pci 0000:09:08.0: PCI INT A -> GSI 40 (level, low) -> IRQ 40
pci 0000:09:08.0: setting latency timer to 64
pci 0000:09:09.0: PCI INT A -> GSI 44 (level, low) -> IRQ 44
pci 0000:09:09.0: setting latency timer to 64
pci 0000:09:0c.0: PCI INT A -> GSI 40 (level, low) -> IRQ 40
pci 0000:09:0c.0: setting latency timer to 64
pci 0000:09:0d.0: PCI INT A -> GSI 44 (level, low) -> IRQ 44
pci 0000:09:0d.0: setting latency timer to 64
pci 0000:09:0e.0: PCI INT A -> GSI 45 (level, low) -> IRQ 45
pci 0000:09:0e.0: setting latency timer to 64
pci 0000:09:0f.0: PCI INT A -> GSI 46 (level, low) -> IRQ 46
pci 0000:09:0f.0: setting latency timer to 64
pci 0000:09:10.0: PCI INT A -> GSI 40 (level, low) -> IRQ 40
pci 0000:09:10.0: setting latency timer to 64
pci 0000:09:11.0: PCI INT A -> GSI 44 (level, low) -> IRQ 44
pci 0000:09:11.0: setting latency timer to 64
pci 0000:09:14.0: PCI INT A -> GSI 40 (level, low) -> IRQ 40
pci 0000:09:14.0: setting latency timer to 64
pci 0000:09:19.0: PCI INT A -> GSI 44 (level, low) -> IRQ 44
pci 0000:09:19.0: setting latency timer to 64
pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:1c.0: setting latency timer to 64
pci 0000:16:00.0: setting latency timer to 64
pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
pci 0000:00:1c.2: setting latency timer to 64
pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
pci 0000:00:1c.3: setting latency timer to 64
pci_bus 0000:00: resource 4 [io  0x0000-0x03af]
pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7]
pci_bus 0000:00: resource 6 [io  0x03b0-0x03df]
pci_bus 0000:00: resource 7 [io  0x1000-0xffff]
pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff]
pci_bus 0000:00: resource 9 [mem 0xfedb0000-0xfedb000f]
pci_bus 0000:00: resource 10 [mem 0xfedc0000-0xfedc000f]
pci_bus 0000:00: resource 11 [mem 0x90000000-0xfbffbfff]
pci_bus 0000:00: resource 12 [mem 0x380000000000-0x38ffffffffff]
pci_bus 0000:04: resource 0 [io  0x1000-0x5fff]
pci_bus 0000:04: resource 1 [mem 0xfa800000-0xfb1fffff]
pci_bus 0000:04: resource 2 [mem 0x90000000-0xdfffffff 64bit pref]
pci_bus 0000:05: resource 0 [io  0x1000-0x5fff]
pci_bus 0000:05: resource 1 [mem 0xfa800000-0xfb0fffff]
pci_bus 0000:05: resource 2 [mem 0x90000000-0xdfffffff 64bit pref]
pci_bus 0000:06: resource 0 [io  0x1000-0x5fff]
pci_bus 0000:06: resource 1 [mem 0xfa800000-0xfb0fffff]
pci_bus 0000:06: resource 2 [mem 0x90000000-0xdfffffff 64bit pref]
pci_bus 0000:07: resource 0 [io  0x1000-0x5fff]
pci_bus 0000:07: resource 1 [mem 0xfa800000-0xfaffffff]
pci_bus 0000:07: resource 2 [mem 0x90000000-0xdfffffff 64bit pref]
pci_bus 0000:08: resource 0 [io  0x1000-0x5fff]
pci_bus 0000:08: resource 1 [mem 0xfa800000-0xfaffffff]
pci_bus 0000:08: resource 2 [mem 0x90000000-0xdfffffff 64bit pref]
pci_bus 0000:09: resource 0 [io  0x1000-0x5fff]
pci_bus 0000:09: resource 1 [mem 0xfa800000-0xfaffffff]
pci_bus 0000:09: resource 2 [mem 0x90000000-0xdfffffff 64bit pref]
pci_bus 0000:0a: resource 0 [io  0x1000-0x1fff]
pci_bus 0000:0a: resource 2 [mem 0x90000000-0x9fffffff 64bit pref]
pci_bus 0000:0c: resource 0 [io  0x2000-0x2fff]
pci_bus 0000:0c: resource 2 [mem 0xa0000000-0xafffffff 64bit pref]
pci_bus 0000:0e: resource 0 [io  0x3000-0x3fff]
pci_bus 0000:0e: resource 2 [mem 0xb0000000-0xbfffffff 64bit pref]
pci_bus 0000:12: resource 0 [io  0x4000-0x4fff]
pci_bus 0000:12: resource 2 [mem 0xc0000000-0xcfffffff 64bit pref]
pci_bus 0000:13: resource 0 [io  0x5000-0x5fff]
pci_bus 0000:13: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
pci_bus 0000:14: resource 1 [mem 0xfa800000-0xfaffffff]
pci_bus 0000:16: resource 0 [io  0xe000-0xefff]
pci_bus 0000:16: resource 1 [mem 0xf9000000-0xfa0fffff]
pci_bus 0000:17: resource 0 [io  0xe000-0xefff]
pci_bus 0000:17: resource 1 [mem 0xf9000000-0xfa0fffff]
pci_bus 0000:18: resource 0 [io  0xd000-0xdfff]
pci_bus 0000:18: resource 1 [mem 0xfb400000-0xfb4fffff]
pci_bus 0000:19: resource 0 [io  0xc000-0xcfff]
pci_bus 0000:19: resource 1 [mem 0xfb300000-0xfb3fffff]
NET: Registered protocol family 2

On Tue, Apr 19, 2016 at 4:40 PM, Kallol Biswas <kallol@nucleodyne.com> wrote:
> Looking at boot time dmesg I see pci resource assignment happens two times.
> In the first pass, everything looks normal, 2nd pass does not look good. Why
> would OS go for 2nd pass?
>
> 1st pass:
>
> ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus ff])
> pci 0000:ff:0b.0: [8086:2f81] type 0 class 0x000880
> pci 0000:ff:0b.1: [8086:2f36] type 0 class 0x001101
> pci 0000:ff:0b.2: [8086:2f37] type 0 class 0x001101
> pci 0000:ff:0c.0: [8086:2fe0] type 0 class 0x000880
> pci 0000:ff:0c.1: [8086:2fe1] type 0 class 0x000880
> pci 0000:ff:0c.2: [8086:2fe2] type 0 class 0x000880
> pci 0000:ff:0c.3: [8086:2fe3] type 0 class 0x000880
> pci 0000:ff:0f.0: [8086:2ff8] type 0 class 0x000880
> pci 0000:ff:0f.1: [8086:2ff9] type 0 class 0x000880
> pci 0000:ff:0f.4: [8086:2ffc] type 0 class 0x000880
> pci 0000:ff:0f.5: [8086:2ffd] type 0 class 0x000880
> pci 0000:ff:0f.6: [8086:2ffe] type 0 class 0x000880
> pci 0000:ff:10.0: [8086:2f1d] type 0 class 0x000880
> pci 0000:ff:10.1: [8086:2f34] type 0 class 0x001101
> pci 0000:ff:10.5: [8086:2f1e] type 0 class 0x000880
> pci 0000:ff:10.6: [8086:2f7d] type 0 class 0x001101
> pci 0000:ff:10.7: [8086:2f1f] type 0 class 0x000880
> pci 0000:ff:12.0: [8086:2fa0] type 0 class 0x000880
> pci 0000:ff:12.1: [8086:2f30] type 0 class 0x001101
> pci 0000:ff:13.0: [8086:2fa8] type 0 class 0x000880
> pci 0000:ff:13.1: [8086:2f71] type 0 class 0x000880
> pci 0000:ff:13.2: [8086:2faa] type 0 class 0x000880
> pci 0000:ff:13.3: [8086:2fab] type 0 class 0x000880
> pci 0000:ff:13.4: [8086:2fac] type 0 class 0x000880
> pci 0000:ff:13.5: [8086:2fad] type 0 class 0x000880
> pci 0000:ff:13.6: [8086:2fae] type 0 class 0x000880
> pci 0000:ff:13.7: [8086:2faf] type 0 class 0x000880
> pci 0000:ff:14.0: [8086:2fb0] type 0 class 0x000880
> pci 0000:ff:14.1: [8086:2fb1] type 0 class 0x000880
> pci 0000:ff:14.2: [8086:2fb2] type 0 class 0x000880
> pci 0000:ff:14.3: [8086:2fb3] type 0 class 0x000880
> pci 0000:ff:14.6: [8086:2fbe] type 0 class 0x000880
> pci 0000:ff:14.7: [8086:2fbf] type 0 class 0x000880
> pci 0000:ff:15.0: [8086:2fb4] type 0 class 0x000880
> pci 0000:ff:15.1: [8086:2fb5] type 0 class 0x000880
> pci 0000:ff:15.2: [8086:2fb6] type 0 class 0x000880
> pci 0000:ff:15.3: [8086:2fb7] type 0 class 0x000880
> pci 0000:ff:16.0: [8086:2f68] type 0 class 0x000880
> pci 0000:ff:16.6: [8086:2f6e] type 0 class 0x000880
> pci 0000:ff:16.7: [8086:2f6f] type 0 class 0x000880
> pci 0000:ff:17.0: [8086:2fd0] type 0 class 0x000880
> pci 0000:ff:17.4: [8086:2fb8] type 0 class 0x000880
> pci 0000:ff:17.5: [8086:2fb9] type 0 class 0x000880
> pci 0000:ff:17.6: [8086:2fba] type 0 class 0x000880
> pci 0000:ff:17.7: [8086:2fbb] type 0 class 0x000880
> pci 0000:ff:1e.0: [8086:2f98] type 0 class 0x000880
> pci 0000:ff:1e.1: [8086:2f99] type 0 class 0x000880
> pci 0000:ff:1e.2: [8086:2f9a] type 0 class 0x000880
> pci 0000:ff:1e.3: [8086:2fc0] type 0 class 0x000880
> pci 0000:ff:1e.3: reg 10: [io  0x0020-0x003f]
> pci 0000:ff:1e.4: [8086:2f9c] type 0 class 0x000880
> pci 0000:ff:1f.0: [8086:2f88] type 0 class 0x000880
> pci 0000:ff:1f.2: [8086:2f8a] type 0 class 0x000880
> ACPI: PCI Interrupt Routing Table [\_SB_.UNC0._PRT]
>  pci0000:ff: Requesting ACPI _OSC control (0x1d)
>  pci0000:ff: ACPI _OSC control (0x15) granted
> ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
> pci_root PNP0A08:00: host bridge window [io  0x0000-0x03af]
> pci_root PNP0A08:00: host bridge window [io  0x03e0-0x0cf7]
> pci_root PNP0A08:00: host bridge window [io  0x03b0-0x03df]
> pci_root PNP0A08:00: host bridge window [io  0x1000-0xffff]
> pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
> pci_root PNP0A08:00: host bridge window [mem 0xfedb0000-0xfedb000f]
> pci_root PNP0A08:00: host bridge window [mem 0xfedc0000-0xfedc000f]
> pci_root PNP0A08:00: host bridge window [mem 0x90000000-0xfbffbfff]
> pci_root PNP0A08:00: host bridge window [mem 0x380000000000-0x38ffffffffff]
> pci 0000:00:00.0: [8086:2f00] type 0 class 0x000600
> pci 0000:00:01.0: [8086:2f02] type 1 class 0x000604
> pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
> pci 0000:00:01.0: PME# disabled
> pci 0000:00:02.0: [8086:2f04] type 1 class 0x000604
> pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
> pci 0000:00:02.0: PME# disabled
> pci 0000:00:02.2: [8086:2f06] type 1 class 0x000604
> pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
> pci 0000:00:02.2: PME# disabled
> pci 0000:00:03.0: [8086:2f08] type 1 class 0x000604
> pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
> pci 0000:00:03.0: PME# disabled
> pci 0000:00:04.0: [8086:2f20] type 0 class 0x000880
> pci 0000:00:04.0: reg 10: [mem 0x38fffff2c000-0x38fffff2ffff 64bit]
> pci 0000:00:04.1: [8086:2f21] type 0 class 0x000880
> pci 0000:00:04.1: reg 10: [mem 0x38fffff28000-0x38fffff2bfff 64bit]
> pci 0000:00:04.2: [8086:2f22] type 0 class 0x000880
> pci 0000:00:04.2: reg 10: [mem 0x38fffff24000-0x38fffff27fff 64bit]
> pci 0000:00:04.3: [8086:2f23] type 0 class 0x000880
> pci 0000:00:04.3: reg 10: [mem 0x38fffff20000-0x38fffff23fff 64bit]
> pci 0000:00:04.4: [8086:2f24] type 0 class 0x000880
> pci 0000:00:04.4: reg 10: [mem 0x38fffff1c000-0x38fffff1ffff 64bit]
> pci 0000:00:04.5: [8086:2f25] type 0 class 0x000880
> pci 0000:00:04.5: reg 10: [mem 0x38fffff18000-0x38fffff1bfff 64bit]
> pci 0000:00:04.6: [8086:2f26] type 0 class 0x000880
> pci 0000:00:04.6: reg 10: [mem 0x38fffff14000-0x38fffff17fff 64bit]
> pci 0000:00:04.7: [8086:2f27] type 0 class 0x000880
> pci 0000:00:04.7: reg 10: [mem 0x38fffff10000-0x38fffff13fff 64bit]
> pci 0000:00:05.0: [8086:2f28] type 0 class 0x000880
> pci 0000:00:05.1: [8086:2f29] type 0 class 0x000880
> pci 0000:00:05.2: [8086:2f2a] type 0 class 0x000880
> pci 0000:00:05.4: [8086:2f2c] type 0 class 0x000800
> pci 0000:00:05.4: reg 10: [mem 0xfa107000-0xfa107fff]
> pci 0000:00:11.0: [8086:8d7c] type 0 class 0x00ff00
> pci 0000:00:11.4: [8086:8d62] type 0 class 0x000106
> pci 0000:00:11.4: reg 10: [io  0xf110-0xf117]
> pci 0000:00:11.4: reg 14: [io  0xf100-0xf103]
> pci 0000:00:11.4: reg 18: [io  0xf0f0-0xf0f7]
> pci 0000:00:11.4: reg 1c: [io  0xf0e0-0xf0e3]
> pci 0000:00:11.4: reg 20: [io  0xf020-0xf03f]
> pci 0000:00:11.4: reg 24: [mem 0xfa106000-0xfa1067ff]
> pci 0000:00:11.4: PME# supported from D3hot
> pci 0000:00:11.4: PME# disabled
> pci 0000:00:14.0: [8086:8d31] type 0 class 0x000c03
> pci 0000:00:14.0: reg 10: [mem 0x38fffff00000-0x38fffff0ffff 64bit]
> pci 0000:00:14.0: PME# supported from D3hot D3cold
> pci 0000:00:14.0: PME# disabled
> pci 0000:00:16.0: [8086:8d3a] type 0 class 0x000780
> pci 0000:00:16.0: reg 10: [mem 0xfa105000-0xfa10500f 64bit]
> pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
> pci 0000:00:16.0: PME# disabled
> pci 0000:00:16.1: [8086:8d3b] type 0 class 0x000780
> pci 0000:00:16.1: reg 10: [mem 0xfa104000-0xfa10400f 64bit]
> pci 0000:00:16.1: PME# supported from D0 D3hot D3cold
> pci 0000:00:16.1: PME# disabled
> pci 0000:00:1a.0: [8086:8d2d] type 0 class 0x000c03
> pci 0000:00:1a.0: reg 10: [mem 0xfa102000-0xfa1023ff]
> pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
> pci 0000:00:1a.0: PME# disabled
> pci 0000:00:1c.0: [8086:8d10] type 1 class 0x000604
> pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> pci 0000:00:1c.0: PME# disabled
> pci 0000:00:1c.2: [8086:8d14] type 1 class 0x000604
> pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
> pci 0000:00:1c.2: PME# disabled
> pci 0000:00:1c.3: [8086:8d16] type 1 class 0x000604
> pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
> pci 0000:00:1c.3: PME# disabled
> pci 0000:00:1d.0: [8086:8d26] type 0 class 0x000c03
> pci 0000:00:1d.0: reg 10: [mem 0xfa101000-0xfa1013ff]
> pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
> pci 0000:00:1d.0: PME# disabled
> pci 0000:00:1f.0: [8086:8d44] type 0 class 0x000601
> pci 0000:00:1f.2: [8086:8d02] type 0 class 0x000106
> pci 0000:00:1f.2: reg 10: [io  0xf070-0xf077]
> pci 0000:00:1f.2: reg 14: [io  0xf060-0xf063]
> pci 0000:00:1f.2: reg 18: [io  0xf050-0xf057]
> pci 0000:00:1f.2: reg 1c: [io  0xf040-0xf043]
> pci 0000:00:1f.2: reg 20: [io  0xf000-0xf01f]
> pci 0000:00:1f.2: reg 24: [mem 0xfa100000-0xfa1007ff]
> pci 0000:00:1f.2: PME# supported from D3hot
> pci 0000:00:1f.2: PME# disabled
> pci 0000:00:1f.3: [8086:8d22] type 0 class 0x000c05
> pci 0000:00:1f.3: reg 10: [mem 0x38fffff31000-0x38fffff310ff 64bit]
> pci 0000:00:1f.3: reg 20: [io  0x0580-0x059f]
> pci 0000:00:1f.6: [8086:8d24] type 0 class 0x001180
> pci 0000:00:1f.6: reg 10: [mem 0x38fffff30000-0x38fffff30fff 64bit]
> pci 0000:00:01.0: PCI bridge to [bus 01-ff]
> pci 0000:00:01.0:   bridge window [io  0xf000-0x0000] (disabled)
> pci 0000:00:01.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
> pci 0000:00:01.0:   bridge window [mem 0xfff00000-0x000fffff pref]
> (disabled)
> pci 0000:00:02.0: PCI bridge to [bus 02-ff]
> pci 0000:00:02.0:   bridge window [io  0xf000-0x0000] (disabled)
> pci 0000:00:02.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
> pci 0000:00:02.0:   bridge window [mem 0xfff00000-0x000fffff pref]
> (disabled)
> pci 0000:00:02.2: PCI bridge to [bus 03-ff]
> pci 0000:00:02.2:   bridge window [io  0xf000-0x0000] (disabled)
> pci 0000:00:02.2:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
> pci 0000:00:02.2:   bridge window [mem 0xfff00000-0x000fffff pref]
> (disabled)
> pci 0000:04:00.0: [10b5:8732] type 1 class 0x000604
> pci 0000:04:00.0: reg 10: [mem 0xfb100000-0xfb13ffff]
> pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
> pci 0000:04:00.0: PME# disabled
> pci 0000:00:03.0: PCI bridge to [bus 04-ff]
> pci 0000:00:03.0:   bridge window [io  0xf000-0x0000] (disabled)
> pci 0000:00:03.0:   bridge window [mem 0xfa800000-0xfb1fffff]
> pci 0000:00:03.0:   bridge window [mem 0xfff00000-0x000fffff pref]
> (disabled)
> pci 0000:05:08.0: [10b5:8732] type 1 class 0x000604
> pci 0000:05:08.0: PME# supported from D0 D3hot D3cold
> pci 0000:05:08.0: PME# disabled
> pci 0000:04:00.0: PCI bridge to [bus 05-ff]
> pci 0000:04:00.0:   bridge window [io  0xfff000-0x0000] (disabled)
> pci 0000:04:00.0:   bridge window [mem 0xfa800000-0xfb0fffff]
> pci 0000:04:00.0:   bridge window [mem 0xfff00000-0x000fffff pref]
> (disabled)
> pci 0000:06:00.0: [10b5:8732] type 1 class 0x000604
> pci 0000:06:00.0: reg 10: [mem 0xfb000000-0xfb03ffff]
> pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
> pci 0000:06:00.0: PME# disabled
> pci 0000:05:08.0: PCI bridge to [bus 06-ff]
> pci 0000:05:08.0:   bridge window [io  0xfff000-0x0000] (disabled)
> pci 0000:05:08.0:   bridge window [mem 0xfa800000-0xfb0fffff]
> pci 0000:05:08.0:   bridge window [mem 0xfff00000-0x000fffff pref]
> (disabled)
> pci 0000:07:00.0: [10b5:8732] type 1 class 0x000604
> pci 0000:07:00.0: PME# supported from D0 D3hot D3cold
> pci 0000:07:00.0: PME# disabled
> pci 0000:06:00.0: PCI bridge to [bus 07-ff]
> pci 0000:06:00.0:   bridge window [io  0xfff000-0x0000] (disabled)
> pci 0000:06:00.0:   bridge window [mem 0xfa800000-0xfaffffff]
> pci 0000:06:00.0:   bridge window [mem 0xfff00000-0x000fffff pref]
> (disabled)
> pci 0000:08:00.0: [10b5:9797] type 1 class 0x000604
> pci 0000:08:00.0: PME# supported from D0 D3hot D3cold
> pci 0000:08:00.0: PME# disabled
> pci 0000:07:00.0: PCI bridge to [bus 08-ff]
> pci 0000:07:00.0:   bridge window [io  0xfff000-0x0000] (disabled)
> pci 0000:07:00.0:   bridge window [mem 0xfa800000-0xfaffffff]
> pci 0000:07:00.0:   bridge window [mem 0xfff00000-0x000fffff pref]
> (disabled)
> pci 0000:09:04.0: [10b5:9797] type 1 class 0x000604
> pci 0000:09:04.0: PME# supported from D0 D3hot D3cold
> pci 0000:09:04.0: PME# disabled
> pci 0000:09:08.0: [10b5:9797] type 1 class 0x000604
> pci 0000:09:08.0: PME# supported from D0 D3hot D3cold
> pci 0000:09:08.0: PME# disabled
> pci 0000:09:09.0: [10b5:9797] type 1 class 0x000604
> pci 0000:09:09.0: PME# supported from D0 D3hot D3cold
> pci 0000:09:09.0: PME# disabled
> pci 0000:09:0c.0: [10b5:9797] type 1 class 0x000604
> pci 0000:09:0c.0: PME# supported from D0 D3hot D3cold
> pci 0000:09:0c.0: PME# disabled
> pci 0000:09:0d.0: [10b5:9797] type 1 class 0x000604
> pci 0000:09:0d.0: PME# supported from D0 D3hot D3cold
> pci 0000:09:0d.0: PME# disabled
> pci 0000:09:0e.0: [10b5:9797] type 1 class 0x000604
> pci 0000:09:0e.0: PME# supported from D0 D3hot D3cold
> pci 0000:09:0e.0: PME# disabled
> pci 0000:09:0f.0: [10b5:9797] type 1 class 0x000604
> pci 0000:09:0f.0: PME# supported from D0 D3hot D3cold
> pci 0000:09:0f.0: PME# disabled
> pci 0000:09:10.0: [10b5:9797] type 1 class 0x000604
> pci 0000:09:10.0: PME# supported from D0 D3hot D3cold
> pci 0000:09:10.0: PME# disabled
> pci 0000:09:11.0: [10b5:9797] type 1 class 0x000604
> pci 0000:09:11.0: PME# supported from D0 D3hot D3cold
> pci 0000:09:11.0: PME# disabled
> pci 0000:09:14.0: [10b5:9797] type 1 class 0x000604
> pci 0000:09:14.0: PME# supported from D0 D3hot D3cold
> pci 0000:09:14.0: PME# disabled
> pci 0000:09:19.0: [10b5:9797] type 1 class 0x000604
> pci 0000:09:19.0: PME# supported from D0 D3hot D3cold
> pci 0000:09:19.0: PME# disabled
> pci 0000:08:00.0: PCI bridge to [bus 09-ff]
> pci 0000:08:00.0:   bridge window [io  0xfff000-0x0000] (disabled)
> pci 0000:08:00.0:   bridge window [mem 0xfa800000-0xfaffffff]
> pci 0000:08:00.0:   bridge window [mem 0xfff00000-0x000fffff pref]
> (disabled)
> pci 0000:09:04.0: PCI bridge to [bus 0a-ff]
> pci 0000:09:04.0:   bridge window [io  0xfff000-0x0000] (disabled)
> pci 0000:09:04.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
> pci 0000:09:04.0:   bridge window [mem 0xfff00000-0x000fffff pref]
> (disabled)
> pci 0000:09:08.0: PCI bridge to [bus 0b-ff]
> pci 0000:09:08.0:   bridge window [io  0xfff000-0x0000] (disabled)
> pci 0000:09:08.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
> pci 0000:09:08.0:   bridge window [mem 0xfff00000-0x000fffff pref]
> (disabled)
> pci 0000:09:09.0: PCI bridge to [bus 0c-ff]
> pci 0000:09:09.0:   bridge window [io  0xfff000-0x0000] (disabled)
> pci 0000:09:09.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
> pci 0000:09:09.0:   bridge window [mem 0xfff00000-0x000fffff pref]
> (disabled)
> pci 0000:09:0c.0: PCI bridge to [bus 0d-ff]
> pci 0000:09:0c.0:   bridge window [io  0xfff000-0x0000] (disabled)
> pci 0000:09:0c.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
> pci 0000:09:0c.0:   bridge window [mem 0xfff00000-0x000fffff pref]
> (disabled)
> pci 0000:09:0d.0: PCI bridge to [bus 0e-ff]
> pci 0000:09:0d.0:   bridge window [io  0xfff000-0x0000] (disabled)
> pci 0000:09:0d.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
> pci 0000:09:0d.0:   bridge window [mem 0xfff00000-0x000fffff pref]
> (disabled)
> pci 0000:09:0e.0: PCI bridge to [bus 0f-ff]
> pci 0000:09:0e.0:   bridge window [io  0xfff000-0x0000] (disabled)
> pci 0000:09:0e.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
> pci 0000:09:0e.0:   bridge window [mem 0xfff00000-0x000fffff pref]
> (disabled)
> pci 0000:09:0f.0: PCI bridge to [bus 10-ff]
> pci 0000:09:0f.0:   bridge window [io  0xfff000-0x0000] (disabled)
> pci 0000:09:0f.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
> pci 0000:09:0f.0:   bridge window [mem 0xfff00000-0x000fffff pref]
> (disabled)
> pci 0000:09:10.0: PCI bridge to [bus 11-ff]
> pci 0000:09:10.0:   bridge window [io  0xfff000-0x0000] (disabled)
> pci 0000:09:10.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
> pci 0000:09:10.0:   bridge window [mem 0xfff00000-0x000fffff pref]
> (disabled)
> pci 0000:09:11.0: PCI bridge to [bus 12-ff]
> pci 0000:09:11.0:   bridge window [io  0xfff000-0x0000] (disabled)
> pci 0000:09:11.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
> pci 0000:09:11.0:   bridge window [mem 0xfff00000-0x000fffff pref]
> (disabled)
> pci 0000:09:14.0: PCI bridge to [bus 13-ff]
> pci 0000:09:14.0:   bridge window [io  0xfff000-0x0000] (disabled)
> pci 0000:09:14.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
> pci 0000:09:14.0:   bridge window [mem 0xfff00000-0x000fffff pref]
> (disabled)
> pci 0000:14:00.0: [10b5:1009] type 0 class 0x000880
> pci 0000:14:00.0: reg 10: [mem 0xfa800000-0xfaffffff]
> pci 0000:09:19.0: PCI bridge to [bus 14-ff]
> pci 0000:09:19.0:   bridge window [io  0xfff000-0x0000] (disabled)
> pci 0000:09:19.0:   bridge window [mem 0xfa800000-0xfaffffff]
> pci 0000:09:19.0:   bridge window [mem 0xfff00000-0x000fffff pref]
> (disabled)
> pci 0000:16:00.0: [1a03:1150] type 1 class 0x000604
> pci 0000:16:00.0: supports D1 D2
> pci 0000:16:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:16:00.0: PME# disabled
> pci 0000:16:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it
> with 'pcie_aspm=force'
> pci 0000:00:1c.0: PCI bridge to [bus 16-ff]
> pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
> pci 0000:00:1c.0:   bridge window [mem 0xf9000000-0xfa0fffff]
> pci 0000:00:1c.0:   bridge window [mem 0xfff00000-0x000fffff pref]
> (disabled)
> pci 0000:17:00.0: [1a03:2000] type 0 class 0x000300
> pci 0000:17:00.0: reg 10: [mem 0xf9000000-0xf9ffffff]
> pci 0000:17:00.0: reg 14: [mem 0xfa000000-0xfa01ffff]
> pci 0000:17:00.0: reg 18: [io  0xe000-0xe07f]
> pci 0000:17:00.0: supports D1 D2
> pci 0000:17:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:17:00.0: PME# disabled
> pci 0000:16:00.0: PCI bridge to [bus 17-ff]
> pci 0000:16:00.0:   bridge window [io  0xe000-0xefff]
> pci 0000:16:00.0:   bridge window [mem 0xf9000000-0xfa0fffff]
> pci 0000:16:00.0:   bridge window [mem 0xfff00000-0x000fffff pref]
> (disabled)
> pci 0000:18:00.0: [8086:1533] type 0 class 0x000200
> pci 0000:18:00.0: reg 10: [mem 0xfb400000-0xfb47ffff]
> pci 0000:18:00.0: reg 18: [io  0xd000-0xd01f]
> pci 0000:18:00.0: reg 1c: [mem 0xfb480000-0xfb483fff]
> pci 0000:18:00.0: PME# supported from D0 D3hot D3cold
> pci 0000:18:00.0: PME# disabled
> pci 0000:00:1c.2: PCI bridge to [bus 18-ff]
> pci 0000:00:1c.2:   bridge window [io  0xd000-0xdfff]
> pci 0000:00:1c.2:   bridge window [mem 0xfb400000-0xfb4fffff]
> pci 0000:00:1c.2:   bridge window [mem 0xfff00000-0x000fffff pref]
> (disabled)
> pci 0000:19:00.0: [8086:1533] type 0 class 0x000200
> pci 0000:19:00.0: reg 10: [mem 0xfb300000-0xfb37ffff]
> pci 0000:19:00.0: reg 18: [io  0xc000-0xc01f]
> pci 0000:19:00.0: reg 1c: [mem 0xfb380000-0xfb383fff]
> pci 0000:19:00.0: PME# supported from D0 D3hot D3cold
> pci 0000:19:00.0: PME# disabled
> pci 0000:00:1c.3: PCI bridge to [bus 19-ff]
> pci 0000:00:1c.3:   bridge window [io  0xc000-0xcfff]
> pci 0000:00:1c.3:   bridge window [mem 0xfb300000-0xfb3fffff]
> pci 0000:00:1c.3:   bridge window [mem 0xfff00000-0x000fffff pref]
> (disabled)
> pci_bus 0000:00: on NUMA node 0 (pxm 0)
>
>
> 2nd pass:
>
> pci 0000:ff:1e.3: BAR 0: trying firmware assignment [io  0x0020-0x003f]
> pci 0000:ff:1e.3: BAR 0: [io  0x0020-0x003f] conflicts with PCI Bus 0000:00
> [io  0x0000-0x03af]
> pci 0000:ff:1e.3: BAR 0: can't assign io (size 0x20)
> pci 0000:00:03.0: BAR 15: assigned [mem 0x90000000-0xdfffffff 64bit pref]
> pci 0000:00:03.0: BAR 13: assigned [io  0x1000-0x5fff]
> pci 0000:00:01.0: PCI bridge to [bus 01-01]
> pci 0000:00:01.0:   bridge window [io  disabled]
> pci 0000:00:01.0:   bridge window [mem disabled]
> pci 0000:00:01.0:   bridge window [mem pref disabled]
> pci 0000:00:02.0: PCI bridge to [bus 02-02]
> pci 0000:00:02.0:   bridge window [io  disabled]
> pci 0000:00:02.0:   bridge window [mem disabled]
> pci 0000:00:02.0:   bridge window [mem pref disabled]
> pci 0000:00:02.2: PCI bridge to [bus 03-03]
> pci 0000:00:02.2:   bridge window [io  disabled]
> pci 0000:00:02.2:   bridge window [mem disabled]
> pci 0000:00:02.2:   bridge window [mem pref disabled]
> pci 0000:04:00.0: BAR 15: assigned [mem 0x90000000-0xdfffffff 64bit pref]
> pci 0000:04:00.0: BAR 13: assigned [io  0x1000-0x5fff]
> pci 0000:05:08.0: BAR 15: assigned [mem 0x90000000-0xdfffffff 64bit pref]
> pci 0000:05:08.0: BAR 13: assigned [io  0x1000-0x5fff]
> pci 0000:06:00.0: BAR 15: assigned [mem 0x90000000-0xdfffffff 64bit pref]
> pci 0000:06:00.0: BAR 13: assigned [io  0x1000-0x5fff]
> pci 0000:07:00.0: BAR 15: assigned [mem 0x90000000-0xdfffffff 64bit pref]
> pci 0000:07:00.0: BAR 13: assigned [io  0x1000-0x5fff]
> pci 0000:08:00.0: BAR 15: assigned [mem 0x90000000-0xdfffffff 64bit pref]
> pci 0000:08:00.0: BAR 13: assigned [io  0x1000-0x5fff]
> pci 0000:09:04.0: BAR 14: can't assign mem (size 0x10000000)
> pci 0000:09:04.0: BAR 15: assigned [mem 0x90000000-0x9fffffff 64bit pref]
> pci 0000:09:09.0: BAR 14: can't assign mem (size 0x10000000)
> pci 0000:09:09.0: BAR 15: assigned [mem 0xa0000000-0xafffffff 64bit pref]
> pci 0000:09:0d.0: BAR 14: can't assign mem (size 0x10000000)
> pci 0000:09:0d.0: BAR 15: assigned [mem 0xb0000000-0xbfffffff 64bit pref]
> pci 0000:09:11.0: BAR 14: can't assign mem (size 0x10000000)
> pci 0000:09:11.0: BAR 15: assigned [mem 0xc0000000-0xcfffffff 64bit pref]
> pci 0000:09:14.0: BAR 14: can't assign mem (size 0x10000000)
> pci 0000:09:14.0: BAR 15: assigned [mem 0xd0000000-0xdfffffff 64bit pref]
> pci 0000:09:04.0: BAR 13: assigned [io  0x1000-0x1fff]
> pci 0000:09:09.0: BAR 13: assigned [io  0x2000-0x2fff]
> pci 0000:09:0d.0: BAR 13: assigned [io  0x3000-0x3fff]
> pci 0000:09:11.0: BAR 13: assigned [io  0x4000-0x4fff]
> pci 0000:09:14.0: BAR 13: assigned [io  0x5000-0x5fff]
> pci 0000:09:04.0: PCI bridge to [bus 0a-0a]
> pci 0000:09:04.0:   bridge window [io  0x1000-0x1fff]
> pci 0000:09:04.0:   bridge window [mem disabled]
> pci 0000:09:04.0:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
> pci 0000:09:08.0: PCI bridge to [bus 0b-0b]
> pci 0000:09:08.0:   bridge window [io  disabled]
> pci 0000:09:08.0:   bridge window [mem disabled]
> pci 0000:09:08.0:   bridge window [mem pref disabled]
> pci 0000:09:09.0: PCI bridge to [bus 0c-0c]
> pci 0000:09:09.0:   bridge window [io  0x2000-0x2fff]
> pci 0000:09:09.0:   bridge window [mem disabled]
> pci 0000:09:09.0:   bridge window [mem 0xa0000000-0xafffffff 64bit pref]
> pci 0000:09:0c.0: PCI bridge to [bus 0d-0d]
> pci 0000:09:0c.0:   bridge window [io  disabled]
> pci 0000:09:0c.0:   bridge window [mem disabled]
> pci 0000:09:0c.0:   bridge window [mem pref disabled]
> pci 0000:09:0d.0: PCI bridge to [bus 0e-0e]
> pci 0000:09:0d.0:   bridge window [io  0x3000-0x3fff]
> pci 0000:09:0d.0:   bridge window [mem disabled]
> pci 0000:09:0d.0:   bridge window [mem 0xb0000000-0xbfffffff 64bit pref]
> pci 0000:09:0e.0: PCI bridge to [bus 0f-0f]
> pci 0000:09:0e.0:   bridge window [io  disabled]
> pci 0000:09:0e.0:   bridge window [mem disabled]
> pci 0000:09:0e.0:   bridge window [mem pref disabled]
> pci 0000:09:0f.0: PCI bridge to [bus 10-10]
> pci 0000:09:0f.0:   bridge window [io  disabled]
> pci 0000:09:0f.0:   bridge window [mem disabled]
> pci 0000:09:0f.0:   bridge window [mem pref disabled]
> pci 0000:09:10.0: PCI bridge to [bus 11-11]
> pci 0000:09:10.0:   bridge window [io  disabled]
> pci 0000:09:10.0:   bridge window [mem disabled]
> pci 0000:09:10.0:   bridge window [mem pref disabled]
> pci 0000:09:11.0: PCI bridge to [bus 12-12]
> pci 0000:09:11.0:   bridge window [io  0x4000-0x4fff]
> pci 0000:09:11.0:   bridge window [mem disabled]
> pci 0000:09:11.0:   bridge window [mem 0xc0000000-0xcfffffff 64bit pref]
> pci 0000:09:14.0: PCI bridge to [bus 13-13]
> pci 0000:09:14.0:   bridge window [io  0x5000-0x5fff]
> pci 0000:09:14.0:   bridge window [mem disabled]
> pci 0000:09:14.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
> pci 0000:09:19.0: PCI bridge to [bus 14-15]
> pci 0000:09:19.0:   bridge window [io  disabled]
> pci 0000:09:19.0:   bridge window [mem 0xfa800000-0xfaffffff]
> pci 0000:09:19.0:   bridge window [mem pref disabled]
> pci 0000:08:00.0: PCI bridge to [bus 09-15]
> pci 0000:08:00.0:   bridge window [io  0x1000-0x5fff]
> pci 0000:08:00.0:   bridge window [mem 0xfa800000-0xfaffffff]
> pci 0000:08:00.0:   bridge window [mem 0x90000000-0xdfffffff 64bit pref]
> pci 0000:07:00.0: PCI bridge to [bus 08-15]
> pci 0000:07:00.0:   bridge window [io  0x1000-0x5fff]
> pci 0000:07:00.0:   bridge window [mem 0xfa800000-0xfaffffff]
> pci 0000:07:00.0:   bridge window [mem 0x90000000-0xdfffffff 64bit pref]
> pci 0000:06:00.0: PCI bridge to [bus 07-15]
> pci 0000:06:00.0:   bridge window [io  0x1000-0x5fff]
> pci 0000:06:00.0:   bridge window [mem 0xfa800000-0xfaffffff]
> pci 0000:06:00.0:   bridge window [mem 0x90000000-0xdfffffff 64bit pref]
> pci 0000:05:08.0: PCI bridge to [bus 06-15]
> pci 0000:05:08.0:   bridge window [io  0x1000-0x5fff]
> pci 0000:05:08.0:   bridge window [mem 0xfa800000-0xfb0fffff]
> pci 0000:05:08.0:   bridge window [mem 0x90000000-0xdfffffff 64bit pref]
> pci 0000:04:00.0: PCI bridge to [bus 05-15]
> pci 0000:04:00.0:   bridge window [io  0x1000-0x5fff]
> pci 0000:04:00.0:   bridge window [mem 0xfa800000-0xfb0fffff]
> pci 0000:04:00.0:   bridge window [mem 0x90000000-0xdfffffff 64bit pref]
> pci 0000:00:03.0: PCI bridge to [bus 04-15]
> pci 0000:00:03.0:   bridge window [io  0x1000-0x5fff]
> pci 0000:00:03.0:   bridge window [mem 0xfa800000-0xfb1fffff]
> pci 0000:00:03.0:   bridge window [mem 0x90000000-0xdfffffff 64bit pref]
> pci 0000:16:00.0: PCI bridge to [bus 17-17]
> pci 0000:16:00.0:   bridge window [io  0xe000-0xefff]
> pci 0000:16:00.0:   bridge window [mem 0xf9000000-0xfa0fffff]
> pci 0000:16:00.0:   bridge window [mem pref disabled]
> pci 0000:00:1c.0: PCI bridge to [bus 16-17]
> pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
> pci 0000:00:1c.0:   bridge window [mem 0xf9000000-0xfa0fffff]
> pci 0000:00:1c.0:   bridge window [mem pref disabled]
> pci 0000:00:1c.2: PCI bridge to [bus 18-18]
> pci 0000:00:1c.2:   bridge window [io  0xd000-0xdfff]
> pci 0000:00:1c.2:   bridge window [mem 0xfb400000-0xfb4fffff]
> pci 0000:00:1c.2:   bridge window [mem pref disabled]
> pci 0000:00:1c.3: PCI bridge to [bus 19-19]
> pci 0000:00:1c.3:   bridge window [io  0xc000-0xcfff]
> pci 0000:00:1c.3:   bridge window [mem 0xfb300000-0xfb3fffff]
> pci 0000:00:1c.3:   bridge window [mem pref disabled]
> pci 0000:00:01.0: PCI INT A -> GSI 26 (level, low) -> IRQ 26
> pci 0000:00:01.0: setting latency timer to 64
> pci 0000:00:02.0: PCI INT A -> GSI 32 (level, low) -> IRQ 32
> pci 0000:00:02.0: setting latency timer to 64
> pci 0000:00:02.2: PCI INT A -> GSI 32 (level, low) -> IRQ 32
> pci 0000:00:02.2: setting latency timer to 64
> pci 0000:00:03.0: PCI INT A -> GSI 40 (level, low) -> IRQ 40
> pci 0000:00:03.0: setting latency timer to 64
> pci 0000:04:00.0: PCI INT A -> GSI 40 (level, low) -> IRQ 40
> pci 0000:04:00.0: setting latency timer to 64
> pci 0000:05:08.0: PCI INT A -> GSI 40 (level, low) -> IRQ 40
> pci 0000:05:08.0: setting latency timer to 64
> pci 0000:06:00.0: PCI INT A -> GSI 40 (level, low) -> IRQ 40
> pci 0000:06:00.0: setting latency timer to 64
> pci 0000:07:00.0: PCI INT A -> GSI 40 (level, low) -> IRQ 40
> pci 0000:07:00.0: setting latency timer to 64
> pci 0000:08:00.0: PCI INT A -> GSI 40 (level, low) -> IRQ 40
> pci 0000:08:00.0: setting latency timer to 64
> pci 0000:09:04.0: PCI INT A -> GSI 40 (level, low) -> IRQ 40
> pci 0000:09:04.0: setting latency timer to 64
> pci 0000:09:08.0: PCI INT A -> GSI 40 (level, low) -> IRQ 40
> pci 0000:09:08.0: setting latency timer to 64
> pci 0000:09:09.0: PCI INT A -> GSI 44 (level, low) -> IRQ 44
> pci 0000:09:09.0: setting latency timer to 64
> pci 0000:09:0c.0: PCI INT A -> GSI 40 (level, low) -> IRQ 40
> pci 0000:09:0c.0: setting latency timer to 64
> pci 0000:09:0d.0: PCI INT A -> GSI 44 (level, low) -> IRQ 44
> pci 0000:09:0d.0: setting latency timer to 64
> pci 0000:09:0e.0: PCI INT A -> GSI 45 (level, low) -> IRQ 45
> pci 0000:09:0e.0: setting latency timer to 64
> pci 0000:09:0f.0: PCI INT A -> GSI 46 (level, low) -> IRQ 46
> pci 0000:09:0f.0: setting latency timer to 64
> pci 0000:09:10.0: PCI INT A -> GSI 40 (level, low) -> IRQ 40
> pci 0000:09:10.0: setting latency timer to 64
> pci 0000:09:11.0: PCI INT A -> GSI 44 (level, low) -> IRQ 44
> pci 0000:09:11.0: setting latency timer to 64
> pci 0000:09:14.0: PCI INT A -> GSI 40 (level, low) -> IRQ 40
> pci 0000:09:14.0: setting latency timer to 64
> pci 0000:09:19.0: PCI INT A -> GSI 44 (level, low) -> IRQ 44
> pci 0000:09:19.0: setting latency timer to 64
> pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> pci 0000:00:1c.0: setting latency timer to 64
> pci 0000:16:00.0: setting latency timer to 64
> pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
> pci 0000:00:1c.2: setting latency timer to 64
> pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
> pci 0000:00:1c.3: setting latency timer to 64
> pci_bus 0000:00: resource 4 [io  0x0000-0x03af]
> pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7]
> pci_bus 0000:00: resource 6 [io  0x03b0-0x03df]
> pci_bus 0000:00: resource 7 [io  0x1000-0xffff]
> pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff]
> pci_bus 0000:00: resource 9 [mem 0xfedb0000-0xfedb000f]
> pci_bus 0000:00: resource 10 [mem 0xfedc0000-0xfedc000f]
> pci_bus 0000:00: resource 11 [mem 0x90000000-0xfbffbfff]
> pci_bus 0000:00: resource 12 [mem 0x380000000000-0x38ffffffffff]
> pci_bus 0000:04: resource 0 [io  0x1000-0x5fff]
> pci_bus 0000:04: resource 1 [mem 0xfa800000-0xfb1fffff]
> pci_bus 0000:04: resource 2 [mem 0x90000000-0xdfffffff 64bit pref]
> pci_bus 0000:05: resource 0 [io  0x1000-0x5fff]
> pci_bus 0000:05: resource 1 [mem 0xfa800000-0xfb0fffff]
> pci_bus 0000:05: resource 2 [mem 0x90000000-0xdfffffff 64bit pref]
> pci_bus 0000:06: resource 0 [io  0x1000-0x5fff]
> pci_bus 0000:06: resource 1 [mem 0xfa800000-0xfb0fffff]
> pci_bus 0000:06: resource 2 [mem 0x90000000-0xdfffffff 64bit pref]
> pci_bus 0000:07: resource 0 [io  0x1000-0x5fff]
> pci_bus 0000:07: resource 1 [mem 0xfa800000-0xfaffffff]
> pci_bus 0000:07: resource 2 [mem 0x90000000-0xdfffffff 64bit pref]
> pci_bus 0000:08: resource 0 [io  0x1000-0x5fff]
> pci_bus 0000:08: resource 1 [mem 0xfa800000-0xfaffffff]
> pci_bus 0000:08: resource 2 [mem 0x90000000-0xdfffffff 64bit pref]
> pci_bus 0000:09: resource 0 [io  0x1000-0x5fff]
> pci_bus 0000:09: resource 1 [mem 0xfa800000-0xfaffffff]
> pci_bus 0000:09: resource 2 [mem 0x90000000-0xdfffffff 64bit pref]
> pci_bus 0000:0a: resource 0 [io  0x1000-0x1fff]
> pci_bus 0000:0a: resource 2 [mem 0x90000000-0x9fffffff 64bit pref]
> pci_bus 0000:0c: resource 0 [io  0x2000-0x2fff]
> pci_bus 0000:0c: resource 2 [mem 0xa0000000-0xafffffff 64bit pref]
> pci_bus 0000:0e: resource 0 [io  0x3000-0x3fff]
> pci_bus 0000:0e: resource 2 [mem 0xb0000000-0xbfffffff 64bit pref]
> pci_bus 0000:12: resource 0 [io  0x4000-0x4fff]
> pci_bus 0000:12: resource 2 [mem 0xc0000000-0xcfffffff 64bit pref]
> pci_bus 0000:13: resource 0 [io  0x5000-0x5fff]
> pci_bus 0000:13: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
> pci_bus 0000:14: resource 1 [mem 0xfa800000-0xfaffffff]
> pci_bus 0000:16: resource 0 [io  0xe000-0xefff]
> pci_bus 0000:16: resource 1 [mem 0xf9000000-0xfa0fffff]
> pci_bus 0000:17: resource 0 [io  0xe000-0xefff]
> pci_bus 0000:17: resource 1 [mem 0xf9000000-0xfa0fffff]
> pci_bus 0000:18: resource 0 [io  0xd000-0xdfff]
> pci_bus 0000:18: resource 1 [mem 0xfb400000-0xfb4fffff]
> pci_bus 0000:19: resource 0 [io  0xc000-0xcfff]
> pci_bus 0000:19: resource 1 [mem 0xfb300000-0xfb3fffff]
> NET: Registered protocol family 2
>
>
>
>
> On Tue, Apr 19, 2016 at 3:33 PM, Kallol Biswas <kallol@nucleodyne.com>
> wrote:
>>
>> How can I force Linux kernel to allocate some window anyway for the
>> bridges? With pcie=hpmemsize=256M once or twice hot plug worked on
>> port 9 (see messages below).
>>
>> When hotplug works the bridge PCI resources are programmed differently.
>>
>> Looks like that there is no other alternative than read the kernel
>> code and figure out what is happening.
>>
>> When hotplug works:
>>
>> pciehp 0000:09:09.0:pcie24: Hotplug Controller:
>> pciehp 0000:09:09.0:pcie24:   Seg/Bus/Dev/Func/IRQ : 0000:09:09.0 IRQ 79
>> pciehp 0000:09:09.0:pcie24:   Vendor ID            : 0x10b5
>> pciehp 0000:09:09.0:pcie24:   Device ID            : 0x9797
>> pciehp 0000:09:09.0:pcie24:   Subsystem ID         : 0x1003
>> pciehp 0000:09:09.0:pcie24:   Subsystem Vendor ID  : 0x10b5
>> pciehp 0000:09:09.0:pcie24:   PCIe Cap offset      : 0x68
>> pciehp 0000:09:09.0:pcie24:   PCI resource [13]     : [io  0xe000-0xefff]
>> pciehp 0000:09:09.0:pcie24:   PCI resource [14]     : [mem
>> 0xfb000000-0xfb0fffff]
>> pciehp 0000:09:09.0:pcie24:   PCI resource [15]     : [mem
>> 0xfbe00000-0xfbefffff 64bit pref]
>> pciehp 0000:09:09.0:pcie24: Slot Capabilities      : 0x004a0cff
>> pciehp 0000:09:09.0:pcie24:   Physical Slot Number : 9
>> pciehp 0000:09:09.0:pcie24:   Attention Button     : yes
>> pciehp 0000:09:09.0:pcie24:   Power Controller     : yes
>> pciehp 0000:09:09.0:pcie24:   MRL Sensor           : yes
>> pciehp 0000:09:09.0:pcie24:   Attention Indicator  : yes
>> pciehp 0000:09:09.0:pcie24:   Power Indicator      : yes
>> pciehp 0000:09:09.0:pcie24:   Hot-Plug Surprise    : yes
>> pciehp 0000:09:09.0:pcie24:   EMI Present          : yes
>> pciehp 0000:09:09.0:pcie24:   Command Completed    : yes
>> pciehp_readw : reg 0x1a value 0x50 ret 0x0
>> pciehp 0000:09:09.0:pcie24: Slot Status            : 0x0050
>>
>>
>> When hotplug does not work:
>>
>> pciehp_readl : reg 0x14 value 0x4a0cff ret 0x0
>> pciehp 0000:09:09.0:pcie24: Hotplug Controller:
>> pciehp 0000:09:09.0:pcie24:   Seg/Bus/Dev/Func/IRQ : 0000:09:09.0 IRQ 79
>> pciehp 0000:09:09.0:pcie24:   Vendor ID            : 0x10b5
>> pciehp 0000:09:09.0:pcie24:   Device ID            : 0x9797
>> pciehp 0000:09:09.0:pcie24:   Subsystem ID         : 0x1003
>> pciehp 0000:09:09.0:pcie24:   Subsystem Vendor ID  : 0x10b5
>> pciehp 0000:09:09.0:pcie24:   PCIe Cap offset      : 0x68
>> pciehp 0000:09:09.0:pcie24:   PCI resource [13]     : [io  0x2000-0x2fff]
>> pciehp 0000:09:09.0:pcie24:   PCI resource [15]     : [mem
>> 0x90200000-0x903fffff 64bit pref]
>> pciehp 0000:09:09.0:pcie24: Slot Capabilities      : 0x004a0cff
>> pciehp 0000:09:09.0:pcie24:   Physical Slot Number : 9
>> pciehp 0000:09:09.0:pcie24:   Attention Button     : yes
>> pciehp 0000:09:09.0:pcie24:   Power Controller     : yes
>> pciehp 0000:09:09.0:pcie24:   MRL Sensor           : yes
>> pciehp 0000:09:09.0:pcie24:   Attention Indicator  : yes
>> pciehp 0000:09:09.0:pcie24:   Power Indicator      : yes
>> pciehp 0000:09:09.0:pcie24:   Hot-Plug Surprise    : yes
>> pciehp 0000:09:09.0:pcie24:   EMI Present          : yes
>> pciehp 0000:09:09.0:pcie24:   Command Completed    : yes
>> pciehp_readw : reg 0x1a value 0x10 ret 0x0
>> pciehp 0000:09:09.0:pcie24: Slot Status            : 0x0010
>> pciehp_readw : reg 0x18 value 0x140 ret 0x0
>>
>> On Tue, Apr 19, 2016 at 2:04 PM, Tang, Jason (ES) <Jason.Tang2@ngc.com>
>> wrote:
>> >> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
>> >> owner@vger.kernel.org] On Behalf Of Kallol Biswas
>> >> Sent: Tuesday, April 19, 2016 16:39
>> >> To: linux-pci@vger.kernel.org
>> >> Subject: PCI Hot Plug: OS can not program BARs for new devices
>> >>
>> >> I have a been testing PCIe Hot Plug feature on a Supericro X10DRL
>> >> motherboard running 2.6.38.1 kernel.
>> >>
>> >> If an endpoint is already present at boot time on a hot plug capable
>> >> PCIe slot then I can remove and add the endpoint with the help of a
>> >> Quarch device. OS allocates resources properly and after hot unplug
>> >> and plug, the device is functional.
>> >>
>> >> If the endpoint is not present at boot time (turned off with the
>> >> Quarch) then put back (turn on with Quarch) the OS can not program BAR
>> >> registers.
>> > <snip>
>> >> Is there a workaround for this? Note, there are other devices on
>> >> downstream PCIe ports, so remove and rescan is not an option.
>> >
>> > I had proposed a solution to this, involving statically enumerating bus
>> > numbers and BAR resources. See
>> > http://www.spinics.net/lists/linux-pci/msg44721.html
>> > Using hpmemsize was not sufficient for my case, because I needed to "hot
>> > add" a bridge.
>> >
>
>
