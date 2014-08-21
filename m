Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:49957 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbaHUARa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Aug 2014 20:17:30 -0400
Received: by mail-vc0-f173.google.com with SMTP id hy10so10045479vcb.18
        for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2014 17:17:30 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 20 Aug 2014 19:17:30 -0500
Message-ID: <CA+55aFyjn5BYHL0b6mTDmKc4pBSS9aViPNJH+8ks87M8wb3UYQ@mail.gmail.com>
Subject: Annoying and insane pci kernel messages..
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[ Oops, my mail client ended up picking an old address for Bjorn, so
resending with the correct one ]

So I don't know when this started happening, and it may well be an
age-old issue, possibly made worse by configurations copied from
distro makers that enable various random PCI hotplug logic, but my
laptop dmesg is full of these annoying and worthless messages after
suspend/resume:

  ...
  pci 0000:00:00.0: no hotplug settings from platform
  pci 0000:00:00.0: using default PCI settings
  i915 0000:00:02.0: no hotplug settings from platform
  i915 0000:00:02.0: using default PCI settings
  ...

basically repeating mindlessly for each PCI device. It's insane. It
adds zero value. Why do we print out those inane messages?

The reason _seems_ to be that some ACPI hotplug logic basically ends
up doing "pci_configure_slot()" on every PCI slot, whether something
is hotpluggable or not. Trust me, those things aren't. Printing
pointless hotplug information for them is just crazy, and takes up
kernel message space and hides _real_ messages for no good reason.

Lookie here:

  [torvalds@vaio linux]$ dmesg | grep "no hotplug settings" | wc
     1006    8658   71574

yeah, that's a thousand lines of crap. There's another 568 lines of
the "using default PCI settings". In fact, there's *more* of this, but
there's been so much of it that it's scrolled off the kernel message
buffer.

Could we please not do this?

          Linus
