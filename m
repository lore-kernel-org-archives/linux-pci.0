Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:38881 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017AbaICU5M (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Sep 2014 16:57:12 -0400
Received: by mail-ie0-f173.google.com with SMTP id lx4so10494650iec.18
        for <linux-pci@vger.kernel.org>; Wed, 03 Sep 2014 13:57:11 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 3 Sep 2014 15:57:11 -0500
Message-ID: <CAA8O7Crwi7=afUpLoC1O5H9ymjYEPyb63kO8QdFuPx6RUJ8NpQ@mail.gmail.com>
Subject: designware: prefetch and 64-bit addr support?
From: L H <swdevgid@gmail.com>
To: linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Greetings my fellow PCI designware developers.  I'm working on an
implementation that relies on the PCIe DesignWare IP and am writing a
platform-specific layer to link with the designware code, but have run
into a couple challenges.

Reading the pcie-designware.c (looking at the master branch of a repo
cloned from git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git --
is that the best branch/repo to view?), it appears to me that the
dw_pcie_host_init() code doesn't comprehend prefetch memory ranges,
but instead just assumes that a memory range is non-prefetch despite
its encoding in the device-tree.  Am I reading that correctly?  The
loop for walking the ranges begins with:

    for_each_of_pci_range(&parser, &range) {
        unsigned long restype = range.flags & IORESOURCE_TYPE_BITS;

The bitmask for IORESOURCE_TYPE_BITS would result in a restype
ignorant of the IORESOURCE_PREFETCH bit, right?   The ensuing code
flow then treats the range as non-prefetch unless I missed something.

Curiously, I also noted that the for_each_of_pcie_range() which calls
of_pci_range_parser_one() that in turn includes calls to
of_bus_pci_get_flags() does not set the IORESOURCE_MEM_64 bit parsed
from the range either.

If I followed that all correctly, is the proper assumption that all of
the current implementations relying on the designware code only use
32-bit non-prefetch memory ranges?

The platform which I'm working on will use a large 64-bit PCI memory
address space, and thus I need 64-bit memory apertures which implies,
I think, only prefetch memory.

I hasten to add this isn't a complaint or critique of the valuable
work developed up to this point. I'm very grateful to have it as a
rich starting point.  I'm reaching out to the list here as a newbie to
verify my comprehension of the designware code, and if valid, to
inquire if there's any effort by anyone currently to support 64-bit
prefetch ranges.  I've accepted the real possibility that I might be
blazing this trail myself, but just wanted to check if anyone else has
considered it or working on this support to avoid a redundant effort.

thanks,
LH
