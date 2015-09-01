Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33580 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbbIAQ5Z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 1 Sep 2015 12:57:25 -0400
Received: by igbkq10 with SMTP id kq10so5873379igb.0
        for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2015 09:57:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <loom.20150901T110001-176@post.gmane.org>
References: <loom.20150831T091131-859@post.gmane.org>
	<CAE9FiQWNA1BEGom757xtbc0zFjFqZ9uqKwj2kM7EFDDKXEL6fw@mail.gmail.com>
	<loom.20150901T110001-176@post.gmane.org>
Date: Tue, 1 Sep 2015 09:57:24 -0700
Message-ID: <CAE9FiQUxU2FCxFKQ=6ZdnJL8fU-YxAOjQmMSAP_YBG1gEG+ntA@mail.gmail.com>
Subject: Re: PCI rescan : can't assign mem
From: Yinghai Lu <yinghai@kernel.org>
To: Peio <peio@azkarate.eu>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 1, 2015 at 2:01 AM, Peio <peio@azkarate.eu> wrote:
> Yinghai Lu <yinghai <at> kernel.org> writes:
>
>
>> how about current upsteam kernel?
>
>> > Is possible to fix it?
>>
>> Please whole post boot log with "debug ignore_loglevel".
>>
>> Need _CRS from BIOS provide enough MMIO range for 00:1c.0
>>
> I prefer the stable kernel used by ubuntu 14.04.
> My BIOS don't have MMIO range configuration options.
> Log with "debug ignore_loglevel" sentto Yinghai (too long for post here).

root bus resource:

[    0.277955] PCI host bridge to bus 0000:00
[    0.277966] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.277975] pci_bus 0000:00: root bus resource [io  0x0000-0x006f]
[    0.277983] pci_bus 0000:00: root bus resource [io  0x0078-0x0cf7]
[    0.277991] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.278000] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.278008] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff]
[    0.278016] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000fffff]
[    0.278025] pci_bus 0000:00: root bus resource [mem 0x80000000-0x909ffffe]

and 00:02.0 use almost all

[    0.278221] pci 0000:00:02.0: reg 0x10: [mem 0x90000000-0x903fffff]
[    0.278239] pci 0000:00:02.0: reg 0x18: [mem 0x80000000-0x8fffffff pref]

so we have no chance to allocate MMIO to 00:1c.0

[    0.359994] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to
[bus 01-02] add_size 1000
[    0.360009] pci 0000:00:1c.0: bridge window [mem
0x00100000-0x000fffff 64bit pref] to [bus 01-02] add_size 200000
[    0.360022] pci 0000:00:1c.0: bridge window [mem
0x00100000-0x000fffff] to [bus 01-02] add_size 200000
[    0.360045] pci 0000:00:1c.2: bridge window [mem
0x00100000-0x000fffff 64bit pref] to [bus 04] add_size 200000
[    0.360061] pci 0000:00:1c.0: res[14]=[mem 0x00100000-0x000fffff]
get_res_add_size add_size 200000
[    0.360072] pci 0000:00:1c.0: res[15]=[mem 0x00100000-0x000fffff
64bit pref] get_res_add_size add_size 200000
[    0.360084] pci 0000:00:1c.2: res[15]=[mem 0x00100000-0x000fffff
64bit pref] get_res_add_size add_size 200000
[    0.360095] pci 0000:00:1c.0: res[13]=[io  0x1000-0x0fff]
get_res_add_size add_size 1000
[    0.360111] pci 0000:00:1c.0: BAR 14: can't assign mem (size 0x200000)
[    0.360123] pci 0000:00:1c.0: BAR 15: can't assign mem pref (size 0x200000)
[    0.360134] pci 0000:00:1c.2: BAR 15: can't assign mem pref (size 0x200000)
[    0.360146] pci 0000:00:1c.0: BAR 13: assigned [io  0x4000-0x4fff]
[    0.360158] pci 0000:00:1c.2: BAR 15: can't assign mem pref (size 0x200000)
[    0.360169] pci 0000:00:1c.0: BAR 14: can't assign mem (size 0x200000)
[    0.360180] pci 0000:00:1c.0: BAR 15: can't assign mem pref (size 0x200000)
[    0.360189] pci 0000:01:00.0: PCI bridge to [bus 02]
[    0.360214] pci 0000:00:1c.0: PCI bridge to [bus 01-02]
[    0.360223] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
