Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:63289 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754742Ab2IGWuD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Sep 2012 18:50:03 -0400
Received: by lbbgj3 with SMTP id gj3so148636lbb.19
        for <linux-pci@vger.kernel.org>; Fri, 07 Sep 2012 15:50:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1346994035-16218-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1346994035-16218-1-git-send-email-shangw@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 7 Sep 2012 15:49:41 -0700
Message-ID: <CAErSpo559Hr-fnZTDZGOfz9T6_GSHKhoKChgNbq-apLuLqbaYQ@mail.gmail.com>
Subject: Re: [PATCH V9 0/5] Minimal alignment for p2p bars
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 6, 2012 at 10:00 PM, Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
> v1 -> v2:
>         * Shorten the varaible names so that they looks more short.
>         * Changelog adjustment so that they looks more meaningful.
> v2 -> v3:
>         * Rebase to 3.5.RC4
> v3 -> v4:
>         * Merge Yinghai's patches.
>         * Split patch for easy review.
>         * Add function to retrieve the minimal alignment of p2p bridge.
> v4 -> v5:
>         * Rebase to 3.5.RC7
>         * Introduce weak function pcibios_window_alignment() to retrieve
>           I/O and memory alignment for P2P bridges.
>         * Introduce pcibios_window_alignment() for ppc to override the
>           PCI function.
>         * Add ppc_md.pcibios_window_alignment() for specific platform like
>           powernv can override ppc's pcibios_window_alignment().
> v5 -> v6:
>         * Refactor pcibios_window_alignment() so the platform-specific
>           implementation needn't return the default alignment according
>           to Bjorn's suggestion.
>         * Simplify pbus_size_mem() according to Bjorn's suggestion: Just
>           check the platform required alignment at very end and adjust
>           the "min_align" if necessary.
> v6 -> v7:
>         * Change "type" to "b_res->flags & mask" while retrieving the
>           minimal alignment for memory window according to Ram's suggestion.
>         * Refactor pbus_size_mem() according to Ram's suggestion.
>         * ppc_md.pcibios_window_alignment returns 1 for those PCI bridges
>           behind PCI bridges so that PCI core will use default alignment
>           values.
> v7 -> v8:
>         * Rebase to 3.6.RC2, which starts to use "struct resource" to represent
>           the range of PCI bus numbers that specific p2p bridge covers.
>         * Define macros for the default alignment of P2P bars according to
>           Richard's comments.
> v8 -> v9:
>         * Rebase to 3.6.RC4
>         * Remove the original first 3 patches since they're irrevelant to the
>           intention.
>         * Platform can override p2p I/O alignment even the p2p bridge explicitly
>           requires 1KiB I/O alignment according to Bjorn's comments.
>         * In function pbus_size_io(), the maximal allowed I/O alignment was changed
>           from 4KiB to 1KiB for those p2p bridges that require 1KiB alignment, which
>           is traced by variable "io_align". I'm not sure that's correct for 100% since
>           the original implementation had 1KiB for "io_align" for the case.
>         * Adjustment for pnv_pci_window_alignment() so that we can use the default
>           alignments (4KiB for I/O, 1MiB for memory) if the PCI bus isn't the top
>           level bus in the associated EEH segment.
>
> Gavin Shan(5)
>   pci: weak function returns alignment
>   pci: resource assignment based on p2p alignment
>   pci: refactor function pbus_size_mem
>   ppc/pci: override pcibios_window_alignment
>   ppc/pnv: I/O and memory alignment for p2p bridges
>
> -----
>
> arch/powerpc/include/asm/machdep.h        |    3 +
> arch/powerpc/kernel/pci-common.c          |   20 +++++++
> arch/powerpc/platforms/powernv/pci-ioda.c |   39 ++++++++++++++
> drivers/pci/setup-bus.c                   |   81 +++++++++++++++++++++--------
> include/linux/pci.h                       |    2 +
> 5 files changed, 124 insertions(+), 21 deletions(-)

I applied these to:

http://git.kernel.org/?p=linux/kernel/git/helgaas/pci.git;a=shortlog;h=refs/heads/pci/gavin-window-alignment

Assuming they pass Fengguang's build/smoke test, I'll merge that to my
"next" branch soon.  Thanks!

Bjorn
