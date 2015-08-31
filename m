Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:32822 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216AbbHaXV4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 31 Aug 2015 19:21:56 -0400
Received: by iods203 with SMTP id s203so176502376iod.0
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2015 16:21:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <loom.20150831T091131-859@post.gmane.org>
References: <loom.20150831T091131-859@post.gmane.org>
Date: Mon, 31 Aug 2015 16:21:55 -0700
Message-ID: <CAE9FiQWNA1BEGom757xtbc0zFjFqZ9uqKwj2kM7EFDDKXEL6fw@mail.gmail.com>
Subject: Re: PCI rescan : can't assign mem
From: Yinghai Lu <yinghai@kernel.org>
To: Peio <peio@azkarate.eu>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 31, 2015 at 12:47 AM, Peio <peio@azkarate.eu> wrote:
> I have a board with an PCI Express-to-PCI Bridge (Texas Instruments
> XIO2001).
> Attached to the PCI bus, there are 2 FPGA PCI Target devices needing 32MB
> memory map each.
> The PCI rescan "echo 1 > /sys/bus/pci/rescan" memory assign fails.
>
> dmesg messages:
> [  150.978654] pci 0000:02:03.0: [4150:0001] type 00 class 0x068000
> [  150.978684] pci 0000:02:03.0: reg 0x10: [mem 0x00000000-0x01ffffff]
> [  150.978885] pci 0000:02:04.0: [4150:000a] type 00 class 0x078000
> [  150.978909] pci 0000:02:04.0: reg 0x10: [mem 0x00000000-0x01ffffff]
> [  150.979158] pcieport 0000:00:1c.0: bridge window [mem 0x00100000-
> 0x000fffff 64bit pref] to [bus 01-02] add_size 200000
> [  150.979166] pcieport 0000:00:1c.0: bridge window [mem 0x02000000-
> 0x05ffffff] to [bus 01-02] add_size 2000000
> [  150.979183] pcieport 0000:00:1c.2: bridge window [mem 0x00100000-
> 0x000fffff 64bit pref] to [bus 04] add_size 200000
> [  150.979190] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has
> bogus alignment
> [  150.979199] pcieport 0000:00:1c.0: res[14]=[mem 0x02000000-0x05ffffff]
> get_res_add_size add_size 2000000
> [  150.979205] pcieport 0000:00:1c.0: res[15]=[mem 0x00100000-0x000fffff
> 64bit pref] get_res_add_size add_size 200000
> [  150.979211] pcieport 0000:00:1c.2: res[15]=[mem 0x00100000-0x000fffff
> 64bit pref] get_res_add_size add_size 200000
> [  150.979222] pcieport 0000:00:1c.0: BAR 14: can't assign mem (size
> 0x6000000)
> [  150.979230] pcieport 0000:00:1c.0: BAR 15: can't assign mem pref (size
> 0x200000)
> [  150.979238] pcieport 0000:00:1c.2: BAR 15: can't assign mem pref (size
> 0x200000)
> [  150.979245] pcieport 0000:00:1c.0: BAR 14: can't assign mem (size
> 0x4000000)

> Linux: Ubuntu 14.04
> Kernel: 3.13.0-62-generic

how about current upsteam kernel?

> Is possible to fix it?

Please whole post boot log with "debug ignore_loglevel".

Need _CRS from BIOS provide enough MMIO range for 00:1c.0

Yinghai
