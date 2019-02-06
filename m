Return-Path: <SRS0=okY7=QN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F43DC169C4
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 21:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC84218D9
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 21:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549488134;
	bh=p8rqAzjOJt+cwwDEORI1nwyRPD6aCHKFkNofaAGLfP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sq+CQwNrXnk5Pr7jdznbsNNb+krXa5XJtRrbw86aRrmQza78LMGQYSLnw3uuE+LZC
	 Vx8wKbcp1VVpsd1BXlN8cUDvSEDSYz5cm86NlLw6uwuO0SwaLVHbt8iUyo5b8yZ/ZI
	 qbe3mV4kjNj+q2JfS/AqmosdSJIyUIw62WO+/mVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfBFVWN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:22:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:45340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfBFVWN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Feb 2019 16:22:13 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C84F2218B0;
        Wed,  6 Feb 2019 21:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549488131;
        bh=p8rqAzjOJt+cwwDEORI1nwyRPD6aCHKFkNofaAGLfP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lBc41plIFBGELCVCKyq3f4RCLd8VHZedEyKzgDKoIStxLrBDhdNZc/axy6WF9BYMt
         AtjuTfJfKdWxleVkHQQuVI5p9Tdl6jeaszNEPU7frLtbRNTSIAJV/JZagb1ZSdtaZO
         UQDsNpV1vJmZdsMurYzP1Y/jovWNjLW394ly+4sI=
Date:   Wed, 6 Feb 2019 15:22:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thymo van Beers <thymovanbeers@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Rientjes <rientjes@google.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI: fix serious bug when sizing bridges with
 additional size
Message-ID: <20190206212206.GE7268@google.com>
References: <PS2P216MB064285AB6C7C1045AB86FC24806F0@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS2P216MB064285AB6C7C1045AB86FC24806F0@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Can you please add a cover letter and series revision the next time
you post this?  See the list archives for samples.  That helps me know
when I can ignore old patches when they've been superseded.

I think you also need to put something in the "To:" header.  I usually
use linux-pci@vger.kernel.org when there's no other obvious candidate.
Mutt doesn't seem to handle the empty To: header correctly; I see this
when responding:

  Cc: no To-header on input <;,
	"mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
	...

You could probably also trim the CC: list.  I'm not sure *all* of them
will be interested in PCI details like this.  But I don't really want
to offend any of them by suggesting names to remove :)

On Wed, Feb 06, 2019 at 10:25:13AM +0000, Nicholas Johnson wrote:
> Background: I discovered a bug while preparing my next patch for
> Thunderbolt native PCI enumeration. This bugfix is vital for that next
> Thunderbolt patch. They are related and could be put together but I am
> presenting them as separate patches.
> 
> Nature of problem: On boot, the PCI bridges are handled in the function
> pci_assign_unassigned_root_bus_resources(). This function makes multiple
> passes / attempts to assign all of the resources. It calls
> __pci_bus_size_bridges() which tries to assign required resources, plus
> additional requested space. It makes calls to pbus_size_io() and
> pbus_size_mem() which return zero on success. However, these functions
> misleadingly return non-zero if the resource is already assigned.
> 
> The fallout: If the first attempt to allocate resources on a bridge
> succeeds in 64-bit MMIO_PREF, but fails in 32-bit MMIO, then a second
> attempt is made. Then, the __pbus_size_mem() returns non-zero for
> MMIO_PREF because the resource is already assigned. That makes
> __pci_bus_size_bridges() think there is no space (ENOSPC) and it
> attempts to assign the sum of the MMIO_PREF and MMIO sizes into a 32-bit
> window. This means that it tries to request the sum of the the MMIO and
> MMIO_PREF size into the MMIO window. In the best case, the MMIO size is
> equal to the MMIO_PREF size and we get double the window in MMIO, and
> the correct size in MMIO_PREF, and nothing bad happens. In a worse case,
> doubling the size makes it fail due to lack of space in the miniscule
> MMIO 32-bit address space. In that case, we might be able to reduce the
> requested size. In the worst case, we have requested for a vast amount
> of MMIO_PREF, and a small amount of MMIO. The kernel tries to assign the
> sum of the sizes of the two types in the MMIO window, leaving us with
> MMIO_PREF assigned and MMIO unassigned due to the requested size being
> too large to assign. In this case, there is nothing we can do about it.
> If a massive additional MMIO_PREF and a small non-zero amount of
> additional MMIO are needed, then we cannot reduce the requested
> MMIO_PREF to work around the bug.
> 
> The cause: pbus_size_io() and pbus_size_mem() both call
> find_free_bus_resource() to identify which bridge window of the bus
> meets the criteria. This function explicitly skips resources with a
> parent, inevitably returning NULL. The functions pbus_size_io() and
> pbus_size_mem() return -ENOSPC if find_free_bus_resource() returns NULL,
> meaning an assigned resource is interpreted as having been failed to
> assign, potentially causing it to try to allocate it again in another
> window.
> 
> The solution: my proposed patch renames find_free_bus_resource() to
> find_bus_resource_of_type() and modifies it to not skip resources with
> r->parent. The name change is because returning an assigned resource
> makes the resource potentially not "free". The calling functions,
> pbus_size_io() and pbus_size_mem() have checks added for b_res->parent
> and they return 0 (success) in this case. This is because a resource
> with a parent is already assigned and should be interpreted as a
> success, not a failure.
> 
> Testing: I have tested my proposed patch and it appears to work
> flawlessly. It has the added benefit of slashing the number of attempts
> taken to assign a given BAR, meaning a much cleaner dmesg. In fact, in
> my configuration, it has gone from very messy to mainly IO BAR failures.
> There is nothing that can be done about IO BARs because of the 16-bit
> hardware limitation, meaning the amount of available space cannot be
> increased. All that I am left with is a few "failed to assign [mem
> size]" very early in boot, before those BARs succeed in the next
> attempt. After the small initial set of failures for MEM, there are no
> more "failed to assign" whatsoever for non-IO BARs.

