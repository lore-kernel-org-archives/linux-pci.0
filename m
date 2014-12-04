Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:39433 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932240AbaLDQPM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Dec 2014 11:15:12 -0500
Received: by mail-pd0-f171.google.com with SMTP id y13so17995868pdi.2
        for <linux-pci@vger.kernel.org>; Thu, 04 Dec 2014 08:15:11 -0800 (PST)
Date: Thu, 4 Dec 2014 09:15:06 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	zermond@gmail.com, David Airlie <airlied@linux.ie>,
	saifi.khan@datasynergy.org, Alex Deucher <alexdeucher@gmail.com>,
	kordikmarek@gmail.com
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
Message-ID: <20141204161506.GA2501@google.com>
References: <CAErSpo6UvY10MNidAOFf4Fptv+wL-NsX6JMaU8OvSP6ywWEebQ@mail.gmail.com>
 <CAE9FiQW1OPP_no1orE+rUHQnmsVY3beUtbS8YdkXBhABVbdfLA@mail.gmail.com>
 <CAE9FiQUP6v=bGxkTXuyYf6mO1reQcD2gLjrr2nDHNYDBQ8ubug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQUP6v=bGxkTXuyYf6mO1reQcD2gLjrr2nDHNYDBQ8ubug@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 03, 2014 at 05:41:32PM -0800, Yinghai Lu wrote:
> On Wed, Dec 3, 2014 at 5:38 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> > On Wed, Dec 3, 2014 at 2:15 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >> There's a bugzilla for this, so this email is to make the bugzilla
> >> more discoverable and to have a more public discussion about it.
> >>
> >>   https://bugzilla.kernel.org/show_bug.cgi?id=85491
> >>
> >> I think this regression is caused by 5b28541552ef ("PCI: Restrict
> >> 64-bit prefetchable bridge windows to 64-bit resources").  These dmesg
> >> fragments are from v3.16, which doesn't work:
> >>
> >>     pci_bus 0000:00: root bus resource [mem 0xc0000000-0xffffffff]
> >>
> >>     pci 0000:00:01.0: PCI bridge to [bus 01]
> >>     pci 0000:00:01.0:   bridge window [io  0x8000-0xafff]
> >>     pci 0000:00:01.0:   bridge window [mem 0xfdf00000-0xfdffffff]
> >>     pci 0000:00:01.0:   bridge window [mem 0xbdf00000-0xddefffff 64bit
> >> pref]  <-- outside host bridge window
> >>
> >>     pci 0000:01:00.0: reg 0x10: [mem 0xc0000000-0xcfffffff pref]
> >>     pci 0000:01:00.0: reg 0x14: [io  0xa000-0xa0ff]
> >>     pci 0000:01:00.0: reg 0x18: [mem 0xfdff0000-0xfdffffff]
> >>     pci 0000:01:00.0: reg 0x30: [mem 0xfdfc0000-0xfdfdffff pref]
> >>
> >>     pci 0000:00:01.0: can't claim BAR 15 [mem 0xbdf00000-0xddefffff
> >> 64bit pref]: no compatible bridge window
> >>     pci 0000:01:00.0: can't claim BAR 0 [mem 0xc0000000-0xcfffffff
> >> pref]: no compatible bridge window
> >
> > Looks like we wrong type checking from parent resource searching.

I don't understand what you're trying to say, but I don't think the "no
compatible bridge window" problem is related to resource types.  I think
it's because the 00:01.0 window at [mem 0xbdf00000-0xddefffff] starts
before the [mem 0xc0000000-0xffffffff] host bridge window.

> oh, no, the BIOS is crazy...
> 
> [    0.158601] pci 0000:00:01.0: address space collision: [mem
> 0xbdf00000-0xddefffff 64bit pref] conflicts with System RAM [mem
> 0x00100000-0xbff9ffff]
> 
> mmio is overlapping with ram range....

I agree, it certainly looks like the BIOS programmed the 00:01.0 window
incorrectly.  But I think we should just clip it so it starts at 0xc0000000
instead of 0xbdf00000.

There's no reason we should depend on correct PCI configuration from the
BIOS.

Bjorn
