Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51612 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754199Ab2APVlg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2012 16:41:36 -0500
Received: by ghbg16 with SMTP id g16so2018101ghb.19
        for <linux-pci@vger.kernel.org>; Mon, 16 Jan 2012 13:41:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CADBTUEHy_R2WJywkJgcPWVOG7J8NEG1SO5UJiDRvZgvwaKpJmA@mail.gmail.com>
References: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
	<1323247984-15281-3-git-send-email-yinghai@kernel.org>
	<20120113163922.GH7380@ram-ThinkPad-T61>
	<CAE9FiQWTVA=LDViVyfSXX6thgGv4TzOpqidVyG6FAdWQqAMWEg@mail.gmail.com>
	<20120115160558.GA2601@ram-ThinkPad-T61>
	<CAE9FiQX2wG9pEZHJE8LD7kL=eiCnFsaS6dRmyNf8F2Kgg=WcpQ@mail.gmail.com>
	<CADBTUEHy_R2WJywkJgcPWVOG7J8NEG1SO5UJiDRvZgvwaKpJmA@mail.gmail.com>
Date: Mon, 16 Jan 2012 13:41:35 -0800
Message-ID: <CAE9FiQW=_jLRwXOg32M7fo9aW+giJ71pGtds5pexXnB9BvcVTg@mail.gmail.com>
Subject: Re: [PATCH 2/5] PCI: Try to assign required+option size at first
From: Yinghai Lu <yinghai@kernel.org>
To: Peter Henriksson <peter.henriksson@gmail.com>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Clemens Ladisch <clemens@ladisch.de>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-pci@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 16, 2012 at 11:59 AM, Peter Henriksson
<peter.henriksson@gmail.com> wrote:
> On Mon, Jan 16, 2012 at 2:14 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>> Peter Henriksson,
>> Can you try for-pci2 branch on your setup with Xonar DX?
>>
>
> Attaching dmesg output with the for-pci2 branch. The Xonar DX appears
> to be working.

Great!

After last retry, every device and bridge is happy now.

PCI: No. 4 try to assign unassigned res
pci 0000:00:1c.0: resource 7 [io  0xd000-0xdfff] released
pci 0000:00:1c.0: PCI bridge to [bus 04-09]
pci 0000:00:1c.0: BAR 7: assigned [io  0x1000-0x5fff]
pci 0000:00:01.0: PCI bridge to [bus 01-01]
pci 0000:00:01.0:   bridge window [io  0xa000-0xafff]
pci 0000:00:01.0:   bridge window [mem 0xfe700000-0xfe7fffff]
pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
pci 0000:04:00.0: BAR 7: assigned [io  0x1000-0x4fff]
pci 0000:05:01.0: BAR 7: assigned [io  0x1000-0x2fff]
pci 0000:05:02.0: BAR 7: assigned [io  0x3000-0x3fff]
pci 0000:05:03.0: BAR 7: assigned [io  0x4000-0x4fff]
pci 0000:08:00.0: BAR 7: assigned [io  0x1000-0x1fff]
pci 0000:09:04.0: BAR 0: assigned [io  0x1000-0x10ff]
pci 0000:09:04.0: BAR 0: set to [io  0x1000-0x10ff] (PCI address
[0x1000-0x10ff])
pci 0000:08:00.0: PCI bridge to [bus 09-09]
pci 0000:08:00.0:   bridge window [io  0x1000-0x1fff]
pci 0000:05:01.0: PCI bridge to [bus 08-09]
pci 0000:05:01.0:   bridge window [io  0x1000-0x2fff]
pci 0000:05:01.0:   bridge window [mem 0xf0400000-0xf05fffff]
pci 0000:05:01.0:   bridge window [mem 0xf1000000-0xf11fffff 64bit pref]
pci 0000:05:02.0: PCI bridge to [bus 07-07]
pci 0000:05:02.0:   bridge window [io  0x3000-0x3fff]
pci 0000:05:02.0:   bridge window [mem 0xf0600000-0xf09fffff]
pci 0000:05:02.0:   bridge window [mem 0xf1200000-0xf13fffff 64bit pref]
pci 0000:05:03.0: PCI bridge to [bus 06-06]
pci 0000:05:03.0:   bridge window [io  0x4000-0x4fff]
pci 0000:05:03.0:   bridge window [mem 0xf0a00000-0xf0dfffff]
pci 0000:05:03.0:   bridge window [mem 0xf1400000-0xf15fffff 64bit pref]
pci 0000:04:00.0: PCI bridge to [bus 05-09]
pci 0000:04:00.0:   bridge window [io  0x1000-0x4fff]
pci 0000:04:00.0:   bridge window [mem 0xf0400000-0xf0ffffff]
pci 0000:04:00.0:   bridge window [mem 0xf1000000-0xf15fffff 64bit pref]
pci 0000:00:1c.0: PCI bridge to [bus 04-09]
pci 0000:00:1c.0:   bridge window [io  0x1000-0x5fff]
pci 0000:00:1c.0:   bridge window [mem 0xf0400000-0xf16fffff]
pci 0000:00:1c.0:   bridge window [mem 0xfde00000-0xfdffffff 64bit pref]
pci 0000:00:1c.4: PCI bridge to [bus 03-03]
pci 0000:00:1c.4:   bridge window [io  0xc000-0xcfff]
pci 0000:00:1c.4:   bridge window [mem 0xfe900000-0xfe9fffff]
pci 0000:00:1c.4:   bridge window [mem 0xf0000000-0xf01fffff 64bit pref]
pci 0000:00:1c.5: PCI bridge to [bus 02-02]
pci 0000:00:1c.5:   bridge window [io  0xb000-0xbfff]
pci 0000:00:1c.5:   bridge window [mem 0xfe800000-0xfe8fffff]
pci 0000:00:1c.5:   bridge window [mem 0xf0200000-0xf03fffff 64bit pref]
pci 0000:00:1e.0: PCI bridge to [bus 0a-0a]
pci 0000:00:1e.0:   bridge window [io  0xe000-0xefff]
pci 0000:00:1e.0:   bridge window [mem 0xfeb00000-0xfebfffff]

Thanks

Yinghai
