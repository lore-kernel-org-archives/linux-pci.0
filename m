Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:62335 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754339AbaIDDfC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Sep 2014 23:35:02 -0400
Received: by mail-qg0-f45.google.com with SMTP id e89so9373467qgf.18
        for <linux-pci@vger.kernel.org>; Wed, 03 Sep 2014 20:35:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAA8O7Crwi7=afUpLoC1O5H9ymjYEPyb63kO8QdFuPx6RUJ8NpQ@mail.gmail.com>
References: <CAA8O7Crwi7=afUpLoC1O5H9ymjYEPyb63kO8QdFuPx6RUJ8NpQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 3 Sep 2014 21:34:40 -0600
Message-ID: <CAErSpo4dUjpGVVtDO6m7uf6MKRcybetg2_nUJ5ve0_Ykr=nXzg@mail.gmail.com>
Subject: Re: designware: prefetch and 64-bit addr support?
To: L H <swdevgid@gmail.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Mohit, Jingoo (from MAINTAINERS)]

On Wed, Sep 3, 2014 at 2:57 PM, L H <swdevgid@gmail.com> wrote:
> Greetings my fellow PCI designware developers.  I'm working on an
> implementation that relies on the PCIe DesignWare IP and am writing a
> platform-specific layer to link with the designware code, but have run
> into a couple challenges.
>
> Reading the pcie-designware.c (looking at the master branch of a repo
> cloned from git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git --
> is that the best branch/repo to view?),

That's a good place to look.  If I have pending changes for that code,
they will be on the pci/host-designware branch in that same repo.
Changes in that branch will generally be merged immediately after the
next major Linux release.  For example, right now we're in the middle
of the v3.17 cycle.  v3.16 was released August 3, the v3.17 release
will probably be in early October, and the contents of my
pci/host-designware branch will be merged in mid-October and be
released as part of v3.18, probably in mid-December.

> it appears to me that the
> dw_pcie_host_init() code doesn't comprehend prefetch memory ranges,
> but instead just assumes that a memory range is non-prefetch despite
> its encoding in the device-tree.  Am I reading that correctly?  The
> loop for walking the ranges begins with:
>
>     for_each_of_pci_range(&parser, &range) {
>         unsigned long restype = range.flags & IORESOURCE_TYPE_BITS;
>
> The bitmask for IORESOURCE_TYPE_BITS would result in a restype
> ignorant of the IORESOURCE_PREFETCH bit, right?   The ensuing code
> flow then treats the range as non-prefetch unless I missed something.
>
> Curiously, I also noted that the for_each_of_pcie_range() which calls
> of_pci_range_parser_one() that in turn includes calls to
> of_bus_pci_get_flags() does not set the IORESOURCE_MEM_64 bit parsed
> from the range either.
>
> If I followed that all correctly, is the proper assumption that all of
> the current implementations relying on the designware code only use
> 32-bit non-prefetch memory ranges?
>
> The platform which I'm working on will use a large 64-bit PCI memory
> address space, and thus I need 64-bit memory apertures which implies,
> I think, only prefetch memory.
>
> I hasten to add this isn't a complaint or critique of the valuable
> work developed up to this point. I'm very grateful to have it as a
> rich starting point.  I'm reaching out to the list here as a newbie to
> verify my comprehension of the designware code, and if valid, to
> inquire if there's any effort by anyone currently to support 64-bit
> prefetch ranges.  I've accepted the real possibility that I might be
> blazing this trail myself, but just wanted to check if anyone else has
> considered it or working on this support to avoid a redundant effort.
>
> thanks,
> LH
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
