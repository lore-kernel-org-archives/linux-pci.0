Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:34554 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754815AbbEOTZz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 May 2015 15:25:55 -0400
Received: by qgfa7 with SMTP id a7so8724168qgf.1
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 12:25:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150515172836.GA27797@svl-evodev-groeck.juniper.net>
References: <20150515172836.GA27797@svl-evodev-groeck.juniper.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 15 May 2015 14:25:34 -0500
Message-ID: <CAErSpo5R0WF7J1OCagXNB2PcFUnNDB3LD6Q8A3pi=YYswzsaLw@mail.gmail.com>
Subject: Re: BAR 7 io space assignment errors
To: Guenter Roeck <groeck@juniper.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Yinghai]

Hi Guenter,

On Fri, May 15, 2015 at 12:28 PM, Guenter Roeck <groeck@juniper.net> wrote:
> Hi all,
>
> ever since 3.18(ish), we see lots of pcie io range allocation error messages
> when booting our systems.
>
> pcieport 0000:02:00.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
> pcieport 0000:02:00.0: BAR 7: no space for [io  size 0x1000]
> pcieport 0000:02:00.0: BAR 7: failed to assign [io  size 0x1000]
>
> This is repeated for each port.
>
> What we atually _want_ is no IO address range, but so far I have not been able to
> tell this to the code (or to the bridge).

What information does the core have that we could use to figure out
that you want no I/O space?  For example, does the host bridge have no
I/O apertures?  Or are there no devices below 02:00.0 that require I/O
space?  If you can post a complete dmesg log, that should contain this
information.

I think we currently will try to assign enough I/O space for any I/O
BARs below the bridge.  Or, if the bridge supports hotplug, we will
try to assign at least pci_hotplug_io_size, which defaults to 256.

> The IO space "0x1000-0xfff" gives an indication of what is going on, at least
> to some degree. The io range is calculated in pbus_size_io() as
>         b_res->start = min_align;
>         b_res->end = b_res->start + size0 - 1;
> with size0 == 0, so end < start.
>
> Searching for the get_res_add_size and the BAR7 message suggests that many
> others see the problem as well, so it appears that we are not alone.
> I have not been able to find a solution, though.
>
> Any idea what we may have to do to fix the problem, or in other words
> what may be wrong ?

Is the problem that some device doesn't work, or is it just extra
annoying messages.  We should fix something in either case, of course,
but it's more urgent if a device used to work but no longer does.

Bjorn
