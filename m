Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753744AbdCTNVl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Mar 2017 09:21:41 -0400
Date: Mon, 20 Mar 2017 13:21:32 +0000
From: Will Deacon <will.deacon@arm.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jerin Jacob <jerin.jacob@caviumnetworks.com>,
        lorenzo.pieralisi@arm.com, david.daney@cavium.com,
        catalin.marinas@arm.com, Liviu.Dudau@arm.com, rrichter@cavium.com,
        hanjun.guo@linaro.org, bhelgaas@google.com,
        linux-arm-kernel@lists.infradead.org,
        linux-pci <linux-pci@vger.kernel.org>, benh@kernel.crashing.org
Subject: Re: [PATCH v2] arm64: pci: add support for pci_mmap_page_range
Message-ID: <20170320132132.GN17263@arm.com>
References: <1460581856-12380-1-git-send-email-jerin.jacob@caviumnetworks.com>
 <20160415130953.GI22906@arm.com>
 <1489666647.4195.238.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1489666647.4195.238.camel@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 16, 2017 at 12:17:27PM +0000, David Woodhouse wrote:
> On Fri, 2016-04-15 at 14:09 +0100, Will Deacon wrote:
> > 
> > > +     if (write_combine)
> > > +             vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> > > +     else
> > > +             vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > 
> > For consistency with ioremap, this should be pgprot_device.
> 
> What's the difference?

The different between ioremap (which used pgprot_device) and a mapping
created using pgprot_noncached is that the former allows for early
acknowledgement of writes (e.g. at a bridge). See this recent series from
Lorenzo that is also trying to clean this up:

http://lkml.kernel.org/r/20170227151436.18698-1-lorenzo.pieralisi@arm.com

> I note that VFIO is using pgprot_noncached() too, in vfio_pci_mmap() —
> where it open-codes an entirely arch-agnostic version of
> pci_mmap_page_range() all for itself. Should that be changed to
> pgprot_device() too?

I think so. At least, on arm64, pgprot_noncached is only really needed
for PCI config space and "I don't know that this is, but I'm going to map
it anyway" regions in /dev/mem.

> Let me see if I can get this straight...
> 
> We have the legacy interface through /proc/bus/pci, where the user
> passes a "user-visible" bus address not necessarily (on platforms with
> HAVE_PCI_RESOURCE_TO_USER) a host physical address.
> 
> The arch-specific pci_mmap_page_range() exists to work around that
> translation, on the two platforms which need it. It *also* has (on
> about three platforms) support for a write-combining mapping.
> 
> The sysfs interface theough /sys/bus/pci/devices/*/resource* probably
> doesn't need to use pci_mmap_page_range() at all, *except* for the
> 'resourceX_wc' variant which has write-combining support.
> 
> How about we do the following (probably not in this order):
>  • Kill pci_mmap_page_range() entirely.
>  • Implement a generic version which has (arch-assisted) WC support
>    but no knowledge of the horrid pci_resource_to_user() mapping.
>  • Require pci_user_to_resource() to be provided by platforms with
>    HAVE_ARCH_PCI_RESOURCE_TO_USER, and call that from *generic* code,
>    for the legacy procfs interface, before invoking the generic
>    replacement for pci_mmap_page_range().
> 
> (Yes, we still need to support mmap of I/O resources on... is it only
> powerpc? And there are a few inconsistencies, like powerpc forcing WC
> even on the sysfs files that *don't* have _wc in their name, that
> probably want to be cleaned up as we consolidate...)

Happy to review patches :)

Will
