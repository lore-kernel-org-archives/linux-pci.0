Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:44947 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbbCKChC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Mar 2015 22:37:02 -0400
Received: by oifu20 with SMTP id u20so5323372oif.11
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2015 19:37:01 -0700 (PDT)
Date: Tue, 10 Mar 2015 21:36:58 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v12 10/21] PCI: Consider additional PF's IOV BAR
 alignment in sizing and assigning
Message-ID: <20150311023658.GA10994@google.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224083406.32124.65957.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224084152.GG6220@google.com>
 <20150302073247.GE21571@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150302073247.GE21571@richard>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 02, 2015 at 03:32:47PM +0800, Wei Yang wrote:
> On Tue, Feb 24, 2015 at 02:41:52AM -0600, Bjorn Helgaas wrote:
> >On Tue, Feb 24, 2015 at 02:34:06AM -0600, Bjorn Helgaas wrote:
> >> From: Wei Yang <weiyang@linux.vnet.ibm.com>
> >> 
> >> When sizing and assigning resources, we divide the resources into two
> >> lists: the requested list and the additional list.  We don't consider the
> >> alignment of additional VF(n) BAR space.
> >> 
> >> This is reasonable because the alignment required for the VF(n) BAR space
> >> is the size of an individual VF BAR, not the size of the space for *all*
> >> VFs.  But some platforms, e.g., PowerNV, require additional alignment.
> >> 
> >> Consider the additional IOV BAR alignment when sizing and assigning
> >> resources.  When there is not enough system MMIO space, the PF's IOV BAR
> >> alignment will not contribute to the bridge.  When there is enough system
> >> MMIO space, the additional alignment will contribute to the bridge.
> >
> >I don't understand the ""when there is not enough system MMIO space" part.
> >How do we tell if there's enough MMIO space?
> >
> 
> In __assign_resources_sorted(), it has two resources list, one for requested
> (head) and one for additional (realloc_head). This function will first try to
> combine them and assign. If failed, this means we don't have enough MMIO
> space.

How about this text:

  This is because the alignment required for the VF(n) BAR space is the size
  of an individual VF BAR, not the size of the space for *all* VFs.  But we
  want additional alignment to support partitioning on PowerNV.

  Consider the additional IOV BAR alignment when sizing and assigning
  resources.  When there is not enough system MMIO space to accomodate both
  the requested list and the additional list, the PF's IOV BAR alignment will
  not contribute to the bridge.  When there is enough system MMIO space for
  both lists, the additional alignment will contribute to the bridge.

We're doing something specifically for PowerNV.  I would really like to be
able to read this patch and say "Oh, here's the hook where we get the
PowerNV behavior, and it's obvious that other platforms are unaffected."
But I don't see a pcibios or similar hook, so I don't know where that
PowerNV behavior is.

Is it something to do with get_res_add_align()?  That uses min_align, but I
don't know how that's connected ...  ah, I see, "add_align" is computed
from pci_resource_alignment(), which has this path:

  pci_resource_alignment
    pci_sriov_resource_alignment
      pcibios_iov_resource_alignment

and powerpc has a special pcibios_iov_resource_alignment() for PowerNV.

> >> Also, take advantage of pci_dev_resource::min_align to store this
> >> additional alignment.
> >
> >This comment doesn't seem to make sense; this patch doesn't save anything
> >in min_align.
> 
> At the end of this patch:
> 
>    add_to_list(realloc_head, bus->self, b_res, size1-size0, add_align);
> 
> The add_align is stored in pci_dev_resource::min_align in add_to_list(). And
> retrieved by get_res_add_align() in below code. This field is not used
> previously, so I took advantage of this field to store the alignment of the
> additional resources.

Hmm.  pci_dev_resource::min_align *is* already used in
reassign_resources_sorted().  Maybe there's no overlap; I gave up the
analysis before I could convince myself.

The changelog needs to mention the add_to_list() connection.

> >> +		/*
> >> +		 * There are two kinds of additional resources in the list:
> >> +		 * 1. bridge resource  -- IORESOURCE_STARTALIGN
> >> +		 * 2. SR-IOV resource   -- IORESOURCE_SIZEALIGN
> >> +		 * Here just fix the additional alignment for bridge
> >> +		 */
> >> +		if (!(dev_res->res->flags & IORESOURCE_STARTALIGN))
> >> +			continue;
> >> +
> >> +		add_align = get_res_add_align(realloc_head, dev_res->res);
> >> +
> >> +		/* Reorder the list by their alignment */
> >
> >Why do we need to reorder the list by alignment?
> 
> Resource list "head" is sorted by the alignment, while the alignment would be
> changed after we considering the additional resource.
> 
> Take powernv platform as an example. The IOV BAR is expanded and need to be
> aligned with its total size instead of the individual VF BAR size. If we don't
> reorder it, the IOV BAR would be assigned after some other resources, which
> may cause the real assignment fail even the total size is enough.

This is worthy of a comment in the code.

Bjorn
