Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:41493 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbaFKUcS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jun 2014 16:32:18 -0400
Received: by mail-ig0-f175.google.com with SMTP id uq10so6895405igb.8
        for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2014 13:32:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5398A8CB.9000007@spellingbeewinnars.org>
References: <5398A8CB.9000007@spellingbeewinnars.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 11 Jun 2014 14:31:57 -0600
Message-ID: <CAErSpo4BoKVRjGEAiWGC0CH+xoFpYcvuwSWY10JA=F5j6AgWeg@mail.gmail.com>
Subject: Re: updating firmware with setpci ?
To: Patrick <patrick@spellingbeewinnars.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 11, 2014 at 1:06 PM, Patrick <patrick@spellingbeewinnars.org> wrote:
> Hi Everyone
>
> I hope i have understood the documentation and I am basically in the right
> place.
>
> I repair circuit boards used with scientific instruments. I have several PCI
> cards that I believe are functioning properly otherwise but a driver for
> them cannot be loaded under windows.
>
> Can I use lspci to retrieve header information from a healthy card and then
> write this to another card using setpci ?

You can use "lspci -x" (or "-xxx", etc) to read the card's
configuration space, and then you can use setpci to write to a
different card.

But most of the stuff in configuration space is either read-only or
programmed by the BIOS and OS during boot, so I don't know how likely
it is that you can fix things this way.

Card firmware probably isn't in configuration space.  It could be in
an option ROM on the card.  You could compare the contents of the ROMs
by doing something like this:

  # cd /sys/devices/pci0000:00/0000:00:02.0
  # echo 1 > rom
  # xxd rom

The option ROM is intended to be executed by the BIOS or the OS.

There might also be other firmware that's executed by a processor on
the card.  That would be in some other card-specific place, and the
way to update it is card-specific, too.  It's possible that it would
be mapped by a BAR.  In that case, you could use something like this:

  http://cmp.felk.cvut.cz/~pisa/linux/rdwrmem.c

to read/write it.  You'd have to use lspci to find the addresses in
the BARs, then give those addresses to rdwrmem to access the memory
mapped by the BARs.  But of course, the stuff mapped by the BARs is
completely device-specific -- it could be registers, buffers,
firmware, etc.

> The -m option speaks about machine readable but it still looks like plain
> text to me. Will setpci take this and write it as binary to another card ?

Nope.  The "machine-readable" part just means it's a simple format
that would be easy for a program to parse.

Bjorn
