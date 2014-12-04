Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:42978 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920AbaLDWZi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Dec 2014 17:25:38 -0500
Received: by mail-ig0-f170.google.com with SMTP id r2so20571836igi.1
        for <linux-pci@vger.kernel.org>; Thu, 04 Dec 2014 14:25:37 -0800 (PST)
Date: Thu, 4 Dec 2014 15:25:34 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alexey Voronkov <zermond@gmail.com>,
	David Airlie <airlied@linux.ie>,
	Saifi Khan <saifi.khan@datasynergy.org>,
	Alex Deucher <alexdeucher@gmail.com>,
	Marek =?iso-8859-1?Q?Kord=EDk?= <kordikmarek@gmail.com>
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
Message-ID: <20141204222534.GA2911@google.com>
References: <CAErSpo6UvY10MNidAOFf4Fptv+wL-NsX6JMaU8OvSP6ywWEebQ@mail.gmail.com>
 <CAE9FiQW1OPP_no1orE+rUHQnmsVY3beUtbS8YdkXBhABVbdfLA@mail.gmail.com>
 <CAE9FiQUP6v=bGxkTXuyYf6mO1reQcD2gLjrr2nDHNYDBQ8ubug@mail.gmail.com>
 <20141204161506.GA2501@google.com>
 <CAE9FiQUfO0-6fn-xrE=aCzouoXDxa1ziN=EkBw2L01Ve-Wi-EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQUfO0-6fn-xrE=aCzouoXDxa1ziN=EkBw2L01Ve-Wi-EQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 04, 2014 at 02:15:14PM -0800, Yinghai Lu wrote:
> On Thu, Dec 4, 2014 at 8:15 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > On Wed, Dec 03, 2014 at 05:41:32PM -0800, Yinghai Lu wrote:
> >> On Wed, Dec 3, 2014 at 5:38 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> >> > On Wed, Dec 3, 2014 at 2:15 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >> >> There's a bugzilla for this, so this email is to make the bugzilla
> >> >> more discoverable and to have a more public discussion about it.
> >> >>
> >> >>   https://bugzilla.kernel.org/show_bug.cgi?id=85491
> >> >>
> >> >> I think this regression is caused by 5b28541552ef ("PCI: Restrict
> >> >> 64-bit prefetchable bridge windows to 64-bit resources").  These dmesg
> >> >> fragments are from v3.16, which doesn't work:
> >> >>
> >> >>     pci_bus 0000:00: root bus resource [mem 0xc0000000-0xffffffff]
> >> >>
> >> >>     pci 0000:00:01.0: PCI bridge to [bus 01]
> >> >>     pci 0000:00:01.0:   bridge window [io  0x8000-0xafff]
> >> >>     pci 0000:00:01.0:   bridge window [mem 0xfdf00000-0xfdffffff]
> >> >>     pci 0000:00:01.0:   bridge window [mem 0xbdf00000-0xddefffff 64bit
> >> >> pref]  <-- outside host bridge window
> >> >>
> >> >>     pci 0000:01:00.0: reg 0x10: [mem 0xc0000000-0xcfffffff pref]
> >> >>     pci 0000:01:00.0: reg 0x14: [io  0xa000-0xa0ff]
> >> >>     pci 0000:01:00.0: reg 0x18: [mem 0xfdff0000-0xfdffffff]
> >> >>     pci 0000:01:00.0: reg 0x30: [mem 0xfdfc0000-0xfdfdffff pref]
> >> >>
> >> >>     pci 0000:00:01.0: can't claim BAR 15 [mem 0xbdf00000-0xddefffff
> >> >> 64bit pref]: no compatible bridge window
> >> >>     pci 0000:01:00.0: can't claim BAR 0 [mem 0xc0000000-0xcfffffff
> >> >> pref]: no compatible bridge window
> >> >
> >> > Looks like we wrong type checking from parent resource searching.
> >
> > I don't understand what you're trying to say, but I don't think the "no
> > compatible bridge window" problem is related to resource types.  I think
> > it's because the 00:01.0 window at [mem 0xbdf00000-0xddefffff] starts
> > before the [mem 0xc0000000-0xffffffff] host bridge window.
> 
> on this system _CRS is not used.

Oh, sorry, I didn't notice that Zermond's system doesn't use _CRS.  I had
been looking at the logs from Marek, and we *do* use _CRS there.  On
Zermond's machine we do still have the e820 code that figures out this:

  e820: [mem 0xc0000000-0xfedfffff] available for PCI devices

I think we could at least clamp the default host bridge window
([mem 0x00000000-0xfffffffff]) to that.

Bjorn
