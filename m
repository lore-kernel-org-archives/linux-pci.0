Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:63179 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbaAJEmD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jan 2014 23:42:03 -0500
Received: by mail-la0-f48.google.com with SMTP id n7so2807336lam.7
        for <linux-pci@vger.kernel.org>; Thu, 09 Jan 2014 20:42:00 -0800 (PST)
Message-ID: <52CF7A17.60703@gmail.com>
Date: Fri, 10 Jan 2014 08:41:59 +0400
From: `VL <vl.homutov@gmail.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pci->pcie bridge issue: kernel unable to find a free I/O port
 range.
References: <52CBC4D1.5080706@gmail.com>	<CAErSpo7bUchKT5WN+BBq6oKn+O62gWbH+gfaruePBAYrvP7Lmw@mail.gmail.com>	<52CD2387.2030403@gmail.com>	<CAE9FiQV5r-c4ufd2SqLJk-KcoJhucmr6RszUb0LyUFtgq_a5sg@mail.gmail.com>	<52CE301E.60108@gmail.com> <CAE9FiQWxpRMX-0vyd5hML-Hnto8H+C83dcne9FBZcN9qsmGCEw@mail.gmail.com>
In-Reply-To: <CAE9FiQWxpRMX-0vyd5hML-Hnto8H+C83dcne9FBZcN9qsmGCEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10.01.2014 00:17, Yinghai Lu wrote:
> On Wed, Jan 8, 2014 at 9:14 PM, `VL <vl.homutov@gmail.com> wrote:
>> I've put all logs here: http://inspert.ru/pci/
>>> CONFIG_PCI_DEBUG=y
>>>
>>> and boot with "debug ignore_loglevel initcall_debug"?
> Jan  9 08:51:49 10 pci 0000:04:00.0: BAR 7: assigned [io  0x2000-0x4fff]
> Jan  9 08:51:49 10 pci 0000:05:01.0: BAR 7: assigned [io  0x2000-0x2fff]
> Jan  9 08:51:49 10 pci 0000:06:00.0: BAR 7: assigned [io  0x2000-0x2fff]
> Jan  9 08:51:49 10 pci 0000:07:00.0: BAR 3: assigned [io  0x2000-0x203f]
> Jan  9 08:51:49 10 pci 0000:07:00.0: BAR 3: error updating (0x002001
> != 0xffffffff)
> Jan  9 08:51:49 10 pci 0000:07:00.0: BAR 3: set to [io  0x2000-0x203f]
> (PCI address [0x2000-0x203f])
> Jan  9 08:51:49 10 pci 0000:07:00.0: BAR 0: assigned [io  0x2040-0x205f]
> Jan  9 08:51:49 10 pci 0000:07:00.0: BAR 0: error updating (0x002041
> != 0xffffffff)
> Jan  9 08:51:49 10 pci 0000:07:00.0: BAR 0: set to [io  0x2040-0x205f]
> (PCI address [0x2040-0x205f])
> Jan  9 08:51:49 10 pci 0000:07:00.0: BAR 1: assigned [io  0x2060-0x206f]
> Jan  9 08:51:49 10 pci 0000:07:00.0: BAR 1: error updating (0x002061
> != 0xffffffff)
> Jan  9 08:51:49 10 pci 0000:07:00.0: BAR 1: set to [io  0x2060-0x206f]
> (PCI address [0x2060-0x206f])
> Jan  9 08:51:49 10 pci 0000:07:00.0: BAR 2: assigned [io  0x2070-0x207f]
> Jan  9 08:51:49 10 pci 0000:07:00.0: BAR 2: error updating (0x002071
> != 0xffffffff)
> Jan  9 08:51:49 10 pci 0000:07:00.0: BAR 2: set to [io  0x2070-0x207f]
> (PCI address [0x2070-0x207f])
> Jan  9 08:51:49 10 pci 0000:06:00.0: PCI bridge to [bus 07]
> Jan  9 08:51:49 10 pci 0000:06:00.0:   bridge window [io  0x2000-0x2fff]
> Jan  9 08:51:49 10 pci 0000:05:01.0: PCI bridge to [bus 06-07]
> Jan  9 08:51:49 10 pci 0000:05:01.0:   bridge window [io  0x2000-0x2fff]
> Jan  9 08:51:49 10 pci 0000:0d:00.0: BAR 0: set to [io  0x4020-0x4027]
> (PCI address [0x4020-0x4027])
> Jan  9 08:51:49 10 pci 0000:0d:00.0: BAR 2: assigned [io  0x4028-0x402f]
> Jan  9 08:51:49 10 pci 0000:0d:00.0: BAR 3: assigned [io  0x4034-0x4037]
> Jan  9 08:51:49 10 pci 0000:0d:00.0: BAR 3: set to [io  0x4034-0x4037]
> (PCI address [0x4034-0x4037])
> Jan  9 08:51:49 10 pci 0000:05:09.0: PCI bridge to [bus 0d]
> Jan  9 08:51:49 10 pci 0000:05:09.0:   bridge window [io  0x4000-0x4fff]
> Jan  9 08:51:49 10 pci 0000:05:09.0:   bridge window [mem 0xf7600000-0xf76fffff]
> Jan  9 08:51:49 10 pci 0000:04:00.0: PCI bridge to [bus 05-0d]
> Jan  9 08:51:49 10 pci 0000:04:00.0:   bridge window [io  0x2000-0x4fff]
> Jan  9 08:51:49 10 pci 0000:04:00.0:   bridge window [mem 0xf7200000-0xf77fffff]
> Jan  9 08:51:49 10 pci 0000:04:00.0:   bridge window [mem
> 0xf0000000-0xf00fffff 64bit pref]
> Jan  9 08:51:49 10 pci 0000:00:1c.3: PCI bridge to [bus 04-0d]
> Jan  9 08:51:49 10 pci 0000:00:1c.3:   bridge window [io  0x2000-0x4fff]
> Jan  9 08:51:49 10 pci 0000:00:1c.3:   bridge window [mem 0xf7200000-0xf78fffff]
> Jan  9 08:51:49 10 pci 0000:00:1c.3:   bridge window [mem
> 0xf0000000-0xf00fffff 64bit pref]
>
> The realloc code does reassign big range to the devices.
>
> but one device refuse to change bar to new assigned vaule, or it is read-only?
>
> Jan  9 08:51:49 10 pci 0000:07:00.0: BAR 3: assigned [io  0x2000-0x203f]
> Jan  9 08:51:49 10 pci 0000:07:00.0: BAR 3: error updating (0x002001
> != 0xffffffff)
> Jan  9 08:51:49 10 pci 0000:07:00.0: BAR 3: set to [io  0x2000-0x203f]
> (PCI address [0x2000-0x203f])
> Jan  9 08:51:49 10 pci 0000:07:00.0: BAR 0: assigned [io  0x2040-0x205f]
> Jan  9 08:51:49 10 pci 0000:07:00.0: BAR 0: error updating (0x002041
> != 0xffffffff)
> Jan  9 08:51:49 10 pci 0000:07:00.0: BAR 0: set to [io  0x2040-0x205f]
> (PCI address [0x2040-0x205f])
> Jan  9 08:51:49 10 pci 0000:07:00.0: BAR 1: assigned [io  0x2060-0x206f]
> Jan  9 08:51:49 10 pci 0000:07:00.0: BAR 1: error updating (0x002061
> != 0xffffffff)
> Jan  9 08:51:49 10 pci 0000:07:00.0: BAR 1: set to [io  0x2060-0x206f]
> (PCI address [0x2060-0x206f])
> Jan  9 08:51:49 10 pci 0000:07:00.0: BAR 2: assigned [io  0x2070-0x207f]
> Jan  9 08:51:49 10 pci 0000:07:00.0: BAR 2: error updating (0x002071
> != 0xffffffff)
> Jan  9 08:51:49 10 pci 0000:07:00.0: BAR 2: set to [io  0x2070-0x207f]
> (PCI address [0x2070-0x207f])
>
>
> also BIOS does not assign any vaule to it:
>
> Jan  9 08:51:49 10 pci 0000:07:00.0: reg 0x10: [io  0x0000-0x001f]
> Jan  9 08:51:49 10 pci 0000:07:00.0: reg 0x18: [io  0x0000-0x000f]
> Jan  9 08:51:49 10 pci 0000:07:00.0: reg 0x1c: [io  0x0000-0x003f]
>
> It is strange 05:01.0/07:00.0 does not work, but 05:09.0/0d:00.0 does work.
>
> Can you boot with "pci=earlydump"?
>
> Yinghai
Here it is: http://inspert.ru/pci/netconsole-realloc-earlydump.txt
