Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f193.google.com ([209.85.217.193]:35770 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161AbcDCSbH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 3 Apr 2016 14:31:07 -0400
Received: by mail-lb0-f193.google.com with SMTP id gk8so15851372lbc.2
        for <linux-pci@vger.kernel.org>; Sun, 03 Apr 2016 11:31:06 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 3 Apr 2016 14:31:05 -0400
Message-ID: <CAPPcaqO6K6_xHsuXtUQUNRzTWLC4iD0nX5ZBCnjZOdUiG_R0PA@mail.gmail.com>
Subject: A question about PCIe peer-to-peer DMA
From: Guy Crazy <superymk.adv@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I try to do some experiments with PCIe peer-to-peer DMA. Specifically,
I want to use a PCIe firewire card to read/write the MMIO of other
devices.

After reading the documents, I still confuse on the effects of the
UPDCR register. I can set its value to be 0xf on my machine (BSPR = 0,
IRBNCE = 0x01118000). In that case, could I access the MMIO of devices
on Bus 0, or just access the MMIO of devices under this root port?
Sorry that I do not have a firewire adapter at the moment (will get it
in a few days...).

I'll plug the firewire card to the Root Port 1, and my hardware falls
in pci_quirk_intel_pch_acs_ids[].

Thanks a lot!

-Superymk

Here is my lspci -nn:

00:00.0 Host bridge [0600]: Intel Corporation 2nd Generation Core
Processor Family DRAM Controller [8086:0100] (rev 09)
00:16.0 Communication controller [0780]: Intel Corporation 6
Series/C200 Series Chipset Family MEI Controller #1 [8086:1c3a] (rev
04)
00:16.3 Serial controller [0700]: Intel Corporation 6 Series/C200
Series Chipset Family KT Controller [8086:1c3d] (rev 04)
00:19.0 Ethernet controller [0200]: Intel Corporation 82579LM Gigabit
Network Connection [8086:1502] (rev 04)
00:1a.0 USB controller [0c03]: Intel Corporation 6 Series/C200 Series
Chipset Family USB Enhanced Host Controller #2 [8086:1c2d] (rev 04)
00:1b.0 Audio device [0403]: Intel Corporation 6 Series/C200 Series
Chipset Family High Definition Audio Controller [8086:1c20] (rev 04)
00:1c.0 PCI bridge [0604]: Intel Corporation 6 Series/C200 Series
Chipset Family PCI Express Root Port 1 [8086:1c10] (rev b4)
00:1c.4 PCI bridge [0604]: Intel Corporation 6 Series/C200 Series
Chipset Family PCI Express Root Port 5 [8086:1c18] (rev b4)
00:1c.6 PCI bridge [0604]: Intel Corporation 6 Series/C200 Series
Chipset Family PCI Express Root Port 7 [8086:1c1c] (rev b4)
00:1c.7 PCI bridge [0604]: Intel Corporation 6 Series/C200 Series
Chipset Family PCI Express Root Port 8 [8086:1c1e] (rev b4)
00:1d.0 USB controller [0c03]: Intel Corporation 6 Series/C200 Series
Chipset Family USB Enhanced Host Controller #1 [8086:1c26] (rev 04)
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 PCI Bridge
[8086:244e] (rev a4)
00:1f.0 ISA bridge [0601]: Intel Corporation Q67 Express Chipset
Family LPC Controller [8086:1c4e] (rev 04)
00:1f.2 SATA controller [0106]: Intel Corporation 6 Series/C200 Series
Chipset Family SATA AHCI Controller [8086:1c02] (rev 04)
00:1f.3 SMBus [0c05]: Intel Corporation 6 Series/C200 Series Chipset
Family SMBus Controller [8086:1c22] (rev 04)
05:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ [10ec:8139] (rev 10)

And lspci -t:
-[0000:00]-+-00.0
           +-16.0
           +-16.3
           +-19.0
           +-1a.0
           +-1b.0
           +-1c.0-[01]--
           +-1c.4-[02]--
           +-1c.6-[03]--
           +-1c.7-[04]--
           +-1d.0
           +-1e.0-[05]----00.0
           +-1f.0
           +-1f.2
           \-1f.3