If it's possible to distill a concrete example of an actual case that
previously failed and now works, with real addresses from dmesg or
similar, that is as small as possible, that might help understand the
changes you're making.

> Remarks: I fixed some other block comments to comply with kernel code
> styling standards. I had to modify the one block comment to reflect the
> changes, and checkpatch.pl got really angry and yelled at me. So I
> figured I may as well fix the lot.

Thanks for the comment cleanups.  I do want those, but it's better if
you can do the minimal changes required to accompany the code changes,
followed by a second patch that does *only* the reformatting required
by checkpatch.  That way the second patch will be trivial to review,
since it's obvious that it doesn't change any code.  It also avoids
cluttering the actual bug-fix or feature-add patches with changes to
unrelated comments.  It's OK if the bug-fix patch is not 100%
checkpatch-clean, as long as it doesn't make things *worse*.  It's
even OK if the final patch is not 100% checkpatch-clean; human
judgment is required to interpret the things it complains about.

I would wait a few days before reposting to address that.  Sometimes
other people will comment and you can take care of those comments at
the same time.  It's a little frustrating as a reviewer to spend a
lot of time reviewing v1 only to find that v2 and v3 have been
posted with significant changes while you were looking at v1.

> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> ---
>  drivers/pci/setup-bus.c | 82 +++++++++++++++++++++++++----------------
>  1 file changed, 51 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index a8be1a90f..c7e0a5e2b 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -563,17 +563,19 @@ void pci_setup_cardbus(struct pci_bus *bus)
>  }
>  EXPORT_SYMBOL(pci_setup_cardbus);
>  
> -/* Initialize bridges with base/limit values we have collected.
> -   PCI-to-PCI Bridge Architecture Specification rev. 1.1 (1998)
> -   requires that if there is no I/O ports or memory behind the
> -   bridge, corresponding range must be turned off by writing base
> -   value greater than limit to the bridge's base/limit registers.
> -
> -   Note: care must be taken when updating I/O base/limit registers
> -   of bridges which support 32-bit I/O. This update requires two
> -   config space writes, so it's quite possible that an I/O window of
> -   the bridge will have some undesirable address (e.g. 0) after the
> -   first write. Ditto 64-bit prefetchable MMIO.  */
> +/*
> + * Initialize bridges with base/limit values we have collected.
> + * PCI-to-PCI Bridge Architecture Specification rev. 1.1 (1998)
> + * requires that if there is no I/O ports or memory behind the
> + * bridge, corresponding range must be turned off by writing base
> + * value greater than limit to the bridge's base/limit registers.
> + *
> + * Note: care must be taken when updating I/O base/limit registers
> + * of bridges which support 32-bit I/O. This update requires two
> + * config space writes, so it's quite possible that an I/O window of
> + * the bridge will have some undesirable address (e.g. 0) after the
> + * first write. Ditto 64-bit prefetchable MMIO.
> + */
>  static void pci_setup_bridge_io(struct pci_dev *bridge)
>  {
>  	struct resource *res;
> @@ -636,9 +638,11 @@ static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
>  	struct pci_bus_region region;
>  	u32 l, bu, lu;
>  
> -	/* Clear out the upper 32 bits of PREF limit.
> -	   If PCI_PREF_BASE_UPPER32 was non-zero, this temporarily
> -	   disables PREF range, which is ok. */
> +	/*
> +	 * Clear out the upper 32 bits of PREF limit.
> +	 * If PCI_PREF_BASE_UPPER32 was non-zero, this temporarily
> +	 * disables PREF range, which is ok.
> +	 */
>  	pci_write_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, 0);
>  
>  	/* Set up PREF base/limit. */
> @@ -730,9 +734,11 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
>  	return -EINVAL;
>  }
>  
> -/* Check whether the bridge supports optional I/O and
> -   prefetchable memory ranges. If not, the respective
> -   base/limit registers must be read-only and read as 0. */
> +/*
> + * Check whether the bridge supports optional I/O and
> + * prefetchable memory ranges. If not, the respective
> + * base/limit registers must be read-only and read as 0.
> + */
>  static void pci_bridge_check_ranges(struct pci_bus *bus)
>  {
>  	u16 io;
> @@ -752,9 +758,11 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
>  	if (io)
>  		b_res[0].flags |= IORESOURCE_IO;
>  
> -	/*  DECchip 21050 pass 2 errata: the bridge may miss an address
> -	    disconnect boundary by one PCI data phase.
> -	    Workaround: do not use prefetching on this device. */
> +	/*
> +	 * DECchip 21050 pass 2 errata: the bridge may miss an address
> +	 * disconnect boundary by one PCI data phase.
> +	 * Workaround: do not use prefetching on this device.
> +	 */
>  	if (bridge->vendor == PCI_VENDOR_ID_DEC && bridge->device == 0x0001)
>  		return;
>  
> @@ -789,11 +797,17 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
>  	}
>  }
>  
> -/* Helper function for sizing routines: find first available
> -   bus resource of a given type. Note: we intentionally skip
> -   the bus resources which have already been assigned (that is,
> -   have non-NULL parent resource). */
> -static struct resource *find_free_bus_resource(struct pci_bus *bus,
> +/*
> + * Helper function for sizing routines: find first bus resource of a
> + * given type. Note: we do not skip the bus resources which have already
> + * been assigned (r->parent != NULL). This is because a resource that is
> + * already assigned (nothing more to be done) will be indistinguishable
> + * from one that failed due to lack of space if we skip assigned
> + * resources. If the caller function cannot tell the difference then it
> + * might try to place the resources in a different window, doubling up on
> + * resources or causing unforeseeable issues.
> + */
> +static struct resource *find_bus_resource_of_type(struct pci_bus *bus,
>  			 unsigned long type_mask, unsigned long type)
>  {
>  	int i;
> @@ -802,7 +816,7 @@ static struct resource *find_free_bus_resource(struct pci_bus *bus,
>  	pci_bus_for_each_resource(bus, r, i) {
>  		if (r == &ioport_resource || r == &iomem_resource)
>  			continue;
> -		if (r && (r->flags & type_mask) == type && !r->parent)
> +		if (r && (r->flags & type_mask) == type)
>  			return r;
>  	}
>  	return NULL;
> @@ -820,8 +834,10 @@ static resource_size_t calculate_iosize(resource_size_t size,
>  		size = min_size;
>  	if (old_size == 1)
>  		old_size = 0;
> -	/* To be fixed in 2.5: we should have sort of HAVE_ISA
> -	   flag in the struct pci_bus. */
> +	/*
> +	 * To be fixed in 2.5: we should have sort of HAVE_ISA
> +	 * flag in the struct pci_bus.
> +	 */
>  #if defined(CONFIG_ISA) || defined(CONFIG_EISA)
>  	size = (size & 0xff) + ((size & ~0xffUL) << 2);
>  #endif
> @@ -900,14 +916,16 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
>  		resource_size_t add_size, struct list_head *realloc_head)
>  {
>  	struct pci_dev *dev;
> -	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO,
> -							IORESOURCE_IO);
> +	struct resource *b_res = find_bus_resource_of_type(bus, IORESOURCE_IO,
> +					IORESOURCE_IO);
>  	resource_size_t size = 0, size0 = 0, size1 = 0;
>  	resource_size_t children_add_size = 0;
>  	resource_size_t min_align, align;
>  
>  	if (!b_res)
>  		return;
> +	if (b_res->parent)
> +		return;
>  
>  	min_align = window_alignment(bus, IORESOURCE_IO);
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
> @@ -1012,7 +1030,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  	resource_size_t min_align, align, size, size0, size1;
>  	resource_size_t aligns[18];	/* Alignments from 1Mb to 128Gb */
>  	int order, max_order;
> -	struct resource *b_res = find_free_bus_resource(bus,
> +	struct resource *b_res = find_bus_resource_of_type(bus,
>  					mask | IORESOURCE_PREFETCH, type);
>  	resource_size_t children_add_size = 0;
>  	resource_size_t children_add_align = 0;
> @@ -1020,6 +1038,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  
>  	if (!b_res)
>  		return -ENOSPC;
> +	if (b_res->parent)
> +		return 0;
>  
>  	memset(aligns, 0, sizeof(aligns));
>  	max_order = 0;
> -- 
> 2.19.1
> 
