Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:47731 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754833AbaLDWPS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Dec 2014 17:15:18 -0500
Received: by mail-ie0-f178.google.com with SMTP id tp5so16804993ieb.37
        for <linux-pci@vger.kernel.org>; Thu, 04 Dec 2014 14:15:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141204161506.GA2501@google.com>
References: <CAErSpo6UvY10MNidAOFf4Fptv+wL-NsX6JMaU8OvSP6ywWEebQ@mail.gmail.com>
	<CAE9FiQW1OPP_no1orE+rUHQnmsVY3beUtbS8YdkXBhABVbdfLA@mail.gmail.com>
	<CAE9FiQUP6v=bGxkTXuyYf6mO1reQcD2gLjrr2nDHNYDBQ8ubug@mail.gmail.com>
	<20141204161506.GA2501@google.com>
Date: Thu, 4 Dec 2014 14:15:14 -0800
Message-ID: <CAE9FiQUfO0-6fn-xrE=aCzouoXDxa1ziN=EkBw2L01Ve-Wi-EQ@mail.gmail.com>
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alexey Voronkov <zermond@gmail.com>,
	David Airlie <airlied@linux.ie>,
	Saifi Khan <saifi.khan@datasynergy.org>,
	Alex Deucher <alexdeucher@gmail.com>,
	=?UTF-8?Q?Marek_Kord=C3=ADk?= <kordikmarek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 4, 2014 at 8:15 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Wed, Dec 03, 2014 at 05:41:32PM -0800, Yinghai Lu wrote:
>> On Wed, Dec 3, 2014 at 5:38 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> > On Wed, Dec 3, 2014 at 2:15 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> >> There's a bugzilla for this, so this email is to make the bugzilla
>> >> more discoverable and to have a more public discussion about it.
>> >>
>> >>   https://bugzilla.kernel.org/show_bug.cgi?id=85491
>> >>
>> >> I think this regression is caused by 5b28541552ef ("PCI: Restrict
>> >> 64-bit prefetchable bridge windows to 64-bit resources").  These dmesg
>> >> fragments are from v3.16, which doesn't work:
>> >>
>> >>     pci_bus 0000:00: root bus resource [mem 0xc0000000-0xffffffff]
>> >>
>> >>     pci 0000:00:01.0: PCI bridge to [bus 01]
>> >>     pci 0000:00:01.0:   bridge window [io  0x8000-0xafff]
>> >>     pci 0000:00:01.0:   bridge window [mem 0xfdf00000-0xfdffffff]
>> >>     pci 0000:00:01.0:   bridge window [mem 0xbdf00000-0xddefffff 64bit
>> >> pref]  <-- outside host bridge window
>> >>
>> >>     pci 0000:01:00.0: reg 0x10: [mem 0xc0000000-0xcfffffff pref]
>> >>     pci 0000:01:00.0: reg 0x14: [io  0xa000-0xa0ff]
>> >>     pci 0000:01:00.0: reg 0x18: [mem 0xfdff0000-0xfdffffff]
>> >>     pci 0000:01:00.0: reg 0x30: [mem 0xfdfc0000-0xfdfdffff pref]
>> >>
>> >>     pci 0000:00:01.0: can't claim BAR 15 [mem 0xbdf00000-0xddefffff
>> >> 64bit pref]: no compatible bridge window
>> >>     pci 0000:01:00.0: can't claim BAR 0 [mem 0xc0000000-0xcfffffff
>> >> pref]: no compatible bridge window
>> >
>> > Looks like we wrong type checking from parent resource searching.
>
> I don't understand what you're trying to say, but I don't think the "no
> compatible bridge window" problem is related to resource types.  I think
> it's because the 00:01.0 window at [mem 0xbdf00000-0xddefffff] starts
> before the [mem 0xc0000000-0xffffffff] host bridge window.

on this system _CRS is not used.

conflicts with System RAM [mem 0x00100000-0xbff9ffff]

Are you going to enforce using _CRS on this system with DMI ?

Yinghai
