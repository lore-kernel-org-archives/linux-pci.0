Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:63711 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbaHVF1s (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Aug 2014 01:27:48 -0400
Received: by mail-qc0-f169.google.com with SMTP id c9so10373301qcz.0
        for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2014 22:27:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+55aFyjn5BYHL0b6mTDmKc4pBSS9aViPNJH+8ks87M8wb3UYQ@mail.gmail.com>
References: <CA+55aFyjn5BYHL0b6mTDmKc4pBSS9aViPNJH+8ks87M8wb3UYQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 22 Aug 2014 00:27:27 -0500
Message-ID: <CAErSpo4y=4uEADB7JpX5ceotUiUzstXsoAg-it_WjHWvv5aLcQ@mail.gmail.com>
Subject: Re: Annoying and insane pci kernel messages..
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rafael]

On Wed, Aug 20, 2014 at 7:17 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> [ Oops, my mail client ended up picking an old address for Bjorn, so
> resending with the correct one ]
>
> So I don't know when this started happening, and it may well be an
> age-old issue, possibly made worse by configurations copied from
> distro makers that enable various random PCI hotplug logic, but my
> laptop dmesg is full of these annoying and worthless messages after
> suspend/resume:
>
>   ...
>   pci 0000:00:00.0: no hotplug settings from platform
>   pci 0000:00:00.0: using default PCI settings
>   i915 0000:00:02.0: no hotplug settings from platform
>   i915 0000:00:02.0: using default PCI settings
>   ...
>
> basically repeating mindlessly for each PCI device. It's insane. It
> adds zero value. Why do we print out those inane messages?
>
> The reason _seems_ to be that some ACPI hotplug logic basically ends
> up doing "pci_configure_slot()" on every PCI slot, whether something
> is hotpluggable or not. Trust me, those things aren't. Printing
> pointless hotplug information for them is just crazy, and takes up
> kernel message space and hides _real_ messages for no good reason.
>
> Lookie here:
>
>   [torvalds@vaio linux]$ dmesg | grep "no hotplug settings" | wc
>      1006    8658   71574
>
> yeah, that's a thousand lines of crap. There's another 568 lines of
> the "using default PCI settings". In fact, there's *more* of this, but
> there's been so much of it that it's scrolled off the kernel message
> buffer.
>
> Could we please not do this?

Yeah, this really seems broken.  It's not really news if the firmware
doesn't supply settings, so we could just drop the printk.  On the
other hand, it *might* be news if it *does* supply settings, so maybe
we should reverse the sense.  But I want to look at it a little more
because it seems like we shouldn't even be calling
pci_configure_slot() that many times to begin with.

Bjorn
