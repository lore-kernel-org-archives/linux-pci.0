Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061782E888C;
	Tue, 28 Jul 2026 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785234936; cv=none; b=fjKCENNKbwz1qXtQwzlHg9VA07aHfvZn+wrrRTyUlnnw5/h5JckpaNlSFtjYqgze5p6Us182IHxD/xZSNJ53p1K9NqhIpTeq60NhuA5V6eLhOpAHZ2DP861Ec0GS5LoHWLNj5iINWiNANFwLXWfIUf1nt2i6D6MNGDBaDFUEUZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785234936; c=relaxed/simple;
	bh=iuXUoHIChjwPPWJ7AW2ooBNG++teht5GXltByQhCAdM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dA7r85myUQhxVGJYWQk7ULSmOymh+YOg8remdm5tOjP5gwIoVZ8Qv+2DktwLeYtx/3mt7TXa2pxc9tglIAZ5xs/365OJOuxw4jnmM0Vf+GVBgECDYSRYR6O1noc6LOIrUWMPRbYYgLXnCTigVyzKng6OWH6xMMofgO92tBmF18g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gwkTVML/; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwkTVML/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785234934; x=1816770934;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iuXUoHIChjwPPWJ7AW2ooBNG++teht5GXltByQhCAdM=;
  b=gwkTVML/ty4GpU/i3IAb5qiNNtqk/CG6qvgzAXTwoSQErm4DlAPJA7z0
   6mQAuAPykiEJDbaPsqwU8MWMB6y5ou0KEQoFt7S08w6oUT++YTmiMGk3l
   HHzb2qVSWaTPh1pApRcGbObpJDC0L0AbsnxeSs9vY2ek/4KwMtfSkHncM
   l3bEMCCmAbAyQUW+ay9JTHyvoQuQkXbY6rIifMGfla/Avd44XuBzzSSSF
   Sz2y5tvA8JP1ao0N3YC8VOL9JLhmiU17sMvt1tJ1tXI64kXakkM/yDEmB
   BiLOKBCkpnuFCHWoXcwpA6l8YoD4IJ7Y/sgglVkhGiOuEFjEOy9h5YX+k
   w==;
X-CSE-ConnectionGUID: zQDmpLSsSi6FjZrJucRWXQ==
X-CSE-MsgGUID: wR4458u5REmZ6W0N0S8veA==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="97189566"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="97189566"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 03:34:44 -0700
X-CSE-ConnectionGUID: ZcwB4GVbQ9+ZmaVOgx3KTg==
X-CSE-MsgGUID: el6LHlssSjObDBjrRBiDfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="257863315"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 03:34:41 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 28 Jul 2026 13:34:37 +0300 (EEST)
To: Anthony Pighin <anthony.pighin@nokia.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Don't report zero-sized resources as assignment
 failures
In-Reply-To: <20260727193714.598562-1-anthony.pighin@nokia.com>
Message-ID: <8d9a8515-03bb-6327-c82c-61cad0de75e8@linux.intel.com>
References: <20260727193714.598562-1-anthony.pighin@nokia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 27 Jul 2026, Anthony Pighin wrote:

> A hotplug bridge may request a window with required size 0 plus
> add_size headroom.  For example, the PCI core speculatively requests
> a non-prefetchable MMIO reserve for a hotplug bridge even when no
> downstream BAR currently requires that space.
> 
> reassign_resources_sorted() temporarily grows an unassigned resource
> from its required size to the required size plus add_size.  If
> pci_assign_resource() fails, the failure is ignored because the
> additional space is optional, but the error path does not restore
> start/end, so the resource is left unassigned at the enlarged size.

This fix is fine, I suggest you send this independently from the other 
change.

