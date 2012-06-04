Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58396 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab2FDX7t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jun 2012 19:59:49 -0400
Received: by pbbrp8 with SMTP id rp8so6685597pbb.19
        for <linux-pci@vger.kernel.org>; Mon, 04 Jun 2012 16:59:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BLU0-SMTP129FFE755310932B1C36438B7000@phx.gbl>
References: <bug-43244-4803@https.bugzilla.kernel.org/>
	<20120513221357.7574ae79@stein>
	<4FB0A6F6.9050504@ladisch.de>
	<CAE9FiQXA4C8hACXChokL4CZVBDhdh17Qs7tngn5q-pS0U5=bPQ@mail.gmail.com>
	<BLU0-SMTP12B809D527F768CCC42B18B7180@phx.gbl>
	<4FB3B159.2090401@ladisch.de>
	<BLU0-SMTP47479D78AA811CB0B224ADFB71D0@phx.gbl>
	<4FBAA3A5.4070200@ladisch.de>
	<20120524202610.5c561d99@stein>
	<BLU0-SMTP129FFE755310932B1C36438B7000@phx.gbl>
Date: Mon, 4 Jun 2012 16:59:48 -0700
Message-ID: <CAE9FiQUtJ_YZEd6kFydi=fwiGnDBkEABpM=FE1EiZwHu4NtwAA@mail.gmail.com>
Subject: Re: [Bug 43244] New: firewire_ohci prevents boot
From: Yinghai Lu <yinghai@kernel.org>
To: Rob Allen <ra-kernel@hotmail.co.uk>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Clemens Ladisch <clemens@ladisch.de>,
	Ram Pai <linuxram@us.ibm.com>,
	linux1394-devel@lists.sourceforge.net, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 24, 2012 at 11:43 AM, Rob Allen <ra-kernel@hotmail.co.uk> wrote:
> On 24/05/12 19:26, Stefan Richter wrote:
>>
>> On May 24 bugzilla-daemon@bugzilla.kernel.org wrote:
>>>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=43244
>>>
>>> --- Comment #3 from Rob Allen<ra-kernel@hotmail.co.uk>   2012-05-24
>>> 17:30:12 ---
>>> Created an attachment (id=73381)
>>>  -->  (https://bugzilla.kernel.org/attachment.cgi?id=73381)
>>> dmesg from v3.4 with CONFIG_PCI_DEBUG
>

it seems kernel assign new resource to the bridge

[    0.841285] pci 0000:00:1e.0: PCI bridge to [bus 0a-0b] (subtractive decode)
[    0.841340] pci 0000:00:1e.0:   bridge window [mem 0xd0400000-0xd04fffff]
[    0.841349] pci 0000:00:1e.0:   bridge window [io  0x0000-0xffff]
(subtractive decode)
[    0.841352] pci 0000:00:1e.0:   bridge window [mem
0x00000000-0xffffffff] (subtractive decode)

[    0.924562] pci 0000:00:1e.0: PCI bridge to [bus 0a-0b]
[    0.924611] pci 0000:00:1e.0:   bridge window [io  0x9000-0x9fff]
[    0.924663] pci 0000:00:1e.0:   bridge window [mem 0xd0400000-0xd04fffff]
[    0.924715] pci 0000:00:1e.0:   bridge window [mem
0x80000000-0x87ffffff pref]

can you post

lspci -vvxxx -s 0a:09.4

with working kernel and not working kernel?

Thanks

Yinghai