> Since commit 96336ec70264 ("PCI: Perform reset_resource() and build
> fail list in sync"), the __assign_resources_sorted() out path
> unconditionally adds every remaining unassigned resource to fail_head.
> The headroom-enlarged window is therefore reported as though a required
> resource failed.

The presence of a resource on fail list does not tell anything about it 
being required or not. It think you're trying to fix this problem on a 
wrong level.

> pci_assign_unassigned_bridge_resources() interprets the non-empty
> fail_head as grounds for another assignment round.  On a system whose
> < 4GB root-bus MMIO aperture [mem 0xe6000000-0xe68fffff] was already
> fully allocated, hotplugging an endpoint that needs only a 64-bit
> prefetchable BAR produces:
> 
>   pci 0000:08:00.0: BAR 0 [mem 0x00000000-0x7fffffff 64bit pref]
>   pcieport 0000:00:03.5: bridge window [mem size 0x00200000]: can't assign; no space
>   pcieport 0000:00:03.5: bridge window [mem size 0x00200000]: failed to assign
>   pci 0000:08:00.0: BAR 0 [mem 0x700000000-0x77fffffff 64bit pref]: assigned
>   PCI: No. 2 try to assign unassigned res
>   release child resource [mem 0xe6800000-0xe681ffff]     <- igb BAR 0
>   release child resource [mem 0xe6820000-0xe6823fff]     <- igb BAR 3
>   pcieport 0000:00:01.3: bridge window [mem 0xe6800000-0xe68fffff]: releasing
>   pcieport 0000:00:03.2: bridge window [mem 0xe6600000-0xe67fffff]: releasing
>   pcieport 0000:00:07.1: bridge window [mem 0xe6300000-0xe65fffff]: releasing
>   [ ... 30 further child resources released below 00:08.1 ... ]
>   pcieport 0000:00:08.1: bridge window [mem 0xe6000000-0xe62fffff]: releasing
>   pcieport 0000:00:03.5: bridge window [mem 0xe6000000-0xe61fffff]: assigned
>   igb 0000:02:00.0 mgmt: PCIe link lost
>   igb: Failed to read reg 0xc030!
> 
> The endpoint's required BAR was assigned in the first pass; only the
> zero-required-size reserve failed.  In the second pass,
> pci_prepare_next_assign_round() selects the window of the failing
> bridge's parent bus, here the root bus, and releases it with
> whole_subtree.  That drops every non-prefetchable window on bus 00 and,
> via release_child_resources(), every BAR below them, and
> pci_setup_one_bridge_window() reprograms each bridge so the MMIO stops
> immediately. Bound drivers are not notified.

Hmm... this sound very interesting detail. I think this is is where the 
problem lies. Obviously, it's wrong to touch any BAR that is in use by any 
driver. I suppose fixing that problem would prevent the problem you're 
seeing?

It could be that the release_child_resources() is just too low-level 
function for this task and it should be done on PCI level so enough 
information is available for the cascading release prior to releasing the 
actual bridge window.

I've never really liked release_child_resources() as it also hampers 
troubleshooting because it's logging is not as useful as logging done with 
PCI level information available (so knowing which resource is which is 
harder).

> The reassignment that follows is scoped to the hotplugged bridge, so the
> released sibling windows and BARs are never restored.

There is no general level "restore" in the whole algoritm nor notion of 
which of the allocation(s) was better. Only the BAR resizing currently 
does "restore" resources/BARs/bridge windows.

I've been thinking of storing all resources into yet another list before 
doing anything, and checking afterwards that at least the same resources 
got assigned as before the operation (but this too may have some cases 
where the kernel's attempt was actually "better"). The same list could be 
used to rewind the entire operation on failure.

> The pass does not
> fail: it succeeds in giving 00:03.5 a 2MB window that no device
> requested, at the cost of the running igb.
> 
> Save the required size before attempting the optional allocation and
> restore it when that allocation fails.  A window with no required part
> is then left at size 0.  In the out path, only report unassigned
> resources that have non-zero size.  A zero-sized resource requests
> nothing and cannot have failed; assign_requested_resources_sorted()
> skips such resources rather than attempting them, and releasing
> upstream windows to make room for zero bytes cannot help.
> 
> Fixes: 96336ec70264 ("PCI: Perform reset_resource() and build fail list in sync")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>
> ---
> Changes in v2:
> - In the out path, drop the !pci_resource_is_optional() check and keep only
>   the zero-size one; it also covered IOV BARs and disabled ROMs, which have
>   a real requested size (Ilpo).
> - Drop the Fixes: 2499f5348431 tag; the zero-size window was never covered
>   by the ROM exception that commit removed.
> - Show the full second assignment pass in the commit message (Ilpo).
> - Reword the commit message and code comments; no functional change.
> 
> Link to v1:
> https://lore.kernel.org/linux-pci/20260717180029.1829888-1-anthony.pighin@nokia.com/
> 
>  drivers/pci/setup-bus.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index c0a949f2c995..7dd662941e67 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -450,12 +450,18 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
>  		add_size = add_res->add_size;
>  		align = add_res->min_align;
>  		if (!resource_assigned(res)) {
> -			resource_set_range(res, align,
> -					   resource_size(res) + add_size);
> +			resource_size_t req_size = resource_size(res);
> +
> +			resource_set_range(res, align, req_size + add_size);
>  			if (pci_assign_resource(dev, idx)) {
>  				pci_dbg(dev,
>  					"%s %pR: ignoring failure in optional allocation\n",
>  					res_name, res);
> +				/*
> +				 * Restore the required size; the failed
> +				 * attempt left the range enlarged.
> +				 */
> +				resource_set_range(res, align, req_size);
>  			}
>  		} else if (add_size > 0 || !IS_ALIGNED(res->start, align)) {
>  			res->flags |= add_res->flags &
> @@ -743,7 +749,12 @@ static void __assign_resources_sorted(struct list_head *head,
>  		if (resource_assigned(res))
>  			continue;
>  
> -		if (fail_head) {
> +		/*
> +		 * A zero-sized resource requests nothing, so it cannot
> +		 * have failed.

This is outright misleading, when it comes to how optional resource, they 
may have zero size so it did request something.

>  Reporting it would only trigger a
> +		 * pointless release/retry round.

This too is misunderstanding about how the algorithm is supposed to work, 
it is normal to do "unnecessary" or "pointless" looking releases/retries.
Even your case clearly showed it actually wasn't unnecessary(?), and you 
get that window assigned which, if I've understood, correctly didn't fit 
there otherwise.

So no, I don't agree with what this comment says nor the intent.

> +		 */
> +		if (fail_head && resource_size(res)) {
>  			pci_dev_res_add_to_list(fail_head, dev, res,
>  						0 /* don't care */,
>  						0 /* don't care */);
> 

-- 
 i.

